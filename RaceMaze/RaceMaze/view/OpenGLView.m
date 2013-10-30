////
////  OpenGLView.m
////  RaceMaze
////
////  Created by Yuhua Mai on 10/28/13.
////  Copyright (c) 2013 Yuhua Mai. All rights reserved.
////


#import "OpenGLView.h"
#import "CC3GLMatrix.h"

@interface OpenGLView ()
{
    GLKMatrix4 _rotMatrix;
    
    float _currentRotationX;
    float _currentRotationY;
    float _currentRotationZ;
    
    float _locationX;
    float _locationY;
    float _locationZ;

}

@end

@implementation OpenGLView

#define TEX_COORD_MAX 4

typedef struct {
    float Position[3];
    float Color[4];
    float TexCoord[2];
} Vertex;

const Vertex Vertices[] = {
    // Front
    {{1, -1, 0}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
    {{1, 1, 0}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-1, 1, 0}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
    {{-1, -1, 0}, {0, 0, 0, 1}, {0, 0}},
    // Back
    {{1, 1, -2}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
    {{-1, -1, -2}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{1, -1, -2}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
    {{-1, 1, -2}, {0, 0, 0, 1}, {0, 0}},
    // Left
    {{-1, -1, 0}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
    {{-1, 1, 0}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-1, 1, -2}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
    {{-1, -1, -2}, {0, 0, 0, 1}, {0, 0}},
    // Right
    {{1, -1, -2}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
    {{1, 1, -2}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{1, 1, 0}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
    {{1, -1, 0}, {0, 0, 0, 1}, {0, 0}},
    // Top
    {{1, 1, 0}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
    {{1, 1, -2}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-1, 1, -2}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
    {{-1, 1, 0}, {0, 0, 0, 1}, {0, 0}},
    // Bottom
    {{1, -1, -2}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
    {{1, -1, 0}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-1, -1, 0}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
    {{-1, -1, -2}, {0, 0, 0, 1}, {0, 0}}
};

const GLubyte Indices[] = {
    // Front
    0, 1, 2,
    2, 3, 0,
    // Back
    4, 6, 5,
    5, 7, 4,
    // Left
    8, 9, 10,
    10, 11, 8,
    // Right
    12, 13, 14,
    14, 15, 12,
    // Top
    16, 17, 18,
    18, 19, 16,
    // Bottom
    20, 21, 22,
    22, 23, 20
};

const Vertex Vertices2[] = {
    {{0.5, -0.5, 0.01}, {1, 1, 1, 1}, {1, 1}},
    {{0.5, 0.5, 0.01}, {1, 1, 1, 1}, {1, 0}},
    {{-0.5, 0.5, 0.01}, {1, 1, 1, 1}, {0, 0}},
    {{-0.5, -0.5, 0.01}, {1, 1, 1, 1}, {0, 1}},
};

const GLubyte Indices2[] = {
    0, 1, 2,
    2, 3, 0
};

const Vertex Vertices3[] = {
    // Front
    {{1, -1, 0}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
    {{1, 1, 0}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-1, 1, 0}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
    {{-1, -1, 0}, {0, 0, 0, 1}, {0, 0}},
    // Back
    {{3, -3, -15}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
    {{3, 3, -15}, {1, 0, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-3, 3, -15}, {0, 0, 0, 1}, {TEX_COORD_MAX, 0}},
    {{-3, -3, -15}, {0, 1, 0, 1}, {0, 0}},
    // Left
    {{-3, -3, 2}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
    {{-3, 3, 2}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-3, 3, -15}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
    {{-3, -3, -15}, {0, 0, 0, 1}, {0, 0}},
    // Right
    {{3, -3, 2}, {0, 0, 0, 1}, {0, 0}},
    {{3, -3, -15}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
    {{3, 3, -15}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{3, 3, 2}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
    // Top
    {{3, 3, 2}, {1, 0, 0, 1}, {0, TEX_COORD_MAX}},
    {{3, 3, -15}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-3, 3, -15}, {0, 0, 1, 1}, {TEX_COORD_MAX, 0}},
    {{-3, 3, 2}, {0, 0, 0, 1}, {0, 0}},
    // Bottom
    {{3, -3, -15}, {1, 0, 0, 1}, {TEX_COORD_MAX, 0}},
    {{3, -3, 2}, {0, 1, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-3, -3, 2}, {0, 0, 1, 1}, {0, TEX_COORD_MAX}},
    {{-3, -3, -15}, {0, 0, 0, 1}, {0, 0}}

};

const GLubyte Indices3[] = {
    // Front
//    0, 1, 2,
//    2, 3, 0,
    // Back
    4, 6, 5,
    5, 7, 4,
   // Left
   8, 9, 10,
   8, 11, 10,
   // Right
   12, 15, 13,
   13, 15, 14,
    // Top
    18, 17, 16,
    18, 16, 19,
   // Bottom
   20, 21, 22,
   20, 23, 22

};



//synchronize the time we render with OpenGL to the rate at which the screen refreshes
- (void)setupDisplayLink {
    CADisplayLink* displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(render:)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

+ (Class)layerClass {
    return [CAEAGLLayer class];
}

- (void)setupLayer {
    _eaglLayer = (CAEAGLLayer*) self.layer;
    _eaglLayer.opaque = YES;
}

- (void)setupContext {
    EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
    _context = [[EAGLContext alloc] initWithAPI:api];
    if (!_context) {
        NSLog(@"Failed to initialize OpenGLES 2.0 context");
        exit(1);
    }

    if (![EAGLContext setCurrentContext:_context]) {
        NSLog(@"Failed to set current OpenGL context");
        exit(1);
    }
}

- (void)setupRenderBuffer {
    glGenRenderbuffers(1, &_colorRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _colorRenderBuffer);
    [_context renderbufferStorage:GL_RENDERBUFFER fromDrawable:_eaglLayer];
}

- (void)setupDepthBuffer {
    glGenRenderbuffers(1, &_depthRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _depthRenderBuffer);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, self.frame.size.width, self.frame.size.height);
}

//Buffer with colorRenderBuffer and depthRenderBuffer
- (void)setupFrameBuffer {
    GLuint framebuffer;
    glGenFramebuffers(1, &framebuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, framebuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0,
                              GL_RENDERBUFFER, _colorRenderBuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _depthRenderBuffer);
}


- (GLuint)compileShader:(NSString*)shaderName withType:(GLenum)shaderType {

    // get the content of glsl file
    NSString* shaderPath = [[NSBundle mainBundle] pathForResource:shaderName
                                                           ofType:@"glsl"];
    NSError* error;
    NSString* shaderString = [NSString stringWithContentsOfFile:shaderPath
                                                       encoding:NSUTF8StringEncoding error:&error];
    if (!shaderString) {
        NSLog(@"Error loading shader: %@", error.localizedDescription);
        exit(1);
    }

    // create OpenGL object to represent the shader
    GLuint shaderHandle = glCreateShader(shaderType);

    // give OpenGL the source code for the shader
    const char * shaderStringUTF8 = [shaderString UTF8String];
    int shaderStringLength = [shaderString length];
    glShaderSource(shaderHandle, 1, &shaderStringUTF8, &shaderStringLength);

    // compile the shader at runtime
    glCompileShader(shaderHandle);

    // handle compile failure
    GLint compileSuccess;
    glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &compileSuccess);
    if (compileSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetShaderInfoLog(shaderHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }

    return shaderHandle;

}

- (void)compileShaders {

    // compile the vertex and fregment shaders
    GLuint vertexShader = [self compileShader:@"SimpleVertex"
                                     withType:GL_VERTEX_SHADER];
    GLuint fragmentShader = [self compileShader:@"SimpleFragment"
                                       withType:GL_FRAGMENT_SHADER];

    // link the vertex and fragment shaders into a complete program
    GLuint programHandle = glCreateProgram();
    glAttachShader(programHandle, vertexShader);
    glAttachShader(programHandle, fragmentShader);
    glLinkProgram(programHandle);

    // check link errors
    GLint linkSuccess;
    glGetProgramiv(programHandle, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetProgramInfoLog(programHandle, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        exit(1);
    }

    // tell OpenGL to actually use the program when given vertex info
    glUseProgram(programHandle);

    // calls glGetAttribLocation to get a pointer to the input values for the vertex shader, so we can set them in code. Also calls glEnableVertexAttribArray to enable use of these arrays (they are disabled by default)
    _positionSlot = glGetAttribLocation(programHandle, "Position");
    _colorSlot = glGetAttribLocation(programHandle, "SourceColor");
    glEnableVertexAttribArray(_positionSlot);
    glEnableVertexAttribArray(_colorSlot);

    _projectionUniform = glGetUniformLocation(programHandle, "Projection");
    _modelViewUniform = glGetUniformLocation(programHandle, "Modelview");

    //texture
    _texCoordSlot = glGetAttribLocation(programHandle, "TexCoordIn");
    glEnableVertexAttribArray(_texCoordSlot);
    _textureUniform = glGetUniformLocation(programHandle, "Texture");

}



//Vertex Buffer Objects
- (void)setupVBOs {
//    //object 1
    glGenBuffers(1, &_vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices), Vertices, GL_STATIC_DRAW);

    glGenBuffers(1, &_indexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Indices), Indices, GL_STATIC_DRAW);

    //object 2
    glGenBuffers(1, &_vertexBuffer2);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer2);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices2), Vertices2, GL_STATIC_DRAW);

    glGenBuffers(1, &_indexBuffer2);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer2);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Indices2), Indices2, GL_STATIC_DRAW);
    
    //object 3
    glGenBuffers(1, &_vertexBuffer3);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer3);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices3), Vertices3, GL_STATIC_DRAW);
    
    glGenBuffers(1, &_indexBuffer3);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer3);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Indices3), Indices3, GL_STATIC_DRAW);

}


