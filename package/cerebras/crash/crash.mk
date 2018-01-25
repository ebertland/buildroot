CRASH_VERSION = 94b8342c71ae65ae049b406fdb5d23f4c16baceb
CRASH_SITE = git://github.com/crash-utility/crash
CRASH_SITE_METHOD = git
CRASH_LICENSE = GPLv3
CRASH_LICENSE_FILES = COPYING3

CRASH_VERSION_NUMBER = 7.1.2
CRASH_GDB_VERSION = 7.6
CRASH_GDB_SOURCE = gdb-$(CRASH_GDB_VERSION).tar.gz

#
# crash build automatically downloads GDB as part of its build. Force it to
# use saved local copy of same GDB version
#
DOWNLOADS = /cb/platform/downloads

CRASH_BUILDOPTS = CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" CFLAGS="$(TARGET_CFLAGS)" LD="$(TARGET_LD)" AR="$(TARGET_AR)" RPMPKG=$(CRASH_VERSION_NUMBER) GDB_TARGET=$(GNU_TARGET_NAME) GDB_HOST=$(GNU_HOST_NAME)

define CRASH_CONFIGURE_CMDS
	(cd $(@D); \
	    sed -i s/FORCE_DEFINE_ARCH/ARM64/g configure.c && \
	    sed -i -e 's/#define TARGET_CFLAGS_ARM_ON_X86_64.*/#define TARGET_CFLAGS_ARM_ON_X86_64\t\"TARGET_CFLAGS=-D_FILE_OFFSET_BITS=64\"/g' configure.c && \
	    sed -i 's/&gt;/>/g' Makefile)
endef

define CRASH_BUILD_CMDS
        if [ ! -e $(@D)/$(CRASH_GDB_SOURCE) ]; then cp $(DOWNLOADS)/$(CRASH_GDB_SOURCE) $(@D); fi
        $(MAKE) -C $(@D) $(CRASH_BUILDOPTS)
endef

define CRASH_INSTALL_TARGET_CMDS
        $(INSTALL) -D -m 0755 $(@D)/crash $(TARGET_DIR)/usr/sbin/crash
endef

define CRASH_CLEAN_CMDS
        $(MAKE) -C $(@D) clean
endef

$(eval $(generic-package))
