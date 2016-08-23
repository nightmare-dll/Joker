@echo off

:menu
cls
echo ipconfig, iprelease, or iprenew
set /p iptools=root/iptools.jr@Joker:~$ 
if %iptools% == ipconfig goto config
if %iptools% == iprelease goto release
if %iptools% == iprenew goto renew
goto error

:config
cls
ipconfig /all
echo Press any key to go back to iptools...
pause >nul
goto menu

:release
cls
ipconfig /release
echo Press any key to go back to iptools...
pause >nul
goto menu

:renew
cls
ipconfig /renew
echo Press any key to go back to iptools...
pause >nul
goto menu

:error
echo '%iptools% isn't a valid command. Try again.
pause >nul
goto menu