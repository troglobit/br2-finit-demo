Buildroot Demo with Fast Init
=============================

This is an example of how Finit (Fast Init) can be used with Buildroot.


Build
-----

    make qemu_x86_64_finit_defconfig


Run
---

    qemu-system-x86_64 -M pc -enable-kvm -nographic                       \
	    -kernel output/images/bzImage                                     \
        -drive file=output/images/rootfs.ext2,if=virtio,format=raw        \
        -append "rootwait root=/dev/vda console=tty1 console=ttyS0 quiet" \
        -net nic,model=virtio -net user

