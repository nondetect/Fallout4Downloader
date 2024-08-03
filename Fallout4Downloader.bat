@echo off
echo.
title Fallout4Downloader
echo. == Fallout4Downloader ==
echo. A basic batch file that uses the official SteamCMD tool can download the necessary version of Fallout 4 (1.10.163.0) required for Fallout London.
echo Downloading SteamCMD from official Valve Developer Community page (https://developer.valvesoftware.com/wiki/SteamCMD)
echo.
if not exist "scmd" ( 
	mkdir scmd 
	cd scmd 
) else ( 
	cd scmd 
)
if not exist "steamcmd.exe" (
	curl -O -J -L -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip && tar -xf .\steamcmd.zip && del .\steamcmd.zip >> nul
	) else (
	echo Running Steamcmd...
)
set /p user= "What is your Steam username? - " 
call :steamcmdscripttxt
powershell -Command "(gc .\f4lsc.txt) -replace 'user', '%user%' | Out-File -encoding ASCII .\f4lsc.txt"
steamcmd +runscript .\f4lsc.txt
setlocal
set "fdd=.\scmd\steamapps\content\app_377160\depot"
set "ffd=Fallout 4"
cd ..\
mkdir "%ffd%"
set "depots=377161 377163 377162 377164 435870 435871 435880 435881 435882 480630 480631 393885 490650 393895"
for %%i in (%depots%) do ( 
	robocopy /MOVE /IS /E /NFL /NDL /NJH /NJS /NP "%fdd%_%%i" ".\%ffd%" 
)
powershell -Command "Remove-Item .\scmd -Recurse -Exclude '%ffd%'" >> nul
cls
endlocal
echo.
echo DONE. Press any key to exit
pause >> nul
goto :EOF

:steamcmdscripttxt
(
echo.@ShutdownOnFailedCommand 1
echo.@sSteamCmdForcePlatformType windows
echo.login %user%
echo.download_depot 377160 377161 7497069378349273908
echo.download_depot 377160 377162 5847529232406005096
echo.download_depot 377160 377163 5819088023757897745
echo.download_depot 377160 377164 2178106366609958945
echo.//dlc Automaton
echo.download_depot 377160 435870 1691678129192680960
echo.download_depot 377160 435871 5106118861901111234
echo.//dlc Wasteland
echo.download_depot 377160 435880 1255562923187931216
echo.//dlc FarHarbor 
echo.download_depot 377160 435881 1207717296920736193
echo.download_depot 377160 435882 8482181819175811242
echo.//dlc Contraptions
echo.download_depot 377160 480630 5527412439359349504
echo.//dlc Vault-Tec
echo.download_depot 377160 480631 6588493486198824788
echo.download_depot 377160 393885 5000262035721758737
echo.//dlc Nuka World 
echo.download_depot 377160 490650 4873048792354485093
echo.download_depot 377160 393895 7677765994120765493
echo.quit
) >> .\f4lsc.txt
goto :EOF
