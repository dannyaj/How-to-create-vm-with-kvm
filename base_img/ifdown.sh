#!/bin/bash

export TAPBR=br0
if test -x /etc/qemu-ifdown; then
    /bin/bash /etc/qemu-ifdown $1
fi
