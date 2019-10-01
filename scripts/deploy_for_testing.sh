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

if [ -z "${LAVA_SSH_USER}" ] || [ -z "${LAVA_SSH_HOST}" ]  || [ -z "${LAVA_SSH_PORT}" ]; then
    echo "Lava environment not available or incomplete - do not deploy"
    exit 0
fi

LAVA_SSH_DESTINATION="${LAVA_SSH_USER}@${LAVA_SSH_HOST}"

LAVA_DEPLOY_DIR=${LAVA_DEPLOY_DIR:-"/var/lib/lava/artifacts"}
DEPLOY_DIR="${LAVA_DEPLOY_DIR}/${CI_PIPELINE_ID}"
ssh -p ${LAVA_SSH_PORT} ${LAVA_SSH_DESTINATION} 'install -d -m 755 "'${DEPLOY_DIR}'"'
#KERNEL
scp -P ${LAVA_SSH_PORT} ${IMAGES_DIR}/${TARGET}/demo-image-xenomai-demo-${TARGET}-vmlinuz \
    ${LAVA_SSH_DESTINATION}:${DEPLOY_DIR}
# INITRD
scp -P ${LAVA_SSH_PORT} ${IMAGES_DIR}/${TARGET}/demo-image-xenomai-demo-${TARGET}-initrd.img \
    ${LAVA_SSH_DESTINATION}:${DEPLOY_DIR}
# ROOTFS
scp -P ${LAVA_SSH_PORT} ${IMAGES_DIR}/${TARGET}/demo-image-xenomai-demo-${TARGET}.* \
    ${LAVA_SSH_DESTINATION}:${DEPLOY_DIR}
# DTB
DTB="${IMAGES_DIR}/${TARGET}/*.dtb"
if [ -e ${DTB} ]; then
    scp -P ${LAVA_SSH_PORT} ${DTB} ${LAVA_SSH_DESTINATION}:${DEPLOY_DIR}
fi
