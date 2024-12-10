cmake_minimum_required(VERSION "3.28")

project("cpackexample" VERSION 0.1.0)

FIND_PACKAGE(deal.II 9.5 REQUIRED
  HINTS ${DEAL_II_DIR} ../ ../../ $ENV{DEAL_II_DIR}
  )
DEAL_II_INITIALIZE_CACHED_VARIABLES()

add_library(cpackexamplelib filesystem/filesystem.cpp fem/fem.cpp flatset/flatset.cpp yamlParser/yamlParser.cpp)

target_sources(cpackexamplelib
   PUBLIC FILE_SET HEADERS
   BASE_DIRS ${CMAKE_CURRENT_SOURCE_DIR} FILES
     ${CMAKE_CURRENT_SOURCE_DIR}/fem/fem.hpp
     ${CMAKE_CURRENT_SOURCE_DIR}/filesystem/filesystem.hpp
     ${CMAKE_CURRENT_SOURCE_DIR}/flatset/flatset.hpp
     ${CMAKE_CURRENT_SOURCE_DIR}/yamlParser/yamlParser.hpp
 )

# Uses the FindBoost module of CMake
find_package(Boost 1.83 COMPONENTS filesystem REQUIRED)

find_package(yaml-cpp 0.6 REQUIRED)

add_executable("${PROJECT_NAME}" main.cpp)

target_link_libraries("${PROJECT_NAME}" cpackexamplelib)
target_link_libraries(cpackexamplelib Boost::filesystem ${YAML_CPP_LIBRARIES})

include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/CPackConfig.cmake)

target_include_directories(cpackexamplelib
   PUBLIC
     $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
     $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/cpackexamplelib>
 )

DEAL_II_SETUP_TARGET("${PROJECT_NAME}")
DEAL_II_SETUP_TARGET(cpackexamplelib)

include(GNUInstallDirs)
 install(TARGETS cpackexamplelib cpackexample
   LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
   ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
   RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
   )

   install(TARGETS cpackexamplelib
     FILE_SET HEADERS
     DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/cpackexamplelib
   )