THEOS_DEVICE_IP = 192.168.1.145
TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Spotifix

Spotifix_FILES = Tweak.x
Spotifix_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
