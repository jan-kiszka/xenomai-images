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

inherit dpkg-raw

DESCRIPTION = "demo image customizations"

SRC_URI = " \
    file://postinst \
    file://ethernet \
    file://99-silent-printk.conf"

DEBIAN_DEPENDS = "passwd"

do_install() {
	install -v -d ${D}/etc/network/interfaces.d
	install -v -m 644 ${WORKDIR}/ethernet ${D}/etc/network/interfaces.d/

	install -v -d ${D}/etc/sysctl.d
	install -v -m 644 ${WORKDIR}/99-silent-printk.conf ${D}/etc/sysctl.d/
}
