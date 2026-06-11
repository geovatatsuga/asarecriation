@echo off
echo ======================================
echo Instalando dependencias do servidor
echo ======================================
echo.

echo Instalando pyodbc para SQL Server...
pip install pyodbc

echo.
echo ======================================
echo Instalacao concluida!
echo ======================================
echo.
echo Para testar a conexao com o banco:
echo   cd server_py
echo   python -c "from database import get_db; print('OK' if get_db().connect() else 'ERRO')"
echo.
pause
