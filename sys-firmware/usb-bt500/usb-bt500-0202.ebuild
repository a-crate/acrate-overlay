# Copyright 2021 Amelia Crate <acrate@waldn.net>
# Distributed under the terms of the BSD License

EAPI=7

inherit linux-mod

DESCRIPTION="Linux driver for ASUS USB BT500"
HOMEPAGE="https://www.asus.com/us/Networking-IoT-Servers/Adapters/All-series/USB-BT500/"
SLOT="0"
LICENSE="GPL-2"
SRC_URI="https://dlcdnets.asus.com/pub/ASUS/wireless/USB-BT500/20200909_LINUX_BT_DRIVER_KERNEL_5.7_COEX_v0202.zip -> ${P}.zip"
KEYWORDS="~amd64"

IUSE="dist-kernel"
DEPEND="dist-kernel? ( virtual/dist-kernel )"
BDEPEND="${DEPEND}
	app-arch/unzip
"

S="${WORKDIR}/20200806_LINUX_BT_DRIVER_RTL8761B_COEX_v0202/20200806_LINUX_BT_DRIVER_RTL8761B_COEX_v0202"

src_prepare() {
	unset ARCH
	default
}

src_compile() {
	einfo "using kernel build directory /lib/modules/${KV_FULL}/${libdir}/build"
	cd "/lib/modules/${KV_FULL}/${libdir}/build" || die "could not change to kernel build directory"
	emake -C "/lib/modules/${KV_FULL}/${libdir}/build" M="${S}/usb/bluetooth_usb_driver" modules
}

src_install() {
	insinto /lib/modules/${KV_FULL}/${libdir}
	doins "${S}/usb/bluetooth_usb_driver/rtk_btusb.ko"
	insinto /lib/firmware
	doins ${S}/rtkbt-firmware/lib/firmware/rtl8761bu_fw ${S}/rtkbt-firmware/lib/firmware/rtl8761bu_config
}
