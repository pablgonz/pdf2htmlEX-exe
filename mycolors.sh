#!/bin/bash
# pdf2htmlEX build script
# Build pdf2htmlEX for 32 and 64 bit under MSYS2
# Author: Pablo González L

# Globlal vars
PDF2HTMLEX_VERSION=0.18.8.rc1
POPPLER_DATA=poppler-data-0.4.12

# Set by CLI before
POPPLER_VERSION="21.02.0"
FONTFORGE_VERSION="20230101"

# Green text
function log_note() {
    echo -ne "\e[32m"; echo "$@"; echo -ne "\e[0m"
}
# Yellow text
function log_status() {
    echo -ne "\e[33m"; echo "$@"; echo -ne "\e[0m"
}
# Red text
function bail () {
    echo -ne "\e[31m\e[1m"; echo "!!! Build failed at: ${@}"; echo -ne "\e[0m"
    exit 1
}
# Red text
function log_error() {
    echo -ne "\e[31m"; echo "$@"; echo -ne "\e[0m"
}

# Validate poppler version
function is_release_version() {
  re='^((0|[1-9][0-9]?|89)\.(0|[1-9][0-9]?)\.(0|[1-9]))$'
  if ! [[ $1 =~ $re ]] ; then
     return 1
  fi
  return 0
}

# Validate fontforge version
function is_release_date_iso() {
  re='^20(19|2[0-9])(0[8-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])$'
  if ! [[ $1 =~ $re ]] ; then
     return 1
  fi
  return 0
}

# First we look for if the environment variable JAVA_HOME is defined in
# Windows, otherwise we look for the executable in the PATH of Windows,
# if found set it to MSYS2 (without this java cannot be executed).
if [[ -n "$JAVA_HOME" ]]; then
    JAVA_HOME=$(echo "$JAVA_HOME" | sed -e 's/\\/\//g' -e 's/\([A-Z]\):/\/\L\1/g' )
    export PATH="$PATH:$JAVA_HOME/bin"
    #JAVA_EXEC=$(find "$JAVA_HOME" -name 'java.exe' -type f -print -quit)
    JAVA_VERSION=$(java -version 2>&1 | head -n 1)

else
    JAVA_HOME=$(powershell -NoProfile -Command "(Get-ItemProperty -Path 'HKCU:\Environment' -Name 'Path').Path | Select-String -Pattern 'java'")
    if [[ -n "$JAVA_HOME" ]]; then
        JAVA_HOME=$(echo "$JAVA_HOME" | sed -e 's/\([A-Z]\):/\/\L\1/g' -e 's/\\/\//g' -e 's/;/\n/g' | grep -i 'java')
        export PATH="$PATH:$JAVA_HOME"
        #JAVA_EXEC=$(find "$JAVA_HOME" -name 'java.exe' -type f -print -quit)
        JAVA_VERSION=$(java -version 2>&1 | head -n 1)
    fi
fi

# Test if $JAVA_VERSION found for --help information and reset var
if [[ -z "$JAVA_VERSION" ]]; then
    JAVA_VERSION="NOT detect java installed in your system"
fi

# Vars defined for script execution
yes=0
nopoppler=0
nofontforge=0
noupx=0
depsonly=0
ghactions=0

function dohelp() {
read -r -d '' usage <<-EOF
Build script for pdf2htmEX version $PDF2HTMLEX_VERSION under MSYS2 (32/64/ucrt)
Usage: `basename $0` [options]

    -h, --help                Prints this help message
    -y, --yes                 Say yes to all build script prompts
    -d, --depsonly            Only install dependencies for MSYS2
    -g, --ghactions           Disable install local dependencies
    -p, --poppler <version>   Install poppler <version>
    -f, --fontforge <version> Install poppler <version>
    -F, --no-fontforge        Skip build/install fontforge
    -P, --no-poppler          Skip build/install poppler
    -U, --no-upx-commpres     Don't commpres .dll/.exe (64-bit/ucrt only)

Default:
poppler version "$POPPLER_VERSION"
fontforge version "$FONTFORGE_VERSION"
$JAVA_VERSION
EOF
echo "$usage"
exit "$1"
}

