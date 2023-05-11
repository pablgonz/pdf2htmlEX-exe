# Install script for directory: D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/contrib/cidmap

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

if(CMAKE_INSTALL_COMPONENT STREQUAL "cidmaps" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/fontforge/cidmap" TYPE FILE FILES
    "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/contrib/cidmap/Adobe-CNS1-6.cidmap"
    "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/contrib/cidmap/Adobe-GB1-5.cidmap"
    "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/contrib/cidmap/Adobe-Identity-0.cidmap"
    "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/contrib/cidmap/Adobe-Japan1-5.cidmap"
    "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/contrib/cidmap/Adobe-Japan1-6.cidmap"
    "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/contrib/cidmap/Adobe-Japan1-7.cidmap"
    "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/contrib/cidmap/Adobe-Japan2-0.cidmap"
    "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/contrib/cidmap/Adobe-Korea1-2.cidmap"
    )
endif()

