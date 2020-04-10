::x86块
@echo off
echo 正在编译 windows x86
set GOOS=windows
set GOARCH=386
go build -o x86.exe

::x64块
@echo off
echo 正在编译 windows x64
set GOOS=windows
set GOARCH=amd64
go build -o x64.exe

::x86块
@echo off
echo 正在编译 linux x86
set GOOS=linux
set GOARCH=386
go build -o x86

::x86块
@echo off
echo 正在编译 linux x64
set GOOS=linux
set GOARCH=amd64
go build -o x64

::arm块
@echo off
echo 正在编译 linux arm
set GOOS=linux
set GOARCH=arm
go build -o arm

::mipsle块
@echo off
echo 正在编译 mipsle
set GOOS=linux
set GOARCH=mipsle
go build -o mipsle

::mips64le块
@echo off
echo 正在编译 mips64le
set GOOS=linux
set GOARCH=mips64le
go build -o mips64le


::精简参数 -ldflags "-s -w"