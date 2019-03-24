cmake_minimum_required(VERSION 3.2)

find_program(NASM_PATH
        nasm NAMES nasm.exe nasm)

if (NASM_PATH)
    message("Found NASM at ${NASM_PATH}")
else ()
    message(FATAL_ERROR "Cannot find NASM")
endif ()
