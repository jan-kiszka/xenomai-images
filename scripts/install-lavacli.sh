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
# check if Debian 10 or later. If not use the pip version
# of lavacli. The apt version from stretch-backports cannot communicate
# with the lava master on Debian 10.
os_version_id=$(sed -nr 's/VERSION_ID="([0-9]+)"/\1/p' /etc/os-release)
if [ "${os_version_id}" -ge "10" ]; then
    sudo apt update
    sudo apt install -y lavacli
else
    sudo pip3 install wheel
    sudo pip3 install lavacli
fi
