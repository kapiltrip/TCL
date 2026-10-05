@echo off
setlocal
if not exist "%~dp0internal\runtime\bin\tclsh.exe" (
    echo Tcl runtime is missing. See README.md under Supporting files. 1>&2
    exit /b 1
)
call "%~dp0internal\scripts\tclsh.cmd" %*
exit /b %errorlevel%
