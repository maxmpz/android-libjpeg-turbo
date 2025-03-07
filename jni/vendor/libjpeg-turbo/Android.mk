
LOCAL_PATH := $(abspath $(call my-dir))
include $(CLEAR_VARS)

LOCAL_MODULE := libjpeg-turbo

LOCAL_CFLAGS := $(PA_GLOBAL_CFLAGS) -Wno-unused-function 

SOURCE_PATH := $(LOCAL_PATH)/libjpeg-turbo-1.4.1

ifneq ($(filter $(TARGET_ARCH_ABI), armeabi-v7a armeabi-v7a-hard),)
LOCAL_ARM_NEON := true
LOCAL_CFLAGS += -D__ARM_HAVE_NEON
endif
LOCAL_CFLAGS += $(PA_GLOBAL_OVERRIDE_CFLAGS)

LOCAL_ASMFLAGS += -DELF

ifeq ($(TARGET_ARCH_ABI),x86_64)
LOCAL_SRC_FILES += \
    $(SOURCE_PATH)/simd/jsimd_x86_64.c \
    $(SOURCE_PATH)/simd/jfdctflt-sse-64.asm \
    $(SOURCE_PATH)/simd/jccolor-sse2-64.asm \
    $(SOURCE_PATH)/simd/jcgray-sse2-64.asm \
    $(SOURCE_PATH)/simd/jcsample-sse2-64.asm \
    $(SOURCE_PATH)/simd/jdcolor-sse2-64.asm \
    $(SOURCE_PATH)/simd/jdmerge-sse2-64.asm \
    $(SOURCE_PATH)/simd/jdsample-sse2-64.asm \
    $(SOURCE_PATH)/simd/jfdctfst-sse2-64.asm \
    $(SOURCE_PATH)/simd/jfdctint-sse2-64.asm \
    $(SOURCE_PATH)/simd/jidctflt-sse2-64.asm \
    $(SOURCE_PATH)/simd/jidctfst-sse2-64.asm \
    $(SOURCE_PATH)/simd/jidctint-sse2-64.asm \
    $(SOURCE_PATH)/simd/jidctred-sse2-64.asm \
    $(SOURCE_PATH)/simd/jquantf-sse2-64.asm \
    $(SOURCE_PATH)/simd/jquanti-sse2-64.asm \

LOCAL_CFLAGS += \
    -DSIZEOF_SIZE_T=8 \

LOCAL_ASMFLAGS += -D__x86_64__

else ifeq ($(TARGET_ARCH_ABI),x86)
LOCAL_SRC_FILES += \
    $(SOURCE_PATH)/simd/jsimd_i386.c \
    $(SOURCE_PATH)/simd/jsimdcpu.asm \
    $(SOURCE_PATH)/simd/jfdctflt-3dn.asm \
    $(SOURCE_PATH)/simd/jidctflt-3dn.asm \
    $(SOURCE_PATH)/simd/jquant-3dn.asm \
    $(SOURCE_PATH)/simd/jccolor-mmx.asm \
    $(SOURCE_PATH)/simd/jcgray-mmx.asm \
    $(SOURCE_PATH)/simd/jcsample-mmx.asm \
    $(SOURCE_PATH)/simd/jdcolor-mmx.asm \
    $(SOURCE_PATH)/simd/jdmerge-mmx.asm \
    $(SOURCE_PATH)/simd/jdsample-mmx.asm \
    $(SOURCE_PATH)/simd/jfdctfst-mmx.asm \
    $(SOURCE_PATH)/simd/jfdctint-mmx.asm \
    $(SOURCE_PATH)/simd/jidctfst-mmx.asm \
    $(SOURCE_PATH)/simd/jidctint-mmx.asm \
    $(SOURCE_PATH)/simd/jidctred-mmx.asm \
    $(SOURCE_PATH)/simd/jquant-mmx.asm \
    $(SOURCE_PATH)/simd/jfdctflt-sse.asm \
    $(SOURCE_PATH)/simd/jidctflt-sse.asm \
    $(SOURCE_PATH)/simd/jquant-sse.asm \
    $(SOURCE_PATH)/simd/jccolor-sse2.asm \
    $(SOURCE_PATH)/simd/jcgray-sse2.asm \
    $(SOURCE_PATH)/simd/jcsample-sse2.asm \
    $(SOURCE_PATH)/simd/jdcolor-sse2.asm \
    $(SOURCE_PATH)/simd/jdmerge-sse2.asm \
    $(SOURCE_PATH)/simd/jdsample-sse2.asm \
    $(SOURCE_PATH)/simd/jfdctfst-sse2.asm \
    $(SOURCE_PATH)/simd/jfdctint-sse2.asm \
    $(SOURCE_PATH)/simd/jidctflt-sse2.asm \
    $(SOURCE_PATH)/simd/jidctfst-sse2.asm \
    $(SOURCE_PATH)/simd/jidctint-sse2.asm \
    $(SOURCE_PATH)/simd/jidctred-sse2.asm \
    $(SOURCE_PATH)/simd/jquantf-sse2.asm \
    $(SOURCE_PATH)/simd/jquanti-sse2.asm \

LOCAL_CFLAGS += \
    -DSIZEOF_SIZE_T=4 \

