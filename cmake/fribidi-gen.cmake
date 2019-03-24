cmake_minimum_required(VERSION 3.2)

# Beware:
# This file runs in build/$build_cfg$/cmake directory, where $build_cfg$ is optional.

add_executable(gen_unicode_version ../src/fribidi/gen.tab/gen-unicode-version.c)
add_executable(gen_arabic_shaping_tab ../src/fribidi/gen.tab/gen-arabic-shaping-tab.c)
add_executable(gen_bidi_type_tab ../src/fribidi/gen.tab/gen-bidi-type-tab.c ../src/fribidi/gen.tab/packtab.c ../src/fribidi/gen.tab/packtab.h)
add_executable(gen_joining_type_tab ../src/fribidi/gen.tab/gen-joining-type-tab.c ../src/fribidi/gen.tab/packtab.c ../src/fribidi/gen.tab/packtab.h)
add_executable(gen_mirroring_tab ../src/fribidi/gen.tab/gen-mirroring-tab.c ../src/fribidi/gen.tab/packtab.c ../src/fribidi/gen.tab/packtab.h)
add_executable(gen_brackets_tab ../src/fribidi/gen.tab/gen-brackets-tab.c ../src/fribidi/gen.tab/packtab.c ../src/fribidi/gen.tab/packtab.h)
add_executable(gen_brackets_type_tab ../src/fribidi/gen.tab/gen-brackets-type-tab.c ../src/fribidi/gen.tab/packtab.c ../src/fribidi/gen.tab/packtab.h)

set(COMPRESSION 2)

target_include_directories(gen_unicode_version
        PUBLIC ../src/fribidi/lib
        PUBLIC ../src/fribidi-config)

target_include_directories(gen_arabic_shaping_tab
        PUBLIC ../src/fribidi/lib
        PUBLIC ../src/fribidi-config)

target_include_directories(gen_bidi_type_tab
        PUBLIC ../src/fribidi/lib
        PUBLIC ../src/fribidi-config)

target_include_directories(gen_joining_type_tab
        PUBLIC ../src/fribidi/lib
        PUBLIC ../src/fribidi-config)

target_include_directories(gen_mirroring_tab
        PUBLIC ../src/fribidi/lib
        PUBLIC ../src/fribidi-config)

target_include_directories(gen_brackets_tab
        PUBLIC ../src/fribidi/lib
        PUBLIC ../src/fribidi-config)

target_include_directories(gen_brackets_type_tab
        PUBLIC ../src/fribidi/lib
        PUBLIC ../src/fribidi-config)

target_compile_definitions(gen_unicode_version PUBLIC HAVE_CONFIG_H)
target_compile_definitions(gen_arabic_shaping_tab PUBLIC HAVE_CONFIG_H)
target_compile_definitions(gen_bidi_type_tab PUBLIC HAVE_CONFIG_H)
target_compile_definitions(gen_joining_type_tab PUBLIC HAVE_CONFIG_H)
target_compile_definitions(gen_mirroring_tab PUBLIC HAVE_CONFIG_H)
target_compile_definitions(gen_brackets_tab PUBLIC HAVE_CONFIG_H)
target_compile_definitions(gen_brackets_type_tab PUBLIC HAVE_CONFIG_H)

# https://stackoverflow.com/a/25439296
add_custom_target(gen_unicode_version_run
        COMMAND gen_unicode_version unidata/ReadMe.txt unidata/BidiMirroring.txt > ${PROJECT_SOURCE_DIR}/src/fribidi/lib/fribidi-unicode-version.h
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/src/fribidi/gen.tab)

add_custom_target(gen_arabic_shaping_tab_run
        COMMAND gen_arabic_shaping_tab ${COMPRESSION} unidata/UnicodeData.txt unidata/ArabicShaping.txt ${PROJECT_SOURCE_DIR}/src/fribidi/lib/fribidi-unicode-version.h > ${PROJECT_SOURCE_DIR}/src/fribidi/lib/arabic-shaping.tab.i
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/src/fribidi/gen.tab)

add_custom_target(gen_bidi_type_tab_run
        COMMAND gen_bidi_type_tab ${COMPRESSION} unidata/UnicodeData.txt ${PROJECT_SOURCE_DIR}/src/fribidi/lib/fribidi-unicode-version.h > ${PROJECT_SOURCE_DIR}/src/fribidi/lib/bidi-type.tab.i
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/src/fribidi/gen.tab)

add_custom_target(gen_joining_type_tab_run
        COMMAND gen_joining_type_tab ${COMPRESSION} unidata/UnicodeData.txt unidata/ArabicShaping.txt ${PROJECT_SOURCE_DIR}/src/fribidi/lib/fribidi-unicode-version.h > ${PROJECT_SOURCE_DIR}/src/fribidi/lib/joining-type.tab.i
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/src/fribidi/gen.tab)

add_custom_target(gen_mirroring_tab_run
        COMMAND gen_mirroring_tab ${COMPRESSION} unidata/BidiMirroring.txt ${PROJECT_SOURCE_DIR}/src/fribidi/lib/fribidi-unicode-version.h > ${PROJECT_SOURCE_DIR}/src/fribidi/lib/mirroring.tab.i
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/src/fribidi/gen.tab)

add_custom_target(gen_brackets_tab_run
        COMMAND gen_brackets_tab ${COMPRESSION} unidata/BidiBrackets.txt unidata/UnicodeData.txt ${PROJECT_SOURCE_DIR}/src/fribidi/lib/fribidi-unicode-version.h > ${PROJECT_SOURCE_DIR}/src/fribidi/lib/brackets.tab.i
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/src/fribidi/gen.tab)

add_custom_target(gen_brackets_type_tab_run
        COMMAND gen_brackets_type_tab ${COMPRESSION} unidata/BidiBrackets.txt unidata/UnicodeData.txt ${PROJECT_SOURCE_DIR}/src/fribidi/lib/fribidi-unicode-version.h > ${PROJECT_SOURCE_DIR}/src/fribidi/lib/brackets-type.tab.i
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/src/fribidi/gen.tab)

add_dependencies(gen_unicode_version_run gen_unicode_version)
add_dependencies(gen_arabic_shaping_tab_run gen_arabic_shaping_tab)
add_dependencies(gen_bidi_type_tab_run gen_bidi_type_tab)
add_dependencies(gen_joining_type_tab_run gen_joining_type_tab)
add_dependencies(gen_mirroring_tab_run gen_mirroring_tab)
add_dependencies(gen_brackets_tab_run gen_brackets_tab)
add_dependencies(gen_brackets_type_tab_run gen_brackets_type_tab)
