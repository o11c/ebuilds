EAPI=4
# tiled installs all languages unconditionally, but we patch it.
LANGS="cs de en es fr he it ja lv nl pt_BR pt ru zh"

inherit qt4-r2

DESCRIPTION="a general purpose tile map editor"
HOMEPAGE="http://mapeditor.org/"
SRC_URI="mirror://sourceforge/tiled/tiled-qt/${PV}/${PN}-qt-${PV}.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 ) BSD"
SLOT=0
KEYWORDS="~amd64" # should be fine on all architectures
IUSE="+nls"

S="${WORKDIR}/${PN}-qt-${PV}"

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
