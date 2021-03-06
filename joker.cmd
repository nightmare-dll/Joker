@echo off

:: Calling the config
call "data/config.cmd"
:: Setting Title
title %program%#%version%

:: Root "Directory"
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
:: Finding all files ending in .cmd or .bat
dir /b plugins\*.cmd plugins\*.bat
echo.
echo Enter the name of the plugin you want to run.
set /p plugin=root/plugins/plugin_dragon.jr@Root:~$ 
if %plugin% == root goto root
:: Running user-specified plugin
start "" plugins\%plugin%
goto root

:help
start data/commandlist.txt
goto root

:ping
echo.
echo Enter the website URL or IP address you want to ping.
set /p ping=root/ping.jr@Joker:~$ 
if %ping% == root goto root
ping %ping%
echo Press any key to return to root...
pause >nul
goto root

:tracert
echo.
echo Enter the website URL or IP address you want to trace.
set /p tracert=root/tracert.jr@Joker:~$ 
if %tracert% == root goto root
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
if %username% == root goto root
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