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
    make

The resulting image files are placed `output/images/` and a Qemu host
program is available in `output/host/bin/`.


Run
---

The `external.mk` file extends Buildroot with a `run` command that calls
the Qemu host program with the generated image files:

    make run

> **Note:** use `Ctrl-a x` to exit qemu, and `Ctrl-a c` to toggle console/monitor

[1]: https://github.com/troglobit/finit/
[2]: https://buildroot.org/downloads/manual/manual.html
