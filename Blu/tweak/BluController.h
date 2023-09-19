#import "BluWindow.h"

@interface BluController : NSObject {
	NSUserDefaults *prefs;
}

@property (nonatomic) BOOL enabled;
@property (nonatomic) float temperature;
@property (nonatomic) float intensity;
@property (nonatomic) float brightness;

+ (BluController*)sharedInstance;
- (BluWindow*)window;
- (void)updateFromPreferences;

@end