# MIT License

# Copyright (c) 2023 ERaftGroup

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


cmake_minimum_required (VERSION 3.26)

project(eraftkv VERSION 0.0.1 LANGUAGES C CXX)

# C standard can be overridden when this is used as a sub-project.
if(NOT CMAKE_C_STANDARD)
  # This project can use C11, but will gracefully decay down to C89.
  set(CMAKE_C_STANDARD 11)
  set(CMAKE_C_STANDARD_REQUIRED OFF)
  set(CMAKE_C_EXTENSIONS OFF)
endif(NOT CMAKE_C_STANDARD)

# C++ standard can be overridden when this is used as a sub-project.
if(NOT CMAKE_CXX_STANDARD)
  # This project requires C++20.
  set(CMAKE_CXX_STANDARD 20)
  set(CMAKE_CXX_STANDARD_REQUIRED ON)
  set(CMAKE_CXX_EXTENSIONS OFF)
endif(NOT CMAKE_CXX_STANDARD)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++20 ")


option(ERAFTKV_BUILD_TESTS "Build ERaftKV's unit tests" ON)
option(ERAFTKV_BUILD_BENCHMARKS "Build ERaftKV's benchmarks" ON)
option(ERAFTKV_INSTALL "Install ERaftKV's header and library" ON)
option(DOWNLOAD_GRPC_CN "Download grpc source code in china" OFF)

################################################
# rocksdb begion
#
find_path(ROCKSDB_ROOT_DIR
    NAMES include/rocksdb/db.h
)

find_library(ROCKSDB_LIBRARIES
    NAMES rocksdb
    HINTS ${ROCKSDB_ROOT_DIR}/lib
)

find_path(ROCKSDB_INCLUDE_DIRS
    NAMES rocksdb/db.h
    HINTS ${ROCKSDB_ROOT_DIR}/include
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(RocksDB DEFAULT_MSG
    ROCKSDB_LIBRARIES
    ROCKSDB_INCLUDE_DIRS
)

mark_as_advanced(
    ROCKSDB_ROOT_DIR
    ROCKSDB_LIBRARIES
    ROCKSDB_INCLUDE_DIRS
)

#
# rocksdb end
################################################


################################################
# grpc begin
#

find_package (OpenSSL)
message (STATUS "Using ssl=${OPENSSL_FOUND}: ${OPENSSL_INCLUDE_DIR} : ${OPENSSL_LIBRARIES}")

find_package(Protobuf EXACT REQUIRED PATHS /usr/local/lib)
message(STATUS "Using protobuf: ${Protobuf_VERSION} : ${Protobuf_INCLUDE_DIRS}, ${Protobuf_LIBRARIES}")

include_directories(${PROTOBUF_INCLUDE_DIRS})

find_package(c-ares REQUIRED)
message(STATUS "Lib c-ares found")

find_package(ZLIB REQUIRED)
message(STATUS "Using ZLIB: ${ZLIB_INCLUDE_DIRS}, ${ZLIB_LIBRARIES}")

find_package(gRPC CONFIG REQUIRED)
message(STATUS "Using gRPC: ${gRPC_VERSION}")

find_package(Gflags REQUIRED)
include_directories(${GFLAGS_INCLUDE_DIRS})

find_package(gflags REQUIRED)


#
# grpc end
################################################

################################################
# gtest begin
#

find_package(GTest REQUIRED)
include_directories(${GTEST_INCLUDE_DIRS})

#
# gtest end
################################################

################################################
# google benchmark begin
#

find_package(benchmark REQUIRED)

#
# google benchmark end
################################################

add_subdirectory(protocol)
add_subdirectory(raftcore)
add_subdirectory(example)
