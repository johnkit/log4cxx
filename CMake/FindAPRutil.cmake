# - Try to find APR Utility headers and libraries
#
# Usage of this module as follows:
#
#     find_package(APRutil)
#
# Variables used by this module, they can change the default behaviour and need
# to be set before calling find_package:
#
# APRutil_INSTALL_DIR  Set this variable to the install directory of
#                      APR-util build & installed from source
#
# Variables defined by this module:
#
#  APRutil_FOUND              The headers & library have been found
#  APRutil_INCLUDE_DIR        The location of the APR-util headers
#  APRutil_LIBRARY            The APR-util library


find_path(APRutil_INCLUDE_DIR
  apu.h
  HINTS
    ${APRutil_INSTALL_DIR}/include/apr-1
    /usr/include/apr-1
)

find_library(APRutil_LIBRARY
  libaprutil-1.so
  HINTS ${APRutil_INSTALL_DIR}/lib
  /usr/lib
)


mark_as_advanced(
    APRutil_INCLUDE_DIR
    APRutil_LIBRARY
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(APRutil DEFAULT_MSG
    APRutil_INCLUDE_DIR
    APRutil_LIBRARY
)