- (void)drawCube
{
    ///object 1
    glPushMatrix();
    
    //Modelview, translation, rotation
    CC3GLMatrix *modelView = [CC3GLMatrix matrix];
    [modelView populateFromTranslation:CC3VectorMake(0, 0, -7)];
    //    [modelView populateFromTranslation:CC3VectorMake(sin(CACurrentMediaTime()), 0, -7)]; //whitin near and far, x, y, z
    [modelView translateBy:CC3VectorMake(_locationX, 0, _locationZ)];
    [modelView rotateBy:CC3VectorMake(_currentRotationX, _currentRotationY, _currentRotationZ)];
//    [modelView translateBy:CC3VectorMake(0, 0, 1)];
    
    glUniformMatrix4fv(_modelViewUniform, 1, 0, modelView.glMatrix);

    
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    
    //Position
    glVertexAttribPointer(_positionSlot, 3, GL_FLOAT, GL_FALSE,
                          sizeof(Vertex), 0);
    //Color
    glVertexAttribPointer(_colorSlot, 4, GL_FLOAT, GL_FALSE,
                          sizeof(Vertex), (GLvoid*) (sizeof(float) * 3)); //offset 3, x y z
    
    //Texture
    glVertexAttribPointer(_texCoordSlot, 2, GL_FLOAT, GL_FALSE,
                          sizeof(Vertex), (GLvoid*) (sizeof(float) * 7)); //offset 7, x y z r b g a
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, _floorTexture); //FLOOR!
    glUniform1i(_textureUniform, 0);
    
    
    //Index
    glDrawElements(GL_TRIANGLES, sizeof(Indices)/sizeof(Indices[0]),
                   GL_UNSIGNED_BYTE, 0);
    glPopMatrix();
    
    
    ///--------------object 2----------
    glDisable(GL_CULL_FACE);
    glPushMatrix();
    
    
    //FISH texture
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer2);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer2);
    
    glActiveTexture(GL_TEXTURE0); // unneccc in practice
    glBindTexture(GL_TEXTURE_2D, _fishTexture); // FISH!
    glUniform1i(_textureUniform, 0); // unnecc in practice
    
    
    glUniformMatrix4fv(_modelViewUniform, 1, 0, modelView.glMatrix);
    
    glVertexAttribPointer(_positionSlot, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), 0);
    glVertexAttribPointer(_colorSlot, 4, GL_FLOAT, GL_FALSE, sizeof(Vertex), (GLvoid*) (sizeof(float) * 3));
    glVertexAttribPointer(_texCoordSlot, 2, GL_FLOAT, GL_FALSE, sizeof(Vertex), (GLvoid*) (sizeof(float) * 7));
    
    glDrawElements(GL_TRIANGLE_STRIP, sizeof(Indices2)/sizeof(Indices2[0]), GL_UNSIGNED_BYTE, 0);
    glPopMatrix();
    glEnable(GL_CULL_FACE);

}

