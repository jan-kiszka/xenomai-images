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

require recipes-kernel/linux/linux-custom.inc

KERNEL_DEFCONFIG = "${DISTRO_ARCH}_defconfig"

SRC_URI += "file://${KERNEL_DEFCONFIG}"

DEPENDS += "xenomai-kernel-source"
KBUILD_DEPENDS += "xenomai-kernel-source"

dpkg_runbuild_prepend() {
	case ${DISTRO_ARCH} in
	armhf)
		ARCH=arm
		;;
	arm64)
		ARCH=arm64
		;;
	amd64)
		ARCH=x86
		;;
	*)
		bberror "Unsupported architecture ${DISTRO_ARCH}"
		exit 1
	esac

	sudo chroot ${BUILDCHROOT_DIR} \
		/usr/src/xenomai-kernel-source/scripts/prepare-kernel.sh \
			--linux=${PP}/${PPS} --arch=$ARCH
}
