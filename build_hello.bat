cmake -S . -B ./build -GNinja -DCMAKE_BUILD_TYPE=Release
cmake --build ./build
C:\Qt\5.15.2\msvc2019_64\bin\windeployqt.exe --qmldir ./src .\build\hello.exe
echo "Done building hello"