- (void)drawWall
{
    //Modelview, translation, rotation
    CC3GLMatrix *modelView = [CC3GLMatrix matrix];
    [modelView populateFromTranslation:CC3VectorMake(0, 0, -7)];
    
    glUniformMatrix4fv(_modelViewUniform, 1, 0, modelView.glMatrix);
    
    glPushMatrix();
    
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer3);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer3);
    
    glActiveTexture(GL_TEXTURE0); // unneccc in practice
    glBindTexture(GL_TEXTURE_2D, _floorTexture);
    glUniform1i(_textureUniform, 0); // unnecc in practice
    
    
    glUniformMatrix4fv(_modelViewUniform, 1, 0, modelView.glMatrix);
    
    glVertexAttribPointer(_positionSlot, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), 0);
    glVertexAttribPointer(_colorSlot, 4, GL_FLOAT, GL_FALSE, sizeof(Vertex), (GLvoid*) (sizeof(float) * 3));
    glVertexAttribPointer(_texCoordSlot, 2, GL_FLOAT, GL_FALSE, sizeof(Vertex), (GLvoid*) (sizeof(float) * 7));
    
    glDrawElements(GL_TRIANGLE_STRIP, sizeof(Indices3)/sizeof(Indices3[0]), GL_UNSIGNED_BYTE, 0);
    glPopMatrix();
}


