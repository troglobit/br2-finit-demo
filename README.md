Buildroot Demo with Fast Init
=============================

<img align="right" src="screenshot.png" alt="Finit starting up Buildroot">

This is an example of how [Finit][1] can be used with Buildroot instead
of the default BusyBox init, or systemd.  Notice the use of an external,
`br2-ext-finit`, providing the necessary packages and root skeleton with
a wide range of service configurations.

The provided `configs/qemu_x86_64_finit_defconfig` is the standard Qemu
defconfig from Buildroot with Finit enabled as the default system init.
The kernel targets only a Qemu machine and the root filesystem (ext4) is
built around BusyBox, with the following changes:

 - Disable BusyBox init
 - Disable BusyBox poweroff/halt/reboot commands (for init)
 - Enable mount helpers (for fstab tricks later)
 - Enable a few services: `httpd`, `ntpd`, `udhcpd`, `dnsd`, `telnetd`, ...

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


Access
------

Port forwarding from your host to the Buildroot guest is available on the
following ports:

| **Host port** | **Guest port** | **Service** |
|---------------|----------------|-------------|
| tcp/8021      | 21             | FTP         |
| tcp/8022      | 22             | SSH         |
| tcp/8023      | 23             | Telnet      |
| tcp/8080      | 80             | HTTP        |

[1]: https://github.com/troglobit/finit/
[2]: https://buildroot.org/downloads/manual/manual.html
