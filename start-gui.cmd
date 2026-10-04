@echo off
setlocal
cd /d "%~dp0"
call "%~dp0wish.cmd" "%~dp0codes\hello-gui.tcl" %*
