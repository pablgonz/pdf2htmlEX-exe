#!/bin/bash
# pdf2htmlEX build script.
# Uses MSYS2/MinGW-w64
# Author: Pablo

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

# Set working folders and vars
export PATH=$PATH:"/c/java/jdk-20.0.1/bin"
export PDF2HTMLEX_VERSION=0.18.8.rc1
export POPPLER_VERSION=poppler-0.89.0
export POPPLER_DATA=poppler-data-0.4.9
export FONTFORGE_VERSION=20220308
FONTFORGE_SRC=$FONTFORGE_VERSION.tar.gz

# Vars for MSYS2
ARCHNUM="64"
MINGVER=mingw64
MINGOTHER=mingw32
HOST="--build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32 --target=x86_64-w64-mingw32"
PMARCH=x86_64
PMPREFIX="mingw-w64-$PMARCH"

# tree for build/release
BASE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
RELEASE=$BASE/ReleasePackage/

# Common options
TARGET=$BASE/target/$MINGVER/
WORK=$BASE/work/$MINGVER/

# Make the output directories
mkdir -p "$WORK"
mkdir -p "$RELEASE/bin"
mkdir -p "$RELEASE/lib"
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

# buid poppler
log_note "* Build poopler $POPPLER_VERSION *"

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

# get poppler-data .tar.gz
if [ ! -f $POPPLER_DATA.tar.gz ]; then
	log_note "Getting $POPPLER_DATA.tar.gz .."
	wget -q https://poppler.freedesktop.org/$POPPLER_DATA.tar.gz
else
	log_note "Found $POPPLER_DATA.tar.gz .."
fi

# unpack poppler-data
tar xf $POPPLER_DATA.tar.gz
rm -rf poppler-data
mv $POPPLER_DATA poppler-data

# patch poppler-23.04
# wget -nv https://raw.githubusercontent.com/msys2/MINGW-packages/master/mingw-w64-poppler/0001-nopython-generate-enums.patch
# patch -p1 -i "0001-nopython-generate-enums.patch"

if [ ! -f poppler/glib/poppler-private.h.orig ]; then
log_note "Patch poppler-private.h for $POPPLER_VERSION .."
patch -b "poppler/glib/poppler-private.h" "patches/poppler-private.patch"
fi

cd poppler
mkdir build
cd build

cmake -G "Ninja" -Wno-dev                \
  -DCMAKE_BUILD_TYPE=Release             \
  -DCMAKE_INSTALL_PREFIX="$TARGET"       \
  -DENABLE_UNSTABLE_API_ABI_HEADERS=OFF  \
  -DBUILD_GTK_TESTS=OFF                  \
  -DBUILD_QT5_TESTS=OFF                  \
  -DBUILD_CPP_TESTS=OFF                  \
  -DENABLE_SPLASH=ON                     \
  -DENABLE_UTILS=OFF                     \
  -DENABLE_CPP=OFF                       \
  -DENABLE_GLIB=ON                       \
  -DENABLE_GOBJECT_INTROSPECTION=OFF     \
  -DENABLE_GTK_DOC=OFF                   \
  -DENABLE_QT5=OFF                       \
  -DENABLE_LIBOPENJPEG="none"            \
  -DENABLE_CMS="none"                    \
  -DENABLE_DCTDECODER="libjpeg"          \
  -DENABLE_LIBCURL=OFF                   \
  -DENABLE_ZLIB=ON                       \
  -DENABLE_ZLIB_UNCOMPRESS=OFF           \
  -DUSE_FLOAT=OFF                        \
  -DBUILD_SHARED_LIBS=OFF                \
  -DRUN_GPERF_IF_PRESENT=OFF             \
  -DEXTRA_WARN=OFF                       \
  -DWITH_JPEG=ON                         \
  -DWITH_PNG=ON                          \
  -DWITH_TIFF=OFF                        \
  -DWITH_NSS3=OFF                        \
  -DWITH_Cairo=ON                        \
  ..

cmake --build ./ 
cmake --build ./ --target install
cd $BASE

