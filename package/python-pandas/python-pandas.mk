################################################################################
#
# python-pandas
#
################################################################################

PYTHON_PANDAS_VERSION = 0.23.4
PYTHON_PANDAS_SOURCE = pandas-$(PYTHON_PANDAS_VERSION).tar.gz
PYTHON_PANDAS_SITE = https://pypi.python.org/packages/e9/ad/5e92ba493eff96055a23b0a1323a9a803af71ec859ae3243ced86fcbd0a4
PYTHON_PANDAS_SETUP_TYPE = setuptools
PYTHON_PANDAS_LICENSE = MIT
PYTHON_PANDAS_LICENSE_FILES = LICENSE

$(eval $(python-package))
