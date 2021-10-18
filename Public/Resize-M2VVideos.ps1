
$ROMS = $(Get-ChildItem *.m2v).BaseName

foreach ($rom in $ROMS) {
    ffmpeg.exe -y -i "$rom.m2v" -b:v 2000k -vcodec mpeg2video -filter:v yadif -s 320x240 "$rom.mpg"
    Sleep 1
    ffmpeg.exe -y -i "$rom.mpg" -vcodec copy -an "$rom.m2v"
    $tmp += "+${rom}.m2v"
    Sleep 1
    Remove-Item "$rom.mpg"
    Sleep 1
}

#Sleep 5
#cmd /c copy /b $tmp.SubString(1) ace.m2v