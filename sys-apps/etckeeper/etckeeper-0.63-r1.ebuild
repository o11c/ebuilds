# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/etckeeper/etckeeper-0.63-r1.ebuild,v 1.6 2013/01/14 22:58:43 hasufell Exp $

EAPI=5

PYTHON_COMPAT=( python2_6 python2_7 )

inherit eutils bash-completion-r1 prefix python-r1

DESCRIPTION="A collection of tools to let /etc be stored in a repository"
HOMEPAGE="http://kitenet.net/~joey/code/etckeeper/"
SRC_URI="http://git.kitenet.net/?p=${PN}.git;a=snapshot;h=refs/tags/${PV};sf=tgz -> ${P}.tar.gz"

LICENSE="GPL-2"
IUSE="bazaar cron"
KEYWORDS="~amd64 ~x86"
SLOT="0"

VCS_DEPEND="
	dev-vcs/git
	dev-vcs/mercurial
	dev-vcs/darcs"
DEPEND="bazaar? ( dev-vcs/bzr )"
RDEPEND="${DEPEND}
	app-portage/portage-utils
	cron? ( virtual/cron )
	bazaar? ( ${PYTHON_DEPS} )
	!bazaar? ( || ( ${VCS_DEPEND} ) )"

src_prepare(){
	epatch "${FILESDIR}"/${P}-gentoo.patch
	epatch "${FILESDIR}"/prefix1.patch
	epatch "${FILESDIR}"/prefix2.patch
	eprefixify etckeeper pre-install.d/10packagelist
}

src_compile() {
	:
}

src_install(){
	emake DESTDIR="${ED}" install

	bzr_install() {
		${PYTHON} ./${PN}-bzr/__init__.py install --root="${ED}" ||
			die "bzr support installation failed!"
	}
	use bazaar && python_foreach_impl bzr_install

	newbashcomp bash_completion ${PN}
	dodoc README TODO
	docinto examples
	dodoc "${FILESDIR}"/bashrc

	if use cron ; then
		exeinto /etc/cron.daily
		newexe debian/cron.daily etckeeper
	fi
}

pkg_postinst(){
	elog "${PN} supports the following VCS: ${VCS_DEPEND}"
	elog "	dev-vcs/bzr"
	elog "This ebuild just ensures at least one is installed!"
	elog "For dev-vcs/bzr you need to enable 'bazaar' useflag."
	elog
	elog "You may want to adjust your ${EPREFIX}/etc/portage/bashrc"
	elog "see the example file in ${EPREFIX}/usr/share/doc/${PF}/examples"
	elog
	elog "To initialise your etc-dir as a repository run:"
	elog "${PN} init"
}
