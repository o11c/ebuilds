# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/tmw/tmw-0.5.2.ebuild,v 1.1 2011/08/02 11:56:25 tupone Exp $

EAPI=2
inherit eutils

DESCRIPTION="Branding for the Mana client for server.themanaworld.org"
HOMEPAGE="http://themanaworld.org/"
SRC_URI="mirror://sourceforge/themanaworld/${PN}-branding-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="games-rpg/mana"
DEPEND=""

S="${WORKDIR}/${PN}-branding-${PV}"

src_install() {
	# Things not yet done:
	# Convert from /usr/share/tmw to /usr/share/games/tmw
	# (requires patching tmw.desktop and tmw)
	# install data/icons/tmw.xpm into /usr/share/pixmaps
	# install data/icons/tmw.png into /usr/share/icons

	insinto /usr/share/applications
	doins tmw.desktop
	insinto /usr/share/tmw/
	doins tmw.mana
	doins -r data/
	exeinto /usr/games/bin
	doexe tmw
}
