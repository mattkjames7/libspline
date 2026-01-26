cmake_minimum_required(VERSION 3.10)
project(
    spline
    VERSION 0.3.0
    DESCRIPTION "A C++ library for spline interpolation"
    LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

option(BUILD_TESTING "Build the testing tree." ON)
option(BUILD_SHARED_LIBS "Build shared library" ON)

if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type" FORCE)
endif()

set(CMAKE_CXX_FLAGS_RELEASE "-g -O3 -Wall -Wextra")
set(CMAKE_CXX_FLAGS_DEBUG "-g -O0 -Wall -Wextra -DDEBUG")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")

add_subdirectory(src)

if (BUILD_TESTING)
    enable_testing()
    add_subdirectory(test)
endif()

