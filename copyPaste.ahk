#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#singleInstance force
SetTitleMatchMode, 2

;=======================================================================================
; Cut - Copy - Paste
; ======================================================================================

~F20::
	Clipboard := ""
	SendInput ^c ;copy selected text
	ClipWait, 0.5
	if ErrorLevel
	{
		SendInput {Left}
	}
	return
	
~F21::
	SendInput ^v
	if (Clipboard == "")
	SendInput {Right}
	return

~F19 & F20::
	SendInput ^x
	return
	
~F19 & Mbutton::
	if WinActive("ahk_exe xtop.exe")
	{
		sendInput ^d
	}
	else
	{
		Clipboard := ""
		SendInput, ^c
		ClipWait, 0.2
		if (Clipboard == "")
		{
			SendInput ^w
			return
		}
	}
	SendInput ^x
	return
