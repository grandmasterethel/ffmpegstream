#! /bin/bash
#
# broadcast to RTMP/RTMPS with ffmpeg

# Configured to output at 720p.

VBR="2500k"                                    # Bitrate of output
FPS="30"                                       # FPS of output vid
QUAL="faster"                                  # FFMPEG quality preset
STREAM_URL="RTMP_SERVER_HERE:443/app"  # RTMPS SERVER URL
TUNE="zerolatency"
SOURCE="INPUT_GOES_HERE"              # Source file
KEY="STREAM_KEY_HERE"                     # Stream Key

ffmpeg \
    -re -i "$SOURCE" -deinterlace \
    -vcodec libx264 -pix_fmt yuv420p -preset $QUAL -r $FPS -g $(($FPS * 2)) -b:v $VBR \
    -tune $TUNE \
    -acodec libmp3lame -ar 44100 -threads 6 -qscale:v 3 -b:a 712000 -bufsize 512k \
    -flvflags no_duration_filesize \
    -f flv "$STREAM_URL/$KEY"
