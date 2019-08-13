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

require xenomai.inc

SRC_URI = " \
    git://gitlab.denx.de/Xenomai/xenomai.git;protocol=https;branch=stable/v3.0.x;tag=v${PV} \
file://0001-debian-Add-config-folder-to-xenomai-kernel-source.patch \
file://0001-debian-Enable-SMP-in-userspace-package.patch \
    "
S = "${WORKDIR}/git"
