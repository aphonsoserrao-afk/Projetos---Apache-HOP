

@echo off
echo -------------------------------------------------------
echo Iniciando Processamento: %date% %time%
echo -------------------------------------------------------

:: Navega para o diretório do projeto
cd /d "C:\Projetos_Apache\MONITORAMENTO_INTEGRACAO_SINAFLOR"

:: Executa o Python do ambiente virtual (onde as libs estao instaladas)
"C:\Projetos_Apache\MONITORAMENTO_INTEGRACAO_SINAFLOR\venv\Scripts\python.exe" "C:\Projetos_Apache\MONITORAMENTO_INTEGRACAO_SINAFLOR\integracao_minio.py"
REM === (Opcional) Variáveis de ambiente p/ credenciais/parametrização ===
set MINIO_URL=minio-prod.apps.ocp.semas.local
set MINIO_ACCESS_KEY=sinaflor-bi
set MINIO_SECRET_KEY=EGq9umN6GdU1
set MINIO_BUCKET=sinaflor
set MINIO_PREFIX=payloads/
set MINIO_SECURE=false
set PRESIGN_DAYS=7

:: Captura o código de erro do Python para informar o Jenkins
if %errorlevel% neq 0 (
    echo [ERRO] O script Python falhou com codigo %errorlevel%
    exit /b %errorlevel%
)

echo -------------------------------------------------------
echo Processo finalizado com sucesso!
echo -------------------------------------------------------