# CLI interface
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            dohelp 0
            ;;
        -y|--yes)
            yes=$((1-yes))
            shift
            ;;
        -d|--depsonly)
            depsonly=$((1-depsonly))
            shift
            ;;
        -g|--ghactions)
            ghactions=$((1-ghactions))
            shift
            ;;
        -p|--poppler)
            if [[ -z "$2" ]]; then
                log_error "Missing value for --poppler"
                dohelp 1
            fi
            if ! is_release_version "$2"; then
                log_error "Invalid value for --poppler: $2 (must be numeric)"
                dohelp 1
            fi
            POPPLER_VERSION="$2"
            shift 2
            ;;
        -f|--fontforge)
            if [[ -z "$2" ]]; then
                log_error "Missing value for --fontforge"
                dohelp 1
            fi
            if ! is_release_date_iso "$2"; then
                log_error "Invalid value for --fontforge: $2 (must be YYYYMMDD)"
                dohelp 1
            fi
            FONTFORGE_VERSION="$2"
            shift 2
            ;;
        -P|--no-poppler)
            nopoppler=$((1-nopoppler))
            shift
            ;;
        -F|--no-fontforge)
            nofontforge=$((1-nofontforge))
            shift
            ;;
        -U|--no-upx-commpres)
            noupx=$((1-noupx))
            shift
            ;;
        *)
            log_error "Unknown option: $1"
            dohelp 1
            ;;
    esac
done

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

elif [ "$MSYSTEM" = "UCRT64" ]; then
    log_note "Building 64-bit ucrt version!"
    ARCHNUM="64"
    MINGVER=ucrt64
    MINGOTHER=mingw32
    HOST="--build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32"
    PMARCH=ucrt-x86_64
    PMPREFIX="mingw-w64-$PMARCH"

else
    bail "Unknown build system!"
fi

# Reset PDF2HTMLEX_VERSION for .exe
if [ "$MSYSTEM" = "UCRT64" ]; then
    PDF2HTMLEX_VERSION=$(echo "$PDF2HTMLEX_VERSION" \($ARCHNUM-bit-ucrt64\))
else
    PDF2HTMLEX_VERSION=$(echo "$PDF2HTMLEX_VERSION" \($ARCHNUM-bit\))
fi

# Tree for build/release (mmm use /tmp => pdf2htmlEX-win-64/ for release)
# Quizas pueda quitar el directorio y luego usar un archivo .zip
# algo del estilo pdf2htmlEX-win-64.zip y evitar git al cambiar de arquitectura
BASE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
RELEASE=$BASE/ReleasePackage/

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

# Early detection
detect_arch_switch $MINGVER

# Dirs for operations
TARGET=$BASE/target/$MINGVER/
WORK=$BASE/work/$MINGVER/

# Test for MINGW version installed
PMTEST="$BASE/.pacman-$MINGVER-installed"

# Make output directories
rm -R -f "$WORK"
mkdir -p "$WORK"
rm -R -f "$RELEASE/bin"
mkdir -p "$RELEASE/bin"

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
        log_status "First time run; installing packages for MSYS and MinGW..."
        pacman -Sy --noconfirm
        IOPTS="-S --noconfirm --needed"

        # Install the base MSYS packages needed
        pacman $IOPTS diffutils findutils make patch pkgconf

        # Install MinGW related stuff
        pacman $IOPTS $PMPREFIX-{gcc,ntldd,gettext,cmake,ninja,gobject-introspection-runtime,libpng,libjpeg-turbo,lcms2,xz,bzip2,pixman,fontconfig,brotli,lzo2,pcre2,libffi,ragel}

        # Libraries
        pacman $IOPTS $PMPREFIX-{libxml2,openjpeg2,freetype,cairo,ttfautohint}
        # Save test file
        touch $PMTEST

        log_note "Finished installing packages for MSYS and MinGW!"
    else
        log_note "Detected that packages for MSYS and MinGW are already installed."
        log_note "execute 'rm -rf $PMTEST' and run this script again if"
        log_note "this is not the case."
    fi
fi

