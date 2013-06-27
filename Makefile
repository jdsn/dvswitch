# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

# Default target executed when no arguments are given to make.
default_target: all
.PHONY : default_target

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The program to use to edit the cache.
CMAKE_EDIT_COMMAND = /usr/bin/ccmake

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/jw/github/dvswitch

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/jw/github/dvswitch

#=============================================================================
# Targets provided globally by CMake.

# Special rule for the target edit_cache
edit_cache:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Running CMake cache editor..."
	/usr/bin/ccmake -H$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR)
.PHONY : edit_cache

# Special rule for the target edit_cache
edit_cache/fast: edit_cache
.PHONY : edit_cache/fast

# Special rule for the target install
install: preinstall
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Install the project..."
	/usr/bin/cmake -P cmake_install.cmake
.PHONY : install

# Special rule for the target install
install/fast: preinstall/fast
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Install the project..."
	/usr/bin/cmake -P cmake_install.cmake
.PHONY : install/fast

# Special rule for the target install/local
install/local: preinstall
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Installing only the local directory..."
	/usr/bin/cmake -DCMAKE_INSTALL_LOCAL_ONLY=1 -P cmake_install.cmake
.PHONY : install/local

# Special rule for the target install/local
install/local/fast: install/local
.PHONY : install/local/fast

# Special rule for the target list_install_components
list_install_components:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Available install components are: \"Unspecified\""
.PHONY : list_install_components

# Special rule for the target list_install_components
list_install_components/fast: list_install_components
.PHONY : list_install_components/fast

# Special rule for the target rebuild_cache
rebuild_cache:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Running CMake to regenerate build system..."
	/usr/bin/cmake -H$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR)
.PHONY : rebuild_cache

# Special rule for the target rebuild_cache
rebuild_cache/fast: rebuild_cache
.PHONY : rebuild_cache/fast

# The main all target
all: cmake_check_build_system
	$(CMAKE_COMMAND) -E cmake_progress_start /home/jw/github/dvswitch/CMakeFiles /home/jw/github/dvswitch/CMakeFiles/progress.marks
	$(MAKE) -f CMakeFiles/Makefile2 all
	$(CMAKE_COMMAND) -E cmake_progress_start /home/jw/github/dvswitch/CMakeFiles 0
.PHONY : all

# The main clean target
clean:
	$(MAKE) -f CMakeFiles/Makefile2 clean
.PHONY : clean

# The main clean target
clean/fast: clean
.PHONY : clean/fast

# Prepare targets for installation.
preinstall: all
	$(MAKE) -f CMakeFiles/Makefile2 preinstall
.PHONY : preinstall

# Prepare targets for installation.
preinstall/fast:
	$(MAKE) -f CMakeFiles/Makefile2 preinstall
.PHONY : preinstall/fast

# clear depends
depend:
	$(CMAKE_COMMAND) -H$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR) --check-build-system CMakeFiles/Makefile.cmake 1
.PHONY : depend

#=============================================================================
# Target rules for targets named dvsink-command

# Build rule for target.
dvsink-command: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 dvsink-command
.PHONY : dvsink-command

# fast build rule for target.
dvsink-command/fast:
	$(MAKE) -f src/CMakeFiles/dvsink-command.dir/build.make src/CMakeFiles/dvsink-command.dir/build
.PHONY : dvsink-command/fast

#=============================================================================
# Target rules for targets named dvsink-files

# Build rule for target.
dvsink-files: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 dvsink-files
.PHONY : dvsink-files

# fast build rule for target.
dvsink-files/fast:
	$(MAKE) -f src/CMakeFiles/dvsink-files.dir/build.make src/CMakeFiles/dvsink-files.dir/build
.PHONY : dvsink-files/fast

#=============================================================================
# Target rules for targets named dvsource-alsa

# Build rule for target.
dvsource-alsa: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 dvsource-alsa
.PHONY : dvsource-alsa

