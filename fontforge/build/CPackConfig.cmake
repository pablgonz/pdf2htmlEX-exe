# This file will be configured to contain variables for CPack. These variables
# should be set in the CMake list file of the project before CPack module is
# included. The list of available CPACK_xxx variables and their associated
# documentation may be obtained using
#  cpack --help-variable-list
#
# Some variables are common to all generators (e.g. CPACK_PACKAGE_NAME)
# and some are specific to a generator
# (e.g. CPACK_NSIS_EXTRA_INSTALL_COMMANDS). The generator specific variables
# usually begin with CPACK_<GENNAME>_xxxx.


set(CPACK_BUILD_SOURCE_DIRS "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge;D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build")
set(CPACK_CMAKE_GENERATOR "Ninja")
set(CPACK_COMPONENTS_ALL "Unspecified;cidmaps;nativescripts;pofiles;theme")
set(CPACK_COMPONENT_UNSPECIFIED_HIDDEN "TRUE")
set(CPACK_COMPONENT_UNSPECIFIED_REQUIRED "TRUE")
set(CPACK_DEFAULT_PACKAGE_DESCRIPTION_FILE "D:/msys64/mingw64/share/cmake/Templates/CPack.GenericDescription.txt")
set(CPACK_DEFAULT_PACKAGE_DESCRIPTION_SUMMARY "fontforge built using CMake")
set(CPACK_GENERATOR "TXZ")
set(CPACK_INSTALL_CMAKE_PROJECTS "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build;fontforge;ALL;/")
set(CPACK_INSTALL_PREFIX "D:/msys64/home/pablg/pdf2htmlEX-exe/target/mingw64")
set(CPACK_INSTALL_SCRIPT "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/CPackExtraDist.cmake")
set(CPACK_MODULE_PATH "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/cmake;D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/cmake/packages")
set(CPACK_NSIS_DISPLAY_NAME "fontforge 20220308")
set(CPACK_NSIS_INSTALLER_ICON_CODE "")
set(CPACK_NSIS_INSTALLER_MUI_ICON_CODE "")
set(CPACK_NSIS_INSTALL_ROOT "$PROGRAMFILES64")
set(CPACK_NSIS_PACKAGE_NAME "fontforge 20220308")
set(CPACK_NSIS_UNINSTALL_NAME "Uninstall")
set(CPACK_OBJCOPY_EXECUTABLE "D:/msys64/mingw64/bin/objcopy.exe")
set(CPACK_OBJDUMP_EXECUTABLE "D:/msys64/mingw64/bin/objdump.exe")
set(CPACK_OUTPUT_CONFIG_FILE "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/CPackConfig.cmake")
set(CPACK_PACKAGE_DEFAULT_LOCATION "/")
set(CPACK_PACKAGE_DESCRIPTION_FILE "D:/msys64/mingw64/share/cmake/Templates/CPack.GenericDescription.txt")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "fontforge built using CMake")
set(CPACK_PACKAGE_FILE_NAME "fontforge-20220308-win64")
set(CPACK_PACKAGE_INSTALL_DIRECTORY "fontforge 20220308")
set(CPACK_PACKAGE_INSTALL_REGISTRY_KEY "fontforge 20220308")
set(CPACK_PACKAGE_NAME "fontforge")
set(CPACK_PACKAGE_RELOCATABLE "true")
set(CPACK_PACKAGE_VENDOR "Humanity")
set(CPACK_PACKAGE_VERSION "20220308")
set(CPACK_PACKAGE_VERSION_MAJOR "20220308")
set(CPACK_PACKAGE_VERSION_MINOR "0")
set(CPACK_PACKAGE_VERSION_PATCH "0")
set(CPACK_READELF_EXECUTABLE "D:/msys64/mingw64/bin/readelf.exe")
set(CPACK_RESOURCE_FILE_LICENSE "D:/msys64/mingw64/share/cmake/Templates/CPack.GenericLicense.txt")
set(CPACK_RESOURCE_FILE_README "D:/msys64/mingw64/share/cmake/Templates/CPack.GenericDescription.txt")
set(CPACK_RESOURCE_FILE_WELCOME "D:/msys64/mingw64/share/cmake/Templates/CPack.GenericWelcome.txt")
set(CPACK_SET_DESTDIR "OFF")
set(CPACK_SOURCE_GENERATOR "TXZ")
set(CPACK_SOURCE_IGNORE_FILES "/\\.git/;\\.swp$;\\.#;/#;/\\.gitignore$;/\\.gitattributes$;~$;\\.mode;\\.pbxuser$;\\.perspective;\\.pyc$;\\.pyo$;/cmake-build/;/build/;/\\.DS_Store;/\\._;/\\.Spotlight-V100$;/\\.Trashes$;/ethumbs.db$;/Thumbs.db$")
set(CPACK_SOURCE_OUTPUT_CONFIG_FILE "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/CPackSourceConfig.cmake")
set(CPACK_SOURCE_PACKAGE_FILE_NAME "fontforge-20220308")
set(CPACK_SYSTEM_NAME "win64")
set(CPACK_THREADS "1")
set(CPACK_TOPLEVEL_TAG "win64")
set(CPACK_WIX_SIZEOF_VOID_P "8")

if(NOT CPACK_PROPERTIES_FILE)
  set(CPACK_PROPERTIES_FILE "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/CPackProperties.cmake")
endif()

if(EXISTS ${CPACK_PROPERTIES_FILE})
  include(${CPACK_PROPERTIES_FILE})
endif()
