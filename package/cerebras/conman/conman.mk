CONMAN_VERSION = 6a08eb2d5bfde0e7e31ae74f196d00e51c1214f1
CONMAN_SITE = https://github.com/dun/conman.git
CONMAN_SITE_METHOD = git
CONMAN_LICENSE = GPLv3
CONMAN_LICENSE_FILES = COPYING3

CONMAN_BUILDOPTS = CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" CFLAGS="$(TARGET_CFLAGS)" LD="$(TARGET_LD)" XC_BUILD="$(XC_BUILD)" XC_TGT="$(XC_TGT)" XC_HOST="$(XC_HOST) "

define CONMAN_CONFIGURE_CMDS
	(cd $(@D); \
		./configure --host=arm --prefix=$(TARGET_DIR) \
	)
endef

define CONMAN_BUILD_CMDS
        $(MAKE) -C $(@D) $(CONMAN_BUILDOPTS)
endef

define CONMAN_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) install
endef

define CONMAN_CLEAN_CMDS
        $(MAKE) -C $(@D) clean
endef

$(eval $(generic-package))
