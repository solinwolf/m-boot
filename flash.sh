#!/bin/sh
dd iflag=dsync oflag=dsync if=./u-boot-4412.bin of=/dev/sdb seek=1
