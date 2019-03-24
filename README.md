# libass-cmake

CMake auto compile setup for [libass](https://github.com/libass/libass).

Configured for (at the time this repo is set up):

- libass: 0.14.0
- fribidi: 1.0.5
- freetype: 2.10.0
- harfbuzz: 2.3.1

For an old version MSVC solution see [libass-msvc](https://github.com/libass/libass-msvc).

Files in `src/compat` and some config headers are taken from libass-msvc, with necessary modifications.

The CMake scripts are written for MSVC. They may also work for other build toolchains, but I haven't tested that.

## Usage

Requirements:

- CMake (>= 3.13)
- NASM (some recent version)

```bash
# Create and enter a build directory
mkdir build
cd build

# Generate build files
cmake -G "Visual Studio 15 2017 Win64" ..

# Fix the source files; see "Extra Steps"

# Build!
cmake --build . --target ass --
```

Built binary (DLL) is located at `build/cmake/bin`.

## Extra Steps

Because of a [known issue](https://github.com/libass/libass/issues/338#issuecomment-475937623)
(`const int` array length) in libass 0.14.0, you have to manually edit some source files
to successfully compile in MSVC.

**In `ass_outline.c`:**

Search for `double mul[max_subdiv + 1]`. For each hit change `max_subdiv`
to the constant assigned above.

**In `ass_render.c`:**

Search for `ASS_Outline outline[n_outlines]`. Change `n_outlines` to the constant assigned above.

## License

ISC
