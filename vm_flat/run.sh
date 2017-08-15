#!/bin/bash

HOME=$( cd "$(dirname "$0")" && pwd )
#pushd $HOME

if test -f "$HOME/ubuntu-20G.qcow2"; then IMG="ubuntu-20G.qcow2";
elif test -f "$HOME/ubuntu-50G.qcow2"; then IMG="ubuntu-50G.qcow2"; fi
if test -z "$IMG"; then echo "Image not exist"; exit 1; fi

source $HOME/config

/usr/bin/kvm -m 8192 -smp 1,sockets=1,cores=1,threads=1 \
-name $NAME \
-rtc base=utc \
-drive file=$HOME/$IMG,format=qcow2 \
-netdev tap,id=eth0,script=$HOME/ifup.sh,downscript=$HOME/ifdown.sh \
-device virtio-net-pci,netdev=eth0,id=net0,mac=$ETH1_MAC,bus=pci.0,addr=0x3 \
-vnc *:$VNC_PORT \
-boot c 2>&1 < /dev/null &
