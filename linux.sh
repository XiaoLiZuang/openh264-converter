#!/bin/bash

echo "Checking for FFmpeg installation..."
if ! command -v ffmpeg &> /dev/null; then
    echo "[ERROR] FFmpeg was NOT found in your system PATH."
    echo "Please install FFmpeg before running this converter."
    exit 1
fi

echo "[SUCCESS] FFmpeg detected. Starting OpenH264 Conversion..."
mkdir -p output

for f in *.mp4 *.mkv *.avi; do
    [ -e "$f" ] || continue
    
    echo "Converting: $f"
    ffmpeg -i "$f" -c:v libopenh264 -profile:v high -b:v 2M -c:a aac -b:a 128k "output/${f%.*}_openh264.mp4" -y
done

echo "Conversion complete. Check the 'output' folder."
