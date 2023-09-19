ARCHS = armv7 arm64
THEOS_PACKAGE_DIR_NAME = debs
TARGET = iphone:clang:latest:8.0
THEOS_PLATFORM_DEB_COMPRESSION_LEVEL = 6

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Blu
Blu_FILES = $(wildcard tweak/*.m tweak/*.mm tweak/*.x tweak/*.xm)
Blu_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += preferences
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "killall -9 SpringBoard"