else ifneq ($(filter $(TARGET_ARCH_ABI), armeabi-v7a armeabi-v7a-hard),)
LOCAL_SRC_FILES += \
    $(SOURCE_PATH)/simd/jsimd_arm.c \
    $(SOURCE_PATH)/simd/jsimd_arm_neon.S \

LOCAL_CFLAGS += \
    -DSIZEOF_SIZE_T=4 \

else ifeq ($(TARGET_ARCH_ABI),armeabi)
LOCAL_CFLAGS += \
    -DSIZEOF_SIZE_T=4 \

else ifeq ($(TARGET_ARCH_ABI),arm64-v8a)
LOCAL_SRC_FILES += \
    $(SOURCE_PATH)/simd/jsimd_arm64.c \
    $(SOURCE_PATH)/simd/jsimd_arm64_neon.S \

LOCAL_CFLAGS += \
    -DSIZEOF_SIZE_T=8 \

    ifneq (,$(findstring clang,$(NDK_TOOLCHAIN_VERSION))) # clang
        # MaxMP: disabled for NDK=23
        #LOCAL_CFLAGS += -fno-integrated-as # Needed to compile aarch64 S in clang mode, but that is not needed for gcc
        LOCAL_CFLAGS += -Wno-shorten-64-to-32
    endif

endif

# libjpeg_la_SOURCES from Makefile.am
LOCAL_SRC_FILES += \
    $(SOURCE_PATH)/jcapimin.c \
    $(SOURCE_PATH)/jcapistd.c \
    $(SOURCE_PATH)/jccoefct.c \
    $(SOURCE_PATH)/jccolor.c \
    $(SOURCE_PATH)/jcdctmgr.c \
    $(SOURCE_PATH)/jchuff.c \
    $(SOURCE_PATH)/jcinit.c \
    $(SOURCE_PATH)/jcmainct.c \
    $(SOURCE_PATH)/jcmarker.c \
    $(SOURCE_PATH)/jcmaster.c \
    $(SOURCE_PATH)/jcomapi.c \
    $(SOURCE_PATH)/jcparam.c \
    $(SOURCE_PATH)/jcphuff.c \
    $(SOURCE_PATH)/jcprepct.c \
    $(SOURCE_PATH)/jcsample.c \
    $(SOURCE_PATH)/jdapimin.c \
    $(SOURCE_PATH)/jdapistd.c \
    $(SOURCE_PATH)/jdatadst.c \
    $(SOURCE_PATH)/jdatasrc.c \
    $(SOURCE_PATH)/jdcoefct.c \
    $(SOURCE_PATH)/jdcolor.c \
    $(SOURCE_PATH)/jddctmgr.c \
    $(SOURCE_PATH)/jdhuff.c \
    $(SOURCE_PATH)/jdinput.c \
    $(SOURCE_PATH)/jdmainct.c \
    $(SOURCE_PATH)/jdmarker.c \
    $(SOURCE_PATH)/jdmaster.c \
    $(SOURCE_PATH)/jdmerge.c \
    $(SOURCE_PATH)/jdphuff.c \
    $(SOURCE_PATH)/jdpostct.c \
    $(SOURCE_PATH)/jdsample.c \
    $(SOURCE_PATH)/jdtrans.c \
    $(SOURCE_PATH)/jerror.c \
    $(SOURCE_PATH)/jfdctflt.c \
    $(SOURCE_PATH)/jfdctfst.c \
    $(SOURCE_PATH)/jfdctint.c \
    $(SOURCE_PATH)/jidctflt.c \
    $(SOURCE_PATH)/jidctfst.c \
    $(SOURCE_PATH)/jidctint.c \
    $(SOURCE_PATH)/jidctred.c \
    $(SOURCE_PATH)/jquant1.c \
    $(SOURCE_PATH)/jquant2.c \
    $(SOURCE_PATH)/jutils.c \
    $(SOURCE_PATH)/jmemmgr.c \
    $(SOURCE_PATH)/jmemnobs.c \

# if WITH_ARITH_ENC from Makefile.am
LOCAL_SRC_FILES += \
    $(SOURCE_PATH)/jaricom.c \
    $(SOURCE_PATH)/jcarith.c \
    $(SOURCE_PATH)/jdarith.c \

# libturbojpeg_la_SOURCES from Makefile.am
#LOCAL_SRC_FILES += \
#    $(SOURCE_PATH)/turbojpeg.c \
#    $(SOURCE_PATH)/transupp.c \
#    $(SOURCE_PATH)/jdatadst-tj.c \
#    $(SOURCE_PATH)/jdatasrc-tj.c \

LOCAL_C_INCLUDES += \
    $(LOCAL_PATH)/include \

LOCAL_C_INCLUDES += \
    $(SOURCE_PATH)/simd \
    $(SOURCE_PATH) \

LOCAL_EXPORT_C_INCLUDES := \
    $(SOURCE_PATH) \
    $(LOCAL_PATH)/include \

ifeq (,$(findstring -O, $(LOCAL_CFLAGS))) # Check for optimization flag
$(error No -Ox in LOCAL_CFLAGS=$(LOCAL_CFLAGS))
endif
ifneq (false,$(PA_GLOBAL_FLTO))
ifeq (,$(findstring -flto, $(LOCAL_CFLAGS)))
$(error No -flto in LOCAL_CFLAGS=$(LOCAL_CFLAGS))
endif
endif

include $(BUILD_STATIC_LIBRARY)
