//
//  ViewController.m
//  RecognizerTest
//
//  Created by Pete Callaway on 12/12/2014.
//  Copyright (c) 2014 Dative Studios. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UILongPressGestureRecognizer *longPressRecognizer;
@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;

@property (nonatomic, assign) BOOL pressing;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressRecognizer:)];
    self.longPressRecognizer.delegate = self;
    self.longPressRecognizer.cancelsTouchesInView = NO;
    self.longPressRecognizer.minimumPressDuration = 0.1;
    [self.view addGestureRecognizer:self.longPressRecognizer];

    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanRecognizer:)];
    self.panRecognizer.delegate = self;
    self.panRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:self.panRecognizer];
    
}


- (void)setPressing:(BOOL)pressing {
    if (_pressing != pressing) {
        _pressing = pressing;
        NSLog(@"%@", pressing ? @"Pressing" : @"Stopped pressing");
    }
}


- (void)handleLongPressRecognizer:(UILongPressGestureRecognizer*)recongizer {
    switch (self.longPressRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.pressing = YES;
            break;
            
        case UIGestureRecognizerStateEnded:
            self.pressing = NO;
            break;
            
        case UIGestureRecognizerStateFailed:
            self.pressing = NO;
            break;
            
        case UIGestureRecognizerStateCancelled:
            self.pressing = NO;
            break;

        case UIGestureRecognizerStateChanged:
            break;
            
        case UIGestureRecognizerStatePossible:
            self.pressing = NO;
            break;
    }
}


- (void)handlePanRecognizer:(UIPanGestureRecognizer*)recognizer {
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStatePossible:
        case UIGestureRecognizerStateEnded:
            break;
            
        case UIGestureRecognizerStateChanged:
            if ([recognizer velocityInView:self.view].y < -1000) {
                NSLog(@"Swiped");
                recognizer.enabled = NO;
                recognizer.enabled = YES;
            }
            break;
    }
}



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
