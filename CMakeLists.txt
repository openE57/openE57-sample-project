# MIT License
# 
# Copyright (c) 2022 openE57 Sample Project
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

cmake_minimum_required(VERSION 3.15.0 FATAL_ERROR)

# Enables the MSVC_RUNTIME_LIBRARY property on targets
cmake_policy(SET CMP0091 NEW)

project(openE57-sample-project VERSION 1.0.0 LANGUAGES CXX DESCRIPTION "openE57 sample project to handle E57 files")

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED TRUE)
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
set(CMAKE_SKIP_BUILD_RPATH FALSE)
set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)
set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/redist-${PROJECT_NAME}-v${PROJECT_VERSION})
list(FIND CMAKE_PLATFORM_IMPLICIT_LINK_DIRECTORIES "${CMAKE_INSTALL_PREFIX}/lib" isSystemDir)
if("${isSystemDir}" STREQUAL "-1")
    set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")
endif("${isSystemDir}" STREQUAL "-1")

option(BUILD_SHARED_LIBS "Build e57 shared libraries" FALSE)

if(BUILD_SHARED_LIBS)
  message(FATAL_ERROR "Shared Libraries are not supported due to missing exported symbols")
else(BUILD_SHARED_LIBS)
  set(LIBRARY_TYPE STATIC)
endif()

if(EXISTS ${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
  include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
  conan_basic_setup(TARGETS)
endif()

# Set a private module find path
set(CMAKE_MODULE_PATH ${CMAKE_BINARY_DIR} ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")
set(CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR} ${CMAKE_PREFIX_PATH})

include(${CMAKE_SOURCE_DIR}/cmake/dependencies.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/compiler_options.cmake)

find_package(opene57 REQUIRED )

add_executable(demo-read ${CMAKE_SOURCE_DIR}/src/DemoRead01.cpp)
set_target_properties(demo-read PROPERTIES 
  DEBUG_POSTFIX "-d" 
  MSVC_RUNTIME_LIBRARY "${MSVC_RUNTIME_TYPE}")
target_include_directories(demo-read PRIVATE 
  ${opene57_INCLUDE_DIRS} 
  )
target_link_libraries(demo-read 
  PRIVATE 
    ${opene57_LIBRARIES}
    ${CMAKE_THREAD_LIBS_INIT}
)

# 
# Install Artifacts
#
install(
  TARGETS 
  demo-read 
  RUNTIME DESTINATION bin
  ARCHIVE DESTINATION lib)
