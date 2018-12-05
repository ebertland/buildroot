################################################################################
#
# python-matplotlib
#
# see: https://matplotlib.org/users/installing.html
#
################################################################################

PYTHON_MATPLOTLIB_VERSION = 3.0.2
PYTHON_MATPLOTLIB_SOURCE = matplotlib-$(PYTHON_MATPLOTLIB_VERSION).tar.gz
PYTHON_MATPLOTLIB_SITE = https://pypi.python.org/packages/89/0c/653aec68e9cfb775c4fbae8f71011206e5e7fe4d60fcf01ea1a9d3bc957f
PYTHON_MATPLOTLIB_SETUP_TYPE = setuptools
PYTHON_MATPLOTLIB_LICENSE = MIT
PYTHON_MATPLOTLIB_LICENSE_FILES = LICENSE
PYTHON_MATPLOTLIB_DEPENDENCIES = host-python-numpy

define PYTHON_MATPLOTLIB_CONFIGURE_CMDS
    -rm -f $(@D)/setup.cfg
    echo "[directories]" >> $(@D)/setup.cfg
    echo "basedirlist = $(STAGING_DIR)/usr" >> $(@D)/setup.cfg
endef

$(eval $(python-package))
