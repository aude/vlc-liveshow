@echo off

title VLC LiveShow

REM ------------ Metadata -------------
REM -----------------------------------
REM VLC LiveShow is a batch file used to launch VLC, programmed to output to secondary monitor.
REM One can optionally pass files desired to launch alongside VLC, eg. by "drag-and-drop"-ing such files onto this script in Windows Explorer.

REM VLC LiveShow is crafted by Asbjørn Apeland.


REM ------------ Copyright ------------
REM -----------------------------------
REM Copyright (C) 2011-toyear  Free Software Foundation, Inc
REM 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA
REM
REM This program is free software: you can redistribute it and/or modify
REM it under the terms of the GNU General Public License as published by
REM the Free Software Foundation, either version 3 of the License, or
REM (at your option) any later version.
REM
REM This program is distributed in the hope that it will be useful,
REM but WITHOUT ANY WARRANTY; without even the implied warranty of
REM MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
REM GNU General Public License for more details.
REM
REM You may have received a copy of the GNU General Public License
REM along with this program.  If not, see <http:REMwww.gnu.org/licenses/>.


REM ------ Userdefined variables ------
REM -----------------------------------
REM Specify custom vlc.exe location on the line below.
set userpath="C:\PortableApps\VLCPortable\VLCPortable.exe"
REM Specify custom horisontal video placement (horistonal screen resolution + ~20) on the line below.
set userscreen=1930


REM --------- Other variables ---------
REM -----------------------------------
set path1="C:\Progra~1\VideoLAN\VLC\vlc.exe"
set path2="C:\Progra~2\VideoLAN\VLC\vlc.exe"
set path3="%cd%\vlc.exe"
set path4="%appdata%\VideoLAN\VLC\vlc.exe"
set input=%*


for %%i in (%userpath%,%path1%,%path2%,%path3%,%path4%) do (
	if exist %%i call:runvlc %%i
)

echo Could not locate vlc.exe. Please edit this file with the correct path to vlc.exe
pause
exit


REM ------------ Functions ------------
REM ------------ down here ------------

:runvlc
echo Disable auto-play of following video(s) ?
choice /c yn
if %errorlevel%==2 set continuousplay=--no-play-and-stop
if %errorlevel%==1 set continuousplay=--play-and-stop
echo.
echo If the video is played on your primary monitor, then please edit this file with a horisontal screen resolution just higher than your primary monitor's horisontal screen resolution.
echo Eg. if your screen resolution is "1280x756", you would edit the "userscreen" variable inside this script to "1290".
REM Disable unwanted OSDs, fullscreen it, external playscreen, deinterlace with yadif(2x) and play on wanted screen.
start "" %~1 --fullscreen --no-embedded-video --no-qt-fs-controller --no-osd --no-video-title-show --deinterlace=-1 --deinterlace-mode=yadif2x --video-x=%userscreen% --video-y=100 %continuousplay% %input%

exit
