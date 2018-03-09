INCLUDE(FindPkgConfig)
PKG_CHECK_MODULES(PC_ROCHASTATICS RochaStatics)

FIND_PATH(
    ROCHASTATICS_INCLUDE_DIRS
    NAMES RochaStatics/api.h
    HINTS $ENV{ROCHASTATICS_DIR}/include
        ${PC_ROCHASTATICS_INCLUDEDIR}
    PATHS ${CMAKE_INSTALL_PREFIX}/include
          /usr/local/include
          /usr/include
)

FIND_LIBRARY(
    ROCHASTATICS_LIBRARIES
    NAMES gnuradio-RochaStatics
    HINTS $ENV{ROCHASTATICS_DIR}/lib
        ${PC_ROCHASTATICS_LIBDIR}
    PATHS ${CMAKE_INSTALL_PREFIX}/lib
          ${CMAKE_INSTALL_PREFIX}/lib64
          /usr/local/lib
          /usr/local/lib64
          /usr/lib
          /usr/lib64
)

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(ROCHASTATICS DEFAULT_MSG ROCHASTATICS_LIBRARIES ROCHASTATICS_INCLUDE_DIRS)
MARK_AS_ADVANCED(ROCHASTATICS_LIBRARIES ROCHASTATICS_INCLUDE_DIRS)

