################################################################################
#
# python-kiwisolver
#
################################################################################

PYTHON_KIWISOLVER_VERSION = 1.0.1
PYTHON_KIWISOLVER_SOURCE = kiwisolver-$(PYTHON_KIWISOLVER_VERSION).tar.gz
PYTHON_KIWISOLVER_SITE = https://pypi.python.org/packages/31/60/494fcce70d60a598c32ee00e71542e52e27c978e5f8219fae0d4ac6e2864
PYTHON_KIWISOLVER_SETUP_TYPE = setuptools
PYTHON_KIWISOLVER_LICENSE = MIT
PYTHON_KIWISOLVER_LICENSE_FILES = LICENSE

$(eval $(python-package))
