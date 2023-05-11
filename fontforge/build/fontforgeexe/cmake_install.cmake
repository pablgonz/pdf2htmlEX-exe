# Install script for directory: D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/fontforgeexe

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "D:/msys64/home/pablg/pdf2htmlEX-exe/target/mingw64")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "D:/msys64/mingw64/bin/objdump.exe")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/bin/fontforge.exe")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/fontforge.exe" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/fontforge.exe")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "D:/msys64/mingw64/bin/strip.exe" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/fontforge.exe")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "nativescripts" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/fontforge/nativescripts" TYPE FILE FILES
    "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/fontforgeexe/fontimage.pe"
    "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/fontforgeexe/fontlint.pe"
    "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/fontforgeexe/sfddiff.pe"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/man/man1" TYPE FILE FILES
    "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/fontforgeexe/fontforge.1"
    "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/fontforgeexe/sfddiff.1"
    "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/fontforgeexe/fontlint.1"
    "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/fontforgeexe/fontimage.1"
    )
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/fontforgeexe/pixmaps/cmake_install.cmake")

endif()

