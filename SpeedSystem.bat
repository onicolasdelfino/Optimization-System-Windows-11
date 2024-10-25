@ECHO off
CHCP 65001 > nul
ECHO MSGBOX "PARA TOTAL FUNCIONALIDADE ACONSELHAMOS EXECUTAR O ARQUIVO COMO ADMINISTRADOR",256,"SPEED SYSTEM" >%temp%\mensagem1.vbs
START %temp%\mensagem1.vbs
CLS
TITLE CONTROLE DE ACESSO
COLOR b
:control
CLS
ECHO  ==========================================
ECHO *   INSIRA A SENHA PARA ATIVAR O PROGRAMA  *
ECHO  ------------------------------------------
ECHO *  - Para mais Informações, acesse a       * 
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
ECHO 				* - Digite um número natural (N*)  * 
ECHO 				*   para selecionar uma das opções.*
ECHO 				* - Aperte as teclas Ctrl + C para * 
ECHO 				*   abortar uma operação.         *
ECHO 				* - Aperte a tecla Enter para      *
ECHO 				*   continuar as operações         *
ECHO  				+ ================================ + 
ECHO 				*                                  * 
ECHO 				*       FEITO POR: Nicolas Delfino *
ECHO 				*  Copyright (c) 2024 Nicolas Delfino * 
ECHO 				*                                  * 
ECHO  				 ==================================
PAUSE > nul
:menu
	CLS
	TITLE FACILITADOR DE COMANDOS
	COLOR b
	ECHO    USUÁRIO: %username% 
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
	ECHO     ==================================
	ECHO    * 9. GitHub                        *
	ECHO    * 10. Voltar ao Guia               *
	ECHO    * 11. Sair                         *
	ECHO     ==================================
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
	IF %opcao% EQU 9 GOTO github
	IF %opcao% EQU 10 GOTO wellcome
	IF %opcao% EQU 11 GOTO EXIT
	IF %opcao% LSS 1 GOTO ERROR
	IF %opcao% GTR 11 GOTO ERROR
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
:LIMP
	CLS
	ECHO MSGBOX "POR SEGURANÇA ACONSELHAMOS CRIAR UM BACKUP ANTES DE PROSSEGUIR",256,"SPEED SYSTEM" >%temp%\mensagem2.vbs
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
:limp1
		CLS
		TITLE LIMPANDO ...
		RD /S /Q C:\$Recycle.bin
		ECHO  ==================================
		ECHO *        Lixeira Esvaziada         *
		ECHO  ==================================
		PAUSE > nul
		GOTO menu
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
:limp3
		TITLE LIMPANDO ARQUIVOS TEMP...
		CLS
		IF EXIST c:\windows\temp\ ( 
			DEL /f /s /q c:\windows\temp\
			DEL /f /s /q %temp%\
			DEL /s C:\windows\system32\dllcache /q
			ECHO  ==================================
			ECHO *        Arquivos Temporários     *
			ECHO *        Limpos com sucesso!      *
			ECHO  ==================================
		)
		PAUSE > nul
		GOTO menu
:limp4
		TITLE LIMPANDO FILA DE IMPRESSÃO ...
		CLS
		NET STOP Spooler
		DEL /F /S /Q %systemroot%\System32\spool\printers\*.* 
		NET START Spooler
		ECHO  ==================================
		ECHO *        Fila de Impressão Limpa   *
		ECHO  ==================================
		PAUSE > nul
		GOTO menu
:REINICIAR
		CLS
		ECHO  ==================================
		ECHO  *      Reiniciando...            *
		ECHO  ==================================
		SHUTDOWN /r /t 0
:GOTO menu
:DESLIGAR
		CLS
		ECHO  ==================================
		ECHO  *      Desligando...             *
		ECHO  ==================================
		SHUTDOWN /s /t 0
:GOTO menu
:github
		CLS
		TITLE GITHUB
		ECHO  ==================================
		ECHO  *   Acesse o nosso GitHub:       *
		ECHO  *   https://github.com/nicolasdelfino *
		ECHO  ==================================
		PAUSE > nul
		GOTO menu
:EXIT
		EXIT
