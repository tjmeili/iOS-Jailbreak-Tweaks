ARCHS = armv7 arm64
TARGET = iphone:clang:latest:8.0
THEOS_PLATFORM_DEB_COMPRESSION_LEVEL = 6

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = Blu
Blu_FILES = Blu.mm
Blu_INSTALL_PATH = /Library/PreferenceBundles
Blu_FRAMEWORKS = UIKit
Blu_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/Blu.plist$(ECHO_END)
