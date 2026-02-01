-- CMake snippets for LuaSnip
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
  -- ========== Project Setup ==========
  s("cmake-project", fmt([[
cmake_minimum_required(VERSION {})
project({} VERSION {} LANGUAGES CXX)

set(CMAKE_CXX_STANDARD {})
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

{}
  ]], {
    c(1, {t("3.20"), t("3.25"), t("3.28")}),
    i(2, "ProjectName"),
    i(3, "1.0.0"),
    c(4, {t("20"), t("23"), t("17")}),
    i(5, "# Add targets here"),
  })),

  s("cmake-exe", fmt([[
add_executable({} {})
target_include_directories({} PRIVATE {})
target_compile_features({} PRIVATE {})
{}
  ]], {
    i(1, "app"),
    i(2, "src/main.cpp"),
    rep(1),
    i(3, "${CMAKE_SOURCE_DIR}/include"),
    rep(1),
    c(4, {t("cxx_std_20"), t("cxx_std_23"), t("cxx_std_17")}),
    i(5, "# Additional configuration"),
  })),

  s("cmake-lib", fmt([[
add_library({} {} {})
target_include_directories({} 
  PUBLIC
    $<BUILD_INTERFACE:${{CMAKE_CURRENT_SOURCE_DIR}}/include>
    $<INSTALL_INTERFACE:include>
  PRIVATE
    ${{CMAKE_CURRENT_SOURCE_DIR}}/src
)
target_compile_features({} PUBLIC {})
{}
  ]], {
    i(1, "mylib"),
    c(2, {t("STATIC"), t("SHARED"), t("INTERFACE")}),
    i(3, "src/mylib.cpp"),
    rep(1),
    rep(1),
    c(4, {t("cxx_std_20"), t("cxx_std_23")}),
    i(5, "# Additional configuration"),
  })),

  s("cmake-header-only", fmt([[
add_library({} INTERFACE)
target_include_directories({} INTERFACE
  $<BUILD_INTERFACE:${{CMAKE_CURRENT_SOURCE_DIR}}/include>
  $<INSTALL_INTERFACE:include>
)
target_compile_features({} INTERFACE {})
  ]], {
    i(1, "header_lib"),
    rep(1),
    rep(1),
    c(2, {t("cxx_std_20"), t("cxx_std_23")}),
  })),

  -- ========== Target Configuration ==========
  s("target-link", fmt([[
target_link_libraries({} {} {})
  ]], {
    i(1, "target"),
    c(2, {t("PRIVATE"), t("PUBLIC"), t("INTERFACE")}),
    i(3, "dependency"),
  })),

  s("target-include", fmt([[
target_include_directories({} {} {})
  ]], {
    i(1, "target"),
    c(2, {t("PRIVATE"), t("PUBLIC"), t("INTERFACE")}),
    i(3, "${CMAKE_CURRENT_SOURCE_DIR}/include"),
  })),

  s("target-compile-options", fmt([[
target_compile_options({} {} {})
  ]], {
    i(1, "target"),
    c(2, {t("PRIVATE"), t("PUBLIC"), t("INTERFACE")}),
    c(3, {
      t("-Wall -Wextra -Wpedantic"),
      t("$<$<CXX_COMPILER_ID:GNU>:-Wall -Wextra>"),
      t("$<$<CONFIG:Debug>:-g -O0>"),
    }),
  })),

  s("target-definitions", fmt([[
target_compile_definitions({} {} {})
  ]], {
    i(1, "target"),
    c(2, {t("PRIVATE"), t("PUBLIC"), t("INTERFACE")}),
    i(3, "MY_DEFINE=1"),
  })),

  s("target-features", fmt([[
target_compile_features({} {} {})
  ]], {
    i(1, "target"),
    c(2, {t("PRIVATE"), t("PUBLIC"), t("INTERFACE")}),
    c(3, {
      t("cxx_std_20"),
      t("cxx_std_23"),
      t("cxx_std_17"),
      t("cxx_constexpr cxx_lambda_init_captures"),
    }),
  })),

  s("target-sources", fmt([[
target_sources({} {} 
  {}
)
  ]], {
    i(1, "target"),
    c(2, {t("PRIVATE"), t("PUBLIC"), t("INTERFACE")}),
    i(3, "src/file.cpp"),
  })),

  s("target-properties", fmt([[
set_target_properties({} PROPERTIES
  {}
)
  ]], {
    i(1, "target"),
    c(2, {
      t("CXX_STANDARD 20\n  CXX_STANDARD_REQUIRED ON"),
      t("OUTPUT_NAME custom_name"),
      t("POSITION_INDEPENDENT_CODE ON"),
      t("RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin"),
    }),
  })),

  -- ========== Dependencies ==========
  s("find-package", fmt([[
find_package({} {} REQUIRED)
target_link_libraries({} {} {}::{})
  ]], {
    i(1, "PackageName"),
    i(2, "CONFIG"),
    i(3, "target"),
    c(4, {t("PRIVATE"), t("PUBLIC")}),
    rep(1),
    i(5, "component"),
  })),

  s("fetchcontent", fmt([[
include(FetchContent)

FetchContent_Declare(
  {}
  GIT_REPOSITORY {}
  GIT_TAG {}
)

FetchContent_MakeAvailable({})

target_link_libraries({} PRIVATE {})
  ]], {
    i(1, "dependency_name"),
    i(2, "https://github.com/user/repo.git"),
    i(3, "v1.0.0"),
    rep(1),
    i(4, "target"),
    rep(1),
  })),

  s("pkg-config", fmt([[
find_package(PkgConfig REQUIRED)
pkg_check_modules({} REQUIRED {})
target_include_directories({} PRIVATE ${{{}_INCLUDE_DIRS}})
target_link_libraries({} PRIVATE ${{{}_LIBRARIES}})
  ]], {
    i(1, "PKG"),
    i(2, "package-name"),
    i(3, "target"),
    rep(1),
    rep(3),
    rep(1),
  })),

  -- ========== Build Configuration ==========
  s("build-type", fmt([[
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE {} CACHE STRING "Build type" FORCE)
endif()
  ]], {
    c(1, {t("Release"), t("Debug"), t("RelWithDebInfo")}),
  })),

  s("generator-expr", fmt([[
$<$<{}:{}>:{}>
  ]], {
    c(1, {t("CONFIG"), t("CXX_COMPILER_ID"), t("PLATFORM_ID")}),
    i(2, "Debug"),
    i(3, "value"),
  })),

  s("option", fmt([[
option({} "{}" {})
  ]], {
    i(1, "ENABLE_FEATURE"),
    i(2, "Description of the option"),
    c(3, {t("ON"), t("OFF")}),
  })),

  s("if-option", fmt([[
if({})
  {}
endif()
  ]], {
    i(1, "OPTION_NAME"),
    i(2, "# conditional code"),
  })),

  -- ========== Testing ==========
  s("enable-testing", fmt([[
include(CTest)
enable_testing()

add_subdirectory(tests)
  ]], {})),

  s("add-test", fmt([[
add_executable({} {})
target_link_libraries({} PRIVATE {})
add_test(NAME {} COMMAND {})
  ]], {
    i(1, "test_name"),
    i(2, "tests/test.cpp"),
    rep(1),
    i(3, "target_to_test"),
    rep(1),
    rep(1),
  })),

  s("gtest-setup", fmt([[
include(FetchContent)
FetchContent_Declare(
  googletest
  GIT_REPOSITORY https://github.com/google/googletest.git
  GIT_TAG v1.14.0
)
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

enable_testing()

add_executable({} {})
target_link_libraries({} PRIVATE GTest::gtest_main)

include(GoogleTest)
gtest_discover_tests({})
  ]], {
    i(1, "test_target"),
    i(2, "tests/test.cpp"),
    rep(1),
    rep(1),
  })),

  s("catch2-setup", fmt([[
include(FetchContent)
FetchContent_Declare(
  Catch2
  GIT_REPOSITORY https://github.com/catchorg/Catch2.git
  GIT_TAG v3.4.0
)
FetchContent_MakeAvailable(Catch2)

add_executable({} {})
target_link_libraries({} PRIVATE Catch2::Catch2WithMain)

include(CTest)
include(Catch)
catch_discover_tests({})
  ]], {
    i(1, "test_target"),
    i(2, "tests/test.cpp"),
    rep(1),
    rep(1),
  })),

  -- ========== Installation ==========
  s("install-targets", fmt([[
install(TARGETS {} 
  EXPORT {}-targets
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  RUNTIME DESTINATION bin
  INCLUDES DESTINATION include
)
  ]], {
    i(1, "target"),
    rep(1),
  })),

  s("install-headers", fmt([[
install(DIRECTORY include/
  DESTINATION include
  FILES_MATCHING PATTERN "*.{}"
)
  ]], {
    c(1, {t("hpp"), t("h"), t("hxx")}),
  })),

  s("install-export", fmt([[
install(EXPORT {}-targets
  FILE {}-targets.cmake
  NAMESPACE {}::
  DESTINATION lib/cmake/{}
)
  ]], {
    i(1, "project"),
    rep(1),
    rep(1),
    rep(1),
  })),

  -- ========== Subdirectories & Files ==========
  s("add-subdir", fmt([[
add_subdirectory({})
  ]], {
    i(1, "src"),
  })),

  s("file-glob", fmt([[
file(GLOB{} {}
  "{}"
)
  ]], {
    c(1, {t(""), t("_RECURSE")}),
    i(2, "SOURCES"),
    i(3, "src/*.cpp"),
  })),

  s("configure-file", fmt([[
configure_file(
  {}
  {}
  @ONLY
)
  ]], {
    i(1, "${CMAKE_SOURCE_DIR}/config.h.in"),
    i(2, "${CMAKE_BINARY_DIR}/config.h"),
  })),

  -- ========== Custom Commands ==========
  s("add-custom-command", fmt([[
add_custom_command(
  OUTPUT {}
  COMMAND {}
  DEPENDS {}
  COMMENT "{}"
)
  ]], {
    i(1, "output_file"),
    i(2, "command"),
    i(3, "dependencies"),
    i(4, "Generating output_file"),
  })),

  s("add-custom-target", fmt([[
add_custom_target({}
  COMMAND {}
  COMMENT "{}"
)
  ]], {
    i(1, "target_name"),
    i(2, "command"),
    i(3, "Running custom target"),
  })),

  -- ========== Platform-Specific ==========
  s("if-windows", fmt([[
if(WIN32)
  {}
endif()
  ]], {
    i(1, "# Windows-specific code"),
  })),

  s("if-linux", fmt([[
if(UNIX AND NOT APPLE)
  {}
endif()
  ]], {
    i(1, "# Linux-specific code"),
  })),

  s("if-macos", fmt([[
if(APPLE)
  {}
endif()
  ]], {
    i(1, "# macOS-specific code"),
  })),

  -- ========== Modern CMake Patterns ==========
  s("interface-lib", fmt([[
add_library({} INTERFACE)
target_compile_features({} INTERFACE {})
target_include_directories({} INTERFACE
  $<BUILD_INTERFACE:${{CMAKE_CURRENT_SOURCE_DIR}}/include>
  $<INSTALL_INTERFACE:include>
)
  ]], {
    i(1, "interface_target"),
    rep(1),
    c(2, {t("cxx_std_20"), t("cxx_std_23")}),
    rep(1),
  })),

  s("imported-target", fmt([[
add_library({}::{} {} IMPORTED)
set_target_properties({}::{} PROPERTIES
  IMPORTED_LOCATION "{}"
  INTERFACE_INCLUDE_DIRECTORIES "{}"
)
  ]], {
    i(1, "namespace"),
    i(2, "target"),
    c(3, {t("STATIC"), t("SHARED"), t("INTERFACE")}),
    rep(1),
    rep(2),
    i(4, "/path/to/library"),
    i(5, "/path/to/include"),
  })),

  s("alias-target", fmt([[
add_library({}::{} ALIAS {})
  ]], {
    i(1, "namespace"),
    i(2, "alias_name"),
    i(3, "real_target"),
  })),

  -- ========== Qt Support ==========
  s("qt-setup", fmt([[
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt{} REQUIRED COMPONENTS {})

target_link_libraries({} PRIVATE Qt{}::{})
  ]], {
    c(1, {t("6"), t("5")}),
    i(2, "Core Widgets"),
    i(3, "target"),
    rep(1),
    i(4, "Widgets"),
  })),

  -- ========== Useful Utilities ==========
  s("message", fmt([[
message({} "{}")
  ]], {
    c(1, {t("STATUS"), t("WARNING"), t("FATAL_ERROR"), t("DEBUG")}),
    i(2, "Message text"),
  })),

  s("foreach", fmt([[
foreach({} {})
  {}
endforeach()
  ]], {
    i(1, "item"),
    i(2, "${LIST}"),
    i(3, "# loop body"),
  })),

  s("function", fmt([[
function({} {})
  {}
endfunction()
  ]], {
    i(1, "function_name"),
    i(2, "arg1 arg2"),
    i(3, "# function body"),
  })),

  s("macro", fmt([[
macro({} {})
  {}
endmacro()
  ]], {
    i(1, "macro_name"),
    i(2, "arg1 arg2"),
    i(3, "# macro body"),
  })),
}
