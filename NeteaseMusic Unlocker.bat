@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B
:gotAdmin
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
if exist "%TEMP%\consoleSettingsBackup.reg" regedit /S "%TEMP%\consoleSettingsBackup.reg"&DEL /F /Q "%TEMP%\consoleSettingsBackup.reg"&goto :mainstart
regedit /S /e "%TEMP%\consoleSettingsBackup.reg" "HKEY_CURRENT_USER\Console"
echo REGEDIT4>"%TEMP%\disablequickedit.reg"
echo [HKEY_CURRENT_USER\Console]>>"%TEMP%\disablequickedit.reg"
(echo "QuickEdit"=dword:00000000)>>"%TEMP%\disablequickedit.reg"
regedit /S "%TEMP%\disablequickedit.reg"
DEL /F /Q "%TEMP%\disablequickedit.reg"
start "" "cmd" /c "%~dpnx0"&exit
:mainstart
chcp 936
cd /d %~dp0files
title NeteaseMusic-Unlocker
mode con lines=30 cols=120
:mouse
cls
echo.
echo.
echo        ###     ## ##      ## ##      ## ###     ## ##        #######   ######  ##    ##  ######## ########
echo        ####    ## ###    ### ##      ## ####    ## ##       ##     ## ##    ## ##   ##   ##       ##     ##
echo        ## ##   ## ####  #### ##      ## ## ##   ## ##       ##     ## ##       ##  ##    ##       ##    ##
echo        ##  ##  ## ## #### ## ##      ## ##  ##  ## ##       ##     ## ##       #####     ######   ########
echo        ##   ## ## ##  ##  ## ##      ## ##   ## ## ##       ##     ## ##       ##  ##    ##       ##   ##
echo        ##    #### ##      ## ##      ## ##    #### ##       ##     ## ##    ## ##   ##   ##       ##    ##
echo        ##     ### ##      ##  ########  ##     ### ########  #######   ######  ##    ##  ######## ##     ##
echo.
echo.
echo                ===================================================================================
echo                          ��Ŀ��ַ��https://github.com/xiaoyv404/NeteaseMusic-Unlocker/
echo                ===================================================================================
echo.
echo.
echo.
echo.
echo                                             ��========================��              
echo                                              ^|                       ^|
echo                                              ^|        ��ʼ����       ^|
echo                                              ^|                       ^|
echo                                             ��========================��
ConsExt /event
set /a xy=%errorlevel%
set /a X=%xy:~0,-3%
set /a Y=%xy%-1000*%X%
if %y% gtr 18 if %y% lss 22 if %x% gtr 44 if %x% lss 70 goto start
goto mouse
:start 
cls
for /f "tokens=2* " %%i in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Netease\cloudmusic" /v "install_dir"') do set software=%%j
if "%software%"=="" ( goto nosoftware ) else ( goto node )
:nosoftware
cls
echo.
echo �޷��Զ���ȡ���������ְ�װĿ¼�����ֶ�����!
echo ��ʽ��C:\Program Files ^(x86^)\Netease\CloudMusic����Ҫ���ţ����Ҫ�ӡ�\��
set /p software=Ŀ¼Ϊ��
echo �������Ŀ¼Ϊ��%software%
echo �����Ƿ���ȷ��
pause
:node
node --version
if %ERRORLEVEL% == 0 ( goto next ) else ( goto nonode )
:nonode
cls
echo.
echo ����д��Node.js
7za.exe x node.7z -aoa -o"%software%"
if %ERRORLEVEL% == 0 ( goto next ) else ( 
    cls
    echo.
    echo ��ѹʧ�ܣ������Ƿ���Ȩ�ޣ�������
    echo ��������˳�...
    pause >nul
    exit
 )
:next
cls
echo.
echo ����д�����ļ�
7za.exe x NMUFiles.7z -aoa -o"%software%"
if %ERRORLEVEL% == 0 ( goto 1 ) else ( 
    cls
    echo.
    echo ��ѹʧ�ܣ������Ƿ���Ȩ�ޣ�������
    echo ��������˳�...
    pause >nul
    exit
 )
:1
echo ���ڴ��������ݷ�ʽ
for /f "tokens=2* " %%i in ('reg query "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Desktop"') do set Dsektop=%%j
del C:\Users\Public\Desktop\����������.lnk
echo set WshShell = WScript.CreateObject("WScript.Shell") >> Shortcut.vbs
echo set oShellLink = WshShell.CreateShortcut("%Dsektop%\����������.lnk") >> Shortcut.vbs
echo oShellLink.TargetPath = "%software%\Start.exe" >> Shortcut.vbs
echo oShellLink.WindowStyle = 1 >> Shortcut.vbs
echo oShellLink.IconLocation = "%software%\cloudmusic.exe, 0" >> Shortcut.vbs
echo oShellLink.Description = "����������" >> Shortcut.vbs
echo oShellLink.WorkingDirectory = "%software%" >> Shortcut.vbs
echo oShellLink.Save >> Shortcut.vbs
Vbs_To_Exe /vbs Shortcut.vbs /exe Shortcut.exe /uac-admin
timeout /t 1 /NOBREAK > nul
start Shortcut.exe
timeout /t 1 /NOBREAK > nul
del Shortcut.vbs
del Shortcut.exe
echo ���ڸ������ô������������
start /B killcloudmusic.bat
"%software%\cloudmusic.exe"
COPY /Y Config C:\Users\"%username%"\AppData\Local\Netease\CloudMusic
cls
echo.
echo �ű�������ɣ�
echo enjoy youself��
echo.
echo ��������˳�...
pause >nul