# Build poppler
if (( ! $nopoppler )) ; then
    # Set version poppler for download
    POPPLER_VERSION=$(echo "poppler-$POPPLER_VERSION")

    log_note "*** Build $POPPLER_VERSION ***"

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

    # patch poppler (need test here for version number)
    log_status "Patch glib/poppler-private.h for $POPPLER_VERSION .."
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
    cmake -G "Ninja" -Wno-dev                \
        -DCMAKE_BUILD_TYPE=Release           \
        -DCMAKE_INSTALL_PREFIX="$TARGET"     \
        -DENABLE_UNSTABLE_API_ABI_HEADERS=ON \
        -DBUILD_GTK_TESTS=OFF                \
        -DBUILD_QT5_TESTS=OFF                \
        -DBUILD_GTK_TESTS=OFF                \
        -DENABLE_QT5=OFF                     \
        -DENABLE_QT6=OFF                     \
        -DBUILD_CPP_TESTS=OFF                \
        -DENABLE_SPLASH=ON                   \
        -DENABLE_UTILS=OFF                   \
        -DENABLE_CPP=ON                      \
        -DENABLE_GLIB=ON                     \
        -DENABLE_GOBJECT_INTROSPECTION=ON    \
        -DENABLE_GTK_DOC=OFF                 \
        -DENABLE_LIBOPENJPEG="openjpeg2"     \
        -DENABLE_CMS="none"                  \
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
        -DWITH_TIFF=OFF                      \
        -DWITH_NSS3=OFF                      \
        -DWITH_Cairo=ON                      \
    ..

    cmake --build ./ --target install || bail "ERROR!!: cmake --build ./ --target install (poppler)"
fi

cd $BASE

# Capture poppler version (for -P option) and reset $POPPLER_VERSION var
poppler_file="poppler/build/cpp/poppler-version.h"
if [[ -f "$poppler_file" ]]; then
    version_line=$(grep -oP '#define POPPLER_VERSION "\K[^"]+' "$poppler_file")
    export POPPLER_VERSION="$version_line"

fi

# Build fontforge
if (( ! $nofontforge )) ; then
    # Set FONTFORGE_SRC for download
    FONTFORGE_SRC=$FONTFORGE_VERSION.tar.gz

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

    # build fontforge
    cd fontforge
    mkdir build
    cd build
    cmake -G "Ninja" -Wno-dev              \
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
        -DENABLE_LIBTIFF:AUTO=OFF          \
        -DENABLE_WOFF2:AUTO=OFF            \
        -DENABLE_DOCS:AUTO=OFF             \
        -DENABLE_CODE_COVERAGE:BOOL=OFF    \
        -DENABLE_DEBUG_RAW_POINTS:BOOL=OFF \
        -DENABLE_FONTFORGE_EXTRAS:BOOL=OFF \
        -DENABLE_MAINTAINER_TOOLS:BOOL=OFF \
        -DENABLE_TILE_PATH:BOOL=OFF        \
        -DENABLE_WRITE_PFM:BOOL=OFF        \
        -DENABLE_SANITIZER:ENUM="none"     \
        -DENABLE_FREETYPE_DEBUGGER:PATH="" \
        -DSPHINX_USE_VENV:BOOL=OFF         \
        -DREAL_TYPE:ENUM="double"          \
        -DTHEME:ENUM="tango"               \
    ..

    cmake --build ./ --target install || bail "ERROR!!: cmake --build ./ --target install (fontforge)"
fi

cd $BASE

# Capture fontforge version (for -F option) and reset FONTFORGE_VERSION var
config_file="fontforge/build/inc/fontforge-config.h"
if [[ -f "$config_file" ]]; then
    version_line=$(grep '#define FONTFORGE_VERSION' "$config_file" | awk '{print $3}' | tr -d '"')
    export FONTFORGE_VERSION="$version_line"
fi

# Build pdf2htmlEX (use -P -F if all before are OK)
log_note  "*** Build pdf2htmlEX $PDF2HTMLEX_VERSION ***"
cd pdf2htmlEX
rm -rf build
mkdir build
cd build
cmake -G "Ninja" -Wno-dev            \
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
log_status "Copying files and dirs need by pdf2htmlEX.exe "
cp -Rvf $TARGET/share/pdf2htmlEX "$RELEASE/bin/data"
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
    strip "$f" -so "$RELEASE/bin/$filename"
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
    strip "$f" -so "$RELEASE/bin/$filename"
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
    strip "$f" -so "$RELEASE/bin/$filename"
done

# copy libs ttfautohint
log_status "Copying files need by ttfautohint.exe "
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
    strip "$f" -so "$RELEASE/bin/$filename"
done

cd $BASE

# Only 64-bit and ucrt support upx commpress
if (( ! $noupx )) && [ "$MSYSTEM" != "MINGW32" ]; then
    log_note "Compress generated .dll and executable files using upx ..."
    cd "$RELEASE/bin"
    for f in *.{dll, exe} ; do
        upx -qq --best --ultra-brute "$f"
    done
    cd $BASE
fi

# Finish
log_note "*** Finish!!! ***"

exit 0
