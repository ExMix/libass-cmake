cmake_minimum_required(VERSION 3.2)

set(HARFBUZZ_SOURCE
        ../src/harfbuzz/src/hb-aat-layout.cc
        ../src/harfbuzz/src/hb-aat-map.cc
        ../src/harfbuzz/src/hb-blob.cc
        ../src/harfbuzz/src/hb-buffer.cc
        ../src/harfbuzz/src/hb-common.cc
        ../src/harfbuzz/src/hb-face.cc
        ../src/harfbuzz/src/hb-static.cc
        ../src/harfbuzz/src/hb-fallback-shape.cc
        ../src/harfbuzz/src/hb-font.cc
        ../src/harfbuzz/src/hb-ft.cc
        ../src/harfbuzz/src/hb-ot-cff1-table.cc
        ../src/harfbuzz/src/hb-ot-cff2-table.cc
        ../src/harfbuzz/src/hb-ot-face.cc
        ../src/harfbuzz/src/hb-ot-font.cc
        ../src/harfbuzz/src/hb-ot-layout.cc
        ../src/harfbuzz/src/hb-ot-map.cc
        ../src/harfbuzz/src/hb-ot-shape-complex-arabic.cc
        ../src/harfbuzz/src/hb-ot-shape-complex-default.cc
        ../src/harfbuzz/src/hb-ot-shape-complex-hangul.cc
        ../src/harfbuzz/src/hb-ot-shape-complex-hebrew.cc
        ../src/harfbuzz/src/hb-ot-shape-complex-indic-table.cc
        ../src/harfbuzz/src/hb-ot-shape-complex-indic.cc
        ../src/harfbuzz/src/hb-ot-shape-complex-khmer.cc
        ../src/harfbuzz/src/hb-ot-shape-complex-myanmar.cc
        ../src/harfbuzz/src/hb-ot-shape-complex-thai.cc
        ../src/harfbuzz/src/hb-ot-shape-complex-use-table.cc
        ../src/harfbuzz/src/hb-ot-shape-complex-use.cc
        ../src/harfbuzz/src/hb-ot-shape-complex-vowel-constraints.cc
        ../src/harfbuzz/src/hb-ot-shape-fallback.cc
        ../src/harfbuzz/src/hb-ot-shape-normalize.cc
        ../src/harfbuzz/src/hb-ot-shape.cc
        ../src/harfbuzz/src/hb-ot-tag.cc
        ../src/harfbuzz/src/hb-ot-var.cc
        ../src/harfbuzz/src/hb-set.cc
        ../src/harfbuzz/src/hb-shape-plan.cc
        ../src/harfbuzz/src/hb-shape.cc
        ../src/harfbuzz/src/hb-shaper.cc
        ../src/harfbuzz/src/hb-ucdn.cc
        ../src/harfbuzz/src/hb-unicode.cc
        ../src/harfbuzz/src/hb-warning.cc
        ../src/harfbuzz/src/hb-ucdn/ucdn.c
        )

add_library(harfbuzz STATIC ${HARFBUZZ_SOURCE})

target_include_directories(harfbuzz SYSTEM
        PUBLIC ../src/freetype2/include
        PUBLIC ../src/harfbuzz/src/hb-ucdn)

target_compile_definitions(harfbuzz
        PUBLIC _CRT_SECURE_NO_WARNINGS
        PUBLIC _CRT_NONSTDC_NO_DEPRECATE
        PUBLIC HAVE_OT
        PUBLIC HAVE_UCDN)
