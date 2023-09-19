#import <UIKit/UIKit.h>
#import <Preferences/PSListController.h>

@interface BluListController: PSListController
@end

@implementation BluListController

- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Blu" target:self] retain];
	}
	return _specifiers;
}

@end
