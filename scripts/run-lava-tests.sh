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
TARGET=$1

LAVA_MASTER="${LAVA_USER}@${LAVA_HOST}"

# open connection for ssh port forwarding
ssh -N  -p ${LAVA_PORT} -o 'LocalForward localhost:28080 localhost:80' ${LAVA_MASTER} &

# connect to lava master
lavacli identities add --token ${LAVA_TOKEN} --uri http://localhost:28080 --username siemens default

test_id=$(lavacli jobs submit tests/jobs/xenomai-${TARGET}.yml)
lavacli jobs logs ${test_id}
lavacli results ${test_id}
# change return code to generate a error in gitlab-ci if a test is failed
number_of_fails=$(lavacli results ${test_id} | grep fail | wc -l)
if [ "${number_of_fails}" -gt "0" ]; then
    exit 1
fi
