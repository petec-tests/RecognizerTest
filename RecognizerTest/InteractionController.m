//
//  Created by Pete Callaway on 12/12/2014.
//  Copyright (c) 2014 Dative Studios. All rights reserved.
//

#import "InteractionController.h"

@interface InteractionController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UILongPressGestureRecognizer *longPressRecognizer;
@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;

@end


@implementation InteractionController

- (instancetype)initWithView:(UIView*)view {
    self = [super init];
    if (self != nil) {
        _longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressRecognizer:)];
        _longPressRecognizer.delegate = self;
        _longPressRecognizer.cancelsTouchesInView = NO;
        _longPressRecognizer.minimumPressDuration = 0.1;
        [view addGestureRecognizer:_longPressRecognizer];
        
        _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanRecognizer:)];
        _panRecognizer.delegate = self;
        _panRecognizer.cancelsTouchesInView = NO;
        [view addGestureRecognizer:_panRecognizer];
        
        _pressState = InteractionControllerPressStateNone;
    }
    
    return self;
}

- (void)setPressState:(InteractionControllerPressState)newState {
    if (_pressState != newState) {
        _pressState = newState;
        
        if ([self.delegate respondsToSelector:@selector(interactionControllerDidTogglePressingState:)]) {
            [self.delegate interactionControllerDidTogglePressingState:self];
        }
    }
}



#pragma mark Gesture recognizer handling


- (void)handleLongPressRecognizer:(UILongPressGestureRecognizer*)recongizer {
    switch (self.longPressRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            CGFloat const viewMidX = recongizer.view.bounds.size.width / 2.0;
            
            if ([recongizer locationInView:recongizer.view].x < viewMidX) {
                self.pressState = InteractionControllerPressStateLeft;
            }
            else {
                self.pressState = InteractionControllerPressStateRight;
            }

            break;
        }
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStatePossible:
            self.pressState = InteractionControllerPressStateNone;
            break;
            
        case UIGestureRecognizerStateChanged:
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
            if ([recognizer velocityInView:recognizer.view].y < -1000) {
                if ([self.delegate respondsToSelector:@selector(interactionControllerDidDetectSwipe:)]) {
                    [self.delegate interactionControllerDidDetectSwipe:self];
                }
                
                recognizer.enabled = NO;
                recognizer.enabled = YES;
            }
            break;
    }
}


#pragma mark UIGestureRecognizerDelegate methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
