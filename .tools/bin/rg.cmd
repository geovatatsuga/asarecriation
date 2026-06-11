@echo off
setlocal
set "ROOT=%~dp0..\.."
set "RG=%ROOT%\node_modules\@vscode\ripgrep-win32-x64\bin\rg.exe"
if exist "%RG%" (
  "%RG%" %*
) else (
  rg %*
)
