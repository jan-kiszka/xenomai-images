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
LAVA_MASTER_PORT=28080
# open connection for ssh port forwarding
ssh -N  -p ${LAVA_PORT} -o 'LocalForward localhost:'${LAVA_MASTER_PORT}' localhost:80' ${LAVA_MASTER} &
# wait for connection
INTERVAL=1
TIMEOUT=60
until ss -tulw | grep -q "${LAVA_MASTER_PORT}"
do
    if [ ${TIMEOUT} -le 0 ]; then
        echo "could not open connection to LAVA Master"
        exit 1
    fi
    sleep ${INTERVAL}
    TIMEOUT=$(expr ${TIMEOUT} - ${INTERVAL})
done
# connect to lava master
lavacli identities add --token ${LAVA_TOKEN} --uri http://localhost:${LAVA_MASTER_PORT} --username ${LAVA_ACCOUNT} default

test_id=$(lavacli jobs submit tests/jobs/xenomai-${TARGET}.yml)
lavacli jobs logs ${test_id}
lavacli results ${test_id}
# change return code to generate a error in gitlab-ci if a test is failed
number_of_fails=$(lavacli results ${test_id} | grep fail | wc -l)
if [ "${number_of_fails}" -gt "0" ]; then
    exit 1
fi
