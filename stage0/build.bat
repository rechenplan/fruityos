@echo off
rem Rebuild the raw Orgasm bootstraps with platform-blind Petit.
rem Run this file from the stage0 directory under DOS.

petit.com < orgasm-linux-x86_64.pm > ..\bin\bootstrap\linux-x86_64\orgasm.elf
petit.com < orgasm-windows-x86_64.pm > ..\bin\bootstrap\windows-x86_64\orgasm.exe
