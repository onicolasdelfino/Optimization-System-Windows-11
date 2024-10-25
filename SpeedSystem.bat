:: Nome   : Menu.cmd
:: Motivo : Agilizar pequenas ações e funcionalidades.
:: Autor  : Nicolas Delfino - github.com/onicolasdelfino
:: VERSÃO : 1.4.6
:: Direitos Autorais: Copyright (c) 2024 Nicolas Delfino

@ECHO off
CHCP 65001 > nul

:: Exibindo mensagem inicial recomendando execução como administrador
ECHO MSGBOX "Para total funcionalidade, aconselhamos executar o arquivo como administrador",256,"FAST WIN" > %temp%\mensagem1.vbs
START %temp%\mensagem1.vbs

CLS
TITLE CONTROLE DE ACESSO
COLOR b
:control
CLS
ECHO ==========================================
ECHO *     INSIRA A SENHA PARA ATIVAR O PROGRAMA   *
ECHO -------------------------------------------
ECHO * Para mais informações, acesse a documentação *
ECHO * do repositório Git no repositório raiz      *
ECHO ==========================================
SET /P "pass=Senha> "  
IF "%pass%" NEQ "admin" (
    ECHO Senha incorreta. Tente novamente.
    PAUSE > nul
    GOTO control
)

:welcome
CLS
TITLE BEM-VINDO
ECHO ========================================
ECHO *              BEM-VINDO                *
ECHO * AUTOR: Nicolas Delfino                *
ECHO * Copyright (c) 2024 Nicolas Delfino    *
ECHO ========================================
PAUSE > nul

:menu
    CLS
    TITLE FACILITADOR DE COMANDOS
    COLOR b
    ECHO USUÁRIO: %username% 
    ECHO COMPUTADOR: %computername% 
    ECHO DATA: %date%   %time%
    ECHO ----- MENU DE TAREFAS -----
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
    SET /p opcao= Escolha uma opção: 

    IF %opcao% EQU 1 GOTO INFO
    IF %opcao% EQU 2 GOTO LIMP
    IF %opcao% EQU 3 GOTO DISCO
    IF %opcao% EQU 4 GOTO BACKUP
    IF %opcao% EQU 5 GOTO REDE
    IF %opcao% EQU 6 GOTO EXE
    IF %opcao% EQU 7 GOTO REINICIAR
    IF %opcao% EQU 8 GOTO DESLIGAR
    IF %opcao% EQU 9 GOTO github
    IF %opcao% EQU 10 GOTO welcome
    IF %opcao% EQU 11 GOTO EXIT

    IF %opcao% LSS 1 GOTO ERROR
    IF %opcao% GTR 11 GOTO ERROR

:INFO
    CLS
    TITLE INFORMAÇÕES
    COLOR c
    ECHO ==================================
    ECHO *           INFORMAÇÕES DO SISTEMA          *
    ECHO ==================================
    WMIC baseboard get product, manufacturer, version, serialnumber
    POWERCFG /L 
    SYSTEMINFO
    SYSTEMINFO > c:\INFO.txt
    ECHO ==================================
    ECHO Arquivo INFO.txt gerado no disco C:
    ECHO ==================================
    PAUSE > nul
    GOTO menu

:LIMP
    CLS
    ECHO MSGBOX "Por segurança, aconselhamos criar um backup antes de prosseguir",256,"FAST WIN" > %temp%\mensagem2.vbs
    START %temp%\mensagem2.vbs
    TITLE LIMPEZA
    ECHO ---- MENU DE LIMPEZA ----
    ECHO ===============================
    ECHO * 1. Esvaziar a Lixeira         *
    ECHO * 2. Limpeza Interna            *
    ECHO * 3. Limpar Arquivos Temporários*
    ECHO * 4. Limpar Fila de Impressão   *
    ECHO * 5. Voltar                     *
    ECHO ===============================
    SET /p limp= Selecione: 

    IF %limp% EQU 1 GOTO limp1
    IF %limp% EQU 2 GOTO limp2
    IF %limp% EQU 3 GOTO limp3
    IF %limp% EQU 4 GOTO limp4
    IF %limp% EQU 5 GOTO menu

    IF %limp% GTR 5 GOTO invalid_choice
    IF %limp% LSS 1 GOTO invalid_choice

    :limp1
        CLS
        TITLE LIMPANDO ...
        RD /S /Q C:\$Recycle.bin
        ECHO ==================================
        ECHO *        Lixeira Esvaziada         *
        ECHO ==================================
        PAUSE > nul
        GOTO menu

    :limp2
        TITLE LIMPANDO ARQUIVOS ...
        CLS
        TASKKILL /F /IM wscript.exe
        DEL C:\Windows\System32\CLINT.*.*  /q
        DEL C:\Windows\System32\LOAD.*.*   /q
        DEL C:\Windows\System32\GIF.*.*    /q
        DEL C:\windows\spool\printers\*.*  /q
        RD /S /Q C:\RECYCLER\ 
        DEL /s C:\windows\system32\dllcache\*.* /q
        DEL /s C:\MSOCache\*.*              /q
        SC stop DiagTrack
        SC stop dmwappushservice
        SC delete DiagTrack
        SC delete dmwappushservice
        ECHO ==================================
        ECHO *        Limpeza Concluída         *
        ECHO ==================================
        PAUSE > nul
        GOTO menu

    :limp3
        TITLE LIMPANDO ARQUIVOS TEMP...
        CLS
        IF EXIST C:\windows\temp\ (
            DEL /f /s /q C:\windows\temp\
            DEL /f /s /q %temp%\
            DEL /s C:\windows\temp\*.* /q 
            RD /S /Q "%HOMEPATH%\Config~1\Temp"
            MD "%HOMEPATH%\Config~1\Temp"
            RD /S /Q C:\windows\Temp\
            MD C:\windows\Temp
        )
        ECHO ==================================
        ECHO *        Limpeza Concluída         *
        ECHO ==================================
        PAUSE > nul
        GOTO menu

    :limp4
        CLS
        NET STOP spooler
        CD %systemroot%\system32\spool\printers
        DEL /F /S *.shd
        DEL /F /S *.spl
        NET START spooler
        ECHO =======================================
        ECHO +          Processo Finalizado          +
        ECHO =======================================
        PAUSE > nul
        GOTO menu

:EXIT
CLS
ECHO ==================================
ECHO *   Saindo do programa...        *
ECHO ==================================
PAUSE > nul
EXIT