# fast build rule for target.
dvsource-alsa/fast:
	$(MAKE) -f src/CMakeFiles/dvsource-alsa.dir/build.make src/CMakeFiles/dvsource-alsa.dir/build
.PHONY : dvsource-alsa/fast

# Manual pre-install relink rule for target.
dvsource-alsa/preinstall:
	$(MAKE) -f src/CMakeFiles/dvsource-alsa.dir/build.make src/CMakeFiles/dvsource-alsa.dir/preinstall
.PHONY : dvsource-alsa/preinstall

#=============================================================================
# Target rules for targets named dvsource-dvgrab

# Build rule for target.
dvsource-dvgrab: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 dvsource-dvgrab
.PHONY : dvsource-dvgrab

# fast build rule for target.
dvsource-dvgrab/fast:
	$(MAKE) -f src/CMakeFiles/dvsource-dvgrab.dir/build.make src/CMakeFiles/dvsource-dvgrab.dir/build
.PHONY : dvsource-dvgrab/fast

#=============================================================================
# Target rules for targets named dvsource-file

# Build rule for target.
dvsource-file: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 dvsource-file
.PHONY : dvsource-file

# fast build rule for target.
dvsource-file/fast:
	$(MAKE) -f src/CMakeFiles/dvsource-file.dir/build.make src/CMakeFiles/dvsource-file.dir/build
.PHONY : dvsource-file/fast

# Manual pre-install relink rule for target.
dvsource-file/preinstall:
	$(MAKE) -f src/CMakeFiles/dvsource-file.dir/build.make src/CMakeFiles/dvsource-file.dir/preinstall
.PHONY : dvsource-file/preinstall

#=============================================================================
# Target rules for targets named dvsource-firewire-rtsp

# Build rule for target.
dvsource-firewire-rtsp: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 dvsource-firewire-rtsp
.PHONY : dvsource-firewire-rtsp

# fast build rule for target.
dvsource-firewire-rtsp/fast:
	$(MAKE) -f src/CMakeFiles/dvsource-firewire-rtsp.dir/build.make src/CMakeFiles/dvsource-firewire-rtsp.dir/build
.PHONY : dvsource-firewire-rtsp/fast

# Manual pre-install relink rule for target.
dvsource-firewire-rtsp/preinstall:
	$(MAKE) -f src/CMakeFiles/dvsource-firewire-rtsp.dir/build.make src/CMakeFiles/dvsource-firewire-rtsp.dir/preinstall
.PHONY : dvsource-firewire-rtsp/preinstall

#=============================================================================
# Target rules for targets named dvsource-jack

# Build rule for target.
dvsource-jack: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 dvsource-jack
.PHONY : dvsource-jack

# fast build rule for target.
dvsource-jack/fast:
	$(MAKE) -f src/CMakeFiles/dvsource-jack.dir/build.make src/CMakeFiles/dvsource-jack.dir/build
.PHONY : dvsource-jack/fast

# Manual pre-install relink rule for target.
dvsource-jack/preinstall:
	$(MAKE) -f src/CMakeFiles/dvsource-jack.dir/build.make src/CMakeFiles/dvsource-jack.dir/preinstall
.PHONY : dvsource-jack/preinstall

#=============================================================================
# Target rules for targets named dvswitch

# Build rule for target.
dvswitch: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 dvswitch
.PHONY : dvswitch

# fast build rule for target.
dvswitch/fast:
	$(MAKE) -f src/CMakeFiles/dvswitch.dir/build.make src/CMakeFiles/dvswitch.dir/build
.PHONY : dvswitch/fast

# Manual pre-install relink rule for target.
dvswitch/preinstall:
	$(MAKE) -f src/CMakeFiles/dvswitch.dir/build.make src/CMakeFiles/dvswitch.dir/preinstall
.PHONY : dvswitch/preinstall

#=============================================================================
# Target rules for targets named mixer

