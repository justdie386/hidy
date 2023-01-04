TARGET := iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = hidy
hidy_FILES = Tweak.x
hidy_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += hidyprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
