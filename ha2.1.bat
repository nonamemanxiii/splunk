@setlocal enableextensions enabledelayedexpansion
@echo off
set ipaddr=%1
set /p oldstate=<"C:\Program Files\SplunkUniversalForwarder\etc\system\local\status.txt"
set state=down

for /f "tokens=6" %%a in ('ping -n 1 !ipaddr!') do (
        echo "x%%a" | findstr "TTL=" > nul
        If not errorlevel 1 set state=up
)

if not !state!==!oldstate! (
    if !oldstate!==up (
                COPY /y "C:\Program Files\SplunkUniversalForwarder\etc\system\local\outputs.conf.pre_bak" "C:\Program Files\SplunkUniversalForwarder\etc\system\local\outputs.conf"
                net stop SplunkForwarder
                net start SplunkForwarder
        )
    if !oldstate!==down (
                COPY /y "C:\Program Files\SplunkUniversalForwarder\etc\system\local\outputs.conf.pre_ori" "C:\Program Files\SplunkUniversalForwarder\etc\system\local\outputs.conf"
                net stop SplunkForwarder
                net start SplunkForwarder
        )
        <nul set /p =%state%>"C:\Program Files\SplunkUniversalForwarder\etc\system\local\status.txt"
)

endlocal
