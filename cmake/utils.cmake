function(ani_utils_print_list)
    cmake_parse_arguments(PARSE_ARGV 0 ARG "" "PREFIX" "")
    foreach(item ${ARG_UNPARSED_ARGUMENTS})
        message("${ARG_PREFIX}${item}")
    endforeach()
endfunction()

function(ani_init)
	set(ANI_PLATFORMS
        "win32"
        "macos_x86"
        "macos_arm"
        "ios"
        "android"
        "linux"
        CACHE INTERNAL "")

	set(ANI_TARGET_PLATFORM "" CACHE STRING "")
    set_property(CACHE ANI_TARGET_PLATFORM PROPERTY STRINGS ${ANI_PLATFORMS})

    if(NOT ANI_TARGET_PLATFORM IN_LIST ANI_PLATFORMS)
        message("Please, run cmake with the following param:")
        message("  cmake -DANI_TARGET_PLATFORM=<platform> ...")
        message("Allowed platforms are:")
        ani_utils_print_list(${ANI_PLATFORMS} PREFIX "  - ")
        message(FATAL_ERROR "Incompleate environment")
    else()
    	if("${ANI_TARGET_PLATFORM}" STREQUAL "macos_arm")
    		set(CMAKE_OSX_ARCHITECTURES "arm64" PARENT_SCOPE)
    	elseif("${ANI_TARGET_PLATFORM}" STREQUAL "macos_x86")
    		set(CMAKE_OSX_ARCHITECTURES "x86_64" PARENT_SCOPE)
    	elseif("${ANI_TARGET_PLATFORM}" STREQUAL "win32")
    	elseif("${ANI_TARGET_PLATFORM}" STREQUAL "ios")
    	endif()
	endif()
endfunction()