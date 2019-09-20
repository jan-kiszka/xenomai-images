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

SRC_URI_append_amd64 = " git://gitlab.denx.de/Xenomai/ipipe-x86.git;protocol=https;nobranch=1"
SRCREV_amd64 ?= "f83bda3e0785ae2e0ea8ad530bc903d2b420c2c7"
PV_amd64 ?= "4.19.66+"

SRC_URI_append_arm64 = " git://gitlab.denx.de/Xenomai/ipipe-arm64.git;protocol=https;nobranch=1"
SRCREV_arm64 ?= "ipipe-core-4.19.55-arm64-2"
PV_arm64 ?= "4.19.55+"


SRC_URI_append_armhf = " git://gitlab.denx.de/Xenomai/ipipe-arm.git;protocol=https;nobranch=1"
SRCREV_armhf ?= "ipipe-core-4.19.55-arm-3"
PV_armhf ?= "4.19.55+"

S = "${WORKDIR}/git"
