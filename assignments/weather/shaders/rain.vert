#version 330 core
layout (location = 2) in vec3 pos;
layout (location = 3) in vec4 color;
out vec4 vtxColor;

uniform mat4 model;
uniform mat4 prevModel;
uniform vec3 offset;
uniform vec3 camPosition;
uniform vec3 camForward;
uniform float windSpeed;
uniform float boxSize;
uniform float motionBlurMultiplier;

void main()
{
   float rainLength = 0.1;

   vec3 position = mod(pos + offset, boxSize);
   position += camPosition + camForward - boxSize/2;

   vec3 prevPosition = position + vec3(-windSpeed, rainLength, 0); // get a previous position from y length up and wind offset
   vec4 top = model * vec4(prevPosition, 1.0);
   vec4 prevTop = prevModel * vec4(prevPosition, 1.0);
   vec4 bottom = model * vec4(position, 1.0);

   if(mod(gl_VertexID, 2) == 0){ // check if top or bottom
      gl_Position = mix(top, prevTop, motionBlurMultiplier);
      // create a "mix" vector which is either halfway between top and prevtop, or just prevtop based on if we are moving or not.
   } else {
      gl_Position = bottom;
   }

   float len = abs(distance(top, bottom));
   float prevLen = abs(distance(prevTop, bottom));
   float alpha = min(max(len/prevLen, 0.0), 1.0);

   vtxColor = vec4(color.xyz, alpha);
}