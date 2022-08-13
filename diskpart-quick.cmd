@echo off
cd /d %~dp0
openfiles > nul
if errorlevel 1 (
    PowerShell.exe -Command Start-Process \"%~f0\" -Verb runas
    exit
)
echo [Created by https://github.com/kododake]
echo; > diskpart-quick.tmp
echo list disk >> diskpart-quick.tmp
diskpart /s diskpart-quick.tmp
set /p selectdisk=select disk(num):
echo; > diskpart-quick.tmp
echo select disk %selectdisk% >> diskpart-quick.tmp
echo; >>diskpart-quick.tmp
set /p parnum=!final![Please enter more than the expected number of partitions](num):
FOR /L %%i IN (1,1,%parnum%) DO (
echo select partition %%i >> diskpart-quick.tmp
echo; >>diskpart-quick.tmp
echo delete partition override >> diskpart-quick.tmp
echo; >>diskpart-quick.tmp
)
echo ====LOG===========
diskpart /s diskpart-quick.tmp
echo;
echo; > diskpart-quick2.tmp
echo list disk >> diskpart-quick2.tmp
diskpart /s diskpart-quick2.tmp
echo;
echo [-----COMPLETE-----]
echo;
echo Press Enter to delete the temporary file.
pause
del diskpart-quick.tmp
del diskpart-quick2.tmp
