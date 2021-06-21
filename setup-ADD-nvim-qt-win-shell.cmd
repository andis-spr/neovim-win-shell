@echo off
setlocal
cd /d %~dp0

set setUserFTAZip=%~dp0SetUserFTA.zip
set setUserFTADir=%~dp0SetUserFTA
set setUserFTAExe=%setUserFTADir%\SetUserFTA\SetUserFTA.exe
set setUserFTAURL=https://kolbi.cz/SetUserFTA.zip
set downloadCMD=bitsadmin /transfer myDownloadJob /download /priority normal
set nvimQtExePathFile=%~dp0config-nvim-qt-exe-path.txt
set nvimQtFileAssociationsFile=%~dp0config-file-type-associations.txt
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
  goto :MainSetup
) else (
  :: Download SetUserFTA utility
  echo[
  echo - Downloading SetUserFTA utility...
  %downloadCMD% %setUserFTAURL% %setUserFTAZip%
  goto :SetUserFTASetup
)

:MainSetup

:: Set ProgID
echo[
echo Setting nvim-qt.exe ProgID...
reg add "HKCR\Applications\%nvimQtExeString%\shell\open\command" /t REG_SZ /d "%nvimQtExePath% ""%%1""" /f

:: Set Explorer file, directory & drive context menu option
echo[
echo Setting Explorer file, directory ^& drive '%editWithNvimQtString%' context menu option...
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

:: VBS to exract ZIP files
:UnZipFile <ExtractTo> <newzipfile>
set vbs="%temp%\unzip.vbs"
>>%vbs% echo Set fso = CreateObject("Scripting.FileSystemObject")
>>%vbs% echo If NOT fso.FolderExists(%1) Then
>>%vbs% echo fso.CreateFolder(%1)
>>%vbs% echo End If
>>%vbs% echo set objShell = CreateObject("Shell.Application")
>>%vbs% echo set FilesInZip=objShell.NameSpace(%2).items
>>%vbs% echo objShell.NameSpace(%1).CopyHere(FilesInZip)
>>%vbs% echo Set fso = Nothing
>>%vbs% echo Set objShell = Nothing
cscript //nologo %vbs%
if exist %vbs% del /f /q %vbs%

exit /B 0
