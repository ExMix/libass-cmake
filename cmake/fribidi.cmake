cmake_minimum_required(VERSION 3.2)

include(fribidi-gen.cmake)

set(FRIBIDI_SOURCE
        ../src/fribidi/lib/fribidi-arabic.c
        ../src/fribidi/lib/fribidi-bidi-types.c
        ../src/fribidi/lib/fribidi-bidi.c
        ../src/fribidi/lib/fribidi-brackets.c
        ../src/fribidi/lib/fribidi-deprecated.c
        ../src/fribidi/lib/fribidi-joining-types.c
        ../src/fribidi/lib/fribidi-joining.c
        ../src/fribidi/lib/fribidi-mirroring.c
        ../src/fribidi/lib/fribidi-run.c
        ../src/fribidi/lib/fribidi-shape.c
        ../src/fribidi/lib/fribidi.c
        )

add_library(fribidi STATIC ${FRIBIDI_SOURCE})

target_include_directories(fribidi SYSTEM
        PUBLIC ../src/fribidi/lib
        PUBLIC ../src/fribidi-config)

target_compile_definitions(fribidi PUBLIC HAVE_CONFIG_H)

add_dependencies(fribidi
        gen_unicode_version_run
        gen_arabic_shaping_tab_run
        gen_bidi_type_tab_run
        gen_joining_type_tab_run
        gen_mirroring_tab_run
        gen_brackets_tab_run
        gen_brackets_type_tab_run
        )
