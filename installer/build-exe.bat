@echo off
..\installer\lib\izpack2exe\izpack2exe.py --file ..\%1.jar --output ..\%1.exe --with-7z=..\installer\lib\izpack2exe\7za.exe --no-upx --with-jdk=..\jre --name das > ..\installer\build-exe.log 2>&1