@echo off
setlocal
chcp 65001 > nul
REM ===========================================================================
REM  MSF_UE_RE (SCR_DB edition) build  --  just double-click this file.
REM
REM  It runs all three stages and writes a playable map:
REM      1) tepc     : main.lua -> triggers   (base map: MSF_UE_RE_base.scx)
REM      2) euddraft : input sync (QCInput.lua) / chatEvent / STRCtrig / stat_txt / sounds
REM                    (sounds come from C:\euddraft0.9.2.0\MSF_UE_RE_BGM)
REM      3) CPLP     : protector  ->  *_out.scx
REM  EUD Editor 3 and the .e3s file are not used any more.
REM
REM  Output goes to  C:\Program Files (x86)\StarCraft\Maps\
REM  (exact file names are printed at the end of this run)
REM
REM  Base map or sound folder missing?  run:  python tools\split_map.py
REM  Extra options are passed through, e.g.  build.bat --tepc-only
REM  Keep this file ASCII-only: the console codepage mangles anything else.
REM ===========================================================================

set "PROJ=%~dp0"
if "%PROJ:~-1%"=="\" set "PROJ=%PROJ:~0,-1%"

where python >nul 2>nul
if errorlevel 1 (
    echo [build] python was not found in PATH.
    goto :fail
)
if not exist "%PROJ%\tools\build_scrdb.py" (
    echo [build] tools\build_scrdb.py is missing.
    goto :fail
)

REM  Some setups set NoDefaultCurrentDirectoryInExePath=1, which makes cmd
REM  refuse bare exe names. Clear it for child processes.
set "NoDefaultCurrentDirectoryInExePath="

echo.
echo  ========================================================
echo   MSF_UE_RE SCR_DB  full build  (tepc -^> euddraft -^> CPLP)
echo  ========================================================
echo.

python "%PROJ%\tools\build_scrdb.py" %*

if %ERRORLEVEL% NEQ 0 goto :fail

echo.
echo  ========================================================
echo   DONE.  Play this file:
echo.
dir /b "C:\Program Files (x86)\StarCraft\Maps\*UnLimit_ExceeD_SCR_DB*.scx" 2>nul
echo.
echo   ( *_out.scx is the CPLP-protected one. )
echo  ========================================================
echo.
pause
exit /b 0

:fail
echo.
echo [build] FAILED - the error is printed above.
pause
exit /b 1
