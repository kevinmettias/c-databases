cmake_minimum_required(VERSION 3.20)

project(c_databases C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

option(ENABLE_COVERAGE "Build with gcov/lcov coverage instrumentation" OFF)
option(ENABLE_ASAN "Build with AddressSanitizer instrumentation" OFF)
option(ENABLE_UBSAN "Build with UndefinedBehaviorSanitizer instrumentation" OFF)

find_package(cmocka CONFIG QUIET)
if(cmocka_FOUND)
    if(TARGET cmocka::cmocka)
        set(CMOCKA_TARGET cmocka::cmocka)
    else()
        set(CMOCKA_TARGET cmocka)
    endif()
else()
    find_library(CMOCKA_TARGET cmocka REQUIRED)
endif()

add_library(c_databases_core
    bench/src/bench.c
    btree/src/btree.c
    common/src/common.c
    kv/src/kv.c
    lsm/src/lsm.c
    page/src/page.c
    tools/src/tools.c
    tsdb/src/tsdb.c
    wal/src/wal.c
)
target_include_directories(c_databases_core PUBLIC
    bench/include
    btree/include
    common/include
    kv/include
    lsm/include
    page/include
    tools/include
    tsdb/include
    wal/include
)

if(MSVC)
    target_compile_options(c_databases_core PRIVATE /W4 /WX)
else()
    target_compile_options(c_databases_core PRIVATE -Wall -Wextra -Wpedantic -Werror)
endif()

if(ENABLE_COVERAGE)
    if(CMAKE_C_COMPILER_ID MATCHES "GNU|Clang")
        target_compile_options(c_databases_core PRIVATE --coverage -O0 -g)
        target_link_options(c_databases_core PUBLIC --coverage)
    else()
        message(FATAL_ERROR "ENABLE_COVERAGE requires GCC or Clang")
    endif()
endif()

if(ENABLE_ASAN)
    if(CMAKE_C_COMPILER_ID MATCHES "GNU|Clang")
        target_compile_options(c_databases_core PUBLIC -fsanitize=address -fno-omit-frame-pointer -O1 -g)
        target_link_options(c_databases_core PUBLIC -fsanitize=address)
    else()
        message(FATAL_ERROR "ENABLE_ASAN requires GCC or Clang")
    endif()
endif()

if(ENABLE_UBSAN)
    if(CMAKE_C_COMPILER_ID MATCHES "GNU|Clang")
        target_compile_options(c_databases_core PUBLIC -fsanitize=undefined -fno-omit-frame-pointer -O1 -g)
        target_link_options(c_databases_core PUBLIC -fsanitize=undefined)
    else()
        message(FATAL_ERROR "ENABLE_UBSAN requires GCC or Clang")
    endif()
endif()

enable_testing()
add_executable(test_bench bench/tests/test_bench.c)
target_link_libraries(test_bench PRIVATE c_databases_core ${CMOCKA_TARGET})
add_test(NAME test_bench COMMAND test_bench)
add_executable(test_btree btree/tests/test_btree.c)
target_link_libraries(test_btree PRIVATE c_databases_core ${CMOCKA_TARGET})
add_test(NAME test_btree COMMAND test_btree)
add_executable(test_common common/tests/test_common.c)
target_link_libraries(test_common PRIVATE c_databases_core ${CMOCKA_TARGET})
add_test(NAME test_common COMMAND test_common)
add_executable(test_kv kv/tests/test_kv.c)
target_link_libraries(test_kv PRIVATE c_databases_core ${CMOCKA_TARGET})
add_test(NAME test_kv COMMAND test_kv)
add_executable(test_lsm lsm/tests/test_lsm.c)
target_link_libraries(test_lsm PRIVATE c_databases_core ${CMOCKA_TARGET})
add_test(NAME test_lsm COMMAND test_lsm)
add_executable(test_page page/tests/test_page.c)
target_link_libraries(test_page PRIVATE c_databases_core ${CMOCKA_TARGET})
add_test(NAME test_page COMMAND test_page)
add_executable(test_tools tools/tests/test_tools.c)
target_link_libraries(test_tools PRIVATE c_databases_core ${CMOCKA_TARGET})
add_test(NAME test_tools COMMAND test_tools)
add_executable(test_tsdb tsdb/tests/test_tsdb.c)
target_link_libraries(test_tsdb PRIVATE c_databases_core ${CMOCKA_TARGET})
add_test(NAME test_tsdb COMMAND test_tsdb)
add_executable(test_wal wal/tests/test_wal.c)
target_link_libraries(test_wal PRIVATE c_databases_core ${CMOCKA_TARGET})
add_test(NAME test_wal COMMAND test_wal)
