# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
# these are what I test with, there's no reason others might not work
PYTHON_COMPAT=( pypy1_8 pypy1_9 python3_2 python2_6 python2_7 )
inherit git-2 distutils-r1

DESCRIPTION="Another generator for openbox menus"
HOMEPAGE="https://github.com/o11c/obxmenu"
EGIT_REPO_URI="git://github.com/o11c/obxmenu.git"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

# distutils-r1 sets DEPEND and RDEPEND
#DEPEND="${DEPEND}"
RDEPEND="${RDEPEND}
	dev-python/pyxdg
"
