FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append:rcar-gen3 = "\
    file://domd-set-root.gen3 \
"

SRC_URI:append:r8a779f0 = "\
    file://domd-set-root.gen4 \
"

FILES:${PN} += " \
    ${libdir}/xen/bin/domd-set-root \
"

DOMD_RAM_SIZE:mem8gb = "2048"
DOMD_RAM_SIZE:mem4gb = "1024"
DOMD_RAM_SIZE:mem8gb:enable_android:enable_virtio = "3072"

# It is used a lot in the do_install, so variable will be handy
CFG_FILE="${D}${sysconfdir}/xen/domd.cfg"

do_install:append:rcar-gen3() {
    echo "" >> ${CFG_FILE}
    echo "# Initial memory allocation (MB)" >> ${CFG_FILE}
    echo "memory = ${DOMD_RAM_SIZE}" >> ${CFG_FILE}

    if ${@bb.utils.contains('DISTRO_FEATURES', 'enable_virtio', 'true', 'false', d)}; then
        echo "" >> ${CFG_FILE}
        echo "driver_domain = 1" >> ${CFG_FILE}
    fi

    # Install domd-set-root script
    install -d ${D}${libdir}/xen/bin
    install -m 0744 ${WORKDIR}/domd-set-root.gen3 ${D}${libdir}/xen/bin/domd-set-root
}

do_install:append:r8a779f0() {
    # Install domd-set-root script
    install -d ${D}${libdir}/xen/bin
    install -m 0744 ${WORKDIR}/domd-set-root.gen4 ${D}${libdir}/xen/bin/domd-set-root
}

do_install:append() {
    # Call domd-set-root script
    echo "[Service]" >> ${D}${systemd_unitdir}/system/domd.service
    echo "ExecStartPre=${libdir}/xen/bin/domd-set-root" >> ${D}${systemd_unitdir}/system/domd.service
}
