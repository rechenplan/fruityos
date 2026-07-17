@echo off
setlocal
rem Host continuation for Windows x86-64.
rem Run from stage0 after build.bat has generated out\orgseed.exe.

if not exist out\orgseed.exe goto noseed

set SEED=out\orgseed.exe
set JBC=out\jbc.exe
set ORGASM=out\orgasm.exe
set MODULE=out\module.asm

echo Seed Orgasm: assembling stage0\jbc.asm
%SEED% ..\lib\windows-x86_64\start.asm jbc.asm ..\lib\windows-x86_64\runtime.asm %JBC%
if errorlevel 1 goto fail

echo JBC: compiling the current Orgasm sources
%JBC% ..\lib\windows-x86_64\pith.jabara ..\jabara\src\orgasm\main.jabara ..\jabara\src\orgasm\lex.jabara ..\jabara\src\orgasm\modern.jabara ..\jabara\src\orgasm\parse.jabara ..\jabara\src\orgasm\emit.jabara %MODULE%
if errorlevel 1 goto fail

echo Seed Orgasm: assembling current orgasm.exe
%SEED% ..\lib\windows-x86_64\start.asm %MODULE% ..\lib\windows-x86_64\runtime.asm %ORGASM%
if errorlevel 1 goto fail

rem Nothing below this point is assembled by the seed.
call :tool windows-x86_64 exe juicer ..\peel\src\juicer\juicer.hr
if errorlevel 1 goto fail
call :tool windows-x86_64 exe concat ..\peel\src\concat\concat.hr
if errorlevel 1 goto fail
call :tool windows-x86_64 exe pish ..\peel\src\pish\pish.hr
if errorlevel 1 goto fail

call :makeorg linux-x86_64 elf
if errorlevel 1 goto fail
call :tool linux-x86_64 elf juicer ..\peel\src\juicer\juicer.hr
if errorlevel 1 goto fail
call :tool linux-x86_64 elf concat ..\peel\src\concat\concat.hr
if errorlevel 1 goto fail
call :tool linux-x86_64 elf pish ..\peel\src\pish\pish.hr
if errorlevel 1 goto fail

call :makeorg fruityos-x86_64 fap
if errorlevel 1 goto fail
call :tool fruityos-x86_64 fap juicer ..\peel\src\juicer\juicer.hr
if errorlevel 1 goto fail
call :tool fruityos-x86_64 fap concat ..\peel\src\concat\concat.hr
if errorlevel 1 goto fail
call :tool fruityos-x86_64 fap pish ..\peel\src\pish\pish.hr
if errorlevel 1 goto fail

if exist %MODULE% del %MODULE%
echo Stage 0 complete. All bootstrap binaries are in stage0\out.
goto done

:tool
echo JBC: %3 for %1
%JBC% ..\lib\%1\pith.jabara %4 %MODULE%
if errorlevel 1 exit /b 1
echo Orgasm: %3.%2
%ORGASM% ..\lib\%1\start.asm %MODULE% ..\lib\%1\runtime.asm out\%3.%2
exit /b %errorlevel%

:makeorg
echo JBC: Orgasm for %1
%JBC% ..\lib\%1\pith.jabara ..\jabara\src\orgasm\main.jabara ..\jabara\src\orgasm\lex.jabara ..\jabara\src\orgasm\modern.jabara ..\jabara\src\orgasm\parse.jabara ..\jabara\src\orgasm\emit.jabara %MODULE%
if errorlevel 1 exit /b 1
echo Orgasm: orgasm.%2
%ORGASM% ..\lib\%1\start.asm %MODULE% ..\lib\%1\runtime.asm out\orgasm.%2
exit /b %errorlevel%

:noseed
echo Missing out\orgseed.exe. Run build.bat under DOS first.
goto fail

:fail
echo Stage-0 host bootstrap failed.
exit /b 1

:done
endlocal
