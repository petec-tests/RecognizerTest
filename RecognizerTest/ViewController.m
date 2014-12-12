//
//  Created by Pete Callaway on 12/12/2014.
//  Copyright (c) 2014 Dative Studios. All rights reserved.
//

#import "ViewController.h"

#import "InteractionController.h"


@interface ViewController ()<InteractionControllerDelegate>

@property (nonatomic, strong) InteractionController *interactionController;

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.interactionController = [[InteractionController alloc] initWithView:self.view];
    self.interactionController.delegate = self;
}

- (void)interactionControllerDidDetectSwipe:(InteractionController *)interactionController {
    NSLog(@"Swiped");
}

- (void)interactionControllerDidTogglePressState:(InteractionController *)interactionController {
    switch (interactionController.pressState) {
        case InteractionControllerPressStateNone:
            NSLog(@"Released");
            break;
            
        case InteractionControllerPressStateLeft:
            NSLog(@"Holding left");
            break;
            
        case InteractionControllerPressStateRight:
            NSLog(@"Holding right");
            break;
    }
}


@end
