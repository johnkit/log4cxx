# - Try to find Apache Portable Runtime (APR) headers and libraries
#
# Usage of this module as follows:
#
#     find_package(APR)
#
# Variables used by this module, they can change the default behaviour and need
# to be set before calling find_package:
#
# APR_INSTALL_DIR  Set this variable to the install directory of
#                  APR build & installed from source
#
# Variables defined by this module:
#
#  APR_FOUND              The headers & library have been found
#  APR_INCLUDE_DIR        The location of the APR headers
#  APR_LIBRARY            The APR library

find_path(APR_INCLUDE_DIR
  apr.h
  HINTS
    ${APR_INSTALL_DIR}/include
    ${APR_INSTALL_DIR}/include/apr-1
    /usr/include/apr-1
)

find_library(APR_LIBRARY
  NAMES
    libapr-1.lib
    apr-1
  HINTS
    ${APR_INSTALL_DIR}/lib
    /usr/lib
)


mark_as_advanced(
    APR_INCLUDE_DIR
    APR_LIBRARY
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(APR DEFAULT_MSG
    APR_INCLUDE_DIR
    APR_LIBRARY
)
