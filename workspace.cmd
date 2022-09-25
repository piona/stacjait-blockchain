@echo off

set "CTOOLS=%~dp0"
set "CTOOLS=%CTOOLS:~0,-1%"
pushd "%CTOOLS%"

set "PATH=%CTOOLS%;%PATH%"
popd

if "%1" == "" start cmd /K "cd /D "%CTOOLS%""
