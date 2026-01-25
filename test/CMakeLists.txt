
include(FetchContent)
FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/releases/download/v1.17.0/googletest-1.17.0.tar.gz
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
)

# Prevent GoogleTest from being installed
set(INSTALL_GTEST OFF CACHE BOOL "Disable installation of GoogleTest" FORCE)
set(BUILD_GMOCK OFF CACHE BOOL "Disable GoogleMock" FORCE)


set(_OLD_BSL "${BUILD_SHARED_LIBS}")
set(BUILD_SHARED_LIBS OFF CACHE BOOL "" FORCE)

FetchContent_MakeAvailable(googletest)

# Restore parent setting
set(BUILD_SHARED_LIBS "${_OLD_BSL}" CACHE BOOL "" FORCE)

link_directories(${CMAKE_SOURCE_DIR}/lib)

add_executable(test_spline test.cc)


# Determine which datetime library to link against
set(SPLINE_LIB_TARGET "")
if(WIN32)
    set(SPLINE_LIB_TARGET libspline_shared)
elseif(TARGET libspline_shared)
    set(SPLINE_LIB_TARGET libspline_shared)
elseif(TARGET libspline_static)
    set(SPLINE_LIB_TARGET libspline_static)
else()
    message(FATAL_ERROR "No spline library target found")
endif()

target_link_libraries(test_spline
    gtest_main
    ${SPLINE_LIB_TARGET}
    m
)

# Include headers
target_include_directories(test_spline PRIVATE ${CMAKE_SOURCE_DIR}/include)

# So test executable can find the shared lib at runtime (only needed for shared libs)
if(BUILD_SHARED_LIBS)
    set_target_properties(test_spline PROPERTIES
        BUILD_RPATH ${CMAKE_SOURCE_DIR}/lib
        INSTALL_RPATH ${CMAKE_SOURCE_DIR}/lib
    )
endif()

include(GoogleTest)
gtest_discover_tests(test_spline)

# On Windows the test executable won't find DLLs located in other directories
# (RPATH doesn't apply). If we built shared libs, copy the spline DLL
# next to the test executable so it can be loaded at runtime in CI.
if(BUILD_SHARED_LIBS AND WIN32)
    # Copy the spline DLL to the test exe dir
    add_custom_command(TARGET test_spline POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
            $<TARGET_FILE:libspline_shared>
            $<TARGET_FILE_DIR:test_spline>
    )
    # Copy GoogleTest DLLs to the test exe dir (they're in bin/)
    add_custom_command(TARGET test_spline POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
            $<TARGET_FILE:gtest>
            $<TARGET_FILE_DIR:test_spline>
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
            $<TARGET_FILE:gtest_main>
            $<TARGET_FILE_DIR:test_spline>
    )
endif()