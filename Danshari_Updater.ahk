; AutoHotkey Script to Check for Updates and Download
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 3
FileEncoding, UTF-8

DetectHiddenWindows, On 
SetTitleMatchMode, 2
IfWinExist, Danshari.exe
WinClose

FileDelete, Danshari.exe
FileMove, newVersion.exe, Danshari.exe, 1 ; Overwrite. Make the program more robust
TrayTip, Update Completed, Danshari is successfully updated to latest version!, 1, 17
Run, Danshari.exe
ExitApp
