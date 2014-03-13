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
- (void) pluginInitialize:(CDVInvokedUrlCommand*)command;
@end