- (void)render:(CADisplayLink*)displayLink {
    //set to GL_ONE for the source (which means “take all of the source”) and GL_ONE_MINS_SRC_ALPHA for the destination (which means “take all of the destination except where the source is set”).
    glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_BLEND);
    glEnable(GL_CULL_FACE);

    glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
//    glClear(GL_COLOR_BUFFER_BIT);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);

    //Projection
    CC3GLMatrix *projection = [CC3GLMatrix matrix];
    float h = 4.0f * self.frame.size.height / self.frame.size.width;
    [projection populateFromFrustumLeft:-2 andRight:2 andBottom:-h/2 andTop:h/2 andNear:3 andFar:20];
    glUniformMatrix4fv(_projectionUniform, 1, 0, projection.glMatrix);
    
    //set the portion of the UIView to use for rendering
    //By default, OpenGL has the “camera” at (0,0,0), looking down the z-axis. The bottom left of the screen is mapped to (-1,-1), and the upper right of the screen is mapped to (1,1),
    glViewport(0, 0, self.frame.size.width, self.frame.size.height);

    [self drawCube];
    [self drawWall];
    
        //update
//    //Modelview Matrix
//    GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -8.0f); //move backwards within near plane and far plane
//    modelViewMatrix = GLKMatrix4Multiply(modelViewMatrix, _rotMatrix);

    
    [_context presentRenderbuffer:GL_RENDERBUFFER];
}



- (GLuint)setupTexture:(NSString *)fileName {
    // Get Core Graphics image reference.
    CGImageRef spriteImage = [UIImage imageNamed:fileName].CGImage;
    if (!spriteImage) {
        NSLog(@"Failed to load image %@", fileName);
        exit(1);
    }

    // Create Core Graphics bitmap context.

    size_t width = CGImageGetWidth(spriteImage);
    size_t height = CGImageGetHeight(spriteImage);

    GLubyte * spriteData = (GLubyte *) calloc(width*height*4, sizeof(GLubyte)); //rgba 4

    //The fourth parameter to CGBitmapContextCreate is the bits per component, and we set this to 8 bits (1 byte).
    CGContextRef spriteContext = CGBitmapContextCreate(spriteData, width, height, 8, width*4, CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast);

    // Draw the image into the context
    CGContextDrawImage(spriteContext, CGRectMake(0, 0, width, height), spriteImage);

    CGContextRelease(spriteContext);

    // Send the pixel data to OpenGL
    GLuint texName;
    glGenTextures(1, &texName);
    glBindTexture(GL_TEXTURE_2D, texName);

    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);

    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);

    free(spriteData);
    return texName;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLayer];
        [self setupContext];
        [self setupDepthBuffer];
        [self setupRenderBuffer];
        [self setupFrameBuffer];
        [self compileShaders];
        [self setupVBOs];
        [self setupDisplayLink];
        _floorTexture = [self setupTexture:@"tile_floor.png"];
        _fishTexture = [self setupTexture:@"duke_icon.png"];
    }
    return self;
}

- (void)dealloc
{
    [_context release];
    _context = nil;
    [super dealloc];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    CGPoint lastLoc = [touch previousLocationInView:self];
    CGPoint diff = CGPointMake(lastLoc.x - location.x, lastLoc.y - location.y);
    
//    float rotX = -1 * GLKMathDegreesToRadians(diff.y / 2.0);
//    float rotY = -1 * GLKMathDegreesToRadians(diff.x / 2.0);
//    NSLog(@"%f, %f", rotX, rotY);
    
    _currentRotationX += diff.y;
    _currentRotationY += diff.x;
    
    
    if (diff.x > 0) {
        _locationX -= 0.02;
    }else{
        _locationX += 0.02;
    }
    
    if (_locationX > 0.2) {
        _locationX = 0.2;
    }
    if (_locationX < -0.2) {
        _locationX = -0.2;
    }
    
    if (diff.y > 0) {
        _locationZ -= 0.05;
    }else{
        _locationZ += 0.05;
    }

    
//    bool isInvertible;
//    GLKVector3 xAxis = GLKMatrix4MultiplyVector3(GLKMatrix4Invert(_rotMatrix, &isInvertible),
//                                                 GLKVector3Make(1, 0, 0));
//    _rotMatrix = GLKMatrix4Rotate(_rotMatrix, rotX, xAxis.x, xAxis.y, xAxis.z);
//    GLKVector3 yAxis = GLKMatrix4MultiplyVector3(GLKMatrix4Invert(_rotMatrix, &isInvertible),
//                                                 GLKVector3Make(0, 1, 0));
//    _rotMatrix = GLKMatrix4Rotate(_rotMatrix, rotY, yAxis.x, yAxis.y, yAxis.z);
    
}


@end
