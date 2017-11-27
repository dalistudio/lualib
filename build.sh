#/bin/bash

## 编译 lua 5.3.4
cd lua-5.3.4
make mingw CC='i686-w64-mingw32-gcc -std=gnu99 -fPIC -static'


## 编译 lsqlite3 库
cd ..
cd lsqlite3_fsl09x
i686-w64-mingw32-gcc -O2 -fPIC -I../lua-5.3.4/src -c lsqlite3.c sqlite3.c 

i686-w64-mingw32-gcc -shared -o lsqlite3.so -L../lua-5.3.4/src ../lua-5.3.4/src/lua53.dll lsqlite3.o sqlite3.o -lpthread -lm -static-libgcc -static-libstdc++

## 编译 luasocket 库
cd ..
cd luasocket-3.0-rc1
i686-w64-mingw32-gcc -fPIC -I../lua-5.3.4/src -DLUASOCKET_DEBUG -c src/auxiliar.c src/buffer.c src/except.c src/inet.c src/io.c src/luasocket.c src/options.c src/select.c src/tcp.c src/timeout.c src/udp.c src/wsocket.c

i686-w64-mingw32-gcc -shared -o socket.so -L../lua-5.3.4/src ../lua-5.3.4/src/lua53.dll *.o -lws2_32 -lpthread -lm -static-libgcc -static-libstdc++ -DLUASOCKET_DEBUG

## 编译 mime 库
i686-w64-mingw32-gcc -fPIC -I../lua-5.3.4/src -c src/mime.c

i686-w64-mingw32-gcc -shared -o mime.so -L../lua-5.3.4/src ../lua-5.3.4/src/lua53.dll mime.o -lws2_32 -lpthread -lm -static-libgcc -static-libstdc++

## 发布
cd ..
mkdir release
cd release
cp ../lua-5.3.4/src/*.a .
cp ../lua-5.3.4/src/*.exe .
cp ../lua-5.3.4/src/*.dll .

cp ../lsqlite3_fsl09x/*.so .

cp ../luasocket-3.0-rc1/src/*.lua .
cp ../luasocket-3.0-rc1/*.so .
cd ..

