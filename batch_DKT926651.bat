@ECHO OFF

for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"

set "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"
echo datestamp: "%datestamp%"
echo timestamp: "%timestamp%"
echo fullstamp: "%fullstamp%"

:start
:save_args_as_variables
set RFT_PROJECT_LOCATION=C:\RFT\AA_DotCom
set RFT_SCRIPT_NAME=AA_DotCom.Full_Home_Regression_Test
set RFT_LOGFILE_NAME="unattended_%RFT_SCRIPT_NAME%_%fullstamp%"
goto check_args
:check_args
if "%RFT_PROJECT_LOCATION%" == "" goto missing_args
if "%RFT_SCRIPT_NAME%" == "" goto missing_args
if "%RFT_LOGFILE_NAME%" == "" goto missing_args
goto args_ok
:args_ok
if "%4" == "silent" goto playback
echo.
echo RFT_PROJECT_LOCATION = %RFT_PROJECT_LOCATION%
echo RFT_SCRIPT_NAME = %RFT_SCRIPT_NAME%
echo RFT_LOGFILE_NAME = %RFT_LOGFILE_NAME%
echo IBM_RATIONAL_RFT_ECLIPSE_DIR = %IBM_RATIONAL_RFT_ECLIPSE_DIR%
echo IBM_RATIONAL_RFT_INSTALL_DIR = %IBM_RATIONAL_RFT_INSTALL_DIR%
echo.
echo Initializing RFT Playback...
:playback
java -classpath "C:\Program Files (x86)\IBM\SDP\FunctionalTester\bin\rational_ft.jar" com.rational.test.ft.rational_ft -datastore %RFT_PROJECT_LOCATION% -playback %RFT_SCRIPT_NAME%
if "%4" == "silent" goto end
echo RFT playback complete.
goto end
:missing_args
echo.
echo ERROR: Invalid syntax! Usage: 
echo RFT_PlayScript ProjectPath ScriptName LogName [silent]
goto end
:end 
