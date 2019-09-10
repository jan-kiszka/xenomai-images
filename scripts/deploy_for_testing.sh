#!/bin/sh

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
set -e
TARGET="$1"

if [ -z "${TARGET}" ]; then
    exit -1
fi
IMAGES_DIR=build/tmp/deploy/images

if [ -z "${LAVA_USER}" ] || [ -z "${LAVA_HOST}" ]  || [ -z "${LAVA_PORT}" ]; then
    echo "Lava environment not available or incomplete - do not deploy"
    exit 0
fi

LAVA_MASTER="${LAVA_USER}@${LAVA_HOST}"
#KERNEL
scp -P ${LAVA_PORT} ${IMAGES_DIR}/${TARGET}/demo-image-xenomai-demo-${TARGET}-vmlinuz \
    ${LAVA_MASTER}:/var/lib/lava/artifacts
# INITRD
scp -P ${LAVA_PORT} ${IMAGES_DIR}/${TARGET}/demo-image-xenomai-demo-${TARGET}-initrd.img \
    ${LAVA_MASTER}:/var/lib/lava/artifacts
# ROOTFS
scp -P ${LAVA_PORT} ${IMAGES_DIR}/${TARGET}/demo-image-xenomai-demo-${TARGET}.* \
    ${LAVA_MASTER}:/var/lib/lava/artifacts
# DTB
DTB="${IMAGES_DIR}/${TARGET}/*.dtb"
if [ -e ${DTB} ]; then
    scp -P ${LAVA_PORT} ${DTB} ${LAVA_MASTER}:/var/lib/lava/artifacts
fi
