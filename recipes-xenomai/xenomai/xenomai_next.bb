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

require xenomai.inc

SRC_URI = " \
    git://gitlab.denx.de/Xenomai/xenomai.git;protocol=https;branch=next"
SRCREV = "next"
PV = "9999-next"

S = "${WORKDIR}/git"

dpkg_runbuild_prepend() {
    bbplain $(printf "xenomai-next: Building revision %.12s\n" \
                     $(cat ${S}/.git/refs/heads/next))

    sudo chroot ${BUILDCHROOT_DIR} sh -c "cd ${PP}/${PPS}; scripts/bootstrap"
}
