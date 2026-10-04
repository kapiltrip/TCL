@echo off
setlocal
cd /d "%~dp0..\.."
title Tcl Practice
color F0
echo Tcl practice console
echo Try: puts "Hello, Kapil!"
echo Run the example: source internal/scripts/hello.tcl
echo Close the console: exit
echo.
call "%~dp0tclsh.cmd"
