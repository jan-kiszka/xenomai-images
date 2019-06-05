#!/bin/sh
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

usage()
{
	echo "Usage: $0 ARCHITECTURE [QEMU_OPTIONS]"
	echo -e "\nSet QEMU_PATH environment variable to use a locally " \
		"built QEMU version"
	exit 1
}

if [ -n "${QEMU_PATH}" ]; then
	QEMU_PATH="${QEMU_PATH}/"
fi

case "$1" in
	x86|x86_64|amd64)
		DISTRO_ARCH=amd64
		QEMU=qemu-system-x86_64
		QEMU_EXTRA_ARGS=" \
			-cpu host -smp 4 \
			-enable-kvm -machine q35 \
			-device ide-hd,drive=disk \
			-device virtio-net-pci,netdev=net"
		KERNEL_CMDLINE=" \
			root=/dev/sda vga=0x305"
		;;
	arm64|aarch64)
		DISTRO_ARCH=arm64
		QEMU=qemu-system-aarch64
		QEMU_EXTRA_ARGS=" \
			-cpu cortex-a57 \
			-smp 4 \
			-machine virt \
			-device virtio-serial-device \
			-device virtconsole,chardev=con -chardev vc,id=con \
			-device virtio-blk-device,drive=disk \
			-device virtio-net-device,netdev=net"
		KERNEL_CMDLINE=" \
			root=/dev/vda"
		;;
	arm|armhf)
		DISTRO_ARCH=armhf
		QEMU=qemu-system-arm
		QEMU_EXTRA_ARGS=" \
			-cpu cortex-a15 \
			-smp 4 \
			-machine virt \
			-device virtio-serial-device \
			-device virtconsole,chardev=con -chardev vc,id=con \
			-device virtio-blk-device,drive=disk \
			-device virtio-net-device,netdev=net"
		KERNEL_CMDLINE=" \
			root=/dev/vda"
		;;
	""|--help)
		usage
		;;
	*)
		echo "Unsupported architecture: $1"
		exit 1
		;;
esac

IMAGE_PREFIX="$(dirname $0)/build/tmp/deploy/images/qemu-${DISTRO_ARCH}/demo-image-xenomai-demo-qemu-${DISTRO_ARCH}"

if [ -z "${DISPLAY}" ]; then
	QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} -nographic"
fi

shift 1

${QEMU_PATH}${QEMU} \
	-drive file=${IMAGE_PREFIX}.ext4.img,discard=unmap,if=none,id=disk,format=raw \
	-m 1G -serial mon:stdio -netdev user,id=net \
	-kernel ${IMAGE_PREFIX}-vmlinuz -append "${KERNEL_CMDLINE}" \
	-initrd ${IMAGE_PREFIX}-initrd.img ${QEMU_EXTRA_ARGS} "$@"
