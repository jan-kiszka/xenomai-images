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
    git://gitlab.denx.de/Xenomai/xenomai.git;protocol=https;branch=master"
SRCREV = "${AUTOREV}"
PV = "master"
S = "${WORKDIR}/git"

