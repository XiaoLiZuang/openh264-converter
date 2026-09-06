#!/bin/bash

echo "Checking for FFmpeg installation..."
if ! command -v ffmpeg &> /dev/null; then
    echo "[ERROR] FFmpeg was NOT found in your system PATH."
    echo "Please install it using Homebrew: brew install ffmpeg"
    
    # Native macOS alert dialog for the error
    osascript -e 'display alert "FFmpeg Not Found" message "Please install FFmpeg using Homebrew (brew install ffmpeg) before running this script." as critical'
    exit 1
fi

echo "[SUCCESS] FFmpeg detected. Starting OpenH264 Conversion..."
mkdir -p output

# Process common formats including macOS native .mov files
for f in *.mp4 *.mkv *.avi *.mov; do
    # Check if files exist to avoid empty loop errors
    [ -e "$f" ] || continue
    
    echo "Converting: $f"
    ffmpeg -i "$f" -c:v libopenh264 -profile:v high -b:v 2M -c:a aac -b:a 128k "output/${f%.*}_openh264.mp4" -y
done

echo "Conversion complete. Check the 'output' folder."

# Native macOS system notification upon completion
osascript -e 'display notification "All videos have been successfully converted to OpenH264!" with title "openh264-converter" subtitle "Conversion Complete"'
