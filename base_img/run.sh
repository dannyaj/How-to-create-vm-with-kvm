#!/bin/bash

#HOME=$( cd "$(dirname "$0")" && pwd )
#pushd $HOME
source config
if test -f "ubuntu_base_16.04.img"; then IMG="ubuntu_base_16.04.img";
elif test -f "ubuntu-20G.qcow2"; then IMG="ubuntu-20G.qcow2"; fi
if test -z "$IMG"; then echo "Image not exist"; exit 1; fi

/usr/bin/kvm -m 1024 -smp 1,sockets=1,cores=1,threads=1 \
-name $NAME \
-rtc base=utc \
-drive file=$IMG,format=qcow2 \
-netdev tap,id=eth0,script=ifup.sh,downscript=ifdown.sh \
-device virtio-net-pci,netdev=eth0,id=net0,mac=$ETH1_MAC,bus=pci.0,addr=0x3 \
-vnc *:$VNC_PORT \
-cdrom /opt/vm/ubuntu-16.04.1-server-amd64.iso \
-boot c 2>&1 < /dev/null &
