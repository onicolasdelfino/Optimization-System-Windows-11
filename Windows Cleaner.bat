rem Este script foi escrito por Nicolas Delfino - Publicado em 2024
rem e-mail: delfinonicolas15@gmail.com
cls

@echo off

rem Verifica se o usuário tem privilégios de administrador
timeout /t 1 /nobreak > NUL
openfiles > NUL 2>&1
if %errorlevel%==0 (
    echo Running..
) else (
    echo Você deve executar este script como Administrador. Saindo..
    echo.
    echo Clique com o botão direito sobre mim e selecione ^'Executar como Administrador^' e tente novamente.
    echo.
    echo Pressione qualquer tecla para sair..
    pause > NUL
    exit
)

echo.

rem Deletar arquivos temporários
del /s /f /q %WinDir%\Temp\*.*
del /s /f /q %WinDir%\Prefetch\*.*
del /s /f /q %Temp%\*.*
del /s /f /q %AppData%\Temp\*.*
del /s /f /q %HomePath%\AppData\LocalLow\Temp\*.*

rem Deletar arquivos de drivers usados (não necessário, pois já estão instalados)
del /s /f /q %SYSTEMDRIVE%\AMD\*.*
del /s /f /q %SYSTEMDRIVE%\NVIDIA\*.*
del /s /f /q %SYSTEMDRIVE%\INTEL\*.*

rem Deletar pastas temporárias
rd /s /q %WinDir%\Temp
rd /s /q %WinDir%\Prefetch
rd /s /q %Temp%
rd /s /q %AppData%\Temp
rd /s /q %HomePath%\AppData\LocalLow\Temp

rem Deletar pastas de drivers usados (não necessário, pois já estão instaladas)
rd /s /q %SYSTEMDRIVE%\AMD
rd /s /q %SYSTEMDRIVE%\NVIDIA
rd /s /q %SYSTEMDRIVE%\INTEL

rem Recriar pastas temporárias vazias
md %WinDir%\Temp
md %WinDir%\Prefetch
md %Temp%
md %AppData%\Temp
md %HomePath%\AppData\LocalLow\Temp

echo.
echo Limpeza do Windows concluída! Você pode sair pressionando qualquer tecla.
echo.

pause > NUL
exit
