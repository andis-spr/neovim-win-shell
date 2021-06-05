@echo off
setlocal

set editWithNvimQtString=Edit with Neovim
set nvimQtExeString=nvim-qt.exe

:: Remove ProgID and coresponding file associations
echo[
echo Removing %nvimQtExeString% ProgID and coresponding file associations...
reg delete "HKCR\Applications\%nvimQtExeString%" /f

:: Remove Explorer file, directory & drive context menu option
echo[
echo Removing Explorer file, directory ^& drive '%editWithNvimQtString%' context menu option...
reg delete "HKCR\AllFilesystemObjects\shell\%editWithNvimQtString%" /f
reg delete "HKCR\Drive\shell\%editWithNvimQtString%" /f

echo[
echo FINISHED
endlocal
exit /B %errorlevel%
