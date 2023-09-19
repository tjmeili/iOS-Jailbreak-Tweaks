#import <UIKit/UIKit.h>
#import <UIKit/UIColor.h>

@interface UIWindow (Private)
- (BOOL)_ignoresHitTest;
- (void)_setSecure:(BOOL)secure;
@end

@interface BluWindow : UIWindow
@end