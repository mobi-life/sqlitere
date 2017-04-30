
LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE:= libsqliteRE

#optimize for size
#LOCAL_CFLAGS    := -Os

LOCAL_CFLAGS += -DSQLITE_HAS_CODEC

# This is important - it causes SQLite to use memory for temp files. Since 
# Android has no globally writable temp directory, if this is not defined the
# application throws an exception when it tries to create a temp file.
#
LOCAL_CFLAGS += -DSQLITE_TEMP_STORE=3

LOCAL_CPPFLAGS += -fvisibility=hidden
LOCAL_CFLAGS += -fvisibility=hidden

#  removes unused functions
LOCAL_CPPFLAGS += -ffunction-sections -fdata-sections
LOCAL_CFLAGS += -ffunction-sections -fdata-sections 
LOCAL_LDFLAGS += -Wl,--gc-sections
# removes unused functions

LOCAL_CFLAGS += -DHAVE_CONFIG_H -DKHTML_NO_EXCEPTIONS -DGKWQ_NO_JAVA
LOCAL_CFLAGS += -DNO_SUPPORT_JS_BINDING -DQT_NO_WHEELEVENT -DKHTML_NO_XBL
LOCAL_CFLAGS += -U__APPLE__
LOCAL_CFLAGS += -DHAVE_STRCHRNUL=0
LOCAL_CFLAGS += -Wno-unused-parameter -Wno-int-to-pointer-cast
LOCAL_CFLAGS += -Wno-maybe-uninitialized -Wno-parentheses
LOCAL_CPPFLAGS += -Wno-conversion-null


ifeq ($(TARGET_ARCH), arm)
	LOCAL_CFLAGS += -DPACKED="__attribute__ ((packed))"
else
	LOCAL_CFLAGS += -DPACKED=""
endif

LOCAL_CFLAGS += -DSQLITE_THREADSAFE=2
LOCAL_CFLAGS += -DSQLITE_ENABLE_FTS3 -DSQLITE_ENABLE_FTS3_PARENTHESIS -DSQLITE_ENABLE_FTS4
LOCAL_CFLAGS += -DSQLITE_ENABLE_RTREE
LOCAL_CFLAGS += -DHAVE_CONFIG_H -DSUPPORT_PCRE8

# includes
LOCAL_C_INCLUDES := $(LOCAL_PATH)/sqlite-amalgamation
LOCAL_C_INCLUDES += $(LOCAL_PATH)/pcre-8.37
LOCAL_C_INCLUDES += $(LOCAL_PATH)/pcre-8.37-generic
LOCAL_C_INCLUDES += $(LOCAL_PATH)/codec

# sqlite amalgamation source code
LOCAL_SRC_FILES := modules.c

# regexp module

LOCAL_SRC_FILES += pcre-8.37/pcre_byte_order.c
LOCAL_SRC_FILES += pcre-8.37/pcre_compile.c
LOCAL_SRC_FILES += pcre-8.37/pcre_config.c
LOCAL_SRC_FILES += pcre-8.37/pcre_dfa_exec.c
LOCAL_SRC_FILES += pcre-8.37/pcre_exec.c
LOCAL_SRC_FILES += pcre-8.37/pcre_fullinfo.c
LOCAL_SRC_FILES += pcre-8.37/pcre_get.c
LOCAL_SRC_FILES += pcre-8.37/pcre_globals.c
LOCAL_SRC_FILES += pcre-8.37/pcre_jit_compile.c
LOCAL_SRC_FILES += pcre-8.37/pcre_maketables.c
LOCAL_SRC_FILES += pcre-8.37/pcre_newline.c
LOCAL_SRC_FILES += pcre-8.37/pcre_ord2utf8.c
LOCAL_SRC_FILES += pcre-8.37/pcre_printint.c
LOCAL_SRC_FILES += pcre-8.37/pcre_refcount.c
LOCAL_SRC_FILES += pcre-8.37/pcre_string_utils.c
LOCAL_SRC_FILES += pcre-8.37/pcre_study.c
LOCAL_SRC_FILES += pcre-8.37/pcre_tables.c
LOCAL_SRC_FILES += pcre-8.37/pcre_ucd.c
LOCAL_SRC_FILES += pcre-8.37/pcre_valid_utf8.c
LOCAL_SRC_FILES += pcre-8.37/pcre_version.c
LOCAL_SRC_FILES += pcre-8.37/pcre_xclass.c
LOCAL_SRC_FILES += pcre-8.37-generic/pcre_chartables.c

# android native helper classes
LOCAL_SRC_FILES+=                             \
	android_database_SQLiteCommon.cpp     \
	android_database_SQLiteConnection.cpp \
	android_database_SQLiteGlobal.cpp     \
	android_database_SQLiteDebug.cpp      \
	JNIHelp.cpp JniConstants.cpp

LOCAL_C_INCLUDES += $(LOCAL_PATH) $(LOCAL_PATH)/nativehelper/

LOCAL_LDLIBS += -ldl -llog 

include $(BUILD_SHARED_LIBRARY)
