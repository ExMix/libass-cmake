cmake_minimum_required(VERSION 3.13)

find_package(Nasm MODULE)

# https://metricpanda.com/using-nasm-with-cmake-and-clang
enable_language(ASM_NASM)

set(ASS_SOURCE
        ../src/libass/libass/ass_bitmap_engine.c
        ../src/libass/libass/ass_bitmap.c
        ../src/libass/libass/ass_blur.c
        ../src/libass/libass/ass_cache.c
        ../src/libass/libass/ass_coretext.c
        ../src/libass/libass/ass_drawing.c
        ../src/libass/libass/ass_filesystem.c
        ../src/libass/libass/ass_font.c
        ../src/libass/libass/ass_fontselect.c
        ../src/libass/libass/ass_library.c
        ../src/libass/libass/ass_outline.c
        ../src/libass/libass/ass_parse.c
        ../src/libass/libass/ass_rasterizer.c
        ../src/libass/libass/ass_render_api.c
        ../src/libass/libass/ass_render.c
        ../src/libass/libass/ass_shaper.c
        ../src/libass/libass/ass_string.c
        ../src/libass/libass/ass_strtod.c
        ../src/libass/libass/ass_utils.c
        ../src/libass/libass/ass.c
        )

if("${ANI_TARGET_PLATFORM}" STREQUAL "macos_arm")
    list(APPEND ASS_SOURCE ../src/libass/libass/c/c_be_blur.c)
    list(APPEND ASS_SOURCE ../src/libass/libass/c/c_blend_bitmaps.c)
    list(APPEND ASS_SOURCE ../src/libass/libass/c/c_blur.c)
    list(APPEND ASS_SOURCE ../src/libass/libass/c/c_rasterizer.c)
elseif("${ANI_TARGET_PLATFORM}" STREQUAL "macos_x86")
    list(APPEND ASS_SOURCE ../src/libass/libass/c/c_be_blur.c)
    list(APPEND ASS_SOURCE ../src/libass/libass/c/c_blend_bitmaps.c)
    list(APPEND ASS_SOURCE ../src/libass/libass/c/c_blur.c)
    list(APPEND ASS_SOURCE ../src/libass/libass/c/c_rasterizer.c)
    
    set(ASS_ASM_SOURCE
            ../src/libass/libass/x86/cpuid.asm
            ../src/libass/libass/x86/rasterizer.asm
            ../src/libass/libass/x86/blend_bitmaps.asm
            ../src/libass/libass/x86/blur.asm
            )

    list(APPEND ASS_SOURCE ${ASS_ASM_SOURCE})

    if (NOT ("${CMAKE_SIZEOF_VOID_P}" STREQUAL "4"))
        list(APPEND ASS_SOURCE ../src/libass/libass/x86/be_blur.asm)
    endif ()

    set_source_files_properties(${ASS_ASM_SOURCE} PROPERTIES LANGUAGE ASM_NASM)
    set(CMAKE_ASM_NASM_OBJECT_FORMAT macho64)
    set(CMAKE_ASM_NASM_SOURCE_FILE_EXTENSIONS nasm asm)
elseif("${ANI_TARGET_PLATFORM}" STREQUAL "win32")
    list(APPEND ASS_SOURCE ../src/libass/libass/x86/cpuid.asm)
    list(APPEND ASS_SOURCE ../src/libass/libass/x86/rasterizer.asm)
    list(APPEND ASS_SOURCE ../src/libass/libass/x86/blend_bitmaps.asm)
    list(APPEND ASS_SOURCE ../src/libass/libass/x86/blur.asm)

    if (NOT ("${CMAKE_SIZEOF_VOID_P}" STREQUAL "4"))
        list(APPEND ASS_SOURCE ../src/libass/libass/x86/be_blur.asm)
    endif ()

    list(APPEND ASS_SOURCE ../src/libass/libass/ass_directwrite.c)
    list(APPEND ASS_SOURCE ../src/compat/dirent.c)

    target_include_directories(ass SYSTEM PUBLIC ../src/compat)
endif()

