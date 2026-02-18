@echo off
setlocal

set "HOP_HOME=C:\ApacheHop\hop-2.12"
set "HOP_CONFIG_FOLDER=C:\ApacheHop\hop-2.12\config"
set "HOP_FILE=C:\Projetos_Apache\MONITORAMENTO_INTEGRACAO_SINAFLOR\job_aut_cred_sinaflor.hwf"
set "HOP_LOG=C:\Projetos_Apache\MONITORAMENTO_INTEGRACAO_SINAFLOR\logs\job_aut_cred_sinaflor.log"

if not exist "%HOP_CONFIG_FOLDER%" mkdir "%HOP_CONFIG_FOLDER%"
if not exist "C:\Projetos_Apache\MONITORAMENTO_INTEGRACAO_SINAFLOR\logs" mkdir "C:\Projetos_Apache\MONITORAMENTO_INTEGRACAO_SINAFLOR\logs"

cd /d "%HOP_HOME%"

call hop-run.bat -j=MONITORAMENTO_INTEGRACAO_SINAFLOR -r=local -l=BASIC -lf="%HOP_LOG%" -f="%HOP_FILE%"

exit /b %ERRORLEVEL%
endlocal


