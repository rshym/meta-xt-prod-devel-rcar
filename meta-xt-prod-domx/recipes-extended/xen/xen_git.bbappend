require xen-source.inc

# We are dropping TUNE_CCARGS from for Xen because it won't build for armv8.2, as
# it conflicts with -mcpu=generic provided by own Xen build system
HOST_CC_ARCH:remove:r8a779f0 = "-march=armv8.2-a+crypto"
HOST_CC_ARCH:remove:r8a779f0 = "-mcpu=cortex-a55"

DEPENDS:append:r8a779f0 = " u-boot-mkimage-native"

do_deploy:append:r8a779f0 () {
    if [ -f ${D}/boot/xen ]; then
        uboot-mkimage -A arm64 -C none -T kernel -a 0x78080000 -e 0x78080000 -n "XEN" -d ${D}/boot/xen ${DEPLOYDIR}/xen-${MACHINE}.uImage
        ln -sfr ${DEPLOYDIR}/xen-${MACHINE}.uImage ${DEPLOYDIR}/xen-uImage
    fi
}
