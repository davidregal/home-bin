echo 
echo 3e recovery installer
echo 
mount -o rw,remount /dev/block/stl9 /system
rm /system/bin/recovery
cp ${recovery} /system/bin/recovery
chmod 0755 /system/bin/recovery

android_sdk=
adb="bin\adb.exe"
recovery="%~dp0bin\recovery"
tmproot="%~dp0bin\TempRoot.exe"
::
ECHO.
ECHO 3e recovery installer
ECHO.
ECHO make sure USB debugging is turned on
ECHO and plugged in to this computer.
ECHO.
ECHO rageagainstthecage can cause the phone
ECHO to become un-responsive so the phone 
ECHO will be rebooted when install is finished.
ECHO.
ECHO.
ECHO Press any key when ready
PAUSE >nul
::
:start
CLS
ECHO.
::
:tryagain
%tmproot%
IF ERRORLEVEL 1 GOTO :error
ECHO Installing modified recovery
%adb% start-server >nul
%adb% -d wait-for-device >nul
%adb% -d shell mount -o rw,remount /dev/block/stl9 /system
%adb% -d shell rm /system/bin/recovery
%adb% -d push %recovery% /system/bin/recovery
%adb% -d shell chmod 0755 /system/bin/recovery
GOTO :finished
::
:finished
ECHO.
ECHO Finished.
ECHO.
ECHO 1......Reboot into recovery
ECHO 2......Reboot (recomended)
ECHO 3......Quit 
ECHO.
SET /P finished=what do you want to do?: 
ECHO.
IF %finished%==1 (GOTO recovery)
IF %finished%==2 (GOTO reboot)
IF %finished%==3 (GOTO quit)
GOTO :finished
::
:error
ECHO.
ECHO temp root failed! install cannot continue.
ECHO.
ECHO 1......Try again (may crash)
ECHO 2......Reboot and try again (recomended)
ECHO 3......Quit
ECHO.
SET /P failed=what do you want to do: 
ECHO.
IF %failed%==1 (GOTO tryagain)
IF %failed%==2 (GOTO restart)
IF %failed%==3 (GOTO quit)
GOTO :error
::
:recovery
ECHO Rebooting into recovery.
%adb% -d reboot recovery
%adb% kill-server
ECHO.
ECHO Press any key to exit
PAUSE >nul
GOTO :quit
::
:reboot
ECHO Rebooting.
%adb% -d reboot
%adb% kill-server
ECHO.
ECHO Press any key to exit
PAUSE >nul
GOTO :quit
::
:restart
ECHO Starting adb server
%adb% start-server >nul
%adb% -d reboot >nul
ECHO Waiting for phone to be ready
%adb% -d wait-for-device >nul
GOTO :start
::
:quit
%adb% kill-server
EXIT
::