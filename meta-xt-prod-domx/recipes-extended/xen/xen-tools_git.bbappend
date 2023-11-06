FILESEXTRAPATHS:prepend:r8a779f0 := "${THISDIR}/files:"

# Avoid redundant runtime dependency on python3-core
RDEPENDS:${PN}:remove:class-target = " ${PYTHON_PN}-core" 

require xen-source.inc

SRC_URI:append:r8a779f0 = " \
    file://xenpcid-xenstore.conf \
"

FILES:${PN}-test = "\
    ${libdir}/xen/bin/test-xenstore \
    ${libdir}/xen/bin/test-resource \
"

FILES:${PN}-test:append:rcar-gen3 = "\
    ${libdir}/xen/bin/test-paging-mempool\
"

PACKAGES:append:r8a779f0 = "\
    ${PN}-pcid \
"

do_install:append() {
    rm -f ${D}/${libdir}/xen/bin/init-dom0less
    rm -f ${D}/${systemd_unitdir}/system/var-lib-xenstored.mount
    rm -rf ${D}/var
}

FILES:${PN}-xencommons:remove = "\
    "${systemd_unitdir}/system/var-lib-xenstored.mount" \
"

SYSTEMD_SERVICE:${PN}-xencommons:remove = " \
    var-lib-xenstored.mount \
"

# Remove the recommendation for Qemu for non-hvm x86 added in meta-virtualization layer
RRECOMMENDS:${PN}:remove = " qemu"

FILES:${PN}-pcid:r8a779f0 = "\
    ${systemd_unitdir}/system/xenpcid.service \
    ${systemd_unitdir}/system/xenpcid.service.d/xenpcid-xenstore.conf \
"

SYSTEMD_SERVICE:${PN}-pcid:r8a779f0 = "xenpcid.service"

SYSTEMD_PACKAGES:append:r8a779f0 = " ${PN}-pcid"

do_install:append:r8a779f0 () {
    install -d ${D}${systemd_unitdir}/system/xenpcid.service.d/
    install -m 0744 ${WORKDIR}/xenpcid-xenstore.conf ${D}${systemd_unitdir}/system/xenpcid.service.d
}
