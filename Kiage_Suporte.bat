@echo off
:: Auto elevar
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)


chcp 65001 >nul
title Assistente de Suporte Kiage - TI
color 0F
cls



:menu
cls
echo                    █████   ████   ███                             
echo                    ▒▒███   ███▒  ▒▒▒                              
echo                     ▒███  ███    ████   ██████    ███████  ██████ 
echo                     ▒███████    ▒▒███  ▒▒▒▒▒███  ███▒▒███ ███▒▒███
echo                     ▒███▒▒███    ▒███   ███████ ▒███ ▒███▒███████ 
echo                     ▒███ ▒▒███   ▒███  ███▒▒███ ▒███ ▒███▒███▒▒▒  
echo                     █████ ▒▒████ █████▒▒████████▒▒███████▒▒██████ 
echo                                                 ▒▒▒▒▒███   
echo                                                  ███ ▒███         
echo                                                 ▒▒██████                                                                                                  
echo ====================================================================================
echo.
echo   1 - Solucoes de Rede
echo   2 - Solucoes de Impressoras
echo   3 - Limpezas do Sistema
echo   4 - Windows Update
echo   5 - Windows Defender
echo.
echo   [6] Sair
echo.
echo =====================================================================================
echo.
choice /c 123456 /n /m "Selecione uma opcao: "

if errorlevel 6 exit
if errorlevel 5 goto DEFENDER_MENU
if errorlevel 4 goto UPDATE_MENU
if errorlevel 3 goto LIMPEZA_MENU
if errorlevel 2 goto IMPRESSORA_MENU
if errorlevel 1 goto REDE_MENU

:: ==============================
:REDE_MENU
cls
echo ===== SOLUCOES DE REDE =====
echo.
echo 1 - Ver configuracao IP
echo 2 - Testar conectividade (Ping Google)
echo 3 - Limpar cache DNS
echo 4 - Abrir Central de Rede
echo.
echo 5 - Voltar
echo.

choice /c 12345 /n /m "Opcao: "

if errorlevel 5 goto MENU
if errorlevel 4 ncpa.cpl
if errorlevel 3 ipconfig /flushdns
if errorlevel 2 ping google.com -n 4
if errorlevel 1 ipconfig

pause
goto REDE_MENU

:: ==============================
:IMPRESSORA_MENU
cls
echo ==================== SOLUCOES DE IMPRESSORA ====================
echo.
echo 1 - Listar impressoras instaladas
echo 2 - Limpar fila de impressao
echo 3 - Testar impressao (pagina de teste)
echo 4 - Reiniciar servico Spooler
echo 5 - Dispositivos e Impressoras
echo 6 - Reinstalar / Gerenciar drivers
echo.
echo 7 - Voltar
echo.
choice /c 1234567 /n /m "Opcao: "

if errorlevel 7 goto MENU
if errorlevel 6 goto GERENCIAR_DRIVER
if errorlevel 5 goto DISPOSITIVOS_IMPRESSORA
if errorlevel 4 goto REINICIAR_SPOOLER
if errorlevel 3 goto TESTE_IMPRESSAO
if errorlevel 2 goto LIMPAR_FILA
if errorlevel 1 goto LISTAR_IMPRESSORAS


:: ---------- LISTAR IMPRESSORAS ----------
:LISTAR_IMPRESSORAS
cls
echo ================== IMPRESSORAS INSTALADAS ==================
echo.
wmic printer get name,default,status
echo.
pause
goto IMPRESSORA


:: ---------- LIMPAR FILA DE IMPRESSAO ----------
:LIMPAR_FILA
cls
echo Limpando fila de impressao...
net stop spooler >nul 2>&1
del /q /f %systemroot%\System32\spool\PRINTERS\*.* >nul 2>&1
net start spooler >nul 2>&1
echo.
echo Fila de impressao limpa com sucesso.
timeout /t 2 >nul
goto IMPRESSORA


:: ---------- TESTE DE IMPRESSAO ----------
:TESTE_IMPRESSAO
cls
echo Abrindo pagina de teste da impressora padrao...
rundll32 printui.dll,PrintUIEntry /k
timeout /t 2 >nul
goto IMPRESSORA


:: ---------- REINICIAR SPOOLER ----------
:REINICIAR_SPOOLER
cls
echo Reiniciando servico de impressao...
net stop spooler
net start spooler
timeout /t 2 >nul
goto IMPRESSORA


:: ---------- DISPOSITIVOS E IMPRESSORAS ----------
:DISPOSITIVOS_IMPRESSORA
cls
control printers
goto IMPRESSORA


:: ---------- GERENCIAR DRIVERS ----------
:GERENCIAR_DRIVER
cls
echo Abrindo console de gerenciamento de drivers...
printmanagement.msc
goto IMPRESSORA
:: ==============================
:LIMPEZA_MENU
cls
echo ===== LIMPEZAS DO SISTEMA =====
echo.
echo 1 - Limpar arquivos temporarios
echo 2 - Limpar cache DNS
echo 3 - Limpeza de Disco (Windows)
echo 4 - Limpar PREFETCH
echo 5 - Limpeza completa
echo.
echo 6 - Voltar
echo.

