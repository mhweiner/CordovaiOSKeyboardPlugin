#import "KeyboardPlugin.h"
#import <QuartzCore/QuartzCore.h>

@implementation KeyboardPlugin


- (void) setup:(CDVInvokedUrlCommand*)command
{
    //defaults
    self.overlay_app = YES;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];

}

- (void) overlayApp:(CDVInvokedUrlCommand*)command
{

    id value = [command.arguments objectAtIndex:0];
    if (!([value isKindOfClass:[NSNumber class]])) {
        value = [NSNumber numberWithBool:YES];
    }

    self.overlay_app = [value boolValue];

    NSLog(self.overlay_app ? @"Keyboard will overlay app." : @"Keyboard will have default iOS behavior.");
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}


- (void)keyboardWillShow:(NSNotification *)notif {


    // If default behavior, return
    if(!self.overlay_app){
        return;
    }

    // Make the scrollview have negative padding, which helps with viewport
    // for some reason.
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

    NSString *cmd = [NSString stringWithFormat:@"Keyboard.nativeKeyboardEventHandler(%f);", height];
    [self.commandDelegate evalJs:cmd];


    // Begin animation.

    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:animations
                     completion:nil];

}

- (void)keyboardWillHide:(NSNotification *)notif {

    //Call JS Event handler

    [self.commandDelegate evalJs:@"Keyboard.nativeKeyboardEventHandler();"];
}

@end

