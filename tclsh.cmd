@echo off
setlocal
set "TCL_LIBRARY=%~dp0runtime\lib\tcl8.6"
set "TK_LIBRARY=%~dp0runtime\lib\tk8.6"
set "TCLLIBPATH="
set "PATH=%~dp0runtime\bin;%PATH%"
"%~dp0runtime\bin\tclsh.exe" %*
exit /b %errorlevel%
