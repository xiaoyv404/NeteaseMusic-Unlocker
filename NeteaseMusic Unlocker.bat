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
echo                          项目地址：https://github.com/xiaoyv404/NeteaseMusic-Unlocker/
echo                ===================================================================================
echo.
echo.
echo.
echo.
echo                                             ┍========================┓              
echo                                              ^|                       ^|
echo                                              ^|        开始部署       ^|
echo                                              ^|                       ^|
echo                                             ┖========================┙
ConsExt /event
set /a xy=%errorlevel%
set /a X=%xy:~0,-3%
set /a Y=%xy%-1000*%X%
if %y% gtr 18 if %y% lss 22 if %x% gtr 44 if %x% lss 70 goto start
goto mouse
:start 
cls
for /f "tokens=2* " %%i in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Netease\cloudmusic" /v "install_dir"') do set software=%%j
for /f "tokens=2* " %%i in ('reg query "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /v "Desktop"') do set Dsektop=%%j
if "%software%"=="" ( goto nosoftware ) else ( goto node )
:nosoftware
cls
echo.
echo 无法自动获取网易云音乐安装目录，请手动输入!
echo 格式如C:\Program Files ^(x86^)\Netease\CloudMusic，不要引号，最后不要加“\”
set /p software=目录为：
echo 您输入的目录为：%software%
echo 请检查是否正确！
pause
:node
node --version
if %ERRORLEVEL% == 0 ( goto next ) else ( goto nonode )
:nonode
echo.
echo 正在写入Node.js
7za.exe x node.7z -aoa -o"%software%"
if %ERRORLEVEL% == 0 ( goto next ) else ( 
    cls
    echo.
    echo 解压失败，请检查是否有权限，并重试
    echo 按任意键退出...
    pause >nul
    exit
 )
:next
echo.
echo 正在写入主文件
7za.exe x NMUFiles.7z -aoa -o"%software%"
if %ERRORLEVEL% == 0 ( goto 1 ) else ( 
    cls
    echo.
    echo 解压失败，请检查是否有权限，并重试
    echo 按任意键退出...
    pause >nul
    exit
 )
:1
echo 正在创建桌面快捷方式
del "C:\Users\Public\Desktop\网易云音乐.lnk"
del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\网易云音乐.lnk"
del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\网易云音乐\网易云音乐.lnk"
echo set WshShell = WScript.CreateObject("WScript.Shell") >> Shortcut1.vbs
echo set oShellLink = WshShell.CreateShortcut("%Dsektop%\网易云音乐.lnk") >> Shortcut1.vbs
echo oShellLink.TargetPath = "%software%\Start.exe" >> Shortcut1.vbs
echo oShellLink.WindowStyle = 1 >> Shortcut1.vbs
echo oShellLink.IconLocation = "%software%\cloudmusic.exe, 0" >> Shortcut1.vbs
echo oShellLink.Description = "网易云音乐" >> Shortcut1.vbs
echo oShellLink.WorkingDirectory = "%software%" >> Shortcut1.vbs
echo oShellLink.Save >> Shortcut1.vbs
echo set WshShell = WScript.CreateObject("WScript.Shell") >> Shortcut2.vbs
echo set oShellLink = WshShell.CreateShortcut("C:\ProgramData\Microsoft\Windows\Start Menu\Programs\网易云音乐.lnk") >> Shortcut2.vbs
echo oShellLink.TargetPath = "%software%\Start.exe" >> Shortcut2.vbs
echo oShellLink.WindowStyle = 1 >> Shortcut2.vbs
echo oShellLink.IconLocation = "%software%\cloudmusic.exe, 0" >> Shortcut2.vbs
echo oShellLink.Description = "网易云音乐" >> Shortcut2.vbs
echo oShellLink.WorkingDirectory = "%software%" >> Shortcut2.vbs
echo oShellLink.Save >> Shortcut2.vbs
echo set WshShell = WScript.CreateObject("WScript.Shell") >> Shortcut3.vbs
echo set oShellLink = WshShell.CreateShortcut("C:\ProgramData\Microsoft\Windows\Start Menu\Programs\网易云音乐\网易云音乐.lnk") >> Shortcut3.vbs
echo oShellLink.TargetPath = "%software%\Start.exe" >> Shortcut3.vbs
echo oShellLink.WindowStyle = 1 >> Shortcut3.vbs
echo oShellLink.IconLocation = "%software%\cloudmusic.exe, 0" >> Shortcut3.vbs
echo oShellLink.Description = "网易云音乐" >> Shortcut3.vbs
echo oShellLink.WorkingDirectory = "%software%" >> Shortcut3.vbs
echo oShellLink.Save >> Shortcut3.vbs
Vbs_To_Exe /vbs Shortcut1.vbs /exe Shortcut1.exe /uac-admin
Vbs_To_Exe /vbs Shortcut2.vbs /exe Shortcut2.exe /uac-admin
Vbs_To_Exe /vbs Shortcut3.vbs /exe Shortcut3.exe /uac-admin
timeout /t 5 /NOBREAK > nul
start Shortcut1.exe
start Shortcut2.exe
start Shortcut3.exe
timeout /t 3 /NOBREAK > nul
del Shortcut1.vbs
del Shortcut2.vbs
del Shortcut3.vbs
del Shortcut1.exe
del Shortcut2.exe
del Shortcut3.exe
echo 正在更改设置代理服务器设置
start /B killcloudmusic.bat
"%software%\cloudmusic.exe"
COPY /Y Config C:\Users\"%username%"\AppData\Local\Netease\CloudMusic
cls
echo.
echo 脚本运行完成！
echo enjoy youself！
echo.
echo 按任意键退出...
pause >nul