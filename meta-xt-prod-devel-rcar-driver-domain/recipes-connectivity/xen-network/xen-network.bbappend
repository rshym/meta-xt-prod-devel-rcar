FILESEXTRAPATHS:prepend:r8a779f0 := "${THISDIR}/files:"

SRC_URI:append:r8a779f0 = "\
    file://systemd-networkd-wait-online.conf \
    file://tsn0.network \
    file://tsn1.network \
    file://vmq0.network \
"

FILES:${PN}:append:r8a779f0 = " \
    ${sysconfdir}/systemd/network/tsn0.network \
    ${sysconfdir}/systemd/network/tsn1.network \
    ${sysconfdir}/systemd/network/vmq0.network \
"
