/* config.h.  Generated from config.h.cmake by cmake.  */

/* Build against libcurl. */
/* #undef ENABLE_LIBCURL */

/* Use libjpeg instead of builtin jpeg decoder. */
#define ENABLE_LIBJPEG 1

/* Use libopenjpeg instead of builtin jpeg2000 decoder. */
/* #undef ENABLE_LIBOPENJPEG */

/* Build against libtiff. */
/* #undef ENABLE_LIBTIFF */

/* Build against libpng. */
#define ENABLE_LIBPNG 1

/* Do not hardcode the library location */
#define ENABLE_RELOCATABLE 1

/* Build against zlib. */
#define ENABLE_ZLIB 1

/* Use zlib instead of builtin zlib decoder to uncompress flate streams. */
/* #undef ENABLE_ZLIB_UNCOMPRESS */

/* Build against libnss3 for digital signature validation */
/* #undef ENABLE_NSS3 */

/* Use cairo for rendering. */
#define HAVE_CAIRO 1

/* Do we have any DCT decoder?. */
#define HAVE_DCT_DECODER 1

/* Do we have any JPX decoder?. */
/* #undef HAVE_JPX_DECODER */

/* Define to 1 if you have the <dirent.h> header file, and it defines `DIR'.
   */
#define HAVE_DIRENT_H 1

/* Define to 1 if you have the <dlfcn.h> header file. */
/* #undef HAVE_DLFCN_H */

/* Define to 1 if you have the <fcntl.h> header file. */
#define HAVE_FCNTL_H 1

/* Define to 1 if you have the `fseek64' function. */
/* #undef HAVE_FSEEK64 */

/* Define to 1 if fseeko (and presumably ftello) exists and is declared. */
#define HAVE_FSEEKO 1

/* Define to 1 if you have the `ftell64' function. */
/* #undef HAVE_FTELL64 */

/* Define to 1 if you have the `pread64' function. */
/* #undef HAVE_PREAD64 */

/* Define to 1 if you have the `lseek64' function. */
#define HAVE_LSEEK64 1

/* Defines if gettimeofday is available on your system */
#define HAVE_GETTIMEOFDAY 1

/* Defines if gmtime_r is available on your system */
/* #undef HAVE_GMTIME_R */

/* Defines if timegm is available on your system */
/* #undef HAVE_TIMEGM */

/* Define if you have the iconv() function and it works. */
/* #undef HAVE_ICONV */

/* Define to 1 if you have the `z' library (-lz). */
/* #undef HAVE_LIBZ */

/* Defines if localtime_r is available on your system */
/* #undef HAVE_LOCALTIME_R */

/* Define to 1 if you have the `mkstemp' function. */
#define HAVE_MKSTEMP 1

/* Define to 1 if you have the `strcpy_s' function. */
#define HAVE_STRCPY_S 1

/* Define to 1 if you have the `strcat_s' function. */
#define HAVE_STRCAT_S 1

/* Defines if strtok_r is available on your system */
#define HAVE_STRTOK_R 1

/* Define to 1 if you have the <ndir.h> header file, and it defines `DIR'. */
/* #undef HAVE_NDIR_H */

/* Define to 1 if you have the `popen' function. */
#define HAVE_POPEN 1

/* Use splash for rendering. */
#define HAVE_SPLASH 1

/* Define to 1 if you have the <sys/dir.h> header file, and it defines `DIR'.
   */
/* #undef HAVE_SYS_DIR_H */

/* Define to 1 if you have the <sys/mman.h> header file. */
/* #undef HAVE_SYS_MMAN_H */

/* Define to 1 if you have the <sys/ndir.h> header file, and it defines `DIR'.
   */
/* #undef HAVE_SYS_NDIR_H */

/* Define to 1 if you have the <sys/stat.h> header file. */
#define HAVE_SYS_STAT_H 1

/* Define to 1 if you have the <unistd.h> header file. */
#define HAVE_UNISTD_H 1

/* Define to 1 if you have the <codecvt> header file. */
#define HAVE_CODECVT

/* Define to 1 if you have a big endian machine */
/* #undef WORDS_BIGENDIAN */

/* Define as const if the declaration of iconv() needs const. */
#define ICONV_CONST 

/* Generate OPI comments in PS output. */
#define OPI_SUPPORT 1

/* Name of package */
#define PACKAGE "poppler"

/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT "https://bugs.freedesktop.org/enter_bug.cgi?product=poppler"

/* Define to the full name of this package. */
#define PACKAGE_NAME "poppler"

/* Define to the full name and version of this package. */
#define PACKAGE_STRING "poppler 0.89.0"

/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME "poppler"

/* Define to the home page for this package. */
#define PACKAGE_URL ""

/* Define to the version of this package. */
#define PACKAGE_VERSION "0.89.0"

/* Poppler data dir */
#define POPPLER_DATADIR "/usr/local/share/poppler"

/* Support for curl based doc builder is compiled in. */
/* #undef POPPLER_HAS_CURL_SUPPORT */

/* Enable word list support. */
#define TEXTOUT_WORD_LIST 1

/* Defines if use cms */
/* #undef USE_CMS */

/* Use single precision arithmetic in the Splash backend */
/* #undef USE_FLOAT */

/* Version number of package */
#define VERSION "0.89.0"

/* Use fontconfig font configuration backend */
/* #undef WITH_FONTCONFIGURATION_FONTCONFIG */

/* Use win32 font configuration backend */
#define WITH_FONTCONFIGURATION_WIN32 1

/* OpenJPEG with the OPJ_DPARAMETERS_IGNORE_PCLR_CMAP_CDEF_FLAG flag */
/* #undef WITH_OPENJPEG_IGNORE_PCLR_CMAP_CDEF_FLAG */

/* MS defined snprintf as deprecated but then added it in Visual Studio 2015. */
#if defined(_MSC_VER) && _MSC_VER < 1900
#define snprintf _snprintf
#endif

//------------------------------------------------------------------------
// popen
//------------------------------------------------------------------------
#if defined(_MSC_VER) || defined(__BORLANDC__)
#define popen _popen
#define pclose _pclose
#endif

/* Number of bits in a file offset, on hosts where this is settable. */
#define _FILE_OFFSET_BITS 64

/* Define to 1 to make fseeko visible on some hosts (e.g. glibc 2.2). */
/* TODO This is wrong, port if needed #undef _LARGEFILE_SOURCE */

/* Define for large files, on AIX-style hosts. */
/* TODO This is wrong, port if needed #undef _LARGE_FILES */
