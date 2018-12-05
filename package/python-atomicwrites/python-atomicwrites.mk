################################################################################
#
# python-atomicwrites
#
################################################################################

PYTHON_ATOMICWRITES_VERSION = 1.2.1
PYTHON_ATOMICWRITES_SOURCE = atomicwrites-$(PYTHON_ATOMICWRITES_VERSION).tar.gz
PYTHON_ATOMICWRITES_SITE = https://pypi.org/packages/ac/ed/a311712ef6b4355035489f665e63e1a73f9eb371929e3c98e5efd451069e
PYTHON_ATOMICWRITES_SETUP_TYPE = setuptools
PYTHON_ATOMICWRITES_LICENSE = MIT
PYTHON_ATOMICWRITES_LICENSE_FILES = LICENSE

$(eval $(python-package))
