:: Nome   : SpeedSystem.bat
:: Motivo : Agilizar pequenas acoes e funcionalidades.
:: Autor  : https://github.com/onicolasdelfino
:: VERSAO : 1.0.0

@echo off
:: Autenticacao
CLS
TITLE CONTROLE DE ACESSO
COLOR b
:control
CLS
ECHO  ==========================================
ECHO *   INSIRA A SENHA PARA ATIVAR O PROGRAMA  *
ECHO  ==========================================
SET /P "pass=Senha>"  
IF NOT "%pass%"=="admin" GOTO fail

:: Tela de Boas Vindas
:welcome
CLS
TITLE BEM VINDO
ECHO  =======================================
ECHO  *        SEJA MUITO BEM-VINDO        *
ECHO  *                                    * 
ECHO  * Guia:                              *
ECHO  * - Para total funcionalidade e      *
ECHO  *   necessario que o programa seja   * 
ECHO  *   executado como administrador.    *
ECHO  * - Digite um numero natural (N*)    * 
ECHO  *   para selecionar uma das opcoes.  * 
ECHO  * - Aperte as teclas Ctrl + C para   * 
ECHO  *   abortar uma operacao.            *
ECHO  =======================================
ECHO  *                                    * 
ECHO  *     MADE BY: Nicolas Delfino       * 
ECHO  * Copyright (c) 2024 Nicolas Delfino * 
ECHO  =======================================
PAUSE > nul

:: Menu Principal
:menu
CLS
ECHO  ==================================
ECHO *          MENU PRINCIPAL         *
ECHO  ==================================
ECHO * 1. Limpar Cache                 *
ECHO * 2. Limpar Fila de Impressao     *
ECHO * 3. Opcoes de Disco              *
ECHO * 4. Opcoes de Backup             *
ECHO * 5. Opcoes de Rede               *
ECHO * 6. Abrir Executaveis            *
ECHO * 7. Reiniciar Computador         *
ECHO * 8. Desligar Computador          *
ECHO * 9. Verificar Processos          *
ECHO * 10. Visualizar Configuracoes    *
ECHO * 11. Acessar GitHub              *
ECHO * 12. Sair                        *
ECHO  ==================================
SET /p "escolha=Selecione uma opcao: "

IF "%escolha%"=="1" GOTO limp1
IF "%escolha%"=="2" GOTO limp4
IF "%escolha%"=="3" GOTO DISCO
IF "%escolha%"=="4" GOTO BACKUP
IF "%escolha%"=="5" GOTO REDE
IF "%escolha%"=="6" GOTO EXE
IF "%escolha%"=="7" GOTO REINICIAR
IF "%escolha%"=="8" GOTO DESLIGAR
IF "%escolha%"=="9" GOTO PROCESSOS
IF "%escolha%"=="10" GOTO CONFIG
IF "%escolha%"=="11" GOTO GITHUB
IF "%escolha%"=="12" EXIT

ECHO  ==================================
ECHO *           OPCAO INVALIDA          *
ECHO  ==================================
PAUSE > nul
GOTO menu

:: Sistema de Limpeza 01
:limp1
TITLE LIMPA CACHE...
CLS
ECHO  ==================================
ECHO *        CACHE LIMPO              *
ECHO  ==================================
DEL /q /f "%temp%\*.*"
ECHO  ==================================
ECHO *        Arquivos Temporarios Limpos *
ECHO  ==================================
PAUSE > nul
GOTO menu

:: Sistema de Limpeza 02
:limp4
TITLE LIMPA FILA DE IMPRESSAO...
CLS
NET STOP SPOOLER
DEL /q "%systemroot%\System32\spool\PRINTERS\*.*"
NET START SPOOLER
ECHO  ==================================
ECHO *        Fila de Impressao Limpa    *
ECHO  ==================================
PAUSE > nul
GOTO menu

:: Menu de Disco
:DISCO
CLS
TITLE OPCOES DE DISCO
ECHO  ---- MENU DE DISCO ----
ECHO  ===============================
ECHO * 1. Checar Disco               *
ECHO * 2. Formatar Disco             *
ECHO * 3. Ver Uso do Disco           *
ECHO * 4. Voltar                     *
ECHO  ===============================
SET /p "disco=Selecione: "

IF "%disco%"=="1" GOTO checar_disco
IF "%disco%"=="2" GOTO formatar_disco
IF "%disco%"=="3" GOTO uso_disco
IF "%disco%"=="4" GOTO menu

ECHO  ==================================
ECHO *           OPCAO INVALIDA          *
ECHO  ==================================
PAUSE > nul
GOTO DISCO

:checar_disco
CLS
ECHO  ==================================
ECHO *        CHECANDO O DISCO...      *
ECHO  ==================================
CHKDSK C: /f /r
PAUSE > nul
GOTO menu