# Build rule for target.
mixer: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 mixer
.PHONY : mixer

# fast build rule for target.
mixer/fast:
	$(MAKE) -f tests/CMakeFiles/mixer.dir/build.make tests/CMakeFiles/mixer.dir/build
.PHONY : mixer/fast

#=============================================================================
# Target rules for targets named pic_in_pic

# Build rule for target.
pic_in_pic: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 pic_in_pic
.PHONY : pic_in_pic

# fast build rule for target.
pic_in_pic/fast:
	$(MAKE) -f tests/CMakeFiles/pic_in_pic.dir/build.make tests/CMakeFiles/pic_in_pic.dir/build
.PHONY : pic_in_pic/fast

#=============================================================================
# Target rules for targets named pic_in_pic_speed

# Build rule for target.
pic_in_pic_speed: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 pic_in_pic_speed
.PHONY : pic_in_pic_speed

# fast build rule for target.
pic_in_pic_speed/fast:
	$(MAKE) -f tests/CMakeFiles/pic_in_pic_speed.dir/build.make tests/CMakeFiles/pic_in_pic_speed.dir/build
.PHONY : pic_in_pic_speed/fast

#=============================================================================
# Target rules for targets named ring_buffer

# Build rule for target.
ring_buffer: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 ring_buffer
.PHONY : ring_buffer

# fast build rule for target.
ring_buffer/fast:
	$(MAKE) -f tests/CMakeFiles/ring_buffer.dir/build.make tests/CMakeFiles/ring_buffer.dir/build
.PHONY : ring_buffer/fast

#=============================================================================
# Target rules for targets named translations

# Build rule for target.
translations: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 translations
.PHONY : translations

# fast build rule for target.
translations/fast:
	$(MAKE) -f po/CMakeFiles/translations.dir/build.make po/CMakeFiles/translations.dir/build
.PHONY : translations/fast

#=============================================================================
# Target rules for targets named translations_1

# Build rule for target.
translations_1: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 translations_1
.PHONY : translations_1

# fast build rule for target.
translations_1/fast:
	$(MAKE) -f po/CMakeFiles/translations_1.dir/build.make po/CMakeFiles/translations_1.dir/build
.PHONY : translations_1/fast

#=============================================================================
# Target rules for targets named update-po

# Build rule for target.
update-po: cmake_check_build_system
	$(MAKE) -f CMakeFiles/Makefile2 update-po
.PHONY : update-po

# fast build rule for target.
update-po/fast:
	$(MAKE) -f po/CMakeFiles/update-po.dir/build.make po/CMakeFiles/update-po.dir/build
.PHONY : update-po/fast

# Help Target
help:
	@echo "The following are some of the valid targets for this Makefile:"
	@echo "... all (the default if no target is provided)"
	@echo "... clean"
	@echo "... depend"
	@echo "... edit_cache"
	@echo "... install"
	@echo "... install/local"
	@echo "... list_install_components"
	@echo "... rebuild_cache"
	@echo "... dvsink-command"
	@echo "... dvsink-files"
	@echo "... dvsource-alsa"
	@echo "... dvsource-dvgrab"
	@echo "... dvsource-file"
	@echo "... dvsource-firewire-rtsp"
	@echo "... dvsource-jack"
	@echo "... dvswitch"
	@echo "... mixer"
	@echo "... pic_in_pic"
	@echo "... pic_in_pic_speed"
	@echo "... ring_buffer"
	@echo "... translations"
	@echo "... translations_1"
	@echo "... update-po"
.PHONY : help



#=============================================================================
# Special targets to cleanup operation of make.

# Special rule to run CMake to check the build system integrity.
# No rule that depends on this can have commands that come from listfiles
# because they might be regenerated.
cmake_check_build_system:
	$(CMAKE_COMMAND) -H$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR) --check-build-system CMakeFiles/Makefile.cmake 0
.PHONY : cmake_check_build_system

