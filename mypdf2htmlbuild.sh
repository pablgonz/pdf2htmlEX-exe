#!/bin/bash
# pdf2htmlEX build script.
# Use in MSYS2/MinGW-w64 for build pdf2htmlEX
# Author: Pablo González L
# Debemos intentar capturar java desde msys2
# JAVA=`powershell -Command "Get-Command java  | select Source" | sed 's/java.exe//' | sed 's/C\:/\/c/' | sed 's@\\\\@/@g'`
# Green text
function log_note() {
    echo -ne "\e[32m"; echo "$@"; echo -ne "\e[0m"
}
# Yellow text
function log_status() {
    echo -ne "\e[33m"; echo "$@"; echo -ne "\e[0m"
}

function bail () {
    echo -ne "\e[31m\e[1m"; echo "!!! Build failed at: ${@}"; echo -ne "\e[0m"
    exit 1
}

# Red text
function log_error() {
    echo -ne "\e[31m"; echo "$@"; echo -ne "\e[0m"
}

# vars for terminal
yes=0
skippoppler=0
skipfontforge=0
onlypdf2htmlEX=0
depsonly=0
ghactions=0

function dohelp() {
    echo "Usage: `basename $0` [options]"
    echo "  -h, --help             Prints this help message"
    echo "  -y, --yes              Say yes to all build script prompts"
    echo "  -d, --depsonly         Only install dependencies for MSYS2"
    echo "  -G, --ghactions        Disable install local dependencies"
    echo "  -P, --skip-poppler     Skip build/install poppler"
    echo "  -F, --skip-fontforge   Skip build/install fontforge"
    echo "  -E, --only-pdf2htmlEX  Only build/install pdf2htmlEX.exe"
    exit $1
}

# Retrieve input arguments to script
optspec=":hydGPFE-:"
while getopts "$optspec" optchar; do
    case "${optchar}" in
        -)
            case "${OPTARG}" in
                skip-poppler)
                    skippoppler=$((1-skippoppler)) ;;
                skip-fontforge)
                    skipfontforge=$((1-skipfontforge)) ;;
                only-pdf2htmlEX)
                    onlypdf2htmlEX=$((1-onlypdf2htmlEX)) ;;
                depsonly)
                    depsonly=$((1-depsonly)) ;;
                ghactions)
                    ghactions=$((1-ghactions)) ;;
                yes)
                    yes=$((1-yes)) ;;
                help)
                    dohelp 0;;
                *)
                    log_error "Unknown option --${OPTARG}"
                    dohelp 1 ;;
            esac;;
        P)
            skippoppler=$((1-skippoppler)) ;;
        F)
            skipfontforge=$((1-skipfontforge)) ;;
        E)
            onlypdf2htmlEX=$((1-onlypdf2htmlEX)) ;;
        d)
            depsonly=$((1-depsonly)) ;;
        G)
            ghactions=$((1-ghactions)) ;;
        y)
            yes=$((1-yes)) ;;
        h)
            dohelp 0 ;;
        *)
            log_error "Unknown argument -${OPTARG}"
            dohelp 1 ;;
    esac
done

# detect arch
function detect_arch_switch () {
    local from="$(ls -1 .building-* 2>/dev/null)"
    local to=".building-$1"

    if [ ! -z "$from" ] && [ "$from" != "$to" ]; then
        if (($yes)); then
            git clean -dxf "$RELEASE" || bail "Could not reset ReleasePackage"
        else
            read -p "Architecture change detected! ReleasePackage must be reset. Continue? [y/N]: " arch_confirm
            case $arch_confirm in
                [Yy]* )
                    git clean -dxf "$RELEASE" || bail "Could not reset ReleasePackage"
                    ;;
                * ) bail "Not overwriting ReleasePackage" ;;
            esac
        fi
    fi

    rm -f $from
    touch $to
}

# Tree for build/release
BASE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
RELEASE=$BASE/ReleasePackage/

# Determine if we're building 32 or 64 bit.
if [ "$MSYSTEM" = "MINGW32" ]; then
    log_note "Building 32-bit version!"

    ARCHNUM="32"
    MINGVER=mingw32
    MINGOTHER=mingw64
    HOST="--build=i686-w64-mingw32 --host=i686-w64-mingw32 --target=i686-w64-mingw32"
    PMARCH=i686
    PMPREFIX="mingw-w64-$PMARCH"
elif [ "$MSYSTEM" = "MINGW64" ]; then
    log_note "Building 64-bit version!"

    ARCHNUM="64"
    MINGVER=mingw64
    MINGOTHER=mingw32
    HOST="--build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32"
    PMARCH=x86_64
    PMPREFIX="mingw-w64-$PMARCH"
else
    bail "Unknown build system!"
fi

