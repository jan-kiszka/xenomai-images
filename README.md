# Xenomai Demonstration and Test Images

This generates a number of bootable image for virtual and real targets in order
to run the [Xenomai](https://www.xenomai.org) real-time system, for evaluation
or testing purposes. The layer may also be used to build real applications on
top.

The build system used for this is [Isar](https://github.com/ilbers/isar), an
image generator that assembles Debian binaries or builds individual packages
from scratch.

## Building Target Images

Install `kas-docker` from the [kas project](https://github.com/siemens/kas):

    wget https://raw.githubusercontent.com/siemens/kas/master/kas-docker -P ~/bin/
    chmod a+x ~/bin/kas-docker

Furthermore, install docker and make sure you have required permissions to
start containers.

To build, e.g., the QEMU AMD64 target inside Docker, invoke kas-docker like
this:

    kas-docker --isar build kas.yml:board-qemu-amd64.yml

This image can be run using `start-qemu.sh x86`.

The QEMU ARM64 target is selected by `... kas.yml:board-qemu-arm64.yml` and
started via `start-qemu.sh arm64`. Make sure to have `qemu-aarch64-system`
installed.

### Physical Targets

This repository contains recipes for x86 (`board-simatic-ipc227e`),
armhf(`board-beagle-bone-black`) and arm64(`board-hikey`) targets.

Each physical target will generate ready-to-boot images under
`build/tmp/deploy/images/`. To flash, e.g., the HiKey image to an SD card, run

    dd if=build/tmp/deploy/images/hikey/demo-image-hikey-xenomai-demo-hikey.wic.img \
       of=/dev/<medium-device> bs=1M status=progress

## CI Build

The CI build can be executed locally by
[installing the gitlab-runner](https://docs.gitlab.com/runner/install/).

To execute the CI build use:
```
gitlab-runner exec docker --docker-privileged \
  --env "HTTP_PROXY=$HTTP_PROXY" --env "HTTPS_PROXY=$HTTPS_PROXY" \
  --env "NO_PROXY=$NO_PROXY" build:armhf
```

## Community Resources

See [Xenomai project](https://www.xenomai.org/).

Contributions are always welcome. They follow the same
[process](https://gitlab.denx.de/Xenomai/xenomai/blob/master/CONTRIBUTING.md)
that Xenomai is using as well. Please tag you patches additional with
"[xenomai-images]" to indicate which repository they are targeting.

## License

Unless otherwise stated in the respective file, files in this layer are
provided under the MIT license, see COPYING file. Patches (files ending with
.patch) are licensed according to their target project and file, typically
GPLv2.
