# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
# these are what I test with, there's no reason others might not work
PYTHON_COMPAT=( pypy1_8 pypy1_9 python3_2 python2_6 python2_7 )
inherit git-2 distutils-r1

DESCRIPTION="Another generator for openbox menus"
HOMEPAGE="https://github.com/o11c/obxmenu"
EGIT_REPO_URI="git://github.com/o11c/obxmenu.git"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
# All platforms should probably work.
KEYWORDS="~x86 ~amd64"
# At least one file is needed in /etc/xdg/menus
IUSE="gnome kde custom"

REQUIRED_USE="|| ( gnome kde custom )"

# distutils-r1 sets DEPEND and RDEPEND
#DEPEND="${DEPEND} "
# There's a bug in pyxdg 0.23 affecting KDE menus
RDEPEND="${RDEPEND}
dev-python/pyxdg
kde? ( >=dev-python/pyxdg-0.24 )
gnome? ( gnome-base/gnome-menus )
kde? ( kde-base/kdelibs )
"

pkg_postinst() {
	elog 'Note that you must export XDG_MENU_PREFIX before calling obxmenu'
	elog 'unless you have created /etc/xdg/menus/applications.menu'
	elog 'Expected values are gnome- and kde-4-'
}
