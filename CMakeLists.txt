# $ cmake -S . -B ./build  -GNinja -DCMAKE_BUILD_TYPE=Release
# $ cmake --build ./build --target all
# $ cmake --install ./build

cmake_minimum_required(VERSION 3.18)

project(msbuilddockerimage VERSION 0.0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Make the environment variable QTDIR a CMake variable of the same name
set(QTDIR $ENV{QTDIR})

find_package(Qt5 COMPONENTS
    Core
    Quick
    REQUIRED
    PATHS ${QTDIR}
)

add_executable(hello
    src/main.cpp
    src/main.qrc
    .github/workflows/main.yml
    docker/Dockerfile
    build_hello.ps1
    cmake/CPackConfig.cmake.in
)

target_link_libraries(hello PRIVATE
    Qt5::Core
    Qt5::Quick
)

configure_file(cmake/CPackConfig.cmake.in CPackConfig.cmake @ONLY)

# Install executable hello to CMAKE_INSTALL_PREFIX/CMAKE_INSTALL_BINDIR
# which becomes
install(
    TARGETS hello
    RUNTIME
    DESTINATION ${CMAKE_INSTALL_BINDIR}
)

install(
    DIRECTORY ${CMAKE_BINARY_DIR}
    DESTINATION bin
    FILES_MATCHING PATTERN "*.qmlc" EXCLUDE
    PATTERN ".debug" EXCLUDE
    PATTERN "*"
)

# install(
#     FILES README.md
#     DESTINATION ${CMAKE_INSTALL_BINDIR}
# )

include(CPack)
