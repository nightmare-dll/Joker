@if (@a)==(@b) @end /* :: ~~~~~~~~~ Batch Part ~~~~~~~~~
@echo off

set ex_noreg=Disabled
2>nul set "ex_noreg=Enabled "
set de_noreg=Disabled
if "!!"=="" (set de_noreg=Enabled )

setlocal EnableExtensions DisableDelayedExpansion
cd /d "%~dp0"
>"%temp%\info.txt" echo [code^]

:: prepare some variables to shorten lines in the script
set "International=Control Panel\International"
set "CurrentVersion=SOFTWARE\Microsoft\Windows NT\CurrentVersion"
set "CodePage=SYSTEM\CurrentControlSet\Control\Nls\CodePage"
set "CMDproc=Software\Microsoft\Command Processor"
set /a "HKCU=80000001, HKLM=80000002, HKU=80000003"
set "sys32=%SystemRoot%\System32"

:: try to assign variables for used tools in order to make the script run even if the path or pathext variables are corrupted
if exist "%sys32%\clip.exe" (set "clip=%sys32%\clip.exe") else (set "clip=" &>>"%temp%\info.txt" echo clip.exe not found.)
if exist "%sys32%\cscript.exe" (set "cscript=%sys32%\cscript.exe") else set "cscript=cscript.exe"
>nul 2>nul %cscript% /? || (set "cscript=" &>>"%temp%\info.txt" echo cscript.exe not accessible.)
if exist "%sys32%\find.exe" (set "find=%sys32%\find.exe") else (set "find=echo" &>>"%temp%\info.txt" echo find.exe not found.)
if exist "%sys32%\findstr.exe" (set "findstr=%sys32%\findstr.exe") else (set "findstr=echo" &>>"%temp%\info.txt" echo findstr.exe not found.)
if exist "%sys32%\gpresult.exe" (set "gpresult=%sys32%\gpresult.exe") else (set "gpresult=" &>>"%temp%\info.txt" echo gpresult.exe not found.)
if defined gpresult >nul 2>nul %gpresult% /? || (set "gpresult=" &>>"%temp%\info.txt" echo gpresult.exe not accessible.)
if exist "%sys32%\net.exe" (set "net=%sys32%\net.exe") else (set "net=echo" &>>"%temp%\info.txt" echo net.exe not found.)
if exist "%SystemRoot%\notepad.exe" (set "notepad=%SystemRoot%\notepad.exe") else if exist "%sys32%\notepad.exe" (
  set "notepad=%sys32%\notepad.exe"
) else (set "notepad=%sys32%\cmd.exe /k type" &>>"%temp%\info.txt" echo notepad.exe not found.)
if exist "%sys32%\ping.exe" (set "ping=%sys32%\ping.exe") else (set "ping=(for /l %%i in (0 1 10000) do echo %%i>nul)&echo" &>>"%temp%\info.txt" echo ping.exe not found.)
if exist "%sys32%\reg.exe" (set "reg=%sys32%\reg.exe") else (set "reg=foo?.exe" &>>"%temp%\info.txt" echo reg.exe not found.)
if exist "%sys32%\whoami.exe" (set "whoami=%sys32%\whoami.exe") else (set "whoami=" &>>"%temp%\info.txt" echo whoami.exe not found.)
if defined whoami >nul 2>nul %whoami% /? || (set "whoami=" &>>"%temp%\info.txt" echo whoami.exe not acessible.)
if exist "%sys32%\wbem\WMIC.exe" (set "wmic=%sys32%\wbem\WMIC.exe") else (set "wmic=" &>>"%temp%\info.txt" echo wmic.exe not found.)
if defined wmic >nul 2>nul %wmic% /? || (set "wmic=" &>>"%temp%\info.txt" echo wmic.exe not accessible.)
>>"%temp%\info.txt" echo ----------------------------------------------------------------------------


:: list of directories to check if missing in the path variable
set dirs="%SystemRoot%","%sys32%","%sys32%\wbem","%sys32%\WindowsPowerShell\v1.0"

:: list ofextensions to check if missing in the pathext variable
set ext=.bat,.cmd,.com,.exe,.js,.jse,.msc,.vbe,.vbs,.wsf,.wsh

:: list of tools to check if missing in the path environment
set tools=certutil,choice,clip,debug,forfiles,gpresult,icacls,openfiles,powershell,robocopy,timeout,whoami,wmic

:: check reg access
%reg% query "HKCU\%International%" >nul 2>&1 && (set "RegUserInternational=1") || (set "RegUserInternational=0")
%reg% query "HKU\.DEFAULT\%International%" >nul 2>&1 && (set "RegDefInternational=1") || (set "RegDefInternational=0")
%reg% query "HKLM\%CurrentVersion%" >nul 2>&1 && (set "RegSysCurrentVersion=1") || (set "RegSysCurrentVersion=0")
%reg% query "HKLM\%CodePage%" >nul 2>&1 && (set "RegSysCodePage=1") || (set "RegSysCodePage=0")
%reg% query "HKCU\%CMDproc%" >nul 2>&1 && (set "RegUserCMDproc=1") || (set "RegUserCMDproc=0")
%reg% query "HKLM\%CMDproc%" >nul 2>&1 && (set "RegSysCMDproc=1") || (set "RegSysCMDproc=0")

:: check elevation and Admin membership
set "RunAs="
%net% session >nul 2>&1 && (set "RunAs=Yes")
if not defined RunAs if defined cscript (
  for /f "delims=" %%i in ('%cscript% //nologo //e:jscript "%~fs0" "%HCU%" "HKU\S-1-5-19" ""') do set "RunAs=%%i"
)
if defined RunAs (if "%RunAs%"=="#AccessDenied" (set "RunAs=No") else set "RunAs=Yes") else set "RunAs=No"
set "LocalAdmin="
if defined whoami 2>nul %whoami% /groups|>nul %findstr% /i "\<S-1-5-32-544\>" && set "LocalAdmin=Yes" || set "LocalAdmin=Yes"
if not defined LocalAdmin if defined wmic (
  for /f "tokens=1* delims==" %%i in (
    '%wmic% path Win32_Group WHERE "LocalAccount='TRUE' AND SID='S-1-5-32-544'" GET Name /value'
  ) do for /f "delims=" %%k in ("%%j") do (
    for /f "tokens=1* delims=:" %%l in ('2^>nul %gpresult% /r /scope user ^| %findstr% /n /c:"--------" /c:"%%k"') do (
      set "check="
      for /f "delims=- " %%n in ("%%m") do set "check=1"
      if not defined check (
        set "n=%%l"
        set "LocalAdmin=No"
      ) else for /f %%n in ('set /a n') do if %%n lss %%l set "LocalAdmin=Yes"
    )
  )
) else set "LocalAdmin=Not found"

:: International
for %%a in ("iDate" "iTime" "LocaleName") do set "%%~a="
if %RegUserInternational%==1 (call :RegInternational) else if defined cscript call :JsInternational
if not defined iDate set "iDate=0"
if not defined iTime set "iTime=1"
if not defined LocaleName call :MUI
if "%iDate%"=="0" (set "format=mm/dd/yy") else if "%iDate%"=="1" (set "format=dd/mm/yy") else if "%iDate%"=="2" (set "format=yy/mm/dd")
if "%iTime%"=="0" (set "hours=12") else set "hours=24"

:: ProductName
set "ProductName="
if %RegSysCurrentVersion%==1 (call :RegProductName) else if defined cscript call :JsProductName
if not defined ProductName for /f "tokens=1* delims==" %%i in ('2^>nul %wmic% os get Caption /value') do set "ProductName=%%j"

:: Extensions and DelayedExpansion
for %%a in (es eu ds du) do set "%%a=Disabled"
if %RegUserCMDproc%==1 (call :RegUserProc) else if defined cscript call :JsUserProc
if %RegSysCMDproc%==1 (call :RegSysProc) else if defined cscript call :JsSysProc
if not defined eu set "eu=%ex_noreg%"
if not defined du set "du=%de_noreg%"

:: Code Pages
set "OEMCP=" &set "ACP="
if %RegSysCodePage%==1 (call :RegCodePage) else if defined cscript call :JsCodePage
if not defined OEMCP for /f "tokens=2 delims=:" %%i in ('CHCP') do set /a "OEMCP=%%~ni"
if not defined ACP (
  if defined wmic (
    for /f "tokens=2 delims==" %%i in ('%wmic% os get CodeSet /value') do set /a "ACP=%%i"
  ) else set "ACP=Not found"
)

:: checks path
:: removes random double quotes, adds double quotes, removes trailing slash
:: http://stackoverflow.com/questions/5471556/pretty-print-windows-path-variable-how-to-split-on-in-cmd-shell/5472168#5472168
set "p=%path:"=""%"
set "p=%p:^=^^%"
set "p=%p:&=^&%"
set "p=%p:|=^|%"
set "p=%p:<=^<%"
set "p=%p:>=^>%"
set "p=%p:;=^;^;%"
set p=%p:""="%
set "p=%p:"=""%"
set "p=%p:;;="";""%"
set "p=%p:^;^;=;%"
set "p=%p:""="%"
set "p=%p:"=""%"
set "p=%p:"";""=";"%"
set "p=%p:"""="%"
set "p=%p:\"="%"

:: Check for 64 bit windows.
set "bit="
if defined wmic (
  for /f "tokens=1* delims==" %%i in ('2^>nul %wmic% os GET OSArchitecture /value') do for /f "delims=" %%k in ("%%j") do set "bit=%%k"
)
if defined bit (echo "%bit%"|%find% "64" >nul && set "bit=64" || set "bit=32") else (
  echo "%PROCESSOR_ARCHITECTURE%"|%find% "86" >nul && set "bit=32" || (
    if exist "%SystemRoot%\SysWOW64\" (set "bit=64") else set "bit=32"
  )
)

:: RAM space
set "ram="
if defined wmic (
  for /f "tokens=1* delims==" %%i in ('2^>nul %wmic% os GET TotalVisibleMemorySize /value') do for /f "delims=" %%k in ("%%j") do set "ram=%%k"
)

:: get the DIR command format to display
for /f "delims=" %%a in ('dir "%SystemDrive%\pagefile.sys" /a ^|%find% ":"') do set "DirFormat=%%a"

set "pad=                          "
:: create the information file and send the information to the clipboard if clip is available
>>"%temp%\info.txt" (
  for /f "delims=" %%a in ('ver') do echo Windows version        :  %%a
  echo Product name           :  %ProductName%, %bit% bit
  echo Performance indicators :  Processor Cores: %NUMBER_OF_PROCESSORS%      Visible RAM: %ram% Bytes&echo(

  echo Date/Time format       :  %format% (%hours% hours^)     %date%  %time%
  echo Extensions             :  system: %es%  user: %eu%
  echo Delayed expansion      :  system: %ds%  user: %du%
  echo Locale name            :  %LocaleName%       Code Pages: OEM  %OEMCP%    ANSI %ACP%
  echo DIR  format            :  %DirFormat%
  echo Permissions            :  Elevated Admin=%RunAs%, Admin group=%LocalAdmin%&echo(

  rem report if path elements are missing
  for %%i in (%dirs%) do (
    set "found="
    setlocal EnableDelayedExpansion
    for %%j in ("!p!") do (
      endlocal
      if /i "%%~i"==%%j set "found=1"
      setlocal EnableDelayedExpansion
    )
    endlocal
    if not defined found echo(%pad%Missing from the PATH environment: %%~i
  )

  rem report if pathext elements are missing
  for %%i in (%ext%) do (
    set "found="
    for %%j in (%PATHEXT%) do (
      if /i "%%i"=="%%j" set "found=1"
    )
    if not defined found echo(%pad%Missing from the PATHEXT environment: %%~i
  )

  rem report if tools are missing
  for %%i in (%tools%) do for /f "tokens=1,2 delims=?" %%j in ("%%~i.exe?%%~i.com") do if "%%~$PATH:j%%~$PATH:k"=="" (
    echo(%pad%Missing from the tool collection:  %%i
  )
  echo [/code^]
)
if defined clip (%clip% < "%temp%\info.txt")
:: load the information into Notepad where it can also be copied to the clipboard
start "" %notepad% "%temp%\info.txt" & %ping% -n 2 127.0.0.1 >nul & del "%temp%\info.txt"

goto :eof

:: ~~~~~~~~~ Sub Routines ~~~~~~~~~
:RegInternational
for /f "tokens=1,2*" %%a in ('%reg% query "HKCU\%International%" /v "i???e" 2^>nul ^| %find% "REG_"') do set "%%~a=%%~c"
if %RegDefInternational%==1 for /f "tokens=1,2*" %%a in ('%reg% query "HKU\.DEFAULT\%International%" /v "i???e" 2^>nul ^| %find% "REG_"') do if not defined %%~a set "%%~a=%%~c"
for /f "tokens=1,2*" %%a in ('%reg% query "HKCU\%International%" /v "LocaleName" 2^>nul ^| %find% "REG_"') do set "%%~a=%%~c"
goto :eof

:JsInternational
for /f "delims=" %%i in ('%cscript% //nologo //e:jscript "%~fs0" "%HKCU%" "%international%" "iDate"') do set "iDate=%%i"
if defined iDate if "%iDate%"=="#NotFound" for /f "delims=" %%i in ('%cscript% //nologo //e:jscript "%~fs0" "%HKU%" ".DEFAULT\%international%" "iDate"') do set "iDate=%%i"
if defined iDate if "%iDate:~,1%"=="#" set "iDate=0"
for /f "delims=" %%i in ('%cscript% //nologo //e:jscript "%~fs0" "%HKCU%" "%international%" "iTime"') do set "iTime=%%i"
if defined iTime if "%iTime%"=="#NotFound" for /f "delims=" %%i in ('%cscript% //nologo //e:jscript "%~fs0" "%HKU%" ".DEFAULT\%international%" "iTime"') do set "iTime=%%i"
if defined iTime if "%iTime:~,1%"=="#" set "iTime=1"
for /f "delims=" %%i in ('%cscript% //nologo //e:jscript "%~fs0" "%HKCU%" "%international%" "LocaleName"') do set "LocaleName=%%i"
if defined LocaleName if "%LocaleName:~,1%"=="#" set "LocaleName="
goto :eof

:MUI
for /f "tokens=2 delims=={}" %%i in ('2^>nul %wmic% os get MUILanguages /value') do set "LocaleName=%%i"
if defined LocaleName (
  set "LocaleName=%LocaleName:"=%"
) else (
  setlocal EnableDelayedExpansion
  for /f %%i in ('dir /ad /b "%sys32%\??-??"^|%findstr% /x "[a-z][a-z]-[a-z][a-z]"') do (
    if exist "%sys32%\%%i\ulib.dll.mui" set "LocaleName=!LocaleName!,%%i"
  )
  if defined LocaleName (for /f %%j in ("!LocaleName:~1!") do (endlocal &set "LocaleName=%%j")) else endlocal
)
goto :eof

:RegProductName
for /f "tokens=2*" %%a in ('%reg% query "HKLM\%CurrentVersion%"^|%find% /i "ProductName"') do set "ProductName=%%b"
goto :eof

:JsProductName
for /f "delims=" %%i in ('%cscript% //nologo //e:jscript "%~fs0" "%HKLM%" "%CurrentVersion%" "ProductName"') do set "ProductName=%%i"
if defined ProductName if "%ProductName:~,1%"=="#" set "ProductName="
goto :eof

:RegUserProc
%reg% query "HKCU\%CMDproc%" /v "EnableExtensions" 2>nul|%find% "0x1">nul && set "eu=Enabled "
%reg% query "HKCU\%CMDproc%" /v "DelayedExpansion" 2>nul|%find% "0x1">nul && set "du=Enabled "
goto :eof

:JsUserProc
set "v="&for /f "delims=" %%i in ('%cscript% //nologo //e:jscript "%~fs0" "%HKCU%" "%CMDproc%" "EnableExtensions"') do set "v=%%i"
if defined v if "%v:~,1%"=="#" (set "eu=") else set "eu=Enabled "
set "v="&for /f "delims=" %%i in ('%cscript% //nologo //e:jscript "%~fs0" "%HKCU%" "%CMDproc%" "DelayedExpansion"') do set "v=%%i"
if defined v if "%v:~,1%"=="#" (set "du=") else set "du=Enabled "
goto :eof

:RegSysProc
%reg% query "HKLM\%CMDproc%" /v "EnableExtensions" 2>nul|%find% "0x1">nul && set "es=Enabled "
%reg% query "HKLM\%CMDproc%" /v "DelayedExpansion" 2>nul|%find% "0x1">nul && set "ds=Enabled "
goto :eof

:JsSysProc
set "v="&for /f "delims=" %%i in ('%cscript% //nologo //e:jscript "%~fs0" "%HKLM%" "%CMDproc%" "EnableExtensions"') do set "v=%%i"
if defined v if "%v:~,1%"=="#" (set "es=") else set "es=Enabled "
set "v="&for /f "delims=" %%i in ('%cscript% //nologo //e:jscript "%~fs0" "%HKLM%" "%CMDproc%" "DelayedExpansion"') do set "v=%%i"
if defined v if "%v:~,1%"=="#" (set "ds=") else set "ds=Enabled "
goto :eof

:RegCodePage
for /f "tokens=3" %%a in ('%reg% query "HKLM\%CodePage%" /v "OEMCP"') do set /a "OEMCP=%%a"
for /f "tokens=3" %%a in ('%reg% query "HKLM\%CodePage%" /v "ACP"') do set /a "ACP=%%a"
goto :eof

:JsCodePage
for /f "delims=" %%i in ('%cscript% //nologo //e:jscript "%~fs0" "%HKLM%" "%CodePage%" "OEMCP"') do set "OEMCP=%%i"
if defined OEMCP if "%OEMCP:~,1%"=="#" set "OEMCP="
for /f "delims=" %%i in ('%cscript% //nologo //e:jscript "%~fs0" "%HKLM%" "%CodePage%" "ACP"') do set "ACP=%%i"
if defined ACP if "%ACP:~,1%"=="#" set "ACP="
goto :eof

:: ~~~~~~~~~ JScript Part ~~~~~~~~~ */
var REG_NONE=0, REG_SZ=1, REG_EXPAND_SZ=2, REG_BINARY=3, REG_DWORD=4, REG_MULTI_SZ=7, REG_QWORD=11;
var KEY_QUERY_VALUE=0x00000001;

