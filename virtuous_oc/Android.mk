LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := virtuous_oc
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := virtuous_oc.c
LOCAL_LDLIBS := -llog
LOCAL_ALLOW_UNDEFINED_SYMBOLS := true
LOCAL_EXPORT_LDLIBS := -llog
LOCAL_SHARED_LIBRARIES := libcutils
include $(BUILD_EXECUTABLE)