# Set working folders and vars
if [ ! -f "$BASE/javalocation.txt" ]; then
    log_status "The script will continue without detecting java, run:"
    log_status "powershell -c \"Get-Command java  | select Source\" > javalocation.txt"
else
    log_status "The script set java from file"
    JAVA=` cat javalocation.txt | grep java.exe | sed 's/java.exe//' \
    | sed 's/Source//' | sed 's/------//' | sed 's/C\:/\/c/' \
    | sed 's@\\\\@\/@g'
    `
    export PATH=$PATH:"$JAVA"
    echo "$JAVA"
fi

export PDF2HTMLEX_VERSION=0.18.8.rc1-"($ARCHNUM-bit)"
# current work poppler-21.02.0 (need patch on windows)
export POPPLER_VERSION=poppler-21.02.0
export POPPLER_DATA=poppler-data-0.4.12
export FONTFORGE_VERSION=20230101
FONTFORGE_SRC=$FONTFORGE_VERSION.tar.gz

# Early detection
detect_arch_switch $MINGVER

# Common options
TARGET=$BASE/target/$MINGVER/
WORK=$BASE/work/$MINGVER/
PMTEST="$BASE/.pacman-$MINGVER-installed"

# Make output directories
rm -R -f "$WORK"
mkdir -p "$WORK"
rm -R -f "$RELEASE/bin"
mkdir -p "$RELEASE/bin"
rm -R -f "$RELEASE/share"
mkdir -p "$RELEASE/share"

# Set pkg-config path to also search mingw libs
export PATH="$TARGET/bin:$PATH"
export PKG_CONFIG_PATH="/$MINGVER/lib/pkgconfig:/usr/local/lib/pkgconfig:/lib/pkgconfig:/usr/local/share/pkgconfig"

# aclocal path
export ACLOCAL_PATH="m4:/$MINGVER/share/aclocal"
export ACLOCAL="/bin/aclocal"
export M4="/bin/m4"

# Compiler flags
export LDFLAGS="-L/$MINGVER/lib -L/usr/local/lib -L/lib"
export CFLAGS="-DWIN32 -I/$MINGVER/include -I/usr/local/include -I/include -g"
export CPPFLAGS="${CFLAGS}"
export LIBS=""

# Install all the available precompiled binaries
if (( $ghactions )); then
    log_status "Installing MSYS and MinGW libraries done by ghactions"
else
    if (( !$depsonly )) && [ ! -f $PMTEST ]; then
        log_status "First time run; installing MSYS and MinGW libraries..."
        pacman -Sy --noconfirm
        IOPTS="-S --noconfirm --needed"

        # Install MinGW related stuff
        pacman $IOPTS $PMPREFIX-{gcc,gmp,ntldd-git,gettext,libiconv,cmake,ninja,ccache,cc,gobject-introspection}

        # Install the base MSYS packages needed
        pacman $IOPTS diffutils findutils make patch tar pkgconf git

        # Libraries
        log_status "Installing precompiled devel libraries..."
        pacman $IOPTS $PMPREFIX-{libspiro,libuninameslist,lcms2,libtiff,cairo,ttfautohint}
        pacman $IOPTS $PMPREFIX-{zlib,libpng,giflib,libjpeg-turbo,libxml2,openjpeg2}
        pacman $IOPTS $PMPREFIX-{freetype,fontconfig,glib2,pixman,harfbuzz}
        touch $PMTEST

        log_note "Finished installing precompiled libraries!"
    else
        log_note "Detected that precompiled libraries are already installed."
        log_note "  Delete '$PMTEST' and run this script again if"
        log_note "  this is not the case."
    fi
fi

