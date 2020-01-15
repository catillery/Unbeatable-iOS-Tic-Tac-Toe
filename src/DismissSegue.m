//
//  DismissSegue.m
//  FinalProgcat0050Su19
//
//  Created by Christopher Tillery on 7/17/19.
//  Copyright © 2019 Christopher Tillery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DismissSegue.h"

@implementation DismissSegue

- (void)perform {
    UIViewController *sourceViewController = self.sourceViewController;
    [sourceViewController.presentingViewController dismissViewControllerAnimated:YES completion: nil];
}

@end
