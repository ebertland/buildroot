################################################################################
#
# python-pytest
#
################################################################################

PYTHON_PYTEST_VERSION = 4.0.0
PYTHON_PYTEST_SOURCE = pytest-$(PYTHON_PYTEST_VERSION).tar.gz
PYTHON_PYTEST_SITE = https://pypi.python.org/packages/ec/34/497c3b126966c3b358398084394ea820c63a34d794d708074accf91bcaf3
PYTHON_PYTEST_SETUP_TYPE = setuptools
PYTHON_PYTEST_LICENSE = MIT
PYTHON_PYTEST_LICENSE_FILES = LICENSE
#PYTHON_PYTEST_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
