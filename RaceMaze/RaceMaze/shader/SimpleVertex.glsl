attribute vec4 Position;    //input variable called Position
attribute vec4 SourceColor; //input variable

varying vec4 DestinationColor; //output variable

uniform mat4 Projection;
uniform mat4 Modelview; //transform/scale/rotation matrix

attribute vec2 TexCoordIn; // Texture
varying vec2 TexCoordOut;

void main(void) { 
    DestinationColor = SourceColor; //destination color equal to source color, OpengGL interpolate the values
    gl_Position = Projection * Modelview * Position;//build-in output variable
    TexCoordOut = TexCoordIn; 
}