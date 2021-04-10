@echo off
setlocal
cd /d %~dp0

set setUserFTAZip=%~dp0SetUserFTA.zip
set setUserFTADir=%~dp0SetUserFTA
set setUserFTAExe=%setUserFTADir%\SetUserFTA\SetUserFTA.exe
set setUserFTAURL=https://kolbi.cz/SetUserFTA.zip
set downloadCMD=bitsadmin /transfer myDownloadJob /download /priority normal
set nvimQtExePathFile=%~dp0nvim-qt.exe-path.txt
set nvimQtFileAssociationsFile=%~dp0file-associations.txt

for /f %%a in (%nvimQtExePathFile%) do (
  set nvimQtExePath=%%a
  break
)

:: Setup SetUserFTA utility to add nvim-qt.exe ProgID file associations
echo[
echo Setting up SetUserFTA utility to add nvim-qt.exe ProgID file associations...
:SetUserFTASetup
if exist %setUserFTAExe% (
  goto :MainSetup
) else if exist %setUserFTAZip% (
  :: Unzip SetUserFTA utility
  echo[
  echo - Unzipping SetUserFTA utility...
  call :UnZipFile "%setUserFTADir%" "%setUserFTAZip%"
  rm %setUserFTAZip%
) else (
  :: Download SetUserFTA utility
  echo[
  echo - Downloading SetUserFTA utility...
  %downloadCMD% %setUserFTAURL% %setUserFTAZip%
)

goto :SetUserFTASetup

:MainSetup

:: Set nvim-qt.exe ProgID
echo[
echo Setting nvim-qt.exe ProgID...
reg add "HKCR\Applications\nvim-qt.exe" /f
reg add "HKCR\Applications\nvim-qt.exe\shell" /f
reg add "HKCR\Applications\nvim-qt.exe\shell\open" /f
reg add "HKCR\Applications\nvim-qt.exe\shell\open\command" /f
reg add "HKCR\Applications\nvim-qt.exe\shell\open\command" /t REG_SZ /d "%nvimQtExePath% %%1" /f

:: Set file & directory 'Edit with Neovim' context menu item
echo[
echo Setting file ^& directory 'Edit with Neovim' context menu item...
reg add "HKCR\AllFilesystemObjects\shell\Edit with Neovim" /f
reg add "HKCR\AllFilesystemObjects\shell\Edit with Neovim" /v Icon /t REG_SZ /d "%nvimQtExePath%" /f
reg add "HKCR\AllFilesystemObjects\shell\Edit with Neovim\command" /f
reg add "HKCR\AllFilesystemObjects\shell\Edit with Neovim\command" /t REG_SZ /d "%nvimQtExePath% %%1" /f

:: Set file associations from .\file-associations.txt
echo[
echo Setting file associations from .\file-associations.txt...
%setUserFTAExe% %nvimQtFileAssociationsFile%

echo[
echo FINISHED
endlocal
exit /B %errorlevel%

:UnZipFile <ExtractTo> <newzipfile>
set extractVBS="%temp%\extractVBS.vbs"
if exist %extractVBS% del /f /q %extractVBS%
>%extractVBS%  echo Set fso = CreateObject("Scripting.FileSystemObject")
>>%extractVBS% echo If NOT fso.FolderExists(%1) Then
>>%extractVBS% echo fso.CreateFolder(%1)
>>%extractVBS% echo End If
>>%extractVBS% echo set objShell = CreateObject("Shell.Application")
>>%extractVBS% echo set FilesInZip=objShell.NameSpace(%2).items
>>%extractVBS% echo objShell.NameSpace(%1).CopyHere(FilesInZip)
>>%extractVBS% echo Set fso = Nothing
>>%extractVBS% echo Set objShell = Nothing
cscript //nologo %extractVBS%
if exist %extractVBS% del /f /q %extractVBS%
exit /B 0
