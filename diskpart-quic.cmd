@echo off
cd /d %~dp0
openfiles > nul
if errorlevel 1 (
    PowerShell.exe -Command Start-Process \"%~f0\" -Verb runas
    exit
)
echo [Created by https://github.com/kododake]
echo; > diskpart.tmp
echo list disk >> diskpart.tmp
diskpart /s diskpart.tmp
set /p selectdisk=select disk(num):
echo; > diskpart.tmp
echo select disk %selectdisk% >> diskpart.tmp
echo; >>diskpart.tmp
set /p parnum=!final![Number of partitions greater than expected](num):
FOR /L %%i IN (1,1,%parnum%) DO (
echo select partition %%i >> diskpart.tmp
echo; >>diskpart.tmp
echo delete partition override >> diskpart.tmp
echo; >>diskpart.tmp
)
diskpart /s diskpart.tmp
del diskpart.tmp