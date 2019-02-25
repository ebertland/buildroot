################################################################################
#
# cpustat
#
################################################################################

CPUSTAT_VERSION = 0.02.07
CPUSTAT_SITE = https://github.com/ColinIanKing/cpustat/archive
CPUSTAT_SOURCE = V$(CPUSTAT_VERSION).zip
CPUSTAT_LICENSE = GPL-2
CPUSTAT_LICENSE_FILES = COPYING

define CPUSTAT_EXTRACT_CMDS
	$(UNZIP) -d $(@D) $(CPUSTAT_DL_DIR)/$(CPUSTAT_SOURCE)
	mv $(@D)/cpustat-$(CPUSTAT_VERSION)/* $(@D)
	$(RM) -r $(@D)/cpustat-$(CPUSTAT_VERSION)
endef

define CPUSTAT_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) \
	    -C $(@D) \
	    CC=$(TARGET_CC) \
	    DESTDIR=$(TARGET_DIR) \
	    install
endef

$(eval $(generic-package))
