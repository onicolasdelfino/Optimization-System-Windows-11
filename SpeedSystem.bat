:: Nome   : Menu.cmd
:: Motivo : Agilizar pequenas ações e funcionalidades.
:: Autor  : Nicolas e github.com/joaovMiranda
:: VERSÃO : 1.4.5

:: Desativando residuos ECHO
@ECHO off

:: Traduzindo para UTF-8
CHCP 65001 > nul

:: Mensagem Inicial
ECHO MSGBOX "PARA TOTAL FUNCIONALIDADE ACONSELHAMOS EXECUTAR O ARQUIVO COMO ADMINISTRADOR",256,"FAST WIN" >%temp%\mensagem1.vbs
START %temp%\mensagem1.vbs

:: Autenticação
CLS
TITLE CONTROLE DE ACESSO
COLOR b
:control
CLS
ECHO  ==========================================
ECHO *   INSIRA A SENHA PARA ATIVAR O PROGRAMA  *
ECHO  ------------------------------------------
ECHO *  - Para mais Informações, acesse a      * 
ECHO *    documentação do repositório GIT raiz  *
ECHO  ==========================================
SET /P "pass=Senha>"  
IF NOT %pass%== admin GOTO fail

:wellcome
CLS
TITLE BEM VINDO
ECHO  				 ==================================
ECHO 				*            BEM VINDO             *
ECHO 				*                                  * 
ECHO 				* Guia:                            *
ECHO 				* - Para total funcionalidade é    *
ECHO 				*   necessário que o programa seja * 
ECHO 				*   executado como administrador.  *
ECHO 				* - Digite um número natural (N*)   * 
ECHO 				*   para selecionar uma das opções.* 
ECHO 				* - Aperte as teclas Ctrl + C para * 
ECHO 				*   abortar uma operação.          *
ECHO 				* - Aperte a tecla Enter para      *
ECHO 				*   continuar as operações         *
ECHO  				+ ================================ + 
ECHO 				*                                  * 
ECHO 				*       MADE BY: Nicolas          * 
ECHO 				*  Copyright (c) 2024 Nicolas     * 
ECHO 				*                                  * 
ECHO  				 ==================================
PAUSE > nul

:: Criando Página Principal 
:menu
	CLS
	TITLE FACILITADOR DE COMANDOS
	COLOR b
	ECHO    USUARIO: %username% 
	ECHO    COMPUTADOR: %computername% 
	ECHO    DATA: %date%   %time%
	ECHO:                                                                      
	ECHO          ----- MENU TAREFAS ----- 
	ECHO     ==================================
	ECHO    * 1.  Informações da Máquina       *
	ECHO    * 2.  Opções de Limpeza            * 
	ECHO    * 3.  Opções de DISCO              * 
	ECHO    * 4.  Opções de Backup             * 
	ECHO    * 5.  Opções de Rede               *
	ECHO    * 6.  Abrir Executáveis            *
	ECHO    * 7.  Reiniciar o Computador       *
	ECHO    * 8.  Desligar o Computador        *
	ECHO    * 9.  Verificar Processos           *
	ECHO    * 10. Visualizar Configurações     *
	ECHO    * 11. GitHub                       *
	ECHO    * 12. Voltar ao Guia               *
	ECHO    * 13. Sair                         *
	ECHO     ==================================

:: Estrutura de Afirmações Para Menu
	SET /p opcao= Escolha uma opção: 
	ECHO ------------------------------
	IF %opcao% EQU 1 GOTO INFO
	IF %opcao% EQU 2 GOTO LIMP
	IF %opcao% EQU 3 GOTO DISCO
	IF %opcao% EQU 4 GOTO BACKUP
	IF %opcao% EQU 5 GOTO REDE
	IF %opcao% EQU 6 GOTO EXE
	IF %opcao% EQU 7 GOTO REINICIAR
	IF %opcao% EQU 8 GOTO DESLIGAR
	IF %opcao% EQU 9 GOTO PROCESSOS
	IF %opcao% EQU 10 GOTO CONFIG
	IF %opcao% EQU 11 GOTO GITHUB
	IF %opcao% EQU 12 GOTO wellcome
	IF %opcao% EQU 13 GOTO EXIT

:: Se menor que 1 ou maior que 13 = Opção inválida
	IF %opcao% LSS 1 GOTO ERROR
	IF %opcao% GTR 13 GOTO ERROR

