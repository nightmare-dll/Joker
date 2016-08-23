@echo off

if "%1"=="/?" (
echo.
echo.--
echo %~n0 usage:
echo.--
echo.
echo.
echo.to put WiFi HotSpot offline:
echo %~n0 -offline
echo.
echo.
echo.to create a WiFi hotspot:
echo.%~n0 WiFiNetworkNameGoHere WiFiNetworkPasswordGoHere
echo.
echo.note: name must not contain spaces
echo.note: password must be 8-63 characters long
goto :end
)

echo.>"%homedrive%\AdminPriv.test"
if exist "%homedrive%\AdminPriv.test" goto :has_uac_elev
cls
echo.requesting UAC elevation ...
echo.set x = createobject("shell.application")>"%temp%\uacelev.vbs"
echo.x.shellexecute "%~dpnx0","%*","","runas",1 >>"%temp%\uacelev.vbs"
echo.x.shellexecute "%comspec%","/D /C @del /f /q "^&wscript.scriptfullname>>"%temp%\uacelev.vbs"
start "" "%temp%\uacelev.vbs"
exit

:has_uac_elev
del /f /q "%homedrive%\AdminPriv.test" >nul

if /I "%1"=="-offline" (
netsh wlan stop hostednetwork >nul
netsh wlan set hostednetwork mode=disallow >nul
echo.
echo.--
echo.WiFi HotSpot is now offline
echo.--
goto :end
)

set "name=%1"

if "%1"=="" echo.name can not contain spaces & set/p "name=[WiFiHotSpotName]:
set "pass=%2"
if "%2"=="" echo.password must be 8 - 63 characters long and not contain spaces & set/p "pass=[WiFiHotSpotPassword]:
netsh wlan set hostednetwork ssid=%name% >nul
netsh wlan set hostednetwork key=%pass% >nul
netsh wlan set hostednetwork mode=allow >nul
netsh wlan start hostednetwork >nul
echo.
echo.--
echo.WiFi HotSpot "%name%" has been created
echo.--

:end
echo.
echo.tap ^<sapce^> to continue
pause >nul