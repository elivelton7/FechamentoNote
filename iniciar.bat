@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"
title Atualizando e abrindo FechamentoNote

echo ======================================================
echo       Verificando atualizacoes do FechamentoNote
echo ======================================================

:: Caso 1: Foi clonado com Git e tem a pasta .git
if exist "%~dp0.git" (
    echo [INFO] Repositorio Git detectado. Verificando via git pull...
    git pull origin main
    goto ABRIR
)

:: Caso 2: Nao tem .git (baixado via ZIP)
echo [INFO] Pasta baixada via ZIP (sem Git configurado).
echo [INFO] Verificando e baixando atualizacoes diretamente do GitHub via PowerShell...

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$repo = 'elivelton7/FechamentoNote'; $branch = 'main';" ^
    "try {" ^
    "    $wc = New-Object System.Net.WebClient;" ^
    "    $wc.Headers.Add('User-Agent', 'PowerShell-Updater');" ^
    "    Write-Host ' -> Verificando versao mais recente...';" ^
    "    $htmlUrl = 'https://raw.githubusercontent.com/' + $repo + '/' + $branch + '/index.html';" ^
    "    $sheetUrl = 'https://raw.githubusercontent.com/' + $repo + '/' + $branch + '/Tabela_Root_Cause.xlsx';" ^
    "    $batUrl = 'https://raw.githubusercontent.com/' + $repo + '/' + $branch + '/iniciar.bat';" ^
    "    $wc.DownloadFile($htmlUrl, '%~dp0index.html');" ^
    "    $wc.DownloadFile($sheetUrl, '%~dp0Tabela_Root_Cause.xlsx');" ^
    "    $wc.DownloadFile($batUrl, '%~dp0iniciar.bat');" ^
    "    Write-Host ' [OK] Arquivos atualizados com sucesso do GitHub!' -ForegroundColor Green;" ^
    "} catch {" ^
    "    Write-Host ' [AVISO] Nao foi possivel baixar do GitHub (sem conexao). Abrindo versao local...' -ForegroundColor Yellow;" ^
    "}"

:ABRIR
echo.
echo Abrindo aplicacao no navegador...
timeout /t 1 >nul
start "" "%~dp0index.html"
exit
