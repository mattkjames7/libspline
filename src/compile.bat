call compileobj.bat

mkdir ..\lib\libspline
g++ -lm -fPIC -std=c++17 -Wextra -O3 -shared -o ..\lib\libspline\libspline.so ..\build\*.o

