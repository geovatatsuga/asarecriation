@echo off
setlocal
set "ROOT=%~dp0..\.."
"%ROOT%\node_modules\.bin\repomix.cmd" %*
