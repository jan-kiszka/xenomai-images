#
# Xenomai Real-Time System
#
# Copyright (c) Siemens AG, 2018
#
# Authors:
#  Jan Kiszka <jan.kiszka@siemens.com>
#
# SPDX-License-Identifier: MIT
#

inherit dpkg

PROVIDES += "xenomai-kernel-source xenomai-runtime"

do_prepare_build() {
	# The xenomai-kernel-source package is supposed to be generic, but we
	# build it per architecture in Isar, and those packages happen to be
	# different in some file so far. Make sure they are pushed into the
	# target architecture to avoid conflicts.
	sudo sed -i 's/Architecture: all/Architecture: any/' ${S}/debian/control
}
