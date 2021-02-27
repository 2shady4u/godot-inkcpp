# Android.mk
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := godot-prebuilt
ifeq ($(TARGET_ARCH_ABI),x86)
    LOCAL_SRC_FILES := godot-cpp/bin/libgodot-cpp.android.release.x86.a
endif
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
    LOCAL_SRC_FILES := godot-cpp/bin/libgodot-cpp.android.release.armv7.a
endif
ifeq ($(TARGET_ARCH_ABI),arm64-v8a)
    LOCAL_SRC_FILES := godot-cpp/bin/libgodot-cpp.android.release.arm64v8.a
endif
include $(PREBUILT_STATIC_LIBRARY)

# inkcpp
include $(CLEAR_VARS)
LOCAL_MODULE := inkcpp
LOCAL_CPPFLAGS := -std=c++17
LOCAL_C_INCLUDES := \
inkcpp/shared/public/ \
inkcpp/shared/private/ \
inkcpp/inkcpp/include/ \

LOCAL_SRC_FILES := $(wildcard $(LOCAL_PATH)/inkcpp/inkcpp/*.cpp)

include $(BUILD_STATIC_LIBRARY)

# inkcpp_compiler
include $(CLEAR_VARS)
LOCAL_MODULE := inkcpp_compiler
LOCAL_CPPFLAGS := -std=c++17
LOCAL_C_INCLUDES := \
inkcpp/shared/public/ \
inkcpp/shared/private/ \
inkcpp/inkcpp_compiler/include/ \

LOCAL_SRC_FILES := $(wildcard $(LOCAL_PATH)/inkcpp/inkcpp_compiler/*.cpp)
LOCAL_CPPFLAGS := \
-DINK_COMPILER \
-DINK_EXPOSE_JSON \

include $(BUILD_STATIC_LIBRARY)

# libgdinkcpp
include $(CLEAR_VARS)
LOCAL_MODULE := libgdinkcpp
LOCAL_CPPFLAGS := -std=c++17
LOCAL_CPP_FEATURES := rtti exceptions
LOCAL_LDLIBS := -llog

LOCAL_SRC_FILES := \
src/gdinkcpp.cpp \
src/library.cpp \

LOCAL_C_INCLUDES := \
inkcpp/shared/public/ \
inkcpp/shared/private/ \
inkcpp/inkcpp/include/ \
inkcpp/inkcpp_compiler/include/ \
godot-cpp/godot-headers \
godot-cpp/include/ \
godot-cpp/include/core \
godot-cpp/include/gen \
src/ \

LOCAL_STATIC_LIBRARIES := \
godot-prebuilt \
inkcpp \
inkcpp_compiler \

include $(BUILD_SHARED_LIBRARY)