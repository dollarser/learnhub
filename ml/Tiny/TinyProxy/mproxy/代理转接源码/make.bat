::x86��
@echo off
echo ���ڱ��� windows x86
set GOOS=windows
set GOARCH=386
go build -o x86.exe

::x64��
@echo off
echo ���ڱ��� windows x64
set GOOS=windows
set GOARCH=amd64
go build -o x64.exe

::x86��
@echo off
echo ���ڱ��� linux x86
set GOOS=linux
set GOARCH=386
go build -o x86

::x86��
@echo off
echo ���ڱ��� linux x64
set GOOS=linux
set GOARCH=amd64
go build -o x64

::arm��
@echo off
echo ���ڱ��� linux arm
set GOOS=linux
set GOARCH=arm
go build -o arm

::mipsle��
@echo off
echo ���ڱ��� mipsle
set GOOS=linux
set GOARCH=mipsle
go build -o mipsle

::mips64le��
@echo off
echo ���ڱ��� mips64le
set GOOS=linux
set GOARCH=mips64le
go build -o mips64le


::������� -ldflags "-s -w"