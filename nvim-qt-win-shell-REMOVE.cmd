@echo off
setlocal

set editWithNvimQtString=Edit with Neovim
set nvimQtExeString=nvim-qt.exe

:: Unset ProgID and coresponding file associations
echo[
echo Unsetting %nvimQtExeString% ProgID and coresponding file associations...
reg delete "HKCR\Applications\%nvimQtExeString%" /f

:: Unset Explorer file, directory & drive context menu item
echo[
echo Unsetting Explorer file, directory ^& drive '%editWithNvimQtString%' context menu item...
reg delete "HKCR\AllFilesystemObjects\shell\%editWithNvimQtString%" /f
reg delete "HKCR\Drive\shell\%editWithNvimQtString%" /f

echo[
echo FINISHED
endlocal
exit /B %errorlevel%
