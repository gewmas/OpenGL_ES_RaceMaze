//
//  HelloGLKitViewController.m
//  RaceMaze
//
//  Created by Yuhua Mai on 10/28/13.
//  Copyright (c) 2013 Yuhua Mai. All rights reserved.
//

#import "HelloGLKitViewController.h"

@interface HelloGLKitViewController ()
{
    float _curRed;
    BOOL _increasing;
}

@property (strong, nonatomic) EAGLContext *context;

@end

@implementation HelloGLKitViewController

@synthesize context = _context;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }

    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
    self.context = nil;
}


#pragma mark - GLKViewDelegate

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    
    glClearColor(_curRed, 0.0, 0.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
}

#pragma mark - GLKViewControllerDelegate

- (void)update {
    if (_increasing) {
        _curRed += 1.0 * self.timeSinceLastUpdate;
    } else {
        _curRed -= 1.0 * self.timeSinceLastUpdate;
    }
    if (_curRed >= 1.0) {
        _curRed = 1.0;
        _increasing = NO;
    }
    if (_curRed <= 0.0) {
        _curRed = 0.0;
        _increasing = YES;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.paused = !self.paused;
}

@end
