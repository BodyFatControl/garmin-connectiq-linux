@echo off

rem allow runtime variable assignment to non-existing environment variables (i.e. constants)
setlocal enabledelayedexpansion

rem Check to make sure the proper arguments are provided
if "%~1"=="" goto usage     rem handle no arguments
if "%~1"=="/?" goto usage   rem handle Windows standard help command

SET test=
SET test_id=
SET device_id="square_watch"

SET home="%~dp0"
SET prg_path="%~dpnxs1"
SET app_name="%~nx1"
SET app_name=%app_name: =%
SET test_mode=0

rem TODO: more generic solution for parsing command line arguments
IF NOT "%2"=="" (
    IF NOT "%2"=="/t" (
        SET device_id="%2"
        SHIFT
    )
)

IF NOT "%2"=="" (
    IF "%2"=="-t" (
       SET test_mode=1
       SET test="/t"
    )

    IF "%2"=="/t" (
       SET test_mode=1
       SET test=%2
    )

    IF !test_mode! EQU 1 (
        IF NOT "%3"=="" (
            SET test_id=%3
        )
    ) else (
        @echo ILLEGAL ARGUMENT: %2
        goto :usage
    )
)

rem Execute the call to shell
"%home%shell.exe" --transport=tcp push "%prg_path%" "0:/GARMIN/APPS/%app_name%"
"%home%shell.exe" --transport=tcp tvm "0:/GARMIN/APPS/%app_name%" %device_id% %test% %test_id%
goto :eof  rem Skip past the usage block

rem Print the help/usage information for this script
:usage
@echo Pushes and runs a Connect IQ executable on the Connect IQ simulator. The simulator must be running for this command to succeed.
@echo.
@echo Usage: %0 executable ^[device_id^] ^[/t ^| /t test_name^]
@echo     executable - A Connect IQ executable to run.
@echo     device_id  - The device to simulate. Defaults to "square_watch".
endlocal
exit /B 1
