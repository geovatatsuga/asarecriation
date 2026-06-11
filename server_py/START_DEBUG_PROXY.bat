@echo off
title Asa de Cristal - Server + Packet Proxy
cd /d "%~dp0"

echo ============================================
echo   ASA DE CRISTAL - DEBUG MODE COM PROXY
echo ============================================
echo.
echo Este modo inicia:
echo   1. Servidor na porta 8889
echo   2. Proxy na porta 8888 encaminhando para 8889
echo.
echo O cliente conecta na 8888, proxy captura tudo e encaminha.
echo.

:: Iniciar servidor na porta 8889
echo.
echo [1/2] Iniciando servidor na porta 8889...
start "ASA Server (8889)" cmd /k "set WORLD_PORT=8889 && python main.py"

:: Esperar servidor iniciar
timeout /t 3 /nobreak > nul

:: Iniciar proxy na 8888 encaminhando para 8889
echo [2/2] Iniciando proxy na porta 8888...
cd tools
start "ASA Packet Proxy" cmd /k "python packet_proxy.py --listen-port 8888 --target-host 127.0.0.1 --target-port 8889"

echo.
echo ============================================
echo   TUDO INICIADO!
echo ============================================
echo.
echo   Cliente conecta em: 127.0.0.1:8888 (proxy)
echo   Proxy encaminha para: 127.0.0.1:8889 (servidor)
echo.
echo   Logs centralizados em: server_py\logs\latest.log
echo.
echo ============================================

