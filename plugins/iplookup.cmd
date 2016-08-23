@echo off
Title My External IP by Hackoo 2015
mode con cols=116 lines=14 & color 0A
Set OuputFile=%Temp%\myexternalip.txt
Set PSFile=%Temp%\tmp.ps1
Set DataFile=%Temp%\MyData.txt
(
echo $wc = new-object System.Net.WebClient
echo $wc.DownloadString("http://myexternalip.com/raw"^)
echo $wc.DownloadString("http://ip-api.com/csv/"^) ^> %OuputFile%
)>%PSFile%
cmd /c PowerShell.exe -ExecutionPolicy bypass -noprofile -file %PSFile%
Del %PSFile%
Timeout /T 1 /NoBreak>nul
cls
FOR /F "tokens=1-14 delims=," %%a in ('Type %OuputFile%') do (
echo %%a - %%b - %%c - %%d - %%e - %%f - %%g - %%h - %%i - %%j - %%k - %%l - %%m - %%n>nul
)
cls
for /f "delims=" %%A in ('Type %OuputFile%') do (
  set "data=%%A"
  setlocal enabledelayedexpansion
  set data
  set "data=!data:,,,,,=,#,#,#,#,!"
  set "data=!data:,,,,=,#,#,#,!"
  set "data=!data:,,,=,#,#,!"
  set "data=!data:,,=,#,!"
  for /f "tokens=1-14 delims=," %%a in ("!Data:#=NULL!") do (
  endlocal
  echo Status  : %%a
  echo Country  : %%b
  echo Code pays  : %%c
  echo Region  : %%d
  echo Code region  : %%e
  echo Ville  : %%f
  echo Code postale  : %%g
  echo Latitude  : %%h
  echo Longitude  : %%i
  echo Fuseau horaire  : %%j
  echo Provider-FAI-AS num/nom  : %%k - %%l - %%m
  echo IP Adress  : %%n
  (
  echo Status  : %%a
  echo Country  : %%b
  echo Code pays  : %%c
  echo Region  : %%d
  echo Code region  : %%e
  echo Ville  : %%f
  echo Code postale  : %%g
  echo Latitude  : %%h
  echo Longitude  : %%i
  echo Fuseau horaire  : %%j
  echo Provider-FAI-AS num/nom  : %%k - %%l - %%m
  echo IP Adress  : %%n
  )>%DataFile%
)
)
pause
::Code from Sacha thanks to him (-_°)
call :make
for /f %%a in ('cscript.exe /nologo getcount.vbs "http://myexternalip.com/raw"') do (
set "IP=%%a"
)
for /f "tokens=1-20 delims=," %%a in ('cscript.exe /nologo getcount.vbs http://ip-api.com/csv/%IP%') do (
cls
echo IP PUBLIQUE : %IP%
echo STATUT  : %%a
echo PAYS  : %%b
echo PAYS MIN  : %%c
echo REGION  : %%e
echo VILLE  : %%f
echo LATITUDE  : %%g
echo LONGITUDE  : %%h
echo TIMEZONE  : %%i
echo ISP  : %%j
echo FAI  : %%k
echo AS NAME  : %%l

set LA=%%g
set LO=%%h
set "VI=%%b-%%f"
)
pause
start https://www.google.fr/maps/place/%VI%
Start %DataFile%
if exist GetCount.vbs del GetCount.vbs

:make
If not exist Getcount.vbs ((
echo Dim o
echo Var1=Wscript.Arguments(0^)
echo Set o = CreateObject("MSXML2.XMLHTTP"^)
echo o.open "GET", var1, False
echo o.send
echo wscript.echo o.responseText
)>GetCount.vbs
)
goto :eof