# buid poppler
if (( ! $skippoppler )) ; then
    log_note "*** Build poopler $POPPLER_VERSION ***"

    if [ ! -f "$BASE/$POPPLER_VERSION.tar.xz" ]; then
        log_status "Getting $POPPLER_VERSION.tar.xz .."
        wget https://poppler.freedesktop.org/$POPPLER_VERSION.tar.xz
    else
        log_status "Found $POPPLER_VERSION.tar.xz .."
    fi
    # unpack poppler
    tar xf $POPPLER_VERSION.tar.xz
    rm -rf poppler
    mv $POPPLER_VERSION poppler
    # patch poppler
    log_status "Patch poppler-private.h for $POPPLER_VERSION .."
    patch -b "poppler/glib/poppler-private.h" "patches/poppler-private-21.02.0.patch"
    # get poppler-data .tar.gz
    if [ ! -f $POPPLER_DATA.tar.gz ]; then
        log_status "Getting $POPPLER_DATA.tar.gz .."
        wget https://poppler.freedesktop.org/$POPPLER_DATA.tar.gz
    else
        log_status "Found $POPPLER_DATA.tar.gz .."
    fi
    # unpack poppler-data
    tar xf $POPPLER_DATA.tar.gz
    rm -rf poppler-data
    mv $POPPLER_DATA poppler-data
    # build poopler
    cd poppler
    mkdir build
    cd build

    cmake -G "Ninja" -Wno-dev            \
    -DCMAKE_BUILD_TYPE=Release           \
    -DCMAKE_INSTALL_PREFIX="$TARGET"     \
    -DENABLE_UNSTABLE_API_ABI_HEADERS=ON \
    -DBUILD_GTK_TESTS=OFF                \
    -DBUILD_QT5_TESTS=OFF                \
    -DBUILD_GTK_TESTS=OFF                \
    -DENABLE_QT5=OFF                     \
    -DBUILD_CPP_TESTS=OFF                \
    -DENABLE_SPLASH=ON                   \
    -DENABLE_UTILS=OFF                   \
    -DENABLE_CPP=ON                      \
    -DENABLE_GLIB=ON                     \
    -DENABLE_GOBJECT_INTROSPECTION=ON    \
    -DENABLE_GTK_DOC=OFF                 \
    -DENABLE_LIBOPENJPEG="openjpeg2"     \
    -DENABLE_CMS="lcms2"                 \
    -DENABLE_DCTDECODER="libjpeg"        \
    -DENABLE_LIBCURL=OFF                 \
    -DENABLE_ZLIB=ON                     \
    -DENABLE_ZLIB_UNCOMPRESS=OFF         \
    -DUSE_FLOAT=OFF                      \
    -DBUILD_SHARED_LIBS=OFF              \
    -DRUN_GPERF_IF_PRESENT=OFF           \
    -DEXTRA_WARN=OFF                     \
    -DWITH_JPEG=ON                       \
    -DWITH_PNG=ON                        \
    -DWITH_TIFF=ON                       \
    -DWITH_NSS3=OFF                      \
    -DWITH_Cairo=ON                      \
    ..

    cmake --build ./ --target install || bail "ERROR!!: cmake --build ./ --target install (poppler)"
fi

cd $BASE

if (( ! $skipfontforge )) ; then
    log_note "*** Build fontforge $FONTFORGE_VERSION ***"
    # get fontforge
    if [ ! -f $FONTFORGE_SRC ]; then
        log_status "Getting fontforge source $FONTFORGE_SRC .."
        wget wget https://github.com/fontforge/fontforge/archive/$FONTFORGE_SRC
    else
        log_status "Found fontforge source $FONTFORGE_SRC .."
    fi
    # unpack fontforge
    tar xf $FONTFORGE_SRC
    rm -rf fontforge
    mv fontforge-$FONTFORGE_VERSION fontforge
    cd fontforge
    mkdir build
    cd build

    cmake -G "Ninja" -Wno-dev          \
    -DCMAKE_BUILD_TYPE=Release         \
    -DCMAKE_INSTALL_PREFIX="$TARGET"   \
    -DBUILD_SHARED_LIBS:BOOL=OFF       \
    -DENABLE_GUI:BOOL=OFF              \
    -DENABLE_X11:BOOL=OFF              \
    -DENABLE_NATIVE_SCRIPTING:BOOL=ON  \
    -DENABLE_PYTHON_SCRIPTING:BOOL=OFF \
    -DENABLE_PYTHON_EXTENSION:AUTO=OFF \
    -DENABLE_LIBSPIRO:BOOL=OFF         \
    -DENABLE_LIBGIF:AUTO=OFF           \
    -DENABLE_LIBJPEG:AUTO=ON           \
    -DENABLE_LIBPNG:AUTO=ON            \
    -DENABLE_LIBREADLINE:AUTO=OFF      \
    -DENABLE_LIBTIFF:AUTO=ON           \
    -DENABLE_WOFF2:AUTO=OFF            \
    -DENABLE_DOCS:AUTO=OFF             \
    -DENABLE_CODE_COVERAGE:BOOL=OFF    \
    -DENABLE_DEBUG_RAW_POINTS:BOOL=OFF \
    -DENABLE_FONTFORGE_EXTRAS:BOOL=OFF \
    -DENABLE_MAINTAINER_TOOLS:BOOL=OFF \
    -DENABLE_TILE_PATH:BOOL=OFF        \
    -DENABLE_WRITE_PFM:BOOL=ON         \
    -DENABLE_SANITIZER:ENUM="none"     \
    -DENABLE_FREETYPE_DEBUGGER:PATH="" \
    -DSPHINX_USE_VENV:BOOL=OFF         \
    -DREAL_TYPE:ENUM="double"          \
    -DTHEME:ENUM="tango"               \
    ..

    cmake --build ./ --target install || bail "ERROR!!: cmake --build ./ --target install (fontforge)"
fi

cd $BASE

