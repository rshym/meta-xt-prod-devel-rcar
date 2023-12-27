FILESEXTRAPATHS:prepend:r8a779f0 := "${THISDIR}/files:"

# Enable virtualization support
EXTRA_OEMAKE:append:r8a779f0 = " \
    CFG_VIRTUALIZATION=y \
    CFG_VIRT_GUEST_COUNT=3 \
    CFG_REE_FS=y \
    CFG_STANDALONE_FS=n \
    CFG_CRYPT_HW_CRYPTOENGINE=n \
"

SRC_URI:append:r8a779f0 = " \
    file://0001-plat-rcar_gen4-extend-memory-available-to-OP-TEE.patch \
"

python __anonymous () {
    if "r8a779f0" in d.getVar("MACHINEOVERRIDES"):
        d.delVarFlag("do_install", "noexec")
}

do_install:append:r8a779f0 () {
    #install TA devkit
    install -d ${D}/usr/include/optee/export-user_ta/

    for f in  ${B}/out/arm-plat-${PLATFORM}/export-ta_arm64/* ; do
        cp -aR  $f  ${D}/usr/include/optee/export-user_ta/
    done
}

INSANE_SKIP:${PN}-dev:r8a779f0 = "staticdev"
INHIBIT_PACKAGE_STRIP:r8a779f0 = "1"
