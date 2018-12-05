################################################################################
#
# python-seaborn
#
################################################################################

PYTHON_SEABORN_VERSION = 0.9.0
PYTHON_SEABORN_SOURCE = seaborn-$(PYTHON_SEABORN_VERSION).tar.gz
PYTHON_SEABORN_SITE = https://pypi.python.org/packages/7a/bf/04cfcfc9616cedd4b5dd24dfc40395965ea9f50c1db0d3f3e52b050f74a5
PYTHON_SEABORN_SETUP_TYPE = setuptools
PYTHON_SEABORN_LICENSE = BSD
PYTHON_SEABORN_LICENSE_FILES = LICENSE

$(eval $(python-package))
