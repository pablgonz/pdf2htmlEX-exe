# Install script for directory: D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/po

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

if(CMAKE_INSTALL_COMPONENT STREQUAL "pofiles" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale/ca/LC_MESSAGES" TYPE FILE RENAME "FontForge.mo" FILES "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/po/ca.mo")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "pofiles" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale/de/LC_MESSAGES" TYPE FILE RENAME "FontForge.mo" FILES "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/po/de.mo")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "pofiles" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale/el/LC_MESSAGES" TYPE FILE RENAME "FontForge.mo" FILES "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/po/el.mo")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "pofiles" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale/en_GB/LC_MESSAGES" TYPE FILE RENAME "FontForge.mo" FILES "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/po/en_GB.mo")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "pofiles" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale/es/LC_MESSAGES" TYPE FILE RENAME "FontForge.mo" FILES "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/po/es.mo")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "pofiles" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale/fr/LC_MESSAGES" TYPE FILE RENAME "FontForge.mo" FILES "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/po/fr.mo")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "pofiles" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale/hr/LC_MESSAGES" TYPE FILE RENAME "FontForge.mo" FILES "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/po/hr.mo")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "pofiles" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale/it/LC_MESSAGES" TYPE FILE RENAME "FontForge.mo" FILES "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/po/it.mo")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "pofiles" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale/ja/LC_MESSAGES" TYPE FILE RENAME "FontForge.mo" FILES "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/po/ja.mo")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "pofiles" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale/ko/LC_MESSAGES" TYPE FILE RENAME "FontForge.mo" FILES "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/po/ko.mo")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "pofiles" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale/ml/LC_MESSAGES" TYPE FILE RENAME "FontForge.mo" FILES "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/po/ml.mo")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "pofiles" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale/pl/LC_MESSAGES" TYPE FILE RENAME "FontForge.mo" FILES "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/po/pl.mo")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "pofiles" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale/pt/LC_MESSAGES" TYPE FILE RENAME "FontForge.mo" FILES "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/po/pt.mo")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "pofiles" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale/ru/LC_MESSAGES" TYPE FILE RENAME "FontForge.mo" FILES "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/po/ru.mo")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "pofiles" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale/tr_TR/LC_MESSAGES" TYPE FILE RENAME "FontForge.mo" FILES "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/po/tr_TR.mo")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "pofiles" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale/uk/LC_MESSAGES" TYPE FILE RENAME "FontForge.mo" FILES "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/po/uk.mo")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "pofiles" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale/vi/LC_MESSAGES" TYPE FILE RENAME "FontForge.mo" FILES "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/po/vi.mo")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "pofiles" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale/zh_CN/LC_MESSAGES" TYPE FILE RENAME "FontForge.mo" FILES "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/po/zh_CN.mo")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "pofiles" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/locale/zh_TW/LC_MESSAGES" TYPE FILE RENAME "FontForge.mo" FILES "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/po/zh_TW.mo")
endif()