log_note "* Build fontforge $FONTFORGE_VERSION *"

# get fontforge
if [ ! -f $FONTFORGE_SRC ]; then
	log_status "Getting fontforge source $FONTFORGE_SRC .."
	wget -q https://github.com/fontforge/fontforge/archive/$FONTFORGE_SRC
else
	log_status "Found fontforge source $FONTFORGE_SRC .."
fi

# unpack poppler
tar xf $FONTFORGE_SRC
rm -rf fontforge
mv fontforge-$FONTFORGE_VERSION fontforge

cd fontforge
mkdir build
cd build

cmake -G "Ninja" -Wno-dev                   \
  -DCMAKE_BUILD_TYPE=Release                \
  -DCMAKE_INSTALL_PREFIX="$TARGET"          \
  -DBUILD_SHARED_LIBS:BOOL=OFF              \
  -DENABLE_GUI:BOOL=OFF                     \
  -DENABLE_X11:BOOL=OFF                     \
  -DENABLE_NATIVE_SCRIPTING:BOOL=ON         \
  -DENABLE_PYTHON_SCRIPTING:BOOL=OFF        \
  -DENABLE_PYTHON_EXTENSION:AUTO=OFF        \
  -DENABLE_LIBSPIRO:BOOL=OFF                \
  -DENABLE_LIBUNINAMESLIST:BOOL=OFF         \
  -DENABLE_LIBGIF:AUTO=OFF                  \
  -DENABLE_LIBJPEG:AUTO=ON                  \
  -DENABLE_LIBPNG:AUTO=ON                   \
  -DENABLE_LIBREADLINE:AUTO=OFF             \
  -DENABLE_LIBTIFF:AUTO=OFF                 \
  -DENABLE_WOFF2:AUTO=OFF                   \
  -DENABLE_DOCS:AUTO=OFF                    \
  -DENABLE_CODE_COVERAGE:BOOL=OFF           \
  -DENABLE_DEBUG_RAW_POINTS:BOOL=OFF        \
  -DENABLE_FONTFORGE_EXTRAS:BOOL=OFF        \
  -DENABLE_MAINTAINER_TOOLS:BOOL=OFF        \
  -DENABLE_TILE_PATH:BOOL=OFF               \
  -DENABLE_WRITE_PFM:BOOL=OFF               \
  -DENABLE_SANITIZER:ENUM="none"            \
  -DENABLE_FREETYPE_DEBUGGER:PATH=""        \
  -DSPHINX_USE_VENV:BOOL=OFF                \
  -DREAL_TYPE:ENUM="double"                 \
  -DTHEME:ENUM="tango"                      \
  ..

cmake --build ./ 
cmake --build ./ --target install
cd $BASE

log_note  "* Build pdf2htmEX *"

## patch StringFormatter.cc
#if [ ! -f pdf2htmlEX/src/StringFormatter.cc.orig ]; then
	#log_status "Patch StringFormatter.cc .."
	#patch -b "pdf2htmlEX/src/StringFormatter.cc" "patches/StringFormatter.patch"
#fi

## patch StringFormatter.h
#if [ ! -f pdf2htmlEX/src/StringFormatter.h.orig ]; then
	#log_status "Patch StringFormatter.h .."
	#patch -b "pdf2htmlEX/src/StringFormatter.h" "patches/StringFormatter_h.patch"
#fi

cd pdf2htmlEX
rm -rf build
mkdir build
cd build

cmake -Wno-dev -G "MSYS Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$TARGET" ..
make -j 8 -s install || bail "ERROR!!: make -j 8 -s instal from pdf2htmlEX"

cd $BASE/poppler-data

log_note "* Install poppler-data "
make -j 8 -s install prefix="$TARGET" datadir="$TARGET/share/pdf2htmlEX" || bail "ERROR!!: make -j 8 -s install from poppler-data"
cd $BASE

log_note "* Assembling the release package pdf2htmlEX.exe *"

