@ECHO OFF

for %%f in (*.m2v) do (
    mediainfo.exe --Output=Video;%%FrameRate%% "%%f"
    REM FOR /F %%I IN ('mediainfo.exe --Output=Video;%%FrameRate%%') DO ( SET var=%%I )
    REM ECHO %var%
    REM mediainfo.exe --Output=Video;%FrameRate%
REM ffmpeg.exe -loglevel fatal -stats -i "%%f" -codec:v mpeg2video -an -s 320x240 -r 23.976 -b:v 3000k -maxrate 4000k -g 18 -bf 2 converted\%%f
REM if errorlevel 1 goto error
)
REM :error

REM ffmpeg.exe -loglevel fatal -stats -i tmp\dl2-00002.m2v -codec:v mpeg2video -an -s 320x240 -r 29.970 -b:v 3000k -maxrate 4000k -g 18 -bf 2 converted\dl2-00002.m2v

REM ffmpeg.exe -loglevel fatal -stats -i "%%f" -codec:v mpeg2video -an -s 640x480 -r 23.976 -b:v 2000k -maxrate 4000k -g 18 -bf 2 converted\%%f