:formatar_disco
CLS
ECHO  ==================================
ECHO *        FORMATACAO DE DISCO       *
ECHO  ==================================
SET /p "drive=Digite a letra da unidade: "
ECHO ATENCAO: Todos os dados serao perdidos. CONTINUAR? (S/N)
SET /p "confirma=Escolha: "
IF /I "%confirma%" NEQ "S" GOTO menu
FORMAT %drive%: /FS:NTFS
PAUSE > nul
GOTO menu

:uso_disco
CLS
ECHO  ==================================
ECHO *   USO DO DISCO EM C:            *
ECHO  ==================================
DIR C:
PAUSE > nul
GOTO menu

:: Sistema de Backup
:BACKUP
CLS
ECHO  ==================================
ECHO *          OPCOES DE BACKUP        *
ECHO  ==================================
ECHO * 1. Criar Backup Completo         *
ECHO * 2. Restaurar Backup              *
ECHO * 3. Voltar                        *
ECHO  ==================================
SET /p "backup=Escolha: "

IF "%backup%"=="1" GOTO criar_backup
IF "%backup%"=="2" GOTO restaurar_backup
IF "%backup%"=="3" GOTO menu

ECHO  ==================================
ECHO *           OPCAO INVALIDA          *
ECHO  ==================================
PAUSE > nul
GOTO BACKUP

:criar_backup
CLS
TITLE CRIANDO BACKUP...
MD C:\Backup
XCOPY C:\* C:\Backup\* /E /H /C /I
ECHO  ==================================
ECHO *         BACKUP COMPLETO CRIADO   *
ECHO  ==================================
PAUSE > nul
GOTO menu

:restaurar_backup
CLS
TITLE RESTAURANDO BACKUP...
ECHO  ==================================
ECHO *       RESTAURANDO BACKUP...      *
ECHO  ==================================
ROBOCOPY C:\Backup C:\ /E
ECHO  ==================================
ECHO *         BACKUP RESTAURADO         *
ECHO  ==================================
PAUSE > nul
GOTO menu

:: Sistema de Rede
:REDE
CLS
ECHO  ==================================
ECHO *            OPCOES DE REDE        *
ECHO  ==================================
ECHO * 1. Ver Configuracoes de Rede     *
ECHO * 2. Reiniciar Adaptador de Rede   *
ECHO * 3. Voltar                        *
ECHO  ==================================
SET /p "rede=Escolha: "

IF "%rede%"=="1" GOTO ver_rede
IF "%rede%"=="2" GOTO reiniciar_rede
IF "%rede%"=="3" GOTO menu

ECHO  ==================================
ECHO *           OPCAO INVALIDA          *
ECHO  ==================================
PAUSE > nul
GOTO REDE

:ver_rede
CLS
ECHO  ==================================
ECHO *       CONFIGURACOES DE REDE      *
ECHO  ==================================
IPCONFIG /ALL
PAUSE > nul
GOTO menu

:reiniciar_rede
CLS
ECHO  ==================================
ECHO *   REINICIANDO ADAPTADOR DE REDE  *
ECHO  ==================================
NETSH INTERFACE SET INTERFACE "Nome do Adaptador" DISABLED
NETSH INTERFACE SET INTERFACE "Nome do Adaptador" ENABLED
ECHO  ==================================
ECHO *         ADAPTADOR REINICIADO      *
ECHO  ==================================
PAUSE > nul
GOTO menu

:EXE
CLS
ECHO  ==================================
ECHO *            EXECUTAVEIS           *
ECHO  ==================================
ECHO * 1. Abrir o Navegador             *
ECHO * 2. Abrir o Editor de Texto       *
ECHO * 3. Voltar                        *
ECHO  ==================================
SET /p "exe=Escolha: "

IF "%exe%"=="1" START chrome.exe
IF "%exe%"=="2" START notepad.exe
IF "%exe%"=="3" GOTO menu

ECHO  ==================================
ECHO *           OPCAO INVALIDA          *
ECHO  ==================================
PAUSE > nul
GOTO EXE

:REINICIAR
CLS
ECHO  ==================================
ECHO *      REINICIANDO O COMPUTADOR     *
ECHO  ==================================
SHUTDOWN /r /t 0
PAUSE > nul
GOTO menu

:DESLIGAR
CLS
ECHO  ==================================
ECHO *       DESLIGANDO O COMPUTADOR      *
ECHO  ==================================
SHUTDOWN /s /t 0
PAUSE > nul
GOTO menu

:PROCESSOS
CLS
ECHO  ==================================
ECHO *        VERIFICANDO PROCESSOS      *
ECHO  ==================================
TASKLIST
PAUSE > nul
GOTO menu

:CONFIG
CLS
ECHO  ==================================
ECHO *        VISUALIZANDO CONFIGURACOES *
ECHO  ==================================
REG QUERY "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
PAUSE > nul
GOTO menu

:GITHUB
CLS
ECHO  ==================================
ECHO *           ACESSANDO GITHUB       *
ECHO  ==================================
START https://github.com/onicolasdelfino
PAUSE > nul
GOTO menu

:fail
ECHO  ==================================
ECHO *            ACESSO NEGADO           *
ECHO  ==================================
PAUSE > nul
EXIT
