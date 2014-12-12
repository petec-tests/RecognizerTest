//
//  Created by Pete Callaway on 12/12/2014.
//  Copyright (c) 2014 Dative Studios. All rights reserved.
//

@import UIKit;
@protocol InteractionControllerDelegate;


@interface InteractionController : NSObject

@property (nonatomic, assign, getter=isPressing, readonly) BOOL pressing;
@property (nonatomic, weak) id<InteractionControllerDelegate> delegate;

- (instancetype)initWithView:(UIView*)view;

@end


@protocol InteractionControllerDelegate <NSObject>

@optional
- (void)interactionControllerDidDetectSwipe:(InteractionController*)interactionController;
- (void)interactionControllerDidTogglePressingState:(InteractionController*)interactionController;

@end
