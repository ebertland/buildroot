################################################################################
#
# python-numpy
#
################################################################################

PYTHON_NUMPY_VERSION = 1.15.4
PYTHON_NUMPY_SOURCE = numpy-$(PYTHON_NUMPY_VERSION).zip
PYTHON_NUMPY_SITE = https://pypi.python.org/packages/2d/80/1809de155bad674b494248bcfca0e49eb4c5d8bee58f26fe7a0dd45029e2
PYTHON_NUMPY_LICENSE = BSD-3-Clause
PYTHON_NUMPY_LICENSE_FILES = LICENSE.txt
PYTHON_NUMPY_SETUP_TYPE = setuptools

PYTHON_NUMPY_ENV += FC=$(TARGET_CROSS)gfortran

PYTHON_NUMPY_BUILD_OPTS = --fcompiler=gnu95

# force openblas
PYTHON_NUMPY_DEPENDENCIES += openblas
PYTHON_NUMPY_SITE_CFG_LIBS += openblas

ifeq ($(BR2_PACKAGE_LAPACK),y)
PYTHON_NUMPY_DEPENDENCIES += lapack
PYTHON_NUMPY_SITE_CFG_LIBS += blas lapack
endif

ifeq ($(BR2_PACKAGE_CLAPACK),y)
PYTHON_NUMPY_DEPENDENCIES += clapack
PYTHON_NUMPY_SITE_CFG_LIBS += blas lapack
endif

define PYTHON_NUMPY_CONFIGURE_CMDS
	-rm -f $(@D)/site.cfg
	echo "[DEFAULT]" >> $(@D)/site.cfg
	echo "library_dirs = $(STAGING_DIR)/usr/lib" >> $(@D)/site.cfg
	echo "include_dirs = $(STAGING_DIR)/usr/include" >> $(@D)/site.cfg
	echo "libraries =" $(subst $(space),$(comma),$(PYTHON_NUMPY_SITE_CFG_LIBS)) >> $(@D)/site.cfg
endef

define HOST_PYTHON_NUMPY_CONFIGURE_CMDS
	-rm -f $(@D)/site.cfg
	echo "[DEFAULT]" >> $(@D)/site.cfg
	echo "library_dirs = $(HOST_DIR)/lib" >> $(@D)/site.cfg
	echo "include_dirs = $(HOST_DIR)/include" >> $(@D)/site.cfg
	echo "libraries =" $(subst $(space),$(comma),$(PYTHON_NUMPY_SITE_CFG_LIBS)) >> $(@D)/site.cfg
endef

define PYTHON_NUMPY_EXTRACT_CMDS
	$(UNZIP) -d $(@D) $(PYTHON_NUMPY_DL_DIR)/$(PYTHON_NUMPY_SOURCE)
	mv $(@D)/numpy-$(PYTHON_NUMPY_VERSION)/* $(@D)
	$(RM) -r $(@D)/numpy-$(PYTHON_NUMPY_VERSION)
endef

define HOST_PYTHON_NUMPY_EXTRACT_CMDS
	$(UNZIP) -d $(@D) $(PYTHON_NUMPY_DL_DIR)/$(PYTHON_NUMPY_SOURCE)
	mv $(@D)/numpy-$(PYTHON_NUMPY_VERSION)/* $(@D)
	$(RM) -r $(@D)/numpy-$(PYTHON_NUMPY_VERSION)
endef

# Some package may include few headers from NumPy, so let's install it
# in the staging area.
PYTHON_NUMPY_INSTALL_STAGING = YES

$(eval $(python-package))
$(eval $(host-python-package))