function regCheckAccess(strComputer, uHive, strRegPath, uRequiredAccess) {
  try {
    var objLocator = new ActiveXObject("WbemScripting.SWbemLocator");
    var objService = objLocator.ConnectServer(strComputer, "root\\default");
    objService.Security_.ImpersonationLevel = 3; //wbemImpersonationLevelImpersonate
    var objReg = objService.Get("StdRegProv");
    var objAccessMethod = objReg.Methods_.Item("CheckAccess");
    var objAccessInParam = objAccessMethod.InParameters.SpawnInstance_();
    objAccessInParam.hDefKey = uHive;
    objAccessInParam.sSubKeyName = strRegPath;
    objAccessInParam.uRequired = uRequiredAccess;
    var objAccessOutParam = objReg.ExecMethod_(objAccessMethod.Name, objAccessInParam);
    if (objAccessOutParam.ReturnValue == 0) {
      if (objAccessOutParam.bGranted) {return true;}
    }
    return false;
  }
  catch(e) {return false;}
}

function regReadVal(strComputer, uHive, strRegPath, strValName) {
  try {
    var vRet = null, iType = -1;
    var objLocator = new ActiveXObject("WbemScripting.SWbemLocator");
    var objService = objLocator.ConnectServer(strComputer, "root\\default");
    objService.Security_.ImpersonationLevel = 3; //wbemImpersonationLevelImpersonate
    var objReg = objService.Get("StdRegProv");
    var objEnumMethod = objReg.Methods_.Item("EnumValues");
    var objEnumInParam = objEnumMethod.InParameters.SpawnInstance_();
    objEnumInParam.hDefKey = uHive;
    objEnumInParam.sSubKeyName = strRegPath;
    var objEnumOutParam = objReg.ExecMethod_(objEnumMethod.Name, objEnumInParam);
    if (objEnumOutParam.ReturnValue == 0) {
      if (objEnumOutParam.sNames != null) {
        for (var i = 0; i <= objEnumOutParam.sNames.ubound(); i++) {
          if (objEnumOutParam.sNames.getItem(i).toLowerCase() == strValName.toLowerCase()) {
            iType = objEnumOutParam.Types.getItem(i);
            break;
          }
        }
      }
      else {if (strValName == "") {iType = REG_NONE;}}
      if (iType == -1) {return null;}
    }
    else {return null;}
    switch (iType) {
      case REG_SZ:
        var objGetMethod = objReg.Methods_.Item("GetStringValue");
        var objGetInParam = objGetMethod.InParameters.SpawnInstance_();
        objGetInParam.hDefKey = uHive;
        objGetInParam.sSubKeyName = strRegPath;
        objGetInParam.sValueName = strValName;
        var objGetOutParam = objReg.ExecMethod_(objGetMethod.Name, objGetInParam);
        if (objGetOutParam.ReturnValue == 0) {vRet = objGetOutParam.sValue;}
        break;
      case REG_EXPAND_SZ:
        var objGetMethod = objReg.Methods_.Item("GetExpandedStringValue");
        var objGetInParam = objGetMethod.InParameters.SpawnInstance_();
        objGetInParam.hDefKey = uHive;
        objGetInParam.sSubKeyName = strRegPath;
        objGetInParam.sValueName = strValName;
        var objGetOutParam = objReg.ExecMethod_(objGetMethod.Name, objGetInParam);
        if (objGetOutParam.ReturnValue == 0) {vRet = objGetOutParam.sValue;}
        break;
      case REG_BINARY:
        var objGetMethod = objReg.Methods_.Item("GetBinaryValue");
        var objGetInParam = objGetMethod.InParameters.SpawnInstance_();
        objGetInParam.hDefKey = uHive;
        objGetInParam.sSubKeyName = strRegPath;
        objGetInParam.sValueName = strValName;
        var objGetOutParam = objReg.ExecMethod_(objGetMethod.Name, objGetInParam);
        if (objGetOutParam.ReturnValue == 0) {if (objGetOutParam.uValue != null) {vRet = objGetOutParam.uValue.toArray();}}
        break;
      case REG_DWORD:
        var objGetMethod = objReg.Methods_.Item("GetDWORDValue");
        var objGetInParam = objGetMethod.InParameters.SpawnInstance_();
        objGetInParam.hDefKey = uHive;
        objGetInParam.sSubKeyName = strRegPath;
        objGetInParam.sValueName = strValName;
        var objGetOutParam = objReg.ExecMethod_(objGetMethod.Name, objGetInParam);
        if (objGetOutParam.ReturnValue == 0) {vRet = objGetOutParam.uValue;}
        break;
      case REG_MULTI_SZ:
        var objGetMethod = objReg.Methods_.Item("GetMultiStringValue");
        var objGetInParam = objGetMethod.InParameters.SpawnInstance_();
        objGetInParam.hDefKey = uHive;
        objGetInParam.sSubKeyName = strRegPath;
        objGetInParam.sValueName = strValName;
        var objGetOutParam = objReg.ExecMethod_(objGetMethod.Name, objGetInParam);
        if (objGetOutParam.ReturnValue == 0) {if (objGetOutParam.sValue != null) {vRet = objGetOutParam.sValue.toArray();}}
        break;
      case REG_QWORD:
        var objGetMethod = objReg.Methods_.Item("GetQWORDValue");
        var objGetInParam = objGetMethod.InParameters.SpawnInstance_();
        objGetInParam.hDefKey = uHive;
        objGetInParam.sSubKeyName = strRegPath;
        objGetInParam.sValueName = strValName;
        var objGetOutParam = objReg.ExecMethod_(objGetMethod.Name, objGetInParam);
        if (objGetOutParam.ReturnValue == 0) {vRet = objGetOutParam.uValue;}
        break;
      case REG_NONE:
        var objGetMethod = objReg.Methods_.Item("GetStringValue");
        var objGetInParam = objGetMethod.InParameters.SpawnInstance_();
        objGetInParam.hDefKey = uHive;
        objGetInParam.sSubKeyName = strRegPath;
        objGetInParam.sValueName = strValName;
        var objGetOutParam = objReg.ExecMethod_(objGetMethod.Name, objGetInParam);
        if (objGetOutParam.ReturnValue == 0) {if (objGetOutParam.sValue != null) {vRet = objGetOutParam.sValue; break;}}
        objGetMethod = objReg.Methods_.Item("GetExpandedStringValue");
        objGetInParam = objGetMethod.InParameters.SpawnInstance_();
        objGetInParam.hDefKey = uHive;
        objGetInParam.sSubKeyName = strRegPath;
        objGetInParam.sValueName = strValName;
        objGetOutParam = objReg.ExecMethod_(objGetMethod.Name, objGetInParam);
        if (objGetOutParam.ReturnValue == 0) {if (objGetOutParam.sValue != null) {vRet = objGetOutParam.sValue; break;}}
        objGetMethod = objReg.Methods_.Item("GetBinaryValue");
        objGetInParam = objGetMethod.InParameters.SpawnInstance_();
        objGetInParam.hDefKey = uHive;
        objGetInParam.sSubKeyName = strRegPath;
        objGetInParam.sValueName = strValName;
        objGetOutParam = objReg.ExecMethod_(objGetMethod.Name, objGetInParam);
        if (objGetOutParam.ReturnValue == 0) {if (objGetOutParam.uValue != null) {vRet = objGetOutParam.uValue.toArray(); break;}}
        objGetMethod = objReg.Methods_.Item("GetDWORDValue");
        objGetInParam = objGetMethod.InParameters.SpawnInstance_();
        objGetInParam.hDefKey = uHive;
        objGetInParam.sSubKeyName = strRegPath;
        objGetInParam.sValueName = strValName;
        objGetOutParam = objReg.ExecMethod_(objGetMethod.Name, objGetInParam);
        if (objGetOutParam.ReturnValue == 0) {if (objGetOutParam.uValue != null) {vRet = objGetOutParam.uValue; break;}}
        objGetMethod = objReg.Methods_.Item("GetMultiStringValue");
        objGetInParam = objGetMethod.InParameters.SpawnInstance_();
        objGetInParam.hDefKey = uHive;
        objGetInParam.sSubKeyName = strRegPath;
        objGetInParam.sValueName = strValName;
        objGetOutParam = objReg.ExecMethod_(objGetMethod.Name, objGetInParam);
        if (objGetOutParam.ReturnValue == 0) {if (objGetOutParam.sValue != null) {vRet = objGetOutParam.sValue.toArray(); break;}}
        objGetMethod = objReg.Methods_.Item("GetQWORDValue");
        objGetInParam = objGetMethod.InParameters.SpawnInstance_();
        objGetInParam.hDefKey = uHive;
        objGetInParam.sSubKeyName = strRegPath;
        objGetInParam.sValueName = strValName;
        objGetOutParam = objReg.ExecMethod_(objGetMethod.Name, objGetInParam);
        if (objGetOutParam.ReturnValue == 0) {if (objGetOutParam.uValue != null) {vRet = objGetOutParam.uValue; break;}}
      default:
        return null;
    }
    return vRet;
  }
  catch(e) {return null;}
}

if (regCheckAccess(".", parseInt(WScript.Arguments(0), 16), WScript.Arguments(1), KEY_QUERY_VALUE) === false) {
  WScript.Echo("#AccessDenied");
} else {
  var v = regReadVal(".", parseInt(WScript.Arguments(0), 16), WScript.Arguments(1), WScript.Arguments(2));
  if (v === null)
  {
    WScript.Echo("#NotFound");
  } else {
    WScript.Echo(v);
  }
}

/*
:eof
:: */