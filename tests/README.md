# Testing

For image testing this project uses the
[Linaro Automated Validation Architecture(LAVA)](https://www.lavasoftware.org/).
The images are generate a gitlab-ci pipeline. This pipline builds the images and
sends them to the lava testlab.

## Test targets

following images are test:
- qemu-arm64
- qemu-amd64
- x86-64-efi
- beagle-bone-black

## Deploy test

After the [LAVA setup](#lava-setup) a test can be deploy with the lavacli tool, e.g.:
```
lavacli jobs run tests/jobs/xenomai-qemu-amd64.yml
```

# Tests

Currently the following tests are executed on each target:
- lava-smoketest
- xenomai-test-suite

### lava-smoketest

The lava smoke tests are part of http://git.linaro.org/lava-team/lava-functional-tests.git
and check machine data from the target.

### xenomai-test-suite

The xenomai test suite executes the xeno-test tool from xenomai/testsuite.

# Test Architecture

To test xenomai-images on the target hardware the following architecture
is used:
```
                                                               +----------+
                                                               | Target 1 |
                                                            /--|  beagle  |
+-----------+        +---------+       +---------+    /-----   |  bone    |
|           |        | LAVA    |       | LAVA    | ---         +----------+
| gitlab-   | ------ | master  |------ | Dis-    | --
| runner    |        |         |       | patcher | \ \---      +----------+
+-----------+        +---------+       +---------+  \-   \---  | Target 2 |
                                                      \      \-| x86-64   |
                                                       \       |          |
                                                        \-     +----------+
                                                          \
                                                           \   +----------+
                                                            \- | Target n |
                                                              \| qemu     |
                                                               |          |
                                                               +----------+
```
A test is deployed in the following steps:
1. gitlab-runner: builds the artifacts
2. After the build is successful the build artifacts are deployed to the
   Lava master per scp.
3. The runner sends a lava job description to the LAVA master, who triggers the
job execution on LAVA Dispatcher.

The LAVA master selects the LAVA Dispatcher to execute the given job on a
target. Qemu targets are executed directly on the LAVA Dispatcher. For non-virtual
targets the payload (kernel,rootfs,...) is deployed via tftp to the selected
hardware.

The dispatcher executes the following steps:
1. Instrumentation of the rootfs. This will collect the necessary lavatools
and adds them to the rootfs
2. Power up the target
3. deploy the payload(kernel,rootfs,...) with help of the bootloader
4. trigger the payload boot
5. execute the tests
6. power off the target

# LAVA Setup

Setup a lava environment by following the
[installation guide](https://docs.lavasoftware.org/lava/first-installation.html)
or use [lava-docker](https://github.com/kernelci/lava-docker).
