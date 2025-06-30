#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#singleInstance force
SetTitleMatchMode, 2

; This is temporary fix for the Razer Basilisk V2 before I get a new wheel encoder

~WheelUp::
~WheelDown::
if (GetKeyState("F19")) 
{
   SetTimer, ScrollDown, 100  ; Start continuous scroll
}
return

ScrollDown:
if (!GetKeyState("F19"))
{
	SetTimer, ScrollDown, Off
	return
}
Send {WheelDown}
return