:: Informações sobre a máquina
:INFO
	CLS
	TITLE INFORMAÇÕES
	COLOR c
	ECHO 				 ==================================
	ECHO 				*           SUA PLACA MÃE          *
	ECHO 				 ==================================
	WMIC baseboard get product, manufacturer, version, serialnumber
	ECHO 				 ==================================
	ECHO 				*        ESQUEMAS DE ENERGIA       *
	ECHO 				 ==================================
	POWERCFG /L 
	ECHO   				 ==================================
	ECHO  				*      INFORMAÇÕES DO SISTEMA      *
	ECHO  				 ==================================
	VOL
	SYSTEMINFO
	SYSTEMINFO > c:\INFO.txt
	ECHO   				 ==================================
	ECHO   				 Arquivo INFO.txt gerado no disco C:
	ECHO   				 ==================================
	PAUSE > nul
	GOTO menu

:: Serviços de limpeza
:LIMP
	CLS
	ECHO MSGBOX "POR SEGURANÇA ACONSELHAMOS CRIAR UM BACK UP ANTES DE PROSSEGUIR",256,"FAST WIN" >%temp%\mensagem2.vbs
	START %temp%\mensagem2.vbs
	TITLE LIMPEZA
	ECHO        ---- MENU DE LIMPEZA ----
	ECHO     ===============================
	ECHO    * 1. Esvaziar a Lixeira         *
	ECHO    * 2. Limpeza Interna            *
	ECHO    * 3. Limpar Arquivos Temporários*
	ECHO    * 4. Limpar Fila de Impressão   *
	ECHO    * 5. Voltar                     *
	ECHO     ===============================
	SET /p limp= Selecione: 

	IF %limp% EQU 1 GOTO limp1
	IF %limp% EQU 2 GOTO limp2
	IF %limp% EQU 3 GOTO limp3
	IF %limp% EQU 4 GOTO limp4
	IF %limp% EQU 5 GOTO limp5

	IF %limp% GTR 5 GOTO limp6
	IF %limp% LSS 1 GOTO limp6

:: Apaga Todos os Arquivos da Lixeira
	:limp1
		CLS
		TITLE LIMPANDO ...
		RD /S /Q C:\$Recycle.bin
		ECHO  ==================================
		ECHO *        Lixeira Esvaziada         *
		ECHO  ==================================
		PAUSE > nul
		GOTO menu

:: Apagando arquivos desnecessários
	:limp2
		TITLE LIMPANDO ARQUIVOS ...
		CLS
		TASKKILL /F /IM wscript.exe
		DEL C:\Windows\System32\CLINT.*.*  /q
		DEL C:\Windows\System32\LOAD.*.*   /q
		DEL C:\Windows\System32\GIF.*.* /q
		DEL c:\windows\spool\printers   /q
		RD /S /Q C:\RECYCLER\ 
		DEL /s   C:\windows\system32\dllcache   /q
		DEL /s   C:\MSOCache\*.*   /q
		SC stop DiagTrack
		SC stop dmwappushservice
		SC Delete DiagTrack
		SC Delete dmwappushservice
		ECHO  ==================================
		ECHO *        Limpeza Concluída         *
		ECHO  ==================================
		PAUSE > nul
		GOTO menu

:: Limpar Arquivos Temporários
	:limp3
		TITLE LIMPANDO ARQUIVOS TEMP...
		CLS
		IF EXIST c:\windows\temp\ ( 
			DEL /f /s /q c:\windows\temp\
			DEL /f /s /q %temp%\
			DEL /s C:\windows\temp\*.* /q 
			DEL /F /S /Q C:\WINDOWS\Temp\*.* 
			DEL "%WINDIR%\Temp\*.*" /F /S /Q 
			RD /S /Q "%HOMEPATH%\Config~1\Temp" 
			MD "%HOMEPATH%\Config~1\Temp" 
			RD /S /Q C:\WINDOWS\Temp\ 
			MD C:\WINDOWS\Temp 
			DEL /F /S /Q %HOMEPATH%\Config~1\Temp\*.* 
			DEL %temp% /q 
		)
		ECHO  ==================================
		ECHO *        Arquivos Temporários Limpas *
		ECHO  ==================================
		PAUSE > nul
		GOTO menu

:: Limpa Fila de Impressão
	:limp4
		TITLE LIMPA FILA DE IMPRESSÃO...
		CLS
		NET STOP SPOLSRV
		DEL %systemroot%\System32\spool\PRINTERS\*.* /q
		NET START SPOLSRV
		ECHO  ==================================
		ECHO *        Fila de Impressão Limpa    *
		ECHO  ==================================
		PAUSE > nul
		GOTO menu

