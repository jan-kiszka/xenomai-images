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

require recipes-kernel/linux/linux-xenomai.inc

SRC_URI_append_amd64 = " git://gitlab.denx.de/Xenomai/ipipe-x86.git;protocol=https;branch=ipipe-x86-4.19.y"
SRCREV_amd64 = "${AUTOREV}"

SRC_URI_append_arm64 = " git://gitlab.denx.de/Xenomai/ipipe-arm64.git;protocol=https;branch=ipipe/master"
SRCREV_arm64 = "${AUTOREV}"


SRC_URI_append_armhf = " git://gitlab.denx.de/Xenomai/ipipe-arm.git;protocol=https;branch=ipipe/master"
SRCREV_armhf = "${AUTOREV}"
S = "${WORKDIR}/git"

