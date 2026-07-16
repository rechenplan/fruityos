@echo off
rem DOS phase: materialize the two platform Orgasm seeds.
rem Every filename used here obeys the DOS 8.3 convention.

if not exist out md out

echo Building Linux seed Orgasm...
petit.com < orglin.pm > out\orgseed.elf
if errorlevel 1 goto fail

echo Building Windows seed Orgasm...
petit.com < orgwin.pm > out\orgseed.exe
if errorlevel 1 goto fail

echo.
echo Seed Orgasm executables are in stage0\out.
echo Continue with linux.sh on Linux or win64.bat on Windows.
goto done

:fail
echo Stage-0 seed generation failed.

:done
