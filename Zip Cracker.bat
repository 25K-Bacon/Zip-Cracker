@echo off
echo.

if not exist "C:\Program Files\7-Zip" (
	echo 7-Zip isn't installed or not found, Please make sure 7-Zip is installed in "C:\Program Files\7-Zip".
	pause
	exit
)

set /p archive="Enter Archive: "
if not exist %archive% (
	echo Archive not found, please make sure it's the right path.
	pause
	exit
)

set /p name="Enter Name: "

set /p wordlist="Enter Wordlist: "
if not exist %wordlist% (
	echo Wordlist not found, please make sure it's the right path.
	pause
	exit
)

for /f %%a in (%wordlist%) do (
	set pass=%%a
	call :attempt
)
echo Password is not in the Wordlist.

:attempt
"C:\Program Files\7-Zip\7z.exe" x -p%pass% "%archive%" -o"%name%" -y > nul 2>&1
echo attempt: %pass%
if /I %errorlevel% EQU 0 (
	echo Password Found: %pass%
	pause
	exit
)
