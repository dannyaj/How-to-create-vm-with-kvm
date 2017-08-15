#!/bin/bash

export TAPBR=br0
if test -x /etc/qemu-ifup; then
    /bin/bash /etc/qemu-ifup $1
fi
