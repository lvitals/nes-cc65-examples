NES CC65 Examples

This project contains example NES programs written in C using the cc65 toolchain.

Project Structure

- cfg/       : NES mapper configuration files
- examples/  : Example NES C source files and local Makefile
- include/   : Header files used by examples
- lib/       : Assembly source files and NES libraries
- src/       : Main source code folder for custom programs
- Makefile   : Main project build script

Requirements

- cc65 toolchain (https://cc65.github.io/)
- A NES emulator, e.g. Mednafen (https://mednafen.github.io/)
- GNU Make

Building

To build all examples, run:

make

This will build the NES ROMs and place them in the build/ folder.

Running

To run all generated ROMs using the default emulator (mednafen), run:

make run

You can override the emulator by setting the EMULATOR environment variable:

make run EMULATOR=your_emulator

Cleaning

To clean all generated files:

make clean

To clean the cc65 toolchain build (if applicable):

make clean-cc65

Notes

- The project uses .cfg files to configure NES mapper settings.
- Assembly libraries and crt0 startup code are located in the lib/ folder.
- Source code for examples is in the examples/ folder.
- The main build output will be in the build/ directory.
- Make sure the cc65 submodule is initialized if using it as a submodule.

