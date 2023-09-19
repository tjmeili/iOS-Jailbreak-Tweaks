#import "BluWindow.h"

//BluWindow is a window over the entire screen that is colored different shades of gray to simulate dimming.
//It passes all touches through to views under it (with _ignoresHitTest)
@implementation BluWindow

- (BluWindow *)init {

	if( [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0f ){
		self = [super init];
	}
	else {
		self = [super initWithFrame:[UIScreen mainScreen].bounds];
	}
	
	if (self) {
		UIColor *color = [UIColor colorWithHue:0 saturation:1.0f brightness:0.5f alpha:1.0f];
		self.backgroundColor = color;
		self.windowLevel = 1000001;
		self.alpha = 0.45;
		self.hidden = YES;

		//Allows Blu on the lockscreen when a passcode is set (iOS 8+)
		if ([self respondsToSelector:@selector(_setSecure:)])
			[self _setSecure:YES];
	}
	return self;
}

//Prevents touches from being blocked by the window
- (BOOL)_ignoresHitTest {
	return YES;
}

@end
