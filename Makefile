DEBUG=0
THEOS_DEVICE_IP = 192.168.1.237
TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Spotifix

Spotifix_FILES = hooks/Tweak.xm
Spotifix_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
