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
set editWithNvimQtString=Edit with Neovim
set nvimQtExeString=nvim-qt.exe

for /f %%a in (%nvimQtExePathFile%) do (
  set nvimQtExePath=%%a
  break
)

:: Setup SetUserFTA utility to add ProgID file associations
echo[
echo Setting up SetUserFTA utility to add %nvimQtExeString% ProgID file associations...
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

:: Set ProgID
echo[
echo Setting nvim-qt.exe ProgID...
reg add "HKCR\Applications\%nvimQtExeString%\shell\open\command" /t REG_SZ /d "%nvimQtExePath% ""%%1""" /f

:: Set Explorer file, directory & drive context menu item
echo[
echo Setting Explorer file, directory ^& drive '%editWithNvimQtString%' context menu item...
reg add "HKCR\AllFilesystemObjects\shell\%editWithNvimQtString%" /v Icon /t REG_SZ /d "%nvimQtExePath%" /f
reg add "HKCR\AllFilesystemObjects\shell\%editWithNvimQtString%\command" /t REG_SZ /d "%nvimQtExePath% ""%%1""" /f
reg add "HKCR\Drive\shell\%editWithNvimQtString%" /v Icon /t REG_SZ /d "%nvimQtExePath%" /f
reg add "HKCR\Drive\shell\%editWithNvimQtString%\command" /t REG_SZ /d "%nvimQtExePath% ""%%1""" /f

:: Set file associations
echo[
echo Setting the file associations...
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
