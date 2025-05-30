# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="Onigmo is a regular expressions library forked from Oniguruma"
HOMEPAGE="https://github.com/k-takata/Onigmo"
SRC_URI="https://github.com/k-takata/${PN^o}/releases/download/${P^o}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0/6"
KEYWORDS="amd64 x86"
IUSE="combination-explosion-check crnl-as-line-terminator"

src_prepare() {
	default

	eautoreconf
}

src_configure() {
	# https://github.com/k-takata/Onigmo/issues/169 (bug #943945)
	append-cflags -std=gnu17

	econf \
		$(use_enable combination-explosion-check) \
		$(use_enable crnl-as-line-terminator)
}

src_install() {
	default

	dodoc doc/{API,FAQ,RE}{,.ja} doc/UnicodeProps.txt

	find "${ED}" -name "*.la" -delete || die
}
