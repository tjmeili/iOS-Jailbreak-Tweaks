#import "BluController.h"
#import <objc/runtime.h>

const CGFloat MAX_ALPHA = 0.8; //So the user can see their screen, even at max darkness

@implementation BluController

+ (BluController*)sharedInstance {
	static dispatch_once_t p = 0;
    __strong static BluController* sharedObject = nil;
    dispatch_once(&p, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}

// NEW
- (id)init {
	if (self = [super init]) {
		prefs = [[NSUserDefaults alloc] initWithSuiteName:@"com.traw.blu"];
		[prefs registerDefaults:@{
			@"enabled": @NO,
			@"temperature": [NSNumber numberWithFloat:0.5],
			@"intensity": [NSNumber numberWithFloat:0.5],
			@"brightness": [NSNumber numberWithFloat:0.5],
			
		}];
	}
	return self;
}

// Used for lazy initialization of the window.
// If the window is loaded too quickly as SpringBoard is launching, it won't appear.
// Also, this fixes a bug causing a respring after using the 9.3.3 jailbreak
- (BluWindow*)window {
	static BluWindow* bluWindow = nil;
	if (!bluWindow) {
		bluWindow = [[BluWindow alloc] init];
	}
	return bluWindow;
}

- (float)alphaForBrightness:(float)b {
	return (1 - b) * MAX_ALPHA; //alpha = 1 means fully opaque (fully dark)
}

// NEW
- (void)updateFromPreferences {
	[self window].hidden = ![prefs boolForKey:@"enabled"];
	[self window].alpha = [self alphaForBrightness:[prefs floatForKey:@"intensity"]];
	UIColor *color = [UIColor colorWithHue:[prefs floatForKey:@"temperature"] saturation:1.0f brightness:[prefs floatForKey:@"brightness"] alpha:1.0f];
	[self window].backgroundColor = color;
}

- (void)setEnabled:(BOOL)e {
	[self window].hidden = !e;
	[prefs setBool:e forKey:@"enabled"];
}

- (BOOL)enabled {
	return ![self window].hidden;
}

- (void)setBrightness:(float)b {
	if (b > 1)
		b = 1;
	else if (b < 0)
		b = 0;

	[self window].alpha = [self alphaForBrightness:b];
	[prefs setFloat:b forKey:@"brightness"];
}

- (float)brightness {
	return 1 - ([self window].alpha / MAX_ALPHA);
}

@end