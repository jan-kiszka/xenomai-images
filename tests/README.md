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

# LAVA Setup

Setup a lava environment by following the
[installation guide](https://docs.lavasoftware.org/lava/first-installation.html)
or use [lava-docker](https://github.com/kernelci/lava-docker).
