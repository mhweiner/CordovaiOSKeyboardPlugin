#import <Cordova/CDVPlugin.h>

@interface KeyboardPlugin : CDVPlugin
- (void) setup:(CDVInvokedUrlCommand*)command;
- (void) overlayApp:(CDVInvokedUrlCommand*)command;
@property (nonatomic, assign) BOOL show_toolbar;
@property (nonatomic, assign) BOOL overlay_app;
@end