@echo off
setlocal enabledelayedexpansion

echo Checking for FFmpeg installation...
where ffmpeg >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] FFmpeg was NOT found in your system PATH.
    echo Please install FFmpeg before running this converter.
    pause
    exit /b
)

echo [SUCCESS] FFmpeg detected. Starting OpenH264 Conversion...
mkdir output 2>nul

for %%f in (*.mp4 *.mkv *.avi) do (
    if not "%%~dpfoutput\"=="%%~dpf" (
        echo Converting: %%f
        ffmpeg -i "%%f" -c:v libopenh264 -profile:v high -b:v 2M -c:a aac -b:a 128k "output\%%~nf_openh264.mp4" -y
    )
)

echo Conversion complete. Check the 'output' folder.
pause
