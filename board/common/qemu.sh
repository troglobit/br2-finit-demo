#!/bin/sh
# Simple hard-coded script to start the br2-finit-demo in Qemu
#
# Notice user networking here, we enable forwarding of FTP(21), SSH(22)
# telnet(23), and HTTP(80) to the local host ports 80xx.  You may want
# to use bridged networking, but that's outside the scope of this demo.
#

imgdir=$(readlink -f "$(dirname "$0")")
binary=qemu-system-x86_64

if [ -n "$O" ]; then
    export PATH=$O/host/bin:$PATH
fi
QEMU=$(command -v $binary)

if [ -z "$QEMU" ]; then
    echo "Cannot find $binary on your system, not possible to run demo."
    exit 1
fi

cd "$imgdir" || exit 1
echo "Starting Qemu  ::  Ctrl-a x -- exit | Ctrl-a c -- toggle console/monitor"
line=$(stty -g)
stty raw

$QEMU -M pc -nographic \
	-kernel bzImage -append "rootwait root=/dev/vda console=ttyS0 quiet" \
	-drive file=rootfs.ext2,if=virtio,format=raw -net nic,model=virtio   \
	-net user,hostfwd=tcp::8021-:21,hostfwd=tcp::8022-:22,hostfwd=tcp::8023-:23,hostfwd=tcp::8080-:80

stty "$line"