choice /c 123456 /n /m "Opcao: "

if errorlevel 6 goto MENU
if errorlevel 5 goto LIMPEZA_COMPLETA
if errorlevel 4 goto LIMPAR_PREFETCH
if errorlevel 3 cleanmgr
if errorlevel 2 ipconfig /flushdns
if errorlevel 1 goto LIMPAR_TEMP

pause
goto LIMPEZA_MENU

:LIMPAR_TEMP
cls
echo Limpando arquivos temporarios...
del /s /q "%temp%\*" >nul 2>&1
rmdir /s /q "%temp%" >nul 2>&1
mkdir "%temp%" >nul 2>&1
timeout /t 2 >nul
goto LIMPEZA_MENU

:LIMPAR_PREFETCH
cls
echo Limpando PREFETCH...
del /s /q C:\Windows\Prefetch\* >nul 2>&1
timeout /t 2 >nul
goto LIMPEZA_MENU

:LIMPEZA_COMPLETA
cls
echo Executando limpeza completa...
ipconfig /flushdns
del /s /q "%temp%\*" >nul 2>&1
del /s /q C:\Windows\Prefetch\* >nul 2>&1
timeout /t 3 >nul
goto LIMPEZA_MENU

:: ==============================
:UPDATE_MENU
cls
echo ====================== WINDOWS UPDATE ======================
echo.
echo 1 - Abrir configuracoes do Windows Update
echo 2 - Verificar por atualizacoes
echo 3 - Reiniciar servicos do Windows Update
echo 4 - Limpar cache do Windows Update
echo 5 - Ver status dos servicos
echo 6 - Reset completo do Windows Update
echo.
echo 7 - Voltar
echo.
choice /c 1234567 /n /m "Opcao: "

if errorlevel 7 goto MENU
if errorlevel 6 goto RESET_WU
if errorlevel 5 goto STATUS_WU
if errorlevel 4 goto LIMPAR_CACHE_WU
if errorlevel 3 goto REINICIAR_SERVICOS_WU
if errorlevel 2 goto VERIFICAR_WU
if errorlevel 1 goto ABRIR_WU


:: ---------- ABRIR WINDOWS UPDATE ----------
:ABRIR_WU
cls
start ms-settings:windowsupdate
goto UPDATE_MENU


:: ---------- VERIFICAR POR ATUALIZACOES ----------
:VERIFICAR_WU
cls
echo Forcando verificacao de atualizacoes...
powershell -Command "UsoClient StartScan"
timeout /t 3 >nul
goto UPDATE_MENU


:: ---------- REINICIAR SERVICOS ----------
:REINICIAR_SERVICOS_WU
cls
echo Reiniciando servicos do Windows Update...
net stop wuauserv
net stop bits
net stop cryptsvc
net stop msiserver

net start msiserver
net start cryptsvc
net start bits
net start wuauserv

timeout /t 2 >nul
goto UPDATE_MENU


:: ---------- LIMPAR CACHE ----------
:LIMPAR_CACHE_WU
cls
echo Limpando cache do Windows Update...
net stop wuauserv
net stop bits
rd /s /q %systemroot%\SoftwareDistribution
md %systemroot%\SoftwareDistribution
net start bits
net start wuauserv
timeout /t 2 >nul
goto UPDATE_MENU


:: ---------- STATUS DOS SERVICOS ----------
:STATUS_WU
cls
echo Status dos servicos do Windows Update:
echo.
sc query wuauserv
echo.
sc query bits
echo.
sc query cryptsvc
echo.
pause
goto UPDATE_MENU


:: ---------- RESET COMPLETO ----------
:RESET_WU
cls
echo Executando RESET COMPLETO do Windows Update...
net stop wuauserv
net stop bits
net stop cryptsvc
net stop msiserver

Ren %systemroot%\SoftwareDistribution SoftwareDistribution.old
Ren %systemroot%\System32\catroot2 catroot2.old

net start msiserver
net start cryptsvc
net start bits
net start wuauserv

echo.
echo Reset completo finalizado.
timeout /t 3 >nul
goto UPDATE_MENU

:: ==============================
:DEFENDER_MENU
cls
echo ===== WINDOWS DEFENDER =====
echo.
echo 1 - Abrir Seguranca do Windows
echo 2 - Atualizar definicoes
echo 3 - Verificacao rapida
echo.
echo 4 - Voltar
echo.

choice /c 1234 /n /m "Opcao: "

if errorlevel 4 goto MENU
if errorlevel 3 powershell Start-MpScan -ScanType QuickScan
if errorlevel 2 powershell Update-MpSignature
if errorlevel 1 start windowsdefender:

pause
goto DEFENDER_MENU
