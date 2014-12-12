//
//  Created by Pete Callaway on 12/12/2014.
//  Copyright (c) 2014 Dative Studios. All rights reserved.
//

@import UIKit;
@protocol InteractionControllerDelegate;

typedef NS_ENUM(NSUInteger, InteractionControllerPressState) {
    InteractionControllerPressStateNone,
    InteractionControllerPressStateLeft,
    InteractionControllerPressStateRight,
};



@interface InteractionController : NSObject

@property (nonatomic, assign, readonly) InteractionControllerPressState pressState;
@property (nonatomic, weak) id<InteractionControllerDelegate> delegate;

- (instancetype)initWithView:(UIView*)view;

@end


@protocol InteractionControllerDelegate <NSObject>

@optional
- (void)interactionControllerDidDetectSwipe:(InteractionController*)interactionController;
- (void)interactionControllerDidTogglePressState:(InteractionController*)interactionController;

@end
