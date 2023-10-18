FILESEXTRAPATHS:prepend:rcar-gen3 := "${THISDIR}/files:"
FILESEXTRAPATHS:prepend:r8a779f0 := "${THISDIR}/files_gen4:"

SRC_URI:append:rcar-gen3 = " \
    file://defconfig \
"

SRC_URI:append:r8a779f0 = " \
    file://ixgbe.cfg \
    file://multicast_routing.cfg \
    file://xen-chosen.dtsi;subdir=git/arch/arm64/boot/dts/renesas \
    file://0001-clk-shmobile-Hide-clock-for-scif3-and-hscif0.patch \
    file://0002-PCIe-MSI-support.patch \
    file://0003-xen-pciback-allow-compiling-on-other-archs-than-x86.patch \
    file://0004-HACK-Allow-DomD-enumerate-PCI-devices.patch \
    file://0005-HACK-pcie-renesas-emulate-reading-from-ECAM-under-Xe.patch \
"

KERNEL_MODULE_PROBECONF:append:r8a779f0 = " ixgbevf"
module_conf_ixgbevf:r8a779f0 = "blacklist ixgbevf"

