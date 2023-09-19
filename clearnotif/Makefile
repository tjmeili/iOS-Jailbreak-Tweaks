ARCHS = armv7 armv7s arm64
TARGET = iphone:clang:latest:8.0
THEOS_PLATFORM_DEB_COMPRESSION_LEVEL = 6


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ClearNotif
ClearNotif_FILES = Tweak.xm
ClearNotif_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
