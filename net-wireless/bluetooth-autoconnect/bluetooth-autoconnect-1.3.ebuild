# Copyright 2021 Amelia Crate <acrate@waldn.net>
# Distributed under the terms of the BSD License

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit systemd python-r1

DESCRIPTION="A linux command line tool to automatically connect to all paired and trusted bluetooth devices."
HOMEPAGE="https://github.com/jrouleau/bluetooth-autoconnect"
SLOT="0"
LICENSE="MIT"
SRC_URI="https://github.com/jrouleau/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

RDEPEND="
	net-wireless/bluez
	$(python_gen_cond_dep 'dev-python/dbus-python[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/python-prctl[${PYTHON_USEDEP}]')
"

src_install() {
	default
	exeinto /usr/local/bin/
	doexe bluetooth-autoconnect || die "didn't install script"
	systemd_dounit bluetooth-autoconnect.service
	systemd_douserunit pulseaudio-bluetooth-autoconnect.service
}
