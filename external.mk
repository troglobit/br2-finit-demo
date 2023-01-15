
.PHONY: run
run:
	@$O/host/bin/qemu-system-x86_64 -M pc -nographic \
		-kernel $O/images/bzImage -append "rootwait root=/dev/vda console=ttyS0 quiet" \
		-drive file=$O/images/rootfs.ext2,if=virtio,format=raw -net nic,model=virtio   \
		-net user,hostfwd=tcp::8021-:21,hostfwd=tcp::8022-:22,hostfwd=tcp::8023-:23,hostfwd=tcp::8080-:80
