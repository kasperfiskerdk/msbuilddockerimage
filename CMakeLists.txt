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

set(QTDIR $ENV{QTDIR})

find_package(Qt5 COMPONENTS
    Core
    Quick
    Multimedia LinguistTools
    REQUIRED
    PATHS ${QTDIR}
)

add_executable(hello
    src/main.cpp
    src/main.qrc
    go.bat
    .github/workflows/main.yml
    docker/Dockerfile
)

target_link_libraries(hello PRIVATE
    Qt5::Core
    Qt5::Quick
    Qt5::Multimedia
)

# Install executable simpleton to CMAKE_INSTALL_PREFIX/CMAKE_INSTALL_BINDIR
# which becomes /opt/yoyodyne/simpleton/bin/simpleton
install(
    TARGETS hello
    RUNTIME
    DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# install(
#     FILES README.md
#     DESTINATION ${CMAKE_INSTALL_BINDIR}
# )

# include(CPack)
