@echo off
java -cp "%~dp0monkeybrains.jar"; com.garmin.monkeybrains.Monkeybrains -a "%~dp0api.db" -u "%~dp0devices.xml" %*
