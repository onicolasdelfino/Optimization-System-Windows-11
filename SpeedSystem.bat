:: Nome   : Menu.cmd
:: Motivo : Agilizar pequenas ações e funcionalidades.
:: Autor  : https://github.com/onicolasdelfino
:: VERSÃO : 1.0.0

@echo off
:: Autenticacao
CLS
TITLE CONTROLE DE ACESSO
COLOR b
:control
CLS
ECHO  ==========================================
ECHO *   INSIRA A SENHA PARA ATIVAR O PROGRAMA  *
ECHO  ------------------------------------------
ECHO *  - Para mais Informacoes, acesse a      * 
ECHO *    documentacao do repositorio GIT raiz  *
ECHO  ==========================================
SET /P "pass=Senha>"  
IF NOT %pass%== admin GOTO fail

:: Tela de Boas Vindas
:wellcome
CLS
TITLE BEM VINDO
ECHO  			======================================
ECHO 				*        SEJA MUITO BEM-VINDO        *
ECHO 				*                                    * 
ECHO 				* Guia:                              *
ECHO 				* - Para total funcionalidade e      *
ECHO 				*   necessario que o programa seja   * 
ECHO 				*   executado como administrador.    *
ECHO 				* - Digite um numero natural (N*)    * 
ECHO 				*   para selecionar uma das opcoes.  * 
ECHO 				* - Aperte as teclas Ctrl + C para   * 
ECHO 				*   abortar uma operacao.            *
ECHO  			+ ================================== + 
ECHO 				*                                    * 
ECHO 				*     MADE BY: Nicolas Delfino       * 
ECHO 				* Copyright (c) 2024 Nicolas Delfino * 
ECHO 				*                                    * 
ECHO  			======================================
PAUSE > nul

:: Menu Principal
:menu
cls
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
SET /p escolha= Selecione uma opcao: 

IF %escolha% EQU 1 GOTO limp1
IF %escolha% EQU 2 GOTO limp4
IF %escolha% EQU 3 GOTO DISCO
IF %escolha% EQU 4 GOTO BACKUP
IF %escolha% EQU 5 GOTO REDE
IF %escolha% EQU 6 GOTO EXE
IF %escolha% EQU 7 GOTO REINICIAR
IF %escolha% EQU 8 GOTO DESLIGAR
IF %escolha% EQU 9 GOTO PROCESSOS
IF %escolha% EQU 10 GOTO CONFIG
IF %escolha% EQU 11 GOTO GITHUB
IF %escolha% EQU 12 EXIT

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
DEL /q /f %temp%\*.* 
ECHO  ==================================
ECHO *        Arquivos Temporarios Limpos *
ECHO  ==================================
PAUSE > nul
GOTO menu

:: Sistema de Limpeza 02
:limp4
TITLE LIMPA FILA DE IMPRESSAO...
CLS
NET STOP SPOLSRV
DEL %systemroot%\System32\spool\PRINTERS\*.* /q
NET START SPOLSRV
ECHO  ==================================
ECHO *        Fila de Impressao Limpa    *
ECHO  ==================================
PAUSE > nul
GOTO menu

:: Sistema de Limpeza 03
:limp5
GOTO menu

:: Sistema de Limpeza 04
:limp6
ECHO  ==================================
ECHO *           OPCAO INVALIDA          *
ECHO  ==================================
PAUSE > nul
GOTO limp

:: Menu de Disco
:DISCO
CLS
TITLE OPCOES DE DISCO
ECHO        ---- MENU DE DISCO ----
ECHO     ===============================
ECHO    * 1. Checar Disco                 *
ECHO    * 2. Formatar Disco                *
ECHO    * 3. Ver Uso do Disco              *
ECHO    * 4. Voltar                        *
ECHO     ===============================
SET /p disco= Selecione: 

IF %disco% EQU 1 GOTO checar_disco
IF %disco% EQU 2 GOTO formatar_disco
IF %disco% EQU 3 GOTO uso_disco
IF %disco% EQU 4 GOTO menu

IF %disco% GTR 4 GOTO disco_error
IF %disco% LSS 1 GOTO disco_error

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
SET /p drive= Digite a letra da unidade: 
ECHO ATENCAO: Todos os dados serao perdidos. CONTINUAR? (S/N)
SET /p confirma= Escolha: 
IF /I "%confirma%" NEQ "S" GOTO menu
FORMAT %drive%: /FS:NTFS
PAUSE > nul
GOTO menu

:uso_disco
CLS
ECHO  ==================================
ECHO *   USO DO DISCO EM C:            *
ECHO  ==================================
DISKCOPY C: 
PAUSE > nul
GOTO menu

:disco_error
ECHO  ==================================
ECHO *           OPCAO INVALIDA          *
ECHO  ==================================
PAUSE > nul
GOTO DISCO

:: Sistema de Backup
:BACKUP
CLS
ECHO  ==================================
ECHO *          OPCOES DE BACKUP        *
ECHO  ==================================
ECHO    * 1. Criar Backup Completo       *
ECHO    * 2. Restaurar Backup            *
ECHO    * 3. Voltar                      *
ECHO  ==================================
SET /p backup= Escolha: 

IF %backup% EQU 1 GOTO criar_backup
IF %backup% EQU 2 GOTO restaurar_backup
IF %backup% EQU 3 GOTO menu

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
ECHO    * 1. Ver Configuracoes de Rede   *
ECHO    * 2. Reiniciar Adaptador de Rede  *
ECHO    * 3. Voltar                      *
ECHO  ==================================
SET /p rede= Escolha: 

IF %rede% EQU 1 GOTO ver_rede
IF %rede% EQU 2 GOTO reiniciar_rede
IF %rede% EQU 3 GOTO menu

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
ECHO    * 1. Abrir o Navegador          *
ECHO    * 2. Abrir o Editor de Texto    *
ECHO    * 3. Voltar                    *
ECHO  ==================================
SET /p exe= Escolha: 

IF %exe% EQU 1 START chrome.exe
IF %exe% EQU 2 START notepad.exe
IF %exe% EQU 3 GOTO menu

ECHO  ==================================
ECHO *           OPCAO INVALIDA          *
ECHO  ==================================
PAUSE > nul
GOTO EXE

:REINICIAR
CLS
ECHO  ==================================
ECHO *        REINICIANDO O PC...      *
ECHO  ==================================
shutdown /r /t 0
GOTO menu

:DESLIGAR
CLS
ECHO  ==================================
ECHO *        DESLIGANDO O PC...       *
ECHO  ==================================
shutdown /s /t 0
GOTO menu

:PROCESSOS
CLS
ECHO  ==================================
ECHO *         VERIFICANDO PROCESSOS    *
ECHO  ==================================
TASKLIST
PAUSE > nul
GOTO menu

:CONFIG
CLS
ECHO  ==================================
ECHO *         CONFIGURACOES DO SISTEMA *
ECHO  ==================================
ECHO * Para mais Informacoes sobre       *
ECHO * as configuracoes, consulte a     *
ECHO * documentacao do sistema.          *
ECHO  ==================================
PAUSE > nul
GOTO menu

:GITHUB
CLS
ECHO  ==================================
ECHO *           ACESSANDO GITHUB       *
ECHO  ==================================
START https://github.com/onicolasdelfino
GOTO menu

:fail
ECHO  ==================================
ECHO *         SENHA INCORRETA!         *
ECHO  ==================================
PAUSE > nul
GOTO control
