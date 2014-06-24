EAPI=4
inherit git-2

DESCRIPTION="A fully free and open source MMORPG game server"
HOMEPAGE="https://www.themanaworld.org/"
EGIT_REPO_URI="git://github.com/themanaworld/tmwa.git"

LICENSE="GPL-3"
SLOT="2" # new and improved server
KEYWORDS="~x86 ~amd64" # master branch should support all arches now, v14.4.18 is little-endian only
IUSE="stable"

RDEPEND=">=sys-devel/gcc-4.7"
DEPEND="<dev-lang/python-3 dev-python/attoconf:0"

src_unpack() {
    if use stable
    then
        EGIT_BRANCH=stable
    else
        EGIT_BRANCH=master
    fi
    git-2_src_unpack
}
