# Copyright 2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=4
# tiled installs all languages unconditionally, but we patch it.
LANGS="cs de en es fr he it ja lv nl pt_BR pt ru zh"

inherit qt4-r2

DESCRIPTION="a general purpose tile map editor"
HOMEPAGE="http://mapeditor.org/"
if [[ ${PV} = 9999 ]]
then
	EGIT_REPO_URI="git://github.com/bjorn/tiled.git"
	inherit git-2
else
	SRC_URI="mirror://sourceforge/tiled/tiled-qt/${PV}/${PN}-qt-${PV}.tar.gz"
	S="${WORKDIR}/${PN}-qt-${PV}"
	KEYWORDS="~amd64" # should be fine on all architectures
fi

LICENSE="|| ( GPL-2 GPL-3 ) BSD"
SLOT=0
IUSE="+nls"

# possibly incomplete
CDEPEND="
>=x11-libs/qt-opengl-4.6:4
"
DEPEND="${CDEPEND}
"
RDEPEND="${CDEPEND}
"
# Sort the arguments
sorted() {
	# printf repeats the format for extra arguments
	printf '%s\n' "$@" | sort
}

# print the intersection of 2 or more lists
intersect() {
	local out=$(sorted $1)
	shift
	for arg
	do
		out=$(join <(printf '%s\n' $out) <(sorted $arg))
	done
	echo $out
}

src_prepare() {
	qt4-r2_src_prepare
	use nls || LANGS=
	sed "s/^LANGUAGES = .*$/LANGUAGES = $(intersect "$LANGS" "$LINGUAS")/" \
		-i translations/translations.pro
}

src_configure() {
	eqmake4 ${PN}.pro PREFIX=/usr
}
