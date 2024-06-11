#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#singleInstance force
SetTitleMatchMode, 2


/*
	;==================================================	
	Volume control using mouse buttons only
	;==================================================	
*/
{ 
	F7 & WheelUp:: 
	Send {Volume_Up}  ; Raise the master volume by 1 interval (typically 5%).
	return

	F7 & WheelDown:: 
	Send {Volume_Down}  ; Lower the master volume by 3 intervals.
	return
}
