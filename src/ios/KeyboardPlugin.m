/**
 * CordovaiOSKeyboardPlugin
 * ======================================================
 * Apache Cordova Plugin for iOS
 * Written by Marc Weiner (mhweiner234@gmail.com)
 * https://github.com/mhweiner/CordovaiOSKeyboardPlugin
 * License: MIT
 */

#import "KeyboardPlugin.h"
#import <QuartzCore/QuartzCore.h>

@implementation KeyboardPlugin


- (void) pluginInitialize
{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    NSLog(@"Keyboard plugin initialized.");

}

- (void)keyboardWillShow:(NSNotification *)notif {

    NSDictionary *userInfo = notif.userInfo;

    // Get keyboard size.

    NSValue *endFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardEndFrame = [self.viewController.view convertRect:endFrameValue.CGRectValue fromView:nil];

    // Get height of keyboard for JS callback
    
    CGFloat height = keyboardEndFrame.size.height;

    // Call JS event handler
    
    NSString *cmd = [NSString stringWithFormat:@"Keyboard.keyboardWillShow(%f);", height];
    [self.commandDelegate evalJs:cmd];

}

- (void)keyboardWillHide:(NSNotification *)notif {
    
    [self.commandDelegate evalJs:@"Keyboard.keyboardWillHide();"];
    
}

- (void)keyboardDidShow:(NSNotification *)notif {
    
    [self.commandDelegate evalJs:@"Keyboard.keyboardDidShow();"];
    
}

- (void)keyboardDidHide:(NSNotification *)notif {

    [self.commandDelegate evalJs:@"Keyboard.keyboardDidHide();"];
    
}

@end