if (${MSVC})
    set(ASS_LINK_DEF_FILE_FLAG "${CMAKE_SOURCE_DIR}/src/libass-config/libass.def")
elseif ("${CMAKE_COMPILER_IS_GNUC}" OR "${CMAKE_COMPILER_IS_GNUCC}" OR "${CMAKE_COMPILER_IS_GNUCXX}")
    set(ASS_LINK_DEF_FILE_FLAG "${CMAKE_SOURCE_DIR}/src/libass/libass/libass.sym")
endif ()

if (ASS_LINK_DEF_FILE_FLAG)
    list(APPEND ASS_SOURCE ${ASS_LINK_DEF_FILE_FLAG})
endif ()

add_library(ass SHARED ${ASS_SOURCE})

if("${ANI_TARGET_PLATFORM}" STREQUAL "macos_arm")
    target_link_libraries("ass" "-framework CoreFoundation"
                                "-framework CoreText")
elseif("${ANI_TARGET_PLATFORM}" STREQUAL "macos_x86")
    target_link_libraries("ass" "-framework CoreFoundation"
                                "-framework CoreText")
elseif("${ANI_TARGET_PLATFORM}" STREQUAL "win32")
endif()

target_include_directories(ass SYSTEM
        PUBLIC ../src/libass/libass
        PUBLIC ../src/libass-config
        PUBLIC ../src/harfbuzz/src
        PUBLIC ../src/fribidi/lib
        PUBLIC ../src/freetype2/include)

target_link_directories(ass PUBLIC ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
target_link_libraries(ass freetype2 harfbuzz fribidi)

if (ASS_LINK_DEF_FILE_FLAG)
    set_target_properties(ass
            PROPERTIES
            LINK_DEF_FILE_FLAG ${ASS_LINK_DEF_FILE_FLAG})
endif ()

if (CMAKE_ASM_NASM_COMPILER_LOADED)
    set(INTEL 1)

    if ("${CMAKE_SIZEOF_VOID_P}" STREQUAL "4")
        set(BITS 32)
        set(BITTYPE 32)
        set(ASM_FLAGS "-DARCH_X86_64=0")
    else ()
        set(BITS 64)
        set(BITTYPE 64)
        set(ASM_FLAGS "-DARCH_X86_64=1 -DPIC")
    endif ()

    if (${APPLE})
        set(ASM_FLAGS "${ASM_FLAGS} -f macho${BITTYPE} -DPREFIX -DHAVE_ALIGNED_STACK=1")
    elseif (${UNIX})
        set(ASM_FLAGS "${ASM_FLAGS} -f elf${BITTYPE} -DHAVE_ALIGNED_STACK=1")
    elseif (${WIN32})
        set(ASM_FLAGS "${ASM_FLAGS} -f win${BITTYPE}")

        if ("${BITS}" STREQUAL "64")
            set(ASM_FLAGS "${ASM_FLAGS} -DHAVE_ALIGNED_STACK=1")
        else ()
            set(ASM_FLAGS "${ASM_FLAGS} -DHAVE_ALIGNED_STACK=0 -DPREFIX")
        endif ()
    else ()
        message(FATAL_ERROR "OS not supported")
    endif ()

    set(ASM_FLAGS "${ASM_FLAGS} -DHAVE_CPUNOP=0 -Dprivate_prefix=ass")
else ()
    message(FATAL_ERROR "Failed to enable NASM")
endif ()

if (${APPLE})
    target_compile_definitions(ass PUBLIC ASS_MACOS)
elseif (${WIN32})
    target_compile_definitions(ass PUBLIC ASS_WIN32)
endif()

set(CMAKE_ASM_NASM_FLAGS ${ASM_FLAGS})

if (${APPLY_PATCH})
    if (${APPLE})
        execute_process(COMMAND git apply "${CMAKE_CURRENT_LIST_DIR}/patches/harfbuzz.mac.patch" "--ignore-whitespace" "-v"
            WORKING_DIRECTORY "${CMAKE_CURRENT_LIST_DIR}/../src/harfbuzz" RESULT_VARIABLE git_result)
    endif()
endif()
