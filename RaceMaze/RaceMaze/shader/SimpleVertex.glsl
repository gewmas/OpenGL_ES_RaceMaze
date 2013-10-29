attribute vec4 Position;    //input variable called Position
attribute vec4 SourceColor; //input variable

varying vec4 DestinationColor; //output variable

uniform mat4 Projection;

void main(void) { 
    DestinationColor = SourceColor; //destination color equal to source color, OpengGL interpolate the values
    gl_Position = Projection * Position; //build-in output variable
}