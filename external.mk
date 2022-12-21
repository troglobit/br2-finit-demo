
.PHONY: run
run:
	@$O/host/bin/qemu-system-x86_64 -M pc -enable-kvm -nographic \
		-kernel $O/images/bzImage -drive file=$O/images/rootfs.ext2,if=virtio,format=raw \
		-append "rootwait root=/dev/vda console=tty1 console=ttyS0 quiet" \
		-net nic,model=virtio -net user
