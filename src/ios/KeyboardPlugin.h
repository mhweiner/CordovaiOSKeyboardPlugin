/**
 * CordovaiOSKeyboardPlugin
 * ======================================================
 * Apache Cordova Plugin for iOS
 * Written by Marc Weiner (mhweiner234@gmail.com)
 * https://github.com/mhweiner/CordovaiOSKeyboardPlugin
 * License: MIT
 */

#import <Cordova/CDVPlugin.h>

@interface KeyboardPlugin : CDVPlugin
- (void) setup:(CDVInvokedUrlCommand*)command;
- (void) resizeApp:(CDVInvokedUrlCommand*)command;
@property (nonatomic, assign) BOOL resize_app;
@end