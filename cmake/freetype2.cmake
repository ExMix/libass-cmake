cmake_minimum_required(VERSION 3.2)

set(FREETYPE2_SOURCE
        ../src/freetype2/src/autofit/autofit.c
        ../src/freetype2/src/base/ftbase.c
        ../src/freetype2/src/base/ftbbox.c
        ../src/freetype2/src/base/ftbitmap.c
        ../src/freetype2/src/base/ftdebug.c
        ../src/freetype2/src/base/ftfntfmt.c
        ../src/freetype2/src/base/ftfstype.c
        ../src/freetype2/src/base/ftgasp.c
        ../src/freetype2/src/base/ftglyph.c
        ../src/freetype2/src/base/ftgxval.c
        ../src/freetype2/src/base/ftinit.c
        ../src/freetype2/src/base/ftlcdfil.c
        ../src/freetype2/src/base/ftmm.c
        ../src/freetype2/src/base/ftotval.c
        ../src/freetype2/src/base/ftpatent.c
        ../src/freetype2/src/base/ftpfr.c
        ../src/freetype2/src/base/ftstroke.c
        ../src/freetype2/src/base/ftsynth.c
        ../src/freetype2/src/base/ftsystem.c
        ../src/freetype2/src/base/fttype1.c
        ../src/freetype2/src/base/ftwinfnt.c
        ../src/freetype2/src/bdf/bdf.c
        ../src/freetype2/src/cache/ftcache.c
        ../src/freetype2/src/cff/cff.c
        ../src/freetype2/src/cid/type1cid.c
        ../src/freetype2/src/gzip/ftgzip.c
        ../src/freetype2/src/lzw/ftlzw.c
        ../src/freetype2/src/pcf/pcf.c
        ../src/freetype2/src/pfr/pfr.c
        ../src/freetype2/src/psaux/psaux.c
        ../src/freetype2/src/pshinter/pshinter.c
        ../src/freetype2/src/psnames/psmodule.c
        ../src/freetype2/src/raster/raster.c
        ../src/freetype2/src/sfnt/sfnt.c
        ../src/freetype2/src/smooth/smooth.c
        ../src/freetype2/src/truetype/truetype.c
        ../src/freetype2/src/type1/type1.c
        ../src/freetype2/src/type42/type42.c
        ../src/freetype2/src/winfonts/winfnt.c
        )

add_library(freetype2 STATIC ${FREETYPE2_SOURCE})

target_include_directories(freetype2 SYSTEM
        PUBLIC ../src/freetype2/include
        PUBLIC ../src/harfbuzz/src)

target_compile_definitions(freetype2
        PUBLIC FT_DEBUG_LEVEL_ERROR # debug
        PUBLIC FT_DEBUG_LEVEL_TRACE # debug
        PUBLIC _CRT_SECURE_NO_WARNINGS
        PUBLIC FT2_BUILD_LIBRARY)
