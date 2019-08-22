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

require recipes-kernel/linux/linux-xenomai.inc

SRC_URI_append_amd64 = " git://gitlab.denx.de/Xenomai/ipipe-x86.git;protocol=https;branch=ipipe-x86-4.14.y"
SRCREV_amd64 = "fdfa1aff4578edf6a03e2e77ea20bf7f97863954"
PV_amd64 = "4.14.134+"

SRC_URI_append_arm64 = " git://gitlab.denx.de/Xenomai/ipipe-arm64.git;protocol=https;branch=stable/4.14.78-arm64"
SRCREV_arm64 = "dec5e42fd43de238df816b31cadfb83b268b7136"
PV_arm64 = "4.14.78+"

SRC_URI_append_armhf = " git://gitlab.denx.de/Xenomai/ipipe-arm.git;protocol=https;branch=stable/4.14.96-arm"
SRCREV_armhf = "723539db0d5a1c995c9bb5524abe311a97b33e43"
PV_armhf = "4.14.96+"

S = "${WORKDIR}/git"
