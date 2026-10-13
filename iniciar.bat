@echo off
setlocal
cd /d "%~dp0"
title Atualizando e abrindo FechamentoNote

echo [1/3] Verificando conexao e atualizacoes no Git...
git pull origin main >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo [OK] Repositorio sincronizado com sucesso!
) else (
    echo [AVISO] Nao foi possivel atualizar via Git ou sem conexao no momento.
    echo Abrindo versao local existente...
)

echo [2/3] Abrindo aplicacao no navegador...
start "" "%~dp0index.html"
exit
