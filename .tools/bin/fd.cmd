@echo off
setlocal
set "ROOT=%~dp0..\.."
"%ROOT%\.tools\fd\fd-v10.4.2-x86_64-pc-windows-msvc\fd.exe" %*
