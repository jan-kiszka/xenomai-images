# Xenomai Demonstration and Test Images

This generates a number of bootable image for virtual and real targets in order
to run the Xenomai real-time system, for evaluation or testing purposes. The
layer may also be used to build real applications on top.

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

    kas-docker --isar build kas.yml

This image can be run using `start-qemu.sh x86`.
