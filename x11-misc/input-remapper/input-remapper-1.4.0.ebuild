# Copyright 2021 Amelia Crate <acrate@waldn.net>
# Distributed under the terms of the ISC License

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="An easy to use tool to change the mapping of your input device buttons."
HOMEPAGE="https://github.com/sezanzeb/input-remapper"
LICENSE="GPL-3"
SLOT="0"
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sezanzeb/${PN}.git"
else
	SRC_URI="https://github.com/sezanzeb/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi
RDEPEND="${DEPEND}
	$(python_gen_cond_dep 'dev-python/python-evdev[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pydantic[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pydbus[${PYTHON_USEDEP}]')
	=x11-libs/gtksourceview-4*
"

