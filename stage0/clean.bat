@echo off
rem Remove every file generated beneath stage0\out.

if exist out\*.asm del out\*.asm
if exist out\*.elf del out\*.elf
if exist out\*.exe del out\*.exe
if exist out\*.fap del out\*.fap
if exist out\*.com del out\*.com
if exist out rd out
