EAPI=4
# tiled installs all languages unconditionally
# LANGS="cs de en es fr he it ja lv nl pt_BR pt ru zh"

inherit qt4-r2

DESCRIPTION="a general purpose tile map editor"
HOMEPAGE="http://mapeditor.org/"
SRC_URI="mirror://sourceforge/tiled/tiled-qt/${PV}/${PN}-qt-${PV}.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 ) BSD"
SLOT=0
KEYWORDS="~amd64" # should be fine on all architectures
IUSE=""

S="${WORKDIR}/${PN}-qt-${PV}"

# incomplete
CDEPEND="
x11-libs/qt-gui:4
"
DEPEND="${CDEPEND}
"
RDEPEND="${CDEPEND}
"

src_configure() {
	eqmake4 ${PN}.pro PREFIX=/usr
}
