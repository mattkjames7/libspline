cmake_minimum_required(3.10)
project(
    spline
    VERSION 0.3.0
    DESCRIPTION "A C++ library for spline interpolation"
    LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

option(BUILD_TESTING "Build the testing tree." OFF)
option(BUILD_SHARED_LIBS "Build shared library" ON)
option(BUILD_STATIC_LIBS "Build static library" OFF)

if (not BUILD_SHARED_LIBS AND not BUILD_STATIC_LIBS)
    message(FATAL_ERROR "At least one of BUILD_SHARED_LIBS or BUILD_STATIC_LIBS must be ON")
endif()

if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type" FORCE)
endif()

set(CMAKE_CXX_FLAGS_RELEASE "-g -O3 -Wall -Wextra")
set(CMAKE_CXX_FLAGS_DEBUG "-g -O0 -Wall -Wextra -DDEBUG")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")

add_subdirectory(src)

if (BUILD_TESTING)
    enable_testing()
    add_subdirectory(tests)
endif()