:limp5
	GOTO menu

:limp6
	ECHO  ==================================
	ECHO *           OPÇÃO INVÁLIDA          *
	ECHO  ==================================
	PAUSE > nul
	GOTO limp

:: Opções de Disco
:DISCO
	CLS
	TITLE OPÇÕES DE DISCO
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
	ECHO *        FORMATAÇÃO DE DISCO       *
	ECHO  ==================================
	SET /p drive= Digite a letra da unidade: 
	ECHO ATENÇÃO: Todos os dados serão perdidos. CONTINUAR? (S/N)
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
	ECHO *           OPÇÃO INVÁLIDA          *
	ECHO  ==================================
	PAUSE > nul
	GOTO DISCO

:: Opções de Backup
:BACKUP
	CLS
	ECHO  ==================================
	ECHO *          OPÇÕES DE BACKUP        *
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
	ECHO *           OPÇÃO INVÁLIDA          *
	ECHO  ==================================
	PAUSE > nul
	GOTO BACKUP

:: Criar Backup Completo
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

:: Restaurar Backup
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

:: Opções de Rede
:REDE
	CLS
	ECHO  ==================================
	ECHO *            OPÇÕES DE REDE        *
	ECHO  ==================================
	ECHO    * 1. Ver Configurações de Rede   *
	ECHO    * 2. Reiniciar Adaptador de Rede  *
	ECHO    * 3. Voltar                      *
	ECHO  ==================================
	SET /p rede= Escolha: 

	IF %rede% EQU 1 GOTO ver_rede
	IF %rede% EQU 2 GOTO reiniciar_rede
	IF %rede% EQU 3 GOTO menu

	ECHO  ==================================
	ECHO *           OPÇÃO INVÁLIDA          *
	ECHO  ==================================
	PAUSE > nul
	GOTO REDE

:: Ver Configurações de Rede
:ver_rede
	CLS
	ECHO  ==================================
	ECHO *       CONFIGURAÇÕES DE REDE      *
	ECHO  ==================================
	IPCONFIG /ALL
	PAUSE > nul
	GOTO menu

:: Reiniciar Adaptador de Rede
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

:: Abrir Executáveis
:EXE
	CLS
	ECHO  ==================================
	ECHO *            EXECUTÁVEIS           *
	ECHO  ==================================
	ECHO    * 1. Abrir o Navegador          *
	ECHO    * 2. Abrir o Editor de Texto    *
	ECHO    * 3. Voltar                    *
	ECHO  ==================================
	SET /p exe= Escolha: 

	IF %exe% EQU 1 GOTO abrir_navegador
	IF %exe% EQU 2 GOTO abrir_editor
	IF %exe% EQU 3 GOTO menu

	ECHO  ==================================
	ECHO *           OPÇÃO INVÁLIDA          *
	ECHO  ==================================
	PAUSE > nul
	GOTO EXE

:: Abrir Navegador
:abrir_navegador
	START https://www.google.com
	GOTO menu

:: Abrir Editor de Texto
:abrir_editor
	START notepad
	GOTO menu

:: Reiniciar Computador
:REINICIAR
	CLS
	ECHO  ==================================
	ECHO *          REINICIANDO...         *
	ECHO  ==================================
	SHUTDOWN /R /T 0
	GOTO menu

:: Desligar Computador
:DESLIGAR
	CLS
	ECHO  ==================================
	ECHO *          DESLIGANDO...          *
	ECHO  ==================================
	SHUTDOWN /S /T 0
	GOTO menu

:: Verificar Processos
:PROCESSOS
	CLS
	ECHO  ==================================
	ECHO *         PROCESSOS ATUAIS         *
	ECHO  ==================================
	TASKLIST
	PAUSE > nul
	GOTO menu

:: Visualizar Configurações
:CONFIG
	CLS
	ECHO  ==================================
	ECHO *       CONFIGURAÇÕES DO SISTEMA   *
	ECHO  ==================================
	MSINFO32
	PAUSE > nul
	GOTO menu

:: Acessar GitHub
:GITHUB
	START https://github.com/Nicolas
	GOTO menu

:: Sair do Programa
:EXIT
	ECHO  ==================================
	ECHO *          PROGRAMA ENCERRADO      *
	ECHO  ==================================
	EXIT
