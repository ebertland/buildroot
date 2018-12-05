################################################################################
#
# python-scipy
#
# "disutils does not properly support cross-compiling".
# see: https://github.com/scipy/scipy/issues/8571
#
################################################################################

PYTHON_SCIPY_VERSION = 1.1.0
PYTHON_SCIPY_SOURCE = scipy-$(PYTHON_SCIPY_VERSION).tar.gz
PYTHON_SCIPY_SITE = https://pypi.python.org/packages/07/76/7e844757b9f3bf5ab9f951ccd3e4a8eed91ab8720b0aac8c2adcc2fdae9f
PYTHON_SCIPY_SETUP_TYPE = setuptools
PYTHON_SCIPY_LICENSE = BSD
PYTHON_SCIPY_LICENSE_FILES = LICENSE

PYTHON_SCIPY_ENV += FC=$(TARGET_CROSS)gfortran
PYTHON_SCIPY_ENV += LDFLAGS=-L$(STAGING_DIR)/usr/lib/python3.6/site-packages/numpy/core/lib

# force openblas
PYTHON_SCIPY_DEPENDENCIES += openblas
PYTHON_SCIPY_SITE_CFG_LIBS += openblas

ifeq ($(BR2_PACKAGE_LAPACK),y)
PYTHON_SCIPY_DEPENDENCIES += lapack
PYTHON_SCIPY_SITE_CFG_LIBS += blas lapack
endif

ifeq ($(BR2_PACKAGE_CLAPACK),y)
PYTHON_SCIPY_DEPENDENCIES += clapack
PYTHON_SCIPY_SITE_CFG_LIBS += blas lapack
endif

define PYTHON_SCIPY_CONFIGURE_CMDS
	-rm -f $(@D)/site.cfg
	echo "[DEFAULT]" >> $(@D)/site.cfg
	echo "library_dirs = $(STAGING_DIR)/usr/lib" >> $(@D)/site.cfg
	echo "include_dirs = $(STAGING_DIR)/usr/include" >> $(@D)/site.cfg
	echo "libraries =" $(subst $(space),$(comma),$(PYTHON_SCIPY_SITE_CFG_LIBS)) >> $(@D)/site.cfg
endef

$(eval $(python-package))

