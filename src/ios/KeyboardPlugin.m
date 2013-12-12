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


- (void) setup:(CDVInvokedUrlCommand*)command
{
    //defaults
    self.resize_app = NO;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];

    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];

}

- (void) resizeApp:(CDVInvokedUrlCommand*)command
{

    id value = [command.arguments objectAtIndex:0];
    if (!([value isKindOfClass:[NSNumber class]])) {
        value = [NSNumber numberWithBool:YES];
    }

    self.resize_app = [value boolValue];

    NSLog(self.resize_app ? @"Keyboard will resize app." : @"Keyboard will have default behavior.");
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}


- (void)keyboardWillShow:(NSNotification *)notif {


    // If default behavior, return
    if(!self.resize_app){
        return;
    }

    // Make the scrollview have negative padding until the keyboard is done animating in.
    // This helps with the black flicker while the keyboard is animating.
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, -600, 0);

    NSDictionary *userInfo = notif.userInfo;

    // Get keyboard size.

    NSValue *beginFrameValue = userInfo[UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardBeginFrame = [self.viewController.view convertRect:beginFrameValue.CGRectValue fromView:nil];

    NSValue *endFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardEndFrame = [self.viewController.view convertRect:endFrameValue.CGRectValue fromView:nil];

    // Get keyboard animation.

    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;

    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;

    // Create animation.

    CGRect webViewFrame = self.webView.frame;
    webViewFrame.size.height = (keyboardBeginFrame.origin.y - webViewFrame.origin.y);
    self.webView.frame = webViewFrame;

    void (^animations)() = ^() {
        CGRect webViewFrame = self.webView.frame;
        webViewFrame.size.height = (keyboardEndFrame.origin.y - webViewFrame.origin.y);
        self.webView.frame = webViewFrame;
    };


    // Get height of keyboard for JS callback
    CGFloat height = keyboardEndFrame.size.height;

    // Call JS event handler
    NSString *cmd = [NSString stringWithFormat:@"Keyboard.keyboardWillShow(%f);", height];
    [self.commandDelegate evalJs:cmd];


    // Begin animation.

    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:animations
                     completion:nil];

}

- (void)keyboardWillHide:(NSNotification *)notif {
    
    [self.commandDelegate evalJs:@"Keyboard.keyboardWillHide();"];
    
}

- (void)keyboardDidShow:(NSNotification *)notif {
    
    // Bring the padding back to nomal.
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [self.commandDelegate evalJs:@"Keyboard.keyboardDidShow();"];
}

- (void)keyboardDidHide:(NSNotification *)notif {
    
    // Bring the padding back to nomal.
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [self.commandDelegate evalJs:@"Keyboard.keyboardDidHide();"];
}

@end

