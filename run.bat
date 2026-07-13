@echo off
call build.bat
if errorlevel 1 exit /b 1

C:\Emulation\Mega65\xmega65.exe -8 C:\Users\scott\repos\mega65-pacman\target\pacman.d81 -hdosvirt true -autoload true
