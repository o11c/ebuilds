# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/tmw/tmw-0.5.2.ebuild,v 1.1 2011/08/02 11:56:25 tupone Exp $

EAPI=2
inherit eutils games cmake-utils git-2

DESCRIPTION="A fully free and open source MMORPG game client (3rd party)"
HOMEPAGE="http://manaplus.evolonline.org/"
EGIT_REPO_URI="git://gitorious.org/manaplus/manaplus.git"
EGIT_COMMIT="v${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="nls opengl"

RDEPEND="
	>=dev-games/physfs-1.0.0
	dev-libs/libxml2
	media-libs/sdl-mixer[vorbis]
	media-libs/sdl-image[png]
	media-libs/sdl-net
	media-libs/sdl-ttf
	net-misc/curl
	sys-libs/zlib
	media-libs/libpng
	media-fonts/dejavu
	>=dev-games/guichan-0.8.1[sdl]
	media-libs/libsdl[X,opengl?,video]
	media-libs/sdl-gfx
	x11-libs/libX11
	nls? ( virtual/libintl )
	opengl? ( virtual/opengl )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

DOCS=( AUTHORS ChangeLog NEWS README )
PATCHES=( "${FILESDIR}"/${PN}-gentoo.patch )

src_prepare() {
	base_src_prepare
	sed -i \
		-e "s:@GENTOO_BINDIR@:${GAMES_BINDIR}:" \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		CMakeLists.txt \
		|| die "sed failed"
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with opengl)
		$(cmake-utils_use_enable nls)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dosym /usr/share/fonts/dejavu/DejaVuSans-Bold.ttf "${GAMES_DATADIR}"/${PN}/data/fonts/dejavusans-bold.ttf
	dosym /usr/share/fonts/dejavu/DejaVuSans.ttf "${GAMES_DATADIR}"/${PN}/data/fonts/dejavusans.ttf
	dosym /usr/share/fonts/dejavu/DejaVuSansMono.ttf "${GAMES_DATADIR}"/${PN}/data/fonts/dejavusans-mono.ttf
	insinto "${GAMES_DATADIR}"/${PN}/data
	prepgamesdirs
}
