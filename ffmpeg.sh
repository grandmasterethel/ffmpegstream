#! /bin/bash
#
# broadcast to mux with ffmpeg

# Configured to output at 720p.

VBR="2500k"                                    # Bitrate of output
FPS="30"                                       # FPS of output vid
QUAL="faster"                                  # FFMPEG quality preset
STREAM_URL="rtmps://global-live.mux.com:443/app"  # RTMPS SERVER URL
TUNE="zerolatency"
SOURCE="https://player.vimeo.com/external/470096829.hd.mp4?s=d41d108cf07d32c5691d988165a0bde43994b1f6&profile_id=174"              # Source file
KEY="62312d9c-d636-4e3c-a6d5-ca3244445d69"                     # Stream Key

ffmpeg \
    -re -i "$SOURCE" -deinterlace \
    -vcodec libx264 -pix_fmt yuv420p -preset $QUAL -r $FPS -g $(($FPS * 2)) -b:v $VBR \
    -tune $TUNE \
    -acodec libmp3lame -ar 44100 -threads 6 -qscale:v 3 -b:a 712000 -bufsize 512k \
    -flvflags no_duration_filesize \
    -f flv "$STREAM_URL/$KEY"
