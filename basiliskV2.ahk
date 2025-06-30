#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Search
~F19 & WheelDown:: ; Basilisk V2 mouse
gosub, yomitanSearch
return

; CopyPaste
;=======================================================================================
; Cut - Copy - Paste
; ======================================================================================
LControl & XButton1::
~F20::
	Clipboard := ""
	SendInput ^c ;copy selected text
	ClipWait, 0.5
	if ErrorLevel
	{
		SendInput {Left}
	}
	return

LControl & XButton2::
~F21::
	SendInput ^v
	; if (Clipboard == "")
	; SendInput {Right}
	return

LControl & MButton::
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