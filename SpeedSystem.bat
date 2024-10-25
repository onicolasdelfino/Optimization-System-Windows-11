@ECHO off
CHCP 65001 > nul
ECHO MSGBOX "PARA TOTAL FUNCIONALIDADE ACONSELHAMOS EXECUTAR O ARQUIVO COMO ADMINISTRADOR",256,"SPEED SYSTEM" > "%temp%\mensagem1.vbs"
START "" "%temp%\mensagem1.vbs"
CLS
TITLE CONTROLE DE ACESSO
COLOR b

SET "username=%USERNAME%"
SET "computername=%COMPUTERNAME%"

:control
CLS
ECHO  ==========================================
ECHO *   INSIRA A SENHA PARA ATIVAR O PROGRAMA  *
ECHO  ------------------------------------------
ECHO *  - Para mais Informações, acesse a       * 
ECHO *    documentação do repositório GIT raiz  *
ECHO  ==========================================
SET /P "pass=Senha> "  
IF "%pass%"=="admin" GOTO welcome
GOTO fail

:fail
CLS
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
ECHO - Para total funcionalidade, execute como administrador.
ECHO - Digite um número para selecionar uma opção.
ECHO - Ctrl + C para abortar e Enter para continuar.
ECHO ==================================
ECHO *       FEITO POR: Nicolas Delfino *
ECHO * Copyright (c) 2024 Nicolas Delfino *
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
ECHO ------------------------------

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
ECHO MSGBOX "POR SEGURANÇA ACONSELHAMOS CRIAR UM BACKUP ANTES DE PROSSEGUIR",256,"SPEED SYSTEM" > "%temp%\mensagem2.vbs"
START "" "%temp%\mensagem2.vbs"
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
ECHO ==================================
ECHO *        Lixeira Esvaziada         *
ECHO ==================================
PAUSE > nul
GOTO LIMP

:limp2
TITLE LIMPANDO ARQUIVOS ...
CLS
TASKKILL /F /IM wscript.exe
DEL /Q C:\Windows\System32\CLINT.*.*
DEL /Q C:\Windows\System32\LOAD.*.*
DEL /Q C:\Windows\System32\GIF.*.*
RD /S /Q C:\RECYCLER\ 
DEL /Q /S C:\windows\system32\dllcache
DEL /Q /S C:\MSOCache\*.*
SC stop DiagTrack
SC stop dmwappushservice
SC delete DiagTrack
SC delete dmwappushservice
ECHO ==================================
ECHO *        Limpeza Concluída         *
ECHO ==================================
PAUSE > nul
GOTO LIMP

:limp3
TITLE LIMPANDO ARQUIVOS TEMP...
CLS
IF EXIST c:\windows\temp\ ( 
    DEL /F /S /Q c:\windows\temp\*
    DEL /F /S /Q %temp%\*
    DEL /Q /S C:\windows\system32\dllcache
    ECHO ==================================
    ECHO *        Arquivos Temporários     *
    ECHO *        Limpos com sucesso!      *
    ECHO ==================================
)
PAUSE > nul
GOTO LIMP

:limp4
TITLE LIMPANDO FILA DE IMPRESSÃO ...
CLS
NET STOP Spooler
DEL /F /S /Q %systemroot%\System32\spool\printers\*.* 
NET START Spooler
ECHO ==================================
ECHO *        Fila de Impressão Limpa   *
ECHO ==================================
PAUSE > nul
GOTO LIMP

:REINICIAR
CLS
ECHO ==================================
ECHO *      Reiniciando...             *
ECHO ==================================
SHUTDOWN /r /t 0
GOTO menu

:DESLIGAR
CLS
ECHO ==================================
ECHO *      Desligando...              *
ECHO ==================================
SHUTDOWN /s /t 0
GOTO menu

:github
CLS
TITLE GITHUB
ECHO ==================================
ECHO *   Acesse o nosso GitHub:        *
ECHO *   https://github.com/nicolasdelfino *
ECHO ==================================
PAUSE > nul
GOTO menu

:EXIT
EXIT
