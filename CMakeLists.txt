cmake_minimum_required(VERSION 2.8.12)

project(log4cxx C CXX)
set(PROJECT_VERSION 0.10.0)
include(CheckFunctionExists)
include(CheckIncludeFile)

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

set(enable-unichar  0       CACHE BOOL "enable unichar(no)")
set(enable-cfstring 0       CACHE BOOL "enable cfstring(no)")
set(enable-wchar_t  1       CACHE BOOL "enable wchar_t")

set(with-logchar    utf-8   CACHE STRING "type for logchar. Accepted TYPE variants: auto, utf-8,\n"
                                  "wchar_t, unichar (default=utf-8)")
set(with-charset    auto    CACHE STRING "locale charset Accepted TYPE variants: auto, utf-8,\n"
                                  "iso-8859-1, usascii, ebcdic (default=auto)")
set(with-ODBC       NO      CACHE STRING "ODBC support. Accepted arguments: unixODBC, iODBC,\n"
                                         "Microsoft, NO (default=NO)")
set(with-SMTP       NO      CACHE STRING "SMTP support, Accepted arguments: libesmtp, NO\n"
                                         "(default=NO)")

# char api
set(CHAR_API            1)
set(UNICHAR_API         0)
set(WCHAR_T_API         1)
set(CFSTRING_API        0)

# logchar
set(LOGCHAR_IS_UTF8     1)
set(LOGCHAR_IS_UNICHAR  0)
set(LOGCHAR_IS_WCHAR    0)

# charset
set(CHARSET_UTF8        0)
set(CHARSET_ISO88591    0)
set(CHARSET_USASCII     0)
set(CHARSET_EBCDIC      0)

# check function exists
set(HAS_MBSRTOWCS 0)
CHECK_FUNCTION_EXISTS(mbsrtowcs HAS_MBSRTOWCS)
set(HAS_WCSTOMBS 0)
CHECK_FUNCTION_EXISTS(wcstombs  HAS_WCSTOMBS)
set(HAS_FWIDE 0)
CHECK_FUNCTION_EXISTS(fwide     HAS_FWIDE)

# check header exists
set(HAS_SYSLOG 0)
CHECK_INCLUDE_FILE(syslog.h HAS_SYSLOG)
set(HAS_STD_LOCALE 0)
CHECK_INCLUDE_FILE(locale.h HAS_STD_LOCALE)

# check libesmtp exists
set(HAS_LIBESMTP 0)
set(HAS_ODBC 0)
if(with-SMTP)
    find_library(LIBESMTP libesmtp REQUIRED)
    set(HAS_LIBESMTP 0)
endif()

# Find APR and APRutil packages
set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/CMake" ${CMAKE_MODULE_PATH})
set(APR_INSTALL_DIR CACHE PATH "Path to Apache Portable Runtime install directory")
find_package(APR REQUIRED)
set(APRutil_INSTALL_DIR CACHE PATH "Path to APR-util install directory")
find_package(APRutil REQUIRED)

# Include export header so that we can easily control symbol exporting
# Setup by default *not* to export symbols unless explicitly stated.
set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN 1)
include(GenerateExportHeader)


# configure log4cxx.h
configure_file(${PROJECT_SOURCE_DIR}/src/main/include/log4cxx/log4cxx.h.in
    ${PROJECT_BINARY_DIR}/log4cxx/log4cxx.h
    @ONLY)

# configure log4cxx
configure_file(${PROJECT_SOURCE_DIR}/src/main/include/log4cxx/private/log4cxx_private.h.in
    ${PROJECT_BINARY_DIR}/log4cxx/private/log4cxx_private.h
    @ONLY)



file(GLOB log4cxx_source "${PROJECT_SOURCE_DIR}/src/main/cpp/*.cpp")
file(GLOB_RECURSE log4cxx_header "${PROJECT_SOURCE_DIR}/src/main/include/log4cxx/*.h")
add_library(log4cxx SHARED 
    ${log4cxx_source}
)

set_target_properties(log4cxx
    PROPERTIES
        VERSION "${PROJECT_VERSION}"
        SOVERSION "${PROJECT_VERSION}"
)
target_include_directories(log4cxx
    PUBLIC
        ${APR_INCLUDE_DIR}
        ${APRutil_INCLUDE_DIR}
        $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}>
        $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/src/main/include>
        $<INSTALL_INTERFACE:include>
)
target_link_libraries(log4cxx PUBLIC ${APR_LIBRARY} ${APRutil_LIBRARY})

# Setup export header
generate_export_header(log4cxx)


install(TARGETS log4cxx
    EXPORT log4cxx-export
    LIBRARY DESTINATION lib
    RUNTIME DESTINATION bin
    ARCHIVE DESTINATION lib
)
install(EXPORT log4cxx-export
    FILE log4cxx-config.cmake
    DESTINATION cmake)
export(TARGETS log4cxx
    FILE log4cxx-export.cmake)

# install header files from source tree
install(DIRECTORY ${PROJECT_SOURCE_DIR}/src/main/include/log4cxx
    DESTINATION include
    COMPONENT devel
    PATTERN "*.h"
    PATTERN "*.hw" EXCLUDE
    PATTERN "*.in" EXCLUDE
    PATTERN ".*" EXCLUDE
    PATTERN "Makefile.am" EXCLUDE
)

# Install log4cxx_export.h
install(FILES
  ${PROJECT_BINARY_DIR}/log4cxx_export.h
  DESTINATION include
)

# install generated header files from build tree
install(DIRECTORY
    ${PROJECT_BINARY_DIR}/log4cxx
    DESTINATION include
    COMPONENT devel
)

