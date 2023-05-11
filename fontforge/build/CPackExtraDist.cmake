# Distributed under the original FontForge BSD 3-clause license

#[=======================================================================[.rst:
ExtraDist
---------

Helper script for CPack to add additional files to the dist bundle.
Currently used to:
* Add the downloaded/generated fonts

#]=======================================================================]

if(CPACK_SOURCE_INSTALLED_DIRECTORIES)
  message(STATUS "Adding retrieved/generated fonts from D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/tests/fonts to ${CMAKE_CURRENT_BINARY_DIR}/tests/fonts...")
  file(INSTALL "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/tests/fonts" DESTINATION "${CMAKE_CURRENT_BINARY_DIR}/tests")
endif()
