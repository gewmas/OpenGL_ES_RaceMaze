//
//  HelloGLKitViewController.m
//  RaceMaze
//
//  Created by Yuhua Mai on 10/28/13.
//  Copyright (c) 2013 Yuhua Mai. All rights reserved.
//

#import "HelloGLKitViewController.h"
#import "OpenGLView.h"

//typedef struct {
//    float Position[3];
//    float Color[4];
//} Vertex;
//
//const Vertex Vertices[] = {
//    //{x,y,z}, {r,g,b,a}
//    {{1, -1, 1}, {1, 0, 1, 0}}, //0
//    {{1, 1, 1}, {0, 1, 0, 0}},  //1
//    {{-1, 1, 1}, {0, 0, 1, 0}},  //2
//    {{-1, -1, 1}, {1, 0.5, 0, 0}},  //3
//    
//    {{1, -1, -1}, {0, 1, 0, 0}}, //4
//    {{1, 1, -1}, {0, 1, 1, 0}},  //5
//    {{-1, 1, -1}, {0, 0, 1, 0}},  //6
//    {{-1, -1, -1}, {1, 1, 0, 0}},  //7
//};
//
//const GLubyte Indices[] = {
//    //front
//    0, 1, 2,
//    2, 3, 0,
//    
//    //up
//    1, 5, 6,
//    6, 2, 1,
//
//    //back
//    7, 6, 4,
//    6, 5, 4,
//
//    //bottom
//    0, 7, 4,
//    0, 3, 7,
//
//    //left
//    3, 2, 6,
//    6, 7, 3,
//    
//    //right
//    4, 5, 1,
//    1, 0, 4,
//};

@interface HelloGLKitViewController ()
{
//    GLuint _vertexBuffer;
//    GLuint _indexBuffer;
//    
//    float _curRed;
//    BOOL _increasing;
//    
//    float _rotation;
    
    OpenGLView* _glView;
}

//@property (strong, nonatomic) EAGLContext *context;
//@property (strong, nonatomic) GLKBaseEffect *effect;

@property (nonatomic, retain) IBOutlet OpenGLView *glView;

@end

@implementation HelloGLKitViewController

//@synthesize context = _context;
//@synthesize effect = _effect;

@synthesize glView=_glView;


#pragma OpenGL
//- (void)setupGL {
//    
//    [EAGLContext setCurrentContext:self.context];
//    self.effect = [[GLKBaseEffect alloc] init];
//    
//    glGenBuffers(1, &_vertexBuffer);
//    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
//    glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices), Vertices, GL_STATIC_DRAW);
//    
//    glGenBuffers(1, &_indexBuffer);
//    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
//    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Indices), Indices, GL_STATIC_DRAW);
//    
//}
//
//- (void)tearDownGL {
//    
//    [EAGLContext setCurrentContext:self.context];
//    
//    glDeleteBuffers(1, &_vertexBuffer);
//    glDeleteBuffers(1, &_indexBuffer);
//    
//    self.effect = nil;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //Use storyboard
    /*
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }

    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    
    [self setupGL];
     */
    
    //Add OpenGLView
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    self.glView = [[[OpenGLView alloc] initWithFrame:screenBounds] autorelease];
    [self.view addSubview:self.glView];
}

//- (void)viewDidUnload
//{
//    [super viewDidUnload];
//    
//    if ([EAGLContext currentContext] == self.context) {
//        [EAGLContext setCurrentContext:nil];
//    }
//    self.context = nil;
//    
//    [self tearDownGL];
//}
//
//
//#pragma mark - GLKViewDelegate
//
//- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
//    
//    glClearColor(_curRed, 0.0, 0.0, 1.0);
//    glClear(GL_COLOR_BUFFER_BIT);
// 
//    [self.effect prepareToDraw]; //call every time change properties on GLKBaseEffect
//    
//    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
//    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
//    
//     glEnable(GL_CULL_FACE);
//    
//    //Position
//    glEnableVertexAttribArray(GLKVertexAttribPosition);
//    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), (const GLvoid *) offsetof(Vertex, Position));
//    //Color
//    glEnableVertexAttribArray(GLKVertexAttribColor);
//    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(Vertex), (const GLvoid *) offsetof(Vertex, Color));
//    
//    //Index
//    glDrawElements(GL_TRIANGLES, sizeof(Indices)/sizeof(Indices[0]), GL_UNSIGNED_BYTE, 0);
//}
//
//#pragma mark - GLKViewControllerDelegate
//
//- (void)update {
//    if (_increasing) {
//        _curRed += 1.0 * self.timeSinceLastUpdate;
//    } else {
//        _curRed -= 1.0 * self.timeSinceLastUpdate;
//    }
//    if (_curRed >= 1.0) {
//        _curRed = 1.0;
//        _increasing = NO;
//    }
//    if (_curRed <= 0.0) {
//        _curRed = 0.0;
//        _increasing = YES;
//    }
//    
//    //Projection Marix
//    float aspect = fabsf(self.view.bounds.size.width / self.view.bounds.size.height);
//    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 4.0f, 10.0f); //near plane to 4 units away from eye, far plane to 10 units away
//    self.effect.transform.projectionMatrix = projectionMatrix;
//    
//    //Modelview Matrix
//    GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -8.0f); //move backwards within near plane and far plane
//    modelViewMatrix = GLKMatrix4Translate(modelViewMatrix, 1.0f, 1.0f, 0.0f);
//    _rotation += 90 * self.timeSinceLastUpdate;
//    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(_rotation), 1, 1, 1);
//    modelViewMatrix = GLKMatrix4Translate(modelViewMatrix, -1.0f, -1.0f, 0.0f);
//    self.effect.transform.modelviewMatrix = modelViewMatrix;
//}
//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    self.paused = !self.paused;
//}

@end
