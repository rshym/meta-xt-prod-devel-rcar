FILESEXTRAPATHS:prepend:r8a779f0 := "${THISDIR}/files:"

SRC_URI:append:r8a779f0 = " \
    file://early_printk.cfg \
"

do_configure:append:r8a779f0() {
    # merge configuration fragments manually using kconfig's native facilities
    ${S}/xen/tools/kconfig/merge_config.sh -m -O ${B}/xen ${B}/xen/.config ${WORKDIR}/*.cfg
}
