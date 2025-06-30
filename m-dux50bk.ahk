#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 2
FileEncoding, UTF-8


; ; Danshari
; ~XButton2 & WheelUp::
; gosub, launchHayanabi
; return

; ~XButton1 & WheelUp::
; gosub, launchYukarilink
; return

; ~XButton2 & WheelDown::
; gosub, launchClipGenie
; return

; Search
Shift & F12:: ; yomichan search. Yomichan seperate search windows must exist.
gosub, yomitanSearch
return

; Close current object
F7 & MButton::
SendInput ^w
return

;==================================================
; Mouse tilt left
;==================================================

F10::
if WinActive("YouTube - Brave") ; when Youtube is opened, F10/F11 is used for winding
	; but if XButton2 is pressed, the two keys will be used for copy/paste
{
	if GetKeyState("XButton2", "P")
	{
		SendInput ^c
		return
	}
	SendInput {Left}
	return
}
else if WinActive("VNU Lic")
{
	if GetKeyState("XButton2", "P")
	{
		SendInput ^c
		return
	}
	SendInput {Right}
	return
}
else if WinActive("N1GD1")
{
	SendInput z
	return
}	
else if WinActive("ahk_exe anki.exe")
{
	clipboard := ""
	sendInput ^c
	ClipWait, 0.2
	if ErrorLevel
	{
		SendInput {Enter}
		return
	}
	return
}	
else if WinActive("Netflix - Brave")
{
	SendInput s
	return
}	
else if WinActive("- Yomichan Search")
{
	if GetKeyState("XButton2", "P")
		SendInput !{Left}
	else
		SendInput ^c
	return
}	
else	
{
	SendInput ^c
	return
}
return

;==================================================
; Mouse tilt Right
;==================================================
F11::
if WinActive("YouTube - Brave")
{
	if GetKeyState("XButton2", "P")
	{
		SendInput ^+v
		return
	}
	SendInput {Right} 
	return
}
else if WinActive("VNU Lic")
{
	if GetKeyState("XButton2", "P")
	{
		SendInput ^+v
		return
	}
	SendInput {Left} 
	return
}
else if WinActive("N1GD1")
{
	SendInput x
	return
}
else if WinActive("Edit Current") or WinActive("Add") or WinActive("Browse") ;anki
{
	sendInput ^+v
	return
}	
else if WinActive("ahk_exe anki.exe")
{
	SendInput {F5}
	return
}
else if WinActive("Netflix - Brave")
{
	SendInput d
	return
}
else if WinActive("- Yomichan Search")
{
	if GetKeyState("XButton2", "P")
		SendInput !{Right}
	else
		SendInput ^+v
	return
}		
else
{
	SendInput ^+v
	return
}
return

F7 & F10:: 
send ^c
return

F7 & F11:: 
send ^+v
return

