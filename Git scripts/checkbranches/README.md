# Purpose

This is a script I've built while working on a multi-repo project. <br>
Since that meant constantly checking out branches and updating them for
collaboration, I got tired of doing it manually and came up with this.

The main skeleton, which is what you see here, can be easily modified for your
own project or configuration. <br>
This features:
- `colormake` support
- Short and long options passed from terminal
- Different `make` options (force develop, clean all, ...)
- Compilation for x86 and ARMv7 (or whatever dual-environment you may need)

# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 2.0.1

### Added

- Support for dual-environment compiling (x86/ARMv7)
- 'Clean all' make option
- Argument option to force 'develop' branches

### Changed

- Various git actions are now silent

## 2.0.0

### Changed

- Re-structured script file to allow more options and actions
- Some prints are now shown only in debug mode

### Added

- Debug mode
- Support for input arguments
- Support for `colormake`
- Handle of different repos (with default list or from terminal arguments)

## 1.0.0

### Added

- First script version with only the main operations
