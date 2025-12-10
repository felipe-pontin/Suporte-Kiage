@echo off
:: Auto elevar
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)


chcp 65001 >nul
title Assistente de Suporte Kiage - TI
color 0B
cls



:menu
cls
echo ██╗  ██╗██╗ █████╗  ██████╗ ███████╗
echo ██║ ██╔╝██║██╔══██╗██╔════╝ ██╔════╝
echo █████╔╝ ██║███████║██║  ███╗█████╗  
echo ██╔═██╗ ██║██╔══██║██║   ██║██╔══╝  
echo ██║  ██╗██║██║  ██║╚██████╔╝███████╗
echo ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝


echo ===============================
echo 1 - Solucoes de Rede
echo 2 - Solucoes de Impressora
echo 3 - Solucoes do Sistema
echo 4 - Windows Update
echo 5 - Windows Defender
echo 6 - Sair
echo ===============================
echo.
choice /c 123456 /n /m "Escolha uma opcao:"

if errorlevel 6 exit
if errorlevel 5 goto defender_menu
if errorlevel 4 goto update_menu
if errorlevel 3 goto sistema_menu
if errorlevel 2 goto impressora_menu
if errorlevel 1 goto rede_menu

:: =============================
:: MENU REDE
:: =============================
:rede_menu
cls
echo ===============================
echo        SOLUCOES DE REDE
echo ===============================
echo 1 - Ver IP
echo 2 - Testar Internet (Ping)
echo 3 - Limpar DNS
echo 4 - Central de Redes
echo 5 - Voltar
echo.
choice /c 12345 /n /m "Escolha:"

if errorlevel 5 goto menu
if errorlevel 4 goto centralrede
if errorlevel 3 goto dns
if errorlevel 2 goto ping
if errorlevel 1 goto ip

:ip
cls
ipconfig
pause
goto rede_menu

:ping
cls
ping google.com
pause
goto rede_menu

:dns
cls
ipconfig /flushdns
pause
goto rede_menu

:centralrede
start ncpa.cpl
goto rede_menu

:: =============================
:: MENU IMPRESSORA
:: =============================
:impressora_menu
cls
echo ===============================
echo     SOLUCOES DE IMPRESSORA
echo ===============================
echo 1 - Reiniciar Spooler
echo 2 - Dispositivos e Impressoras
echo 3 - Configuracoes de Impressoras
echo 4 - Voltar
echo.
choice /c 1234 /n /m "Escolha:"

if errorlevel 4 goto menu
if errorlevel 3 goto printers_settings
if errorlevel 2 goto printers
if errorlevel 1 goto spooler

:spooler
cls
net stop spooler
net start spooler
echo Spooler reiniciado!
pause
goto impressora_menu

:printers
start control printers
goto impressora_menu

:printers_settings
start ms-settings:printers
goto impressora_menu

:: =============================
:: MENU SISTEMA
:: =============================
:sistema_menu
cls
echo ===============================
echo      SOLUCOES DO SISTEMA
echo ===============================
echo 1 - Informacoes do Sistema
echo 2 - Processos em Execucao
echo 3 - Gerenciador de Dispositivos
echo 4 - Voltar
echo.
choice /c 1234 /n /m "Escolha:"

if errorlevel 4 goto menu
if errorlevel 3 goto devmgr
if errorlevel 2 goto processos
if errorlevel 1 goto sysinfo

:sysinfo
systeminfo
pause
goto sistema_menu

:processos
tasklist
pause
goto sistema_menu

:devmgr
devmgmt.msc
goto sistema_menu

:: =============================
:: MENU WINDOWS UPDATE
:: =============================
:update_menu
cls
echo ===============================
echo        WINDOWS UPDATE
echo ===============================
echo 1 - Abrir Windows Update
echo 2 - Reiniciar Servicos
echo 3 - Limpar Cache
echo 4 - Forcar Verificacao
echo 5 - Status dos Servicos
echo 6 - Voltar
echo.
choice /c 123456 /n /m "Escolha:"

if errorlevel 6 goto menu
if errorlevel 5 goto wu_status
if errorlevel 4 goto wu_force
if errorlevel 3 goto wu_clean
if errorlevel 2 goto wu_restart
if errorlevel 1 goto wu_open

:wu_open
start ms-settings:windowsupdate
goto update_menu

:wu_restart
cls
net stop wuauserv
net stop bits
net start bits
net start wuauserv
pause
goto update_menu

:wu_clean
cls
net stop wuauserv
net stop bits
ren C:\Windows\SoftwareDistribution SoftwareDistribution.old
net start bits
net start wuauserv
pause
goto update_menu

:wu_force
cls
wuauclt /detectnow /reportnow
pause
goto update_menu

:wu_status
sc query wuauserv
sc query bits
pause
goto update_menu

:: =============================
:: MENU WINDOWS DEFENDER
:: =============================
:defender_menu
cls
echo ===============================
echo    WINDOWS DEFENDER / SEGURANCA
echo ===============================
echo 1 - Abrir Seguranca do Windows
echo 2 - Atualizar Definicoes
echo 3 - Verificacao Rapida
echo 4 - Verificacao Completa
echo 5 - Status do Defender
echo 6 - Reiniciar Servico
echo 7 - Voltar
echo.
choice /c 1234567 /n /m "Escolha:"

if errorlevel 7 goto menu
if errorlevel 6 goto def_service
if errorlevel 5 goto def_status
if errorlevel 4 goto def_full
if errorlevel 3 goto def_quick
if errorlevel 2 goto def_update
if errorlevel 1 goto def_open

:def_open
start windowsdefender:
goto defender_menu

:def_update
cls
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -SignatureUpdate
pause
goto defender_menu

:def_quick
cls
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 1
pause
goto defender_menu

:def_full
cls
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 2
pause
goto defender_menu

:def_status
cls
sc query WinDefend
pause
goto defender_menu

:def_service
cls
net stop WinDefend
net start WinDefend
pause
goto defender_menu