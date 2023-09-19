#import "BluController.h"

BOOL enabledBeforeScreenshot = NO;

//These hooks are used to disable Blu temporarily when a screenshot is taken
//If these weren't here, Blu would make the screenshot dark.
%hook SBScreenShotter

- (void)saveScreenshot:(BOOL)arg1 {
	enabledBeforeScreenshot = [BluController sharedInstance].enabled;
	[[BluController sharedInstance] window].hidden = YES;

	if (enabledBeforeScreenshot) {
		//Give the window a small amount of time to disappear before taking the screenshot
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.05 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
			%orig;
		});
	}
	else
		%orig;
}

- (void)finishedWritingScreenshot:(id)arg1 didFinishSavingWithError:(id)arg2 context:(void *)arg3 {
	%orig;
	[[BluController sharedInstance] window].hidden = !enabledBeforeScreenshot;
}

%end

//Used to disable Blu during screenshots on 9.3+
%hook SBScreenshotManager

- (void)saveScreenshotsWithCompletion:(void (^)(void))arg1 {
	enabledBeforeScreenshot = [BluController sharedInstance].enabled;
	[[BluController sharedInstance] window].hidden = YES;

	void (^completionBlock)(void) = ^() {
		if (arg1)
			arg1();
		[[BluController sharedInstance] window].hidden = !enabledBeforeScreenshot;
	};

	if (enabledBeforeScreenshot) {
		//Give the window a small amount of time to disappear before taking the screenshot
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.05 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
			%orig(completionBlock);
		});
	}
	else 
		%orig;
}

%end

//Called when any preference is changed in the settings pane
void prefsChanged() {
	[[BluController sharedInstance] updateFromPreferences];
}
 
%ctor {

CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)prefsChanged, CFSTR("com.traw.blu-prefschanged"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);

	[BluController sharedInstance]; //Initialize dim controller
	

}
