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

LAVA_MASTER_PORT=28080
if [ -n "${LAVA_SSH_PORT}" ]; then
    LAVA_SSH_PORT="-p ${LAVA_SSH_PORT}"
fi
LAVA_SSH_DESTINATION="${LAVA_SSH_USER}@${LAVA_SSH_HOST}"
# open connection for ssh port forwarding
ssh -N ${LAVA_SSH_PORT} -o 'LocalForward localhost:'${LAVA_MASTER_PORT}' localhost:80' ${LAVA_SSH_DESTINATION} &
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
LAVA_MASTER_URI=http://localhost:${LAVA_MASTER_PORT}

if [ -z "${TARGET}" ]; then
    echo "no target was given"
    exit -1
fi
artifact_url="${LAVA_ARTIFACTS_URL:-'http://localhost/artifacts'}"

# connect to lava master
lavacli identities add --token ${LAVA_MASTER_TOKEN} --uri ${LAVA_MASTER_URI} --username ${LAVA_MASTER_ACCOUNT} default

#generate lava job description from template
DEPLOY_URL="${artifact_url}/${CI_PIPELINE_ID}"
template=$(cat tests/jobs/xenomai-${TARGET}.yml)
test_id=$(eval "cat <<EOF ${template}
EOF" | lavacli jobs submit -)
lavacli jobs logs ${test_id}
lavacli results ${test_id}
# change return code to generate a error in gitlab-ci if a test is failed
number_of_fails=$(lavacli results ${test_id} | grep fail | wc -l)
if [ "${number_of_fails}" -gt "0" ]; then
    exit 1
fi
