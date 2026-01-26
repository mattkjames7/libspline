
if (BUILD_SHARED_LIBS)
    add_library(libspline SHARED)
    add_library(spline::spline ALIAS libspline)
    set_target_properties(libspline PROPERTIES OUTPUT_NAME spline)
    set_target_properties(libspline PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
    target_sources(libspline PRIVATE
        libspline.cc
        spline.cc
    )
    install(TARGETS libspline
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
    )
else()
    add_library(libspline STATIC)
    add_library(spline::spline ALIAS libspline)
    set_target_properties(libspline PROPERTIES OUTPUT_NAME spline)
    set_target_properties(libspline PROPERTIES ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
    target_sources(libspline PRIVATE
        libspline.cc
        spline.cc
    )
    install(TARGETS libspline
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
    )
endif()
    
    
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/../include/spline.h DESTINATION include)