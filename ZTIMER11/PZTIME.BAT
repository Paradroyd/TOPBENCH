@echo off
rem
rem ***************************************************************
rem * Batch file PZTIME.BAT, which builds and runs the precision  *
rem * Zen Timer program PZTEST.EXE to time the code named as the  *
rem * command-line parameter. To time the code in MOVTST.ASM,     *
rem * type the DOS command:                                       *
rem *                                                             *
rem * pztime movtst.asm                                           *
rem *                                                             *
rem * Note that TASM and TLINK must be in the current directory   *
rem * or on the current path in order for this batch file to      *
rem * work.                                                       *
rem ***************************************************************
rem
rem Make sure a file to test was specified
rem
if not x%1==x goto ckexist
echo ***************************************************************
echo * Please specify a file to test.                              *
echo ***************************************************************
goto end
rem
rem Make sure the file exists.
rem
:ckexist
if exist %1 goto docopy
echo ***************************************************************
echo * The specified file, "%1," doesn't exist
echo ***************************************************************
goto end
rem
rem copy the file to measure to TESTCODE
rem
:docopy
copy %1 testcode
tasm pztest;
if errorlevel 1 goto errorend
tlink pztest+pztimer;
if errorlevel 1 goto errorend
pztest
goto end
:errorend
echo ****************************************************************
echo * An error occurred while building the precision Zen timer.	*
echo ****************************************************************
:end

