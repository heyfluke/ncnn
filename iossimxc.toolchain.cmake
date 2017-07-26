# Standard settings
# set(UNIX True)
# set(Darwin True)
# set(IOS True)
set (CMAKE_SYSTEM_NAME Darwin)
set (CMAKE_SYSTEM_VERSION 1)
set (UNIX True)
set (APPLE True)
set (IOS True)

# suppress -rdynamic
# set(CMAKE_SYSTEM_NAME Generic)

#set(CMAKE_C_COMPILER i386-apple-darwin11-clang)
#set(CMAKE_CXX_COMPILER i386-apple-darwin11-clang++)
IF(NOT CMAKE_C_COMPILER)
  execute_process(COMMAND xcrun -sdk iphonesimulator -find clang
   OUTPUT_VARIABLE CMAKE_C_COMPILER
   ERROR_QUIET
   OUTPUT_STRIP_TRAILING_WHITESPACE)
  message(STATUS "Using c compiler ${CMAKE_C_COMPILER}")
ENDIF()
IF(NOT CMAKE_CXX_COMPILER)
  execute_process(COMMAND xcrun -sdk iphonesimulator -find clang++
   OUTPUT_VARIABLE CMAKE_CXX_COMPILER
   ERROR_QUIET
   OUTPUT_STRIP_TRAILING_WHITESPACE)
  message(STATUS "Using c++ compiler ${CMAKE_CXX_COMPILER}")
ENDIF()

# FIXME: not work. workaround: set CMAKE_AR in build command line.
# IF(NOT CMAKE_AR)
#   execute_process(COMMAND xcrun -sdk iphonesimulator -find ar
#    OUTPUT_VARIABLE CMAKE_AR
#    ERROR_QUIET
#    OUTPUT_STRIP_TRAILING_WHITESPACE)
#   message(STATUS "Using ar ${CMAKE_AR}")
# ENDIF()

set(_CMAKE_TOOLCHAIN_PREFIX i386-apple-darwin11-)

IF(NOT CMAKE_IOS_SDK_ROOT)
  execute_process(COMMAND xcrun --show-sdk-path --sdk iphonesimulator
   OUTPUT_VARIABLE CMAKE_IOS_SDK_ROOT
   ERROR_QUIET
   OUTPUT_STRIP_TRAILING_WHITESPACE)
  message(STATUS "Using xcode root ${CMAKE_IOS_SDK_ROOT}")
ENDIF()

# Set the sysroot default to the most recent SDK
set(CMAKE_OSX_SYSROOT ${CMAKE_IOS_SDK_ROOT} CACHE PATH "Sysroot used for iOS Simulator support")

# set the architecture for iOS
# set(IOS_ARCH i386)
# set(IOS_ARCH x86_64)
set(IOS_ARCH i386;x86_64)

set(CMAKE_OSX_ARCHITECTURES ${IOS_ARCH} CACHE string "Build architecture for iOS Simulator")

# Set the find root to the iOS developer roots and to user defined paths
set(CMAKE_FIND_ROOT_PATH ${CMAKE_IOS_DEVELOPER_ROOT} ${CMAKE_IOS_SDK_ROOT} ${CMAKE_PREFIX_PATH} CACHE string "iOS Simulator find search path root")

# searching for frameworks only
set(CMAKE_FIND_FRAMEWORK FIRST)

# set up the default search directories for frameworks
set(CMAKE_SYSTEM_FRAMEWORK_PATH
    ${CMAKE_IOS_SDK_ROOT}/System/Library/Frameworks
)