log_note  "*** Build pdf2htmlEX.exe ***"
cd pdf2htmlEX
rm -rf build
mkdir build
cd build
cmake -G "Ninja" -Wno-dev          \
  -DCMAKE_BUILD_TYPE=Release       \
  -DCMAKE_INSTALL_PREFIX="$TARGET" \
  ..

cmake --build ./ --target install || bail "ERROR!!: cmake --build ./ --target install (pdf2htmlEX)"
cd $BASE

# poppler-data
log_status "Install poppler-data "
cd $BASE/poppler-data
make "-j $(nproc)" -s install prefix="$TARGET" datadir="$TARGET/share/pdf2htmlEX" || bail "ERROR!!: make -j $(nproc) -s install (poppler-data)"
cd $BASE

# copy folders
log_status "Copying folders and libs need by pdf2htmlEX.exe "
#cp -rf $TARGET/share/fontforge "$RELEASE/share/"
#cp -rf $TARGET/share/locale "$RELEASE/share/"
#cp -rf $TARGET/share/man "$RELEASE/share/"
cp -Rf $TARGET/share/pdf2htmlEX "$RELEASE/bin/data"
#rm -rf "$RELEASE/share/fontforge/prefs"
#rm -Rf "$RELEASE/share/man"
rm -Rf "$RELEASE/bin/data/pkgconfig"

cd $WORK

# copy libs fontforge
ffex=`which fontforge.exe`
MSYSROOT=`cygpath -w /`
FFEXROOT=`cygpath -w $(dirname "${ffex}")`
fflibs=`ntldd -D "$(dirname \"${ffex}\")" -R "$ffex" \
| grep =.*dll \
| sed -e '/^[^\t]/ d'  \
| sed -e 's/\t//'  \
| sed -e 's/.*=..//'  \
| sed -e 's/ (0.*)//' \
| grep -F -e "$MSYSROOT" -e "$FFEXROOT" \
`

for f in $fflibs; do
    filename="$(basename $f)"
    filenoext="${filename%.*}"
    strip "$f" -svo "$RELEASE/bin/$filename"
done

# copy libs gettext
msgmex=`which msgmerge.exe`
MSGMROOT=`cygpath -w $(dirname "${msgmex}")`
msmglibs=`ntldd -D "$(dirname \"${msgmex}\")" -R "$msgmex" \
| grep =.*dll \
| sed -e '/^[^\t]/ d'  \
| sed -e 's/\t//'  \
| sed -e 's/.*=..//'  \
| sed -e 's/ (0.*)//' \
| grep -F -e "$MSYSROOT" -e "MSGMROOT" \
`

for f in $msmglibs; do
    filename="$(basename $f)"
    filenoext="${filename%.*}"
    strip "$f" -svo "$RELEASE/bin/$filename"
done

# copy libs pdf2htmlEX
pdf2htmlEXex=`which pdf2htmlEX.exe`
PDFHTMLEXROOT=`cygpath -w $(dirname "${pdf2htmlEXex}")`
strip "$pdf2htmlEXex" -so "$RELEASE/bin/pdf2htmlEX.exe"
pdf2htmlexlibs=`ntldd -D "$(dirname \"${pdf2htmlEXex}\")" -R "$pdf2htmlEXex" \
| grep =.*dll \
| sed -e '/^[^\t]/ d'  \
| sed -e 's/\t//'  \
| sed -e 's/.*=..//'  \
| sed -e 's/ (0.*)//' \
| grep -F -e "$MSYSROOT" -e "$PDFHTMLEXROOT" \
`

for f in $pdf2htmlexlibs; do
    filename="$(basename $f)"
    filenoext="${filename%.*}"
    strip "$f" -svo "$RELEASE/bin/$filename"
done

# copy libs ttfautohint
ttfautohintex=`which ttfautohint.exe`
TTFAUTOROOT=`cygpath -w $(dirname "${ttfautohintex}")`
strip "$ttfautohintex" -so "$RELEASE/bin/ttfautohint.exe"
ttfautohintlibs=`ntldd -D "$(dirname \"${ttfautohintex}\")" -R "$ttfautohintex" \
| grep =.*dll \
| sed -e '/^[^\t]/ d'  \
| sed -e 's/\t//'  \
| sed -e 's/.*=..//'  \
| sed -e 's/ (0.*)//' \
| grep -F -e "$MSYSROOT" -e "$TTFAUTOROOT" \
`

for f in $ttfautohintlibs; do
    filename="$(basename $f)"
    filenoext="${filename%.*}"
    strip "$f" -svo "$RELEASE/bin/$filename"
done

cd $BASE

log_note "Compress generated lib and executable files using upx ..."
cd "$RELEASE/bin"

for f in *.{dll,exe}; do
    upx --best "$f"
done

cd $BASE
log_note "*** Finish!!! ***"

exit 0
