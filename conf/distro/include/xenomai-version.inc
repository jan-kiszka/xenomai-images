#
# Xenomai Real-Time System
#
# Copyright (c) Siemens AG, 2019
#
# Authors:
#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
#
# SPDX-License-Identifier: MIT
#

XENOMAI_NEXT_KERNEL_VERSION = "4.19%"
XENOMAI_STABLE_VERSION_LIST = "stable 3.0 3.0% 3.0.% 3.0.9"
XENOMAI_STABLE_KERNEL_VERSION = "4.14%"
# if PREFERRED_VERSION_xenomai contains any item from XENOMAI_STABLE_VERSION_LIST use
# XENOMAI_STABLE_KERNEL_VERSION
PREFERRED_VERSION_linux-xenomai ?= "${@bb.utils.contains_any('PREFERRED_VERSION_xenomai','${XENOMAI_STABLE_VERSION_LIST}','${XENOMAI_STABLE_KERNEL_VERSION}','${XENOMAI_NEXT_KERNEL_VERSION}',d) }"
