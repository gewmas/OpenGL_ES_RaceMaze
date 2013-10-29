varying lowp vec4 DestinationColor; //input variable from the vertex shader

varying lowp vec2 TexCoordOut;
uniform sampler2D Texture;

void main(void) {
//    gl_FragColor = DestinationColor;
    gl_FragColor = DestinationColor * texture2D(Texture, TexCoordOut); //pass to the destination color
}