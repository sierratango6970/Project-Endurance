@echo off
chcp 65001>nul
:: Otherwise █ wont work

title Ignition STABLE

:VBSDynamicBuild
SET TempVBSFile=%temp%\~tmpSendKeysTemp.vbs
IF EXIST "%TempVBSFile%" DEL /F /Q "%TempVBSFile%"
ECHO Set WshShell = WScript.CreateObject("WScript.Shell") >>"%TempVBSFile%"
ECHO Wscript.Sleep 900                                    >>"%TempVBSFile%"
ECHO WshShell.SendKeys "{F11}"                            >>"%TempVBSFile%
ECHO Wscript.Sleep 900                                    >>"%TempVBSFile%"

CSCRIPT //nologo "%TempVBSFile%"


:boot
color 0f
cls
echo.             
echo                                       ██████
echo                                         ██  
echo                                         ██
echo                                         ██
echo                                         ██
echo                                         ██
echo                                       ██████
echo.
echo                                      igniti0n
echo ________________________________________________________________________________
systeminfo | findstr /c:"Total Physical Memory"
echo Running on %Processor_Identifier%.
wmic cpu get name
wmic diskdrive get name,model,size
wmic path win32_videocontroller get name
if exist shutdown.bat del shutdown.bat
echo Searching for boot.ini...
ping localhost -n 3 >nul
if exist logo.bat goto autoRepair
if exist boot.bat goto autoRepair
if exist autostart.bat goto autoRepair
if exist kernel.bat goto autoRepair
if exist login.bat goto autoRepair
if exist boot.ini goto startup
goto noBoot

:startup
echo Found boot.ini in /system
ping localhost -n 2 >nul
echo Making sure that files exist for startup...
ping localhost -n 2 >nul
if not exist autostart.ini goto noAuto
if not exist kernel.ini goto noKernel
echo Booting up kernel...
rename logo.ini logo.bat
rename boot.ini boot.bat
rename autostart.ini autostart.bat
rename kernel.ini kernel.bat
rename login.ini login.bat
ping localhost -n 2 >nul
goto noError

:noBoot
echo Couldn't find boot.ini, creating... [EC:1]
echo call autostart.bat>boot.ini
echo No boot.ini>errorlog.txt
ping localhost -n 5 >nul
goto boot

:noAuto
color 04
echo [Error] Autostart is missing from your system!
echo Please check your installation. [EC:2]
echo.
echo Press any key to power off.
echo No autostart>errorlog.txt
pause>nul
exit

:noKernel
color 04
echo.
echo [Error] A kernel is missing from your system!
echo Please check your installation. [EC:3]
echo.
echo Press any key to power off.
echo No kernel>errorlog.txt
pause>nul
exit

:autoRepair
echo [Debug] A corrupt system file has been detected and 
echo igniti0n will attempt to repair it automatically.
ping localhost -n 3 >nul
echo Creating new boot.ini
ping localhost -n 2 >nul
echo Rewriting autostart.ini
ping localhost -n 2 >nul
echo Repairing kernel
ping localhost -n 2 >nul
echo Repairing login.ini
ping localhost -n 2 >nul
del boot.bat
echo call autostart.bat>boot.ini
rename logo.bat logo.ini
rename autostart.bat autostart.ini
rename kernel.bat kernel.ini
rename login.bat login.ini
goto boot

:noError
color 0a
echo No errors detected, Starting system [EC:0] 
ping localhost -n 2 >nul
call boot.bat