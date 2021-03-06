//
//  UIAlertView+MDLib.m
//  MDLib
//
//  Created by ZhangZhibin on 2019/1/29.
//  Copyright © 2019 MDRuby. All rights reserved.
//

#import "UIAlertView+MDLib.h"
#import <objc/runtime.h>

static NSString *LEFT_ACTION_ASS_KEY = @"com.robsaunders.cancelbuttonaction";
static NSString *RIGHT_ACTION_ASS_KEY = @"com.robsaunders.otherbuttonaction";

@implementation UIAlertView (MDLib)

- (id)initWithTitle:(NSString *)title
              message:(NSString *)message
      leftButtonTitle:(NSString *)leftButtonTitle
     leftButtonAction:(void (^)(void))leftButtonAction
     rightButtonTitle:(NSString *)rightButtonTitle
    rightButtonAction:(void (^)(void))rightButtonAction {
    if ((self = [self initWithTitle:title
                            message:message
                           delegate:self
                  cancelButtonTitle:leftButtonTitle
                  otherButtonTitles:rightButtonTitle, nil])) {
        // We might get nil for one or both block inputs.  To

        // Since this is a catogory, we cant add properties in the usual way.
        // Instead we bind the delegate block to the pointer to self.
        // We use copy to invoke block_copy() to ensure the block is copied off the stack to the heap
        // so that it is still in scope when the delegate callback is invoked.
        if (leftButtonAction) {
            objc_setAssociatedObject(self, LEFT_ACTION_ASS_KEY, leftButtonAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
        }

        if (rightButtonAction) {
            objc_setAssociatedObject(self, RIGHT_ACTION_ASS_KEY, rightButtonAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
        }

        if (leftButtonAction || rightButtonAction) {
            // We retain ouself because we want to keep this object alive until its dismissed.
            // We will call release when we get the delegate callback.
            [self retain];
        } else {
            // No blocks have been given so clear set the delegate
            self.delegate = nil;
        }
    }
    return self;
}

// This is a convenience wrapper for the constructor above
+ (void)displayAlertWithTitle:(NSString *)title
                      message:(NSString *)message
              leftButtonTitle:(NSString *)leftButtonTitle
             leftButtonAction:(void (^)(void))leftButtonAction
             rightButtonTitle:(NSString *)rightButtonTitle
            rightButtonAction:(void (^)(void))rightButtonAction {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                leftButtonTitle:leftButtonTitle
                                               leftButtonAction:leftButtonAction
                                               rightButtonTitle:rightButtonTitle
                                              rightButtonAction:rightButtonAction];
    [alertView show];
    [alertView release];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // Decalare the block variable
    void (^action)(void) = nil;

    // Get the block using the correct key
    // depending on the index of the buttom that was tapped
    if (buttonIndex == 0) {
        action = objc_getAssociatedObject(self, LEFT_ACTION_ASS_KEY);
    } else if (buttonIndex == 1) {
        action = objc_getAssociatedObject(self, RIGHT_ACTION_ASS_KEY);
    }

    // Invoke the block if we have it.
    if (action)
        action();

    // Unbind both blocks from ourself so they are released
    // We assign nil to the objects wich will release them automatically
    objc_setAssociatedObject(self, LEFT_ACTION_ASS_KEY, nil, OBJC_ASSOCIATION_COPY);
    objc_setAssociatedObject(self, RIGHT_ACTION_ASS_KEY, nil, OBJC_ASSOCIATION_COPY);

    // We can now release ourselfs, since we retained it eariler.
    [self release];
}

@end
