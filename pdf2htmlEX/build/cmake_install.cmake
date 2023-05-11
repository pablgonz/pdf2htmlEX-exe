# Install script for directory: D:/msys64/home/pablg/pdf2htmlEX-exe/pdf2htmlEX

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "D:/msys64/home/pablg/pdf2htmlEX-exe/pdf2htmlEX/build/pdf2htmlEX.exe")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/pdf2htmlEX.exe" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/pdf2htmlEX.exe")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "D:/msys64/mingw64/bin/strip.exe" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/pdf2htmlEX.exe")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/pdf2htmlEX" TYPE FILE FILES
    "D:/msys64/home/pablg/pdf2htmlEX-exe/pdf2htmlEX/3rdparty/PDF.js/compatibility.js"
    "D:/msys64/home/pablg/pdf2htmlEX-exe/pdf2htmlEX/3rdparty/PDF.js/compatibility.min.js"
    "D:/msys64/home/pablg/pdf2htmlEX-exe/pdf2htmlEX/share/base.css"
    "D:/msys64/home/pablg/pdf2htmlEX-exe/pdf2htmlEX/share/base.min.css"
    "D:/msys64/home/pablg/pdf2htmlEX-exe/pdf2htmlEX/share/fancy.css"
    "D:/msys64/home/pablg/pdf2htmlEX-exe/pdf2htmlEX/share/fancy.min.css"
    "D:/msys64/home/pablg/pdf2htmlEX-exe/pdf2htmlEX/share/LICENSE"
    "D:/msys64/home/pablg/pdf2htmlEX-exe/pdf2htmlEX/share/manifest"
    "D:/msys64/home/pablg/pdf2htmlEX-exe/pdf2htmlEX/share/pdf2htmlEX.js"
    "D:/msys64/home/pablg/pdf2htmlEX-exe/pdf2htmlEX/share/pdf2htmlEX.min.js"
    "D:/msys64/home/pablg/pdf2htmlEX-exe/pdf2htmlEX/share/pdf2htmlEX-64x64.png"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/man/man1" TYPE FILE FILES "D:/msys64/home/pablg/pdf2htmlEX-exe/pdf2htmlEX/pdf2htmlEX.1")
endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "D:/msys64/home/pablg/pdf2htmlEX-exe/pdf2htmlEX/build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
