@echo off
setlocal
cd /d "%~dp0..\.."
call "%~dp0wish.cmd" "%~dp0hello-gui.tcl" %*
