# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/tmw/Attic/tmw-0.0.29.1.ebuild,v 1.6 2010/05/24 15:45:55 tupone Exp $

EAPI=2
inherit eutils games autotools git-2

DESCRIPTION="A fully free and open source MMORPG game client (3rd party)"
HOMEPAGE="http://manaplus.evolonline.org/"
EGIT_REPO_URI="git://gitorious.org/manaplus/manaplus.git"
EGIT_COMMIT="v${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls opengl internalguichan"

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
PATCHES=( )

src_prepare() {
	base_src_prepare
	sed -i \
		-e '/^SUBDIRS/s/fonts//' \
		data/Makefile.am \
		|| die "sed failed"
	eautoreconf
}

src_configure() {
	egamesconf \
		--without-internalguichan \
		--disable-dependency-tracking \
		--localedir=/usr/share/locale \
		$(use_enable nls) \
		$(use_with opengl) \
		$(use_with internalguichan)
}

src_install() {
	base_src_install
	emake DESTDIR="${D}" install || die "emake install failed"
	dosym /usr/share/fonts/dejavu/DejaVuSans-Bold.ttf "${GAMES_DATADIR}"/${PN}/data/fonts/dejavusans-bold.ttf
	dosym /usr/share/fonts/dejavu/DejaVuSans.ttf "${GAMES_DATADIR}"/${PN}/data/fonts/dejavusans.ttf
	dosym /usr/share/fonts/dejavu/DejaVuSansMono.ttf "${GAMES_DATADIR}"/${PN}/data/fonts/dejavusans-mono.ttf
	prepgamesdirs
}
