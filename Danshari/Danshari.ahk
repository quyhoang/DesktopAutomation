#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 3
FileEncoding, UTF-8			

TrayTip, Have a nice day!, You can start using Danshari now, 1, 17
SoundPlay *-1

#include %A_ScriptDir%\Danshari_message.ahk
#include %A_ScriptDir%\Danshari_initialization.ahk

; #include %A_ScriptDir%\Danshari_GUI.ahk
MsgBox,64, Getting started, %welcomeMessage%, 300

#include %A_ScriptDir%\Danshari_manageclipboard.ahk
#include %A_ScriptDir%\Danshari_autoinsert.ahk
#include %A_ScriptDir%\Danshari_lookup.ahk
#include %A_ScriptDir%\Danshari_manageclipboard.ahk

; Define hotkeys to pause/resume the script
LShift & Esc::Suspend, Toggle
return