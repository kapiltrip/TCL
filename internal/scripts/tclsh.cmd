@echo off
setlocal
set "TCL_LIBRARY=%~dp0..\runtime\lib\tcl8.6"
set "TK_LIBRARY=%~dp0..\runtime\lib\tk8.6"
set "TCLLIBPATH="
set "PATH=%~dp0..\runtime\bin;%PATH%"
"%~dp0..\runtime\bin\tclsh.exe" %*
exit /b %errorlevel%
