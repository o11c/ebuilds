EAPI=4
inherit git-2

DESCRIPTION="A fully free and open source MMORPG game server"
HOMEPAGE="http://themanaworld.org/"
EGIT_REPO_URI="git://gitorious.org/tmw-eathena/mainline.git"

LICENSE="GPL-2"
SLOT="1" # classic server
KEYWORDS="" # "~x86 ~amd64 -*"
IUSE="testing"

# TODO set these
# make 3.82, flex, bison
RDEPEND=""
DEPEND=""

src_unpack() {
    if use testing
    then
        EGIT_BRANCH=test
    else
        EGIT_BRANCH=master
    fi
    git-2_src_unpack
}

src_install() {
    make install prefix="${D}/usr"
}
