build_xen() {
	apk fetch --root "$APKROOT" --stdout xen-hypervisor | tar -C "$DESTDIR" -xz boot
}

section_xen() {
	[ -n "${xen_params+set}" ] || return 0
	build_section xen $ARCH $(apk fetch --root "$APKROOT" --simulate xen-hypervisor | checksum)
}

profile_xen() {
	profile_standard
	title="Xen"
	desc="Build-in support for Xen Hypervisor.
		Includes packages targed at Xen usage.
		Use for Xen Dom 0."
	arch="x86_64"
	kernel_cmdline="nomodeset"
	xen_params=""
	apks="$apks ethtool xen xen-bridge"
#	apkovl="genapkovl-xen.sh"
}

profile_domu() {
	profile_standard
	title="Xen domU"
	desc="Xen domU"
	arch="x86_64"
	kernel_cmdline="console=hvc0"
	apks="alpine-base alpine-mirrors bridge busybox chrony e2fsprogs libressl openssh tzdata"
	initfs_features="base bootchart squashfs ext4 virtio"
}
