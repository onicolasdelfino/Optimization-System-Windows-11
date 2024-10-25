@ECHO off
CHCP 65001 > nul
TITLE iDWeb - Soluções™

:: Verificar versão do Windows (Windows 10 ou 11)
FOR /F "tokens=2 delims==" %%I IN ('wmic os get Caption /value') DO SET "OSVer=%%I"
IF NOT "%OSVer%"=="" (
    ECHO Versão do Windows detectada: %OSVer%
    ECHO %OSVer% | FINDSTR /I "Windows 10" >nul && GOTO control
    ECHO %OSVer% | FINDSTR /I "Windows 11" >nul && GOTO control
)

ECHO Este script requer Windows 10 ou 11. Saindo...
TIMEOUT /nobreak /t 5 > nul
EXIT /B

:control
CLS
SET "username=%USERNAME%"
SET "computername=%COMPUTERNAME%"

ECHO ==========================================
ECHO *   INSIRA A SENHA PARA ATIVAR O PROGRAMA  *
ECHO ==========================================
SET /P "pass=Senha> "  
IF "%pass%"=="admin" GOTO welcome
ECHO Senha incorreta. Tente novamente.
PAUSE > nul
GOTO control

:welcome
CLS
TITLE BEM VINDO
ECHO ==================================
ECHO *            BEM VINDO            *
ECHO ==================================
ECHO Guia:
ECHO - Digite um número para selecionar uma opção.
ECHO ==================================
ECHO *       FEITO POR: Nicolas Delfino *
ECHO ==================================
PAUSE > nul
GOTO menu

:menu
CLS
TITLE FACILITADOR DE COMANDOS
COLOR b
ECHO USUÁRIO: %username%
ECHO COMPUTADOR: %computername%
ECHO DATA: %date%   %time%
ECHO:
ECHO ----- MENU TAREFAS -----
ECHO ==================================
ECHO * 1.  Informações da Máquina       *
ECHO * 2.  Opções de Limpeza            * 
ECHO * 3.  Opções de Disco              * 
ECHO * 4.  Opções de Backup             * 
ECHO * 5.  Opções de Rede               *
ECHO * 6.  Abrir Executáveis            *
ECHO * 7.  Reiniciar o Computador       *
ECHO * 8.  Desligar o Computador        *
ECHO ==================================
ECHO * 9. GitHub                        *
ECHO * 10. Voltar ao Guia               *
ECHO * 11. Sair                         *
ECHO ==================================
SET /P "opcao=Escolha uma opção: "

IF "%opcao%"=="1" GOTO INFO
IF "%opcao%"=="2" GOTO LIMP
IF "%opcao%"=="3" GOTO DISCO
IF "%opcao%"=="4" GOTO BACKUP
IF "%opcao%"=="5" GOTO REDE
IF "%opcao%"=="6" GOTO EXE
IF "%opcao%"=="7" GOTO REINICIAR
IF "%opcao%"=="8" GOTO DESLIGAR
IF "%opcao%"=="9" GOTO github
IF "%opcao%"=="10" GOTO welcome
IF "%opcao%"=="11" GOTO EXIT

ECHO Opção inválida! Tente novamente.
PAUSE > nul
GOTO menu

:INFO
CLS
TITLE INFORMAÇÕES
COLOR c
ECHO ==================================
ECHO *           SUA PLACA MÃE         *
ECHO ==================================
WMIC baseboard get product, manufacturer, version, serialnumber
ECHO ==================================
ECHO *       ESQUEMAS DE ENERGIA       *
ECHO ==================================
POWERCFG /L 
ECHO ==================================
ECHO *     INFORMAÇÕES DO SISTEMA      *
ECHO ==================================
SYSTEMINFO > c:\INFO.txt
ECHO Arquivo INFO.txt gerado no disco C:
PAUSE > nul
GOTO menu

:LIMP
CLS
TITLE LIMPEZA
ECHO ---- MENU DE LIMPEZA ----
ECHO ===============================
ECHO * 1. Esvaziar a Lixeira         *
ECHO * 2. Limpeza Interna            *
ECHO * 3. Limpar Arquivos Temporários*
ECHO * 4. Limpar Fila de Impressão   *
ECHO * 5. Voltar                     *
ECHO ===============================
SET /P "limp=Selecione: "
IF "%limp%"=="1" GOTO limp1
IF "%limp%"=="2" GOTO limp2
IF "%limp%"=="3" GOTO limp3
IF "%limp%"=="4" GOTO limp4
IF "%limp%"=="5" GOTO menu

ECHO Opção inválida! Tente novamente.
PAUSE > nul
GOTO LIMP

:limp1
CLS
TITLE LIMPANDO ...
RD /S /Q C:\$Recycle.bin
ECHO Lixeira Esvaziada
PAUSE > nul
GOTO LIMP

:limp2
TITLE LIMPANDO ARQUIVOS ...
CLS
TASKKILL /F /IM wscript.exe >nul 2>&1
DEL /Q C:\Windows\System32\CLINT.*.* >nul 2>&1
DEL /Q C:\Windows\System32\LOAD.*.* >nul 2>&1
DEL /Q C:\Windows\System32\GIF.*.* >nul 2>&1
RD /S /Q C:\RECYCLER\ >nul 2>&1
DEL /Q /S C:\windows\system32\dllcache >nul 2>&1
DEL /Q /S C:\MSOCache\*.* >nul 2>&1
SC stop DiagTrack >nul 2>&1
SC stop dmwappushservice >nul 2>&1
SC delete DiagTrack >nul 2>&1
SC delete dmwappushservice >nul 2>&1
ECHO Limpeza Concluída
PAUSE > nul
GOTO LIMP

:limp3
TITLE LIMPANDO ARQUIVOS TEMP...
CLS
IF EXIST c:\windows\temp\ ( 
    DEL /F /S /Q c:\windows\temp\* >nul 2>&1
    DEL /F /S /Q %temp%\* >nul 2>&1
    DEL /Q /S C:\windows\system32\dllcache >nul 2>&1
    ECHO Arquivos Temporários Limpos
)
PAUSE > nul
GOTO LIMP

:limp4
TITLE LIMPANDO FILA DE IMPRESSÃO ...
CLS
NET STOP Spooler >nul
DEL /F /S /Q %systemroot%\System32\spool\printers\*.* >nul
NET START Spooler >nul
ECHO Fila de Impressão Limpa
PAUSE > nul
GOTO LIMP

:REINICIAR
CLS
ECHO Reiniciando...
SHUTDOWN /r /t 0
GOTO menu

:DESLIGAR
CLS
ECHO Desligando...
SHUTDOWN /s /t 0
GOTO menu

:github
CLS
TITLE GITHUB
ECHO Acesse o nosso GitHub: https://github.com/nicolasdelfino
PAUSE > nul
GOTO menu

:EXIT
EXIT
