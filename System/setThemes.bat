
@echo off
chcp 65001>nul
:: Otherwise █ wont work
:themes
if exist theme.ini rename theme.ini theme.bat
if exist theme.bat call theme.bat
if exist theme.bat rename theme.bat theme.ini
cls
call logo.bat
echo.
echo Available themes:
echo.
echo 1 - Default		Classic purple background, aqua foreground
echo 2 - Dark		Classic dark background, light foreground
echo 3 - Geek		Black background, green foreground
echo X - Quit 		Quits the theme selector
echo.
set /p theme= Select a Theme: 
if "%theme%" == "" goto :themes
if "%theme%" == "1" goto default
if "%theme%" == "2" goto dark
if "%theme%" == "3" goto leet
if /i "%theme%" == "X" goto exit
echo [Notice:] That is not a valid option
pause
goto themes

:default
color 5b
goto confirmSave

:dark
color 08
goto confirmSave

:leet
color 0a
goto confirmSave


:confirmSave
set /p saveTheme= Save Selected? (Y/N): 
if /i "%saveTheme%" == "Y" goto saveTheme
if /i "%saveTheme%" == "N" goto themes
goto themes

:saveTheme
if "%theme%" == "1" echo color 5b>theme.ini
if "%theme%" == "2" echo color 08>theme.ini
if "%theme%" == "3" echo color 0a>theme.ini
echo Profile Saved!
pause
goto themes

:exit
cls
call logo.bat
echo Press any key to return to the desktop.
pause>nul
