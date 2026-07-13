@echo off
setlocal

if not exist target mkdir target

set "PETCAT=petcat.exe"
where petcat.exe >nul 2>nul
if errorlevel 1 (
    if exist "..\basic65-compiler\petcat.exe" (
        set "PETCAT=..\basic65-compiler\petcat.exe"
    ) else (
        echo Error: petcat.exe was not found on PATH or in ..\basic65-compiler.
        exit /b 1
    )
)

set "PYTHON=python"
where python.exe >nul 2>nul
if errorlevel 1 (
    where py.exe >nul 2>nul
    if errorlevel 1 (
        echo Error: Python was not found on PATH.
        exit /b 1
    )
    set "PYTHON=py -3"
)

del target\pacman.prg 2>nul
del target\pacman.d81 2>nul

REM Tokenize the text source as a BASIC 65 program loaded at $2001.
"%PETCAT%" -w65 -l 2001 -o target\pacman.prg -- src\pacman.bas
if errorlevel 1 exit /b 1

REM petcat's BASIC 65 table predates a few MEGA65 tokens. Patch any of
REM those spellings using the fix-up rules from the basic65-compiler repo.
%PYTHON% tools\fix_basic65_petcat_tokens.py target\pacman.prg
if errorlevel 1 exit /b 1

cd target
..\c1541.exe -format "pacman,01" d81 pacman.d81
if errorlevel 1 exit /b 1
REM Keep PACMAN first so MEGA65/Xemu autoload selects it.
..\c1541.exe -attach pacman.d81 -write pacman.prg pacman
if errorlevel 1 exit /b 1
REM Ship the sample sequential leaderboard; the game rewrites it after a score.
..\c1541.exe -attach pacman.d81 -write ..\src\scores.seq "scores,s"
if errorlevel 1 exit /b 1
cd ..

echo Built target\pacman.prg
echo Built target\pacman.d81
