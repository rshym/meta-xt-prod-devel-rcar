DESCRIPTION = "Linux socket test tool"
SECTION = "extras"
LICENSE = "MIT"
PR = "r0"

S = "${WORKDIR}/git"

SRC_URI = " \
    git://github.com/dterletskiy/lisot.git;protocol=https;branch=main \
"

LIC_FILES_CHKSUM = "file://LICENSE;md5=70f43a6798ce05aa97a93b0392832ee9"

SRCREV = "469ab57003cf7916523bad0a766c54edade3717e"

do_compile() {
    oe_runmake SYSROOT=${RECIPE_SYSROOT}
}

do_install() {
    oe_runmake install DESTDIR=${D}
}
