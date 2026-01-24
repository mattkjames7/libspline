
if (BUILD_SHARED_LIBS)
    add_library(libspline_shared SHARED)
    set_target_properties(libspline_shared PROPERTIES OUTPUT_NAME spline)
    target_sources(libspline_shared PRIVATE
        libspline.cc
        spline.cc
    )
    install(TARGETS libspline_shared
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
    )
endif()
    
if (BUILD_STATIC_LIBS)  
    add_library(libspline_static STATIC)
    set_target_properties(libspline_static PROPERTIES OUTPUT_NAME spline)
    target_sources(libspline_static PRIVATE
        libspline.cc
        spline.cc
    )
    install(TARGETS libspline_static
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
    )
endif()
    
    
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/../include/spline.h DESTINATION include)