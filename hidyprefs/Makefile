TARGET := iphone:clang:latest:14.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = hidyprefs

hidyprefs_FILES = XXXRootListController.m
hidyprefs_FRAMEWORKS = UIKit
hidyprefs_PRIVATE_FRAMEWORKS = Preferences
hidyprefs_INSTALL_PATH = /Library/PreferenceBundles
hidyprefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
