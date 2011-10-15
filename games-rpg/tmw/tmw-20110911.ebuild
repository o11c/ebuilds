# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/tmw/tmw-0.5.2.ebuild,v 1.1 2011/08/02 11:56:25 tupone Exp $

EAPI=2
inherit eutils games

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

PATCHES=( "${FILESDIR}"/${PN}-branding-gentoo.patch )

src_prepare() {
	base_src_prepare
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/tmw:" \
		tmw tmw.desktop \
		|| die "sed failed"
}

src_install() {
	insinto /usr/share/pixmaps
	doins data/icons/tmw.xpm
	insinto /usr/share/icons
	doins data/icons/tmw.png

	insinto /usr/share/applications
	doins tmw.desktop
	insinto "${GAMES_DATADIR}/tmw/"
	doins tmw.mana
	doins -r data/
	exeinto "${GAMES_BINDIR}"
	doexe tmw

	prepgamesdirs
}
