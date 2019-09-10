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

## Tests

Currently the following tests are executed on each target:
- lava-smoketest

### lava-smoketest

The lava smoke tests are part of http://git.linaro.org/lava-team/lava-functional-tests.git
and check machine data from the target.
