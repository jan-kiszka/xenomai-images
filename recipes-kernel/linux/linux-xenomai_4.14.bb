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
SRCREV_amd64 = "5dec184b4c190bd3ef4d448fc80c7f2251cfd744"
PV_amd64 = "4.14.78+"

SRC_URI_append_arm64 = " git://gitlab.denx.de/Xenomai/ipipe-arm64.git;protocol=https;branch=stable/4.14.71-arm64"
SRCREV_arm64 = "d24e3f9e425af92f4a181306d22d4b799e71a370"
PV_arm64 = "4.14.71+"

SRC_URI_append_armhf = " git://gitlab.denx.de/Xenomai/ipipe-arm.git;protocol=https;branch=stable/4.14.71-arm"
SRCREV_armhf = "b7600fd089fdcbd5aae5385b42498259924ca2fb"
PV_armhf = "4.14.71+"

S = "${WORKDIR}/git"