log_status "Copying glib spawn helpers..."
strip "/$MINGVER/bin/gspawn-win$ARCHNUM-helper.exe" -so "$RELEASE/bin/gspawn-win$ARCHNUM-helper.exe" || bail "Glib spawn helper not found!"
strip "/$MINGVER/bin/gspawn-win$ARCHNUM-helper-console.exe" -so "$RELEASE/bin/gspawn-win$ARCHNUM-helper-console.exe" || bail "Glib spawn helper not found!"

log_status "Copying the shared folders to $RELEASE/share/"
cp -rf $TARGET/share/fontforge "$RELEASE/share/"
cp -rf $TARGET/share/locale "$RELEASE/share/"
cp -rf $TARGET/share/man "$RELEASE/share/"
cp -rf $TARGET/share/pdf2htmlEX "$RELEASE/share/"
rm -f "$RELEASE/share/prefs"

cd $WORK

log_status "Copying the Python extension dlls..."
cp -f "$TARGET/lib/$PYVER/site-packages/fontforge.pyd" "$RELEASE/lib/$PYVER/site-packages/" || bail "Couldn't copy pyhook dlls"
cp -f "$TARGET/lib/$PYVER/site-packages/psMat.pyd" "$RELEASE/lib/$PYVER/site-packages/" || bail "Couldn't copy pyhook dlls"

ffex=`which fontforge.exe`
MSYSROOT=`cygpath -w /`
FFEXROOT=`cygpath -w $(dirname "${ffex}")`
log_note "The executable: $ffex"
log_note "MSYS root: $MSYSROOT"
log_note "FFEX root: $FFEXROOT"

fflibs=`ntldd -D "$(dirname \"${ffex}\")" \
| grep =.*dll \
| sed -e '/^[^\t]/ d'  \
| sed -e 's/\t//'  \
| sed -e 's/.*=..//'  \
| sed -e 's/ (0.*)//' \
| grep -F -e "$MSYSROOT" -e "$FFEXROOT" \
`

log_status "Copying the FontForge executable..."
strip "$ffex" -so "$RELEASE/bin/fontforge.exe"

log_note "Installing msgmerge.exe need by pdf2htmlEX..."
msgmex=`which msgmerge.exe`
MSGMROOT=`cygpath -w $(dirname "${msgmex}")`
log_note "The executable: $msgmex"
strip "$msgmex" -svo "$RELEASE/bin/msgmerge.exe"

msmglibs=`ntldd -D "$(dirname \"${msgmex}\")" \
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

log_note "Installing potrace.exe need by fontforge..."
potrace=`which potrace.exe`
POTRACERROOT=`cygpath -w $(dirname "${potrace}")`
log_note "The executable: $potrace"
strip "$potrace" -svo "$RELEASE/bin/potrace.exe"

potracelibs=`ntldd -D "$(dirname \"${msgmex}\")" \
| grep =.*dll \
| sed -e '/^[^\t]/ d'  \
| sed -e 's/\t//'  \
| sed -e 's/.*=..//'  \
| sed -e 's/ (0.*)//' \
| grep -F -e "$MSYSROOT" -e "$POTRACERROOT" \
`

for f in $potracelibs; do
    filename="$(basename $f)"
    filenoext="${filename%.*}"
    strip "$f" -svo "$RELEASE/bin/$filename"
done

log_note "Installing custom binaries pdf2htlmEX ..."
pdf2htmlEXex=`which pdf2htmlEX.exe`
PDFHTMLEXROOT=`cygpath -w $(dirname "${pdf2htmlEXex}")`
log_note "The executable: ${pdf2htmlEXex}"
strip "$pdf2htmlEXex" -svo "$RELEASE/bin/pdf2htmlEX.exe"

pdf2htmlexlibs=`ntldd -D "$(dirname \"${pdf2htmlEXex}\")" \
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

log_note "Finish!!! .."

exit 1

# libs not catch by ntldd
RELEASE/bin/libcairo-2.dll
RELEASE/binlibfontconfig-1.dll
RELEASE/bin/libexpat-1.dll
RELEASE/bin/libpixman-1-0.dll
