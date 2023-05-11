#[=======================================================================[.rst:
Uninstall
---------

Uninstall script from
https://gitlab.kitware.com/cmake/community/wikis/FAQ#can-i-do-make-uninstall-with-cmake

#]=======================================================================]

if(NOT EXISTS "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/install_manifest.txt")
  message(FATAL_ERROR "Cannot find install manifest: D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/install_manifest.txt")
endif(NOT EXISTS "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/install_manifest.txt")

file(READ "D:/msys64/home/pablg/pdf2htmlEX-exe/fontforge/build/install_manifest.txt" files)
string(REGEX REPLACE "\n" ";" files "${files}")
foreach(file ${files})
  message(STATUS "Uninstalling $ENV{DESTDIR}${file}")
  if(IS_SYMLINK "$ENV{DESTDIR}${file}" OR EXISTS "$ENV{DESTDIR}${file}")
    exec_program(
      "D:/msys64/mingw64/bin/cmake.exe" ARGS "-E remove \"$ENV{DESTDIR}${file}\""
      OUTPUT_VARIABLE rm_out
      RETURN_VALUE rm_retval
      )
    if(NOT "${rm_retval}" STREQUAL 0)
      message(FATAL_ERROR "Problem when removing $ENV{DESTDIR}${file}")
    endif(NOT "${rm_retval}" STREQUAL 0)
  else(IS_SYMLINK "$ENV{DESTDIR}${file}" OR EXISTS "$ENV{DESTDIR}${file}")
    message(STATUS "File $ENV{DESTDIR}${file} does not exist.")
  endif(IS_SYMLINK "$ENV{DESTDIR}${file}" OR EXISTS "$ENV{DESTDIR}${file}")
endforeach(file)
