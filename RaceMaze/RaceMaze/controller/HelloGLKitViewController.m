//
//  HelloGLKitViewController.m
//  RaceMaze
//
//  Created by Yuhua Mai on 10/28/13.
//  Copyright (c) 2013 Yuhua Mai. All rights reserved.
//

#import "HelloGLKitViewController.h"
#import "OpenGLView.h"

@interface HelloGLKitViewController ()
{
    OpenGLView* _glView;
    
    GLKMatrix4 _rotMatrix;

}

@property (nonatomic, retain) IBOutlet OpenGLView *glView;

@end

@implementation HelloGLKitViewController

@synthesize glView=_glView;


#pragma OpenGL ES
- (void)setupGL
{
    _rotMatrix = GLKMatrix4Identity;

}

- (void)tearDownGL
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Add OpenGLView
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    self.glView = [[[OpenGLView alloc] initWithFrame:screenBounds] autorelease];
    [self.view addSubview:self.glView];
    
    [self setupGL];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [self.glView removeFromSuperview];
    self.glView = nil;
}

#pragma mark - GLKViewControllerDelegate

- (void)update {
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

    //Projection Marix
//    float aspect = fabsf(self.view.bounds.size.width / self.view.bounds.size.height);
//    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 4.0f, 10.0f); //near plane to 4 units away from eye, far plane to 10 units away
//    self.effect.transform.projectionMatrix = projectionMatrix;

    //Modelview Matrix
    GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -8.0f); //move backwards within near plane and far plane
    modelViewMatrix = GLKMatrix4Multiply(modelViewMatrix, _rotMatrix);

//    modelViewMatrix = GLKMatrix4Translate(modelViewMatrix, 1.0f, 1.0f, 0.0f);
    
//    _rotation += 90 * self.timeSinceLastUpdate;
//    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(_rotation), 1, 1, 1);
//    modelViewMatrix = GLKMatrix4Translate(modelViewMatrix, -1.0f, -1.0f, 0.0f);
//    self.effect.transform.modelviewMatrix = modelViewMatrix;
}


//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
////    self.paused = !self.paused;
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    
//    UITouch * touch = [touches anyObject];
//    CGPoint location = [touch locationInView:self.view];
//    CGPoint lastLoc = [touch previousLocationInView:self.view];
//    CGPoint diff = CGPointMake(lastLoc.x - location.x, lastLoc.y - location.y);
//    
//    float rotX = -1 * GLKMathDegreesToRadians(diff.y / 2.0);
//    float rotY = -1 * GLKMathDegreesToRadians(diff.x / 2.0);
//    
//    bool isInvertible;
//    GLKVector3 xAxis = GLKMatrix4MultiplyVector3(GLKMatrix4Invert(_rotMatrix, &isInvertible),
//                                                 GLKVector3Make(1, 0, 0));
//    _rotMatrix = GLKMatrix4Rotate(_rotMatrix, rotX, xAxis.x, xAxis.y, xAxis.z);
//    GLKVector3 yAxis = GLKMatrix4MultiplyVector3(GLKMatrix4Invert(_rotMatrix, &isInvertible),
//                                                 GLKVector3Make(0, 1, 0));
//    _rotMatrix = GLKMatrix4Rotate(_rotMatrix, rotY, yAxis.x, yAxis.y, yAxis.z);
//    
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



@end
