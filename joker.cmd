@echo off
call "data/config.cmd"
title %program%#%version%
:root
cls
echo [===========================================================]
echo [Welcome to %program%#%version% ~ nightmare.dll                       ]
echo [===========================================================]
echo       #                                                      
echo       #  ####  #    # ###### #####       ####  #    # #####  
echo       # #    # #   #  #      #    #     #    # ##  ## #    # 
echo       # #    # ####   #####  #    #     #      # ## # #    # 
echo #     # #    # #  #   #      #####  ### #      #    # #    # 
echo #     # #    # #   #  #      #   #  ### #    # #    # #    # 
echo  #####   ####  #    # ###### #    # ###  ####  #    # #####  
echo =============================================================
echo.
set /p console=root@Joker:~$ 
if %console% == plugins goto plugindragon
if %console% == help goto help
if %console% == ping goto ping
if %console% == tracert goto tracert
if %console% == cpass goto cpass
goto error

:plugindragon
echo.
echo Plugins
echo ==============
dir /b plugins\*.cmd
echo.
echo Enter the name of the plugin you want to run.
set /p plugin=root/plugins/plugin_dragon.jr@Root:~$ 
start "" plugins\%plugin%
goto root

:help
start commandlist.txt
goto root

:ping
echo.
echo Enter the website URL or IP address you want to ping.
set /p ping=root/ping.jr@Joker:~$ 
ping %ping%
echo Press any key to return to root...
pause >nul
goto root

:tracert
echo.
echo Enter the website URL or IP address you want to trace.
set /p tracert=root/tracert.jr@Joker:~$ 
tracert %tracert%
echo Press any key to return to root...
pause >nul
goto root

:cpass
echo.
echo You must run this program as administrator to use this feature!
echo Enter the username of the account (do ls to list all users).
set /p username=root/cpass.jr@Joker:~$ 
if %username% == ls goto ls
goto :cpasspassword
:ls
net user
pause >nul 
goto cpass
:cpasspassword
echo Enter the password of the account.
set /p password=root/cpass.jr@Joker:~$ 
net user %username% %password%
echo Press any key to return to root...
pause >nul
goto root

:error
echo '%console%' is not a valid command. Try again.
pause >nul
goto root