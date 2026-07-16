@echo off
rem Reproduce petit.com from petit.pm and compare the exact bytes.

if not exist out md out
petit.com < petit.pm > out\petit2.com
if errorlevel 1 goto fail
fc /b petit.com out\petit2.com
if errorlevel 1 goto fail

echo Petit reproduced itself exactly.
goto done

:fail
echo Petit self-reproduction failed.

:done
