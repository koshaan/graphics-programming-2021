#version 330 core
// FRAGMENT SHADER

// TODO voronoi 1.4
out vec4 fragColor;
// Create an 'in float' variable to receive the depth value from the vertex shader,
// the variable must have the same name as the 'out variable' in the vertex shader.
in float zValue;

void main()
{
    // Use the interpolated z-coordinate to draw the distance of this fragment
    // relative to the center of the cone.
    // Make sure that the z-coordinate is in the [0, 1] range (if it is not, place it in that range).
    // You can use non-linear transformations of the z-coordinate, such as the 'pow' or 'sqrt' functions,
    // to make the change in grey tone more evident.
    fragColor = vec4(sqrt((-zValue*0.5)+0.5), sqrt((-zValue*0.5)+0.5), sqrt((-zValue*0.5)+0.5), 1.0); // CODE HERE
}