@echo off
setlocal

:: Unset nvim-qt.exe ProgID and coresponding file associations
echo[
echo Unsetting nvim-qt.exe ProgID and coresponding file associations...
reg delete "HKCR\Applications\nvim-qt.exe" /f

:: Unset Explorer file & directory 'Edit with Neovim' context menu item
echo[
echo Unsetting Explorer file ^& directory 'Edit with Neovim' context menu item...
reg delete "HKCR\AllFilesystemObjects\shell\Edit with Neovim" /f

echo[
echo FINISHED
endlocal
exit /B %errorlevel%
