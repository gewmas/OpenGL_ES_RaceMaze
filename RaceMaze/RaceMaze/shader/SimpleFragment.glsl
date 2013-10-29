varying lowp vec4 DestinationColor; //input variable from the vertex shader

void main(void) {
    gl_FragColor = DestinationColor; //pass to the destination color
}