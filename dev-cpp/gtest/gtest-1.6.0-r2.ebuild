# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gtest/gtest-1.6.0-r2.ebuild,v 1.2 2013/06/19 18:44:11 bicatali Exp $

EAPI="5"

DESCRIPTION="Google C++ Testing Framework"
HOMEPAGE="http://code.google.com/p/googletest/"
SRC_URI="http://googletest.googlecode.com/files/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~amd64-linux ~x86-fbsd ~x86-linux ~ppc-macos"
IUSE="examples"

DEPEND="app-arch/unzip"
RDEPEND=""

# need to disable some of the default rules

src_configure() {
	:
}

src_compile() {
	:
}

src_install() {
	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		doins samples/*.{cc,h}
	fi

	doheader -r include/*
	dodoc README CHANGES

	insinto /usr/src/gtest
	doins CMakeLists.txt
	doins -r cmake
	insinto /usr/src/gtest/src
	doins fused-src/gtest/*
}

pkg_postinst() {
	ewarn "As recommended by upstream, this package no longer ships a shared library or the gtest-config binary."
	ewarn "See /usr/share/doc/${PF}/README for instructions."
}
