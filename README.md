Buildroot Demo with Fast Init
=============================

This is an example of how [Finit][1] can be used with Buildroot instead
of the default BusyBox init, or systemd.

The provided defconfig builds a Qemu bootable kernel and root filesystem
(ext4) built around BusyBox.  With the following changes to its default
configuration:

 - Disable BusyBox init
 - Disable BusyBox poweroff/halt/reboot commands (for init)
 - Enable mount helpers (for fstab tricks later)

The rest of this tree is just glue to fit in with the Buildroot external
concept, as [described in the excellent manual][2].


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

[1]: https://github.com/troglobit/finit/
[2]: https://buildroot.org/downloads/manual/manual.html
