#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 2
FileEncoding, UTF-8


; Danshari
~XButton2 & WheelUp::
gosub, launchHayanabi
return

~XButton1 & WheelUp::
gosub, launchYukarilink
return

~XButton2 & WheelDown::
gosub, launchClipGenie
return

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
SetTitleMatchMode, 2
if WinActive(" - YouTube - Brave")
{
	clipboard := ""
	sendInput ^c
	ClipWait, 0.2
	if ErrorLevel
	{
		SendInput {Left}
		return
	}
	return
}
if WinActive("VNU Lic")
{
	SendInput {Right}
	return
}
else if WinActive(" - VLC media player")
{
	SendInput {Left}
	return
}	
if WinActive("ahk_exe anki.exe")
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
if WinActive("Netflix - Brave")
{
	SendInput s
	return
}	
if WinActive("- Yomitan Search")
{
	clipboard := ""
	sendInput ^c
	ClipWait, 0.2
	if ErrorLevel
	{
		SendInput !{Left}
		return
	}
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
SetTitleMatchMode, 2
if WinActive("YouTube - Brave")
{
	SendInput {Right}
	return
}
else if WinActive("VNU Lic")
{
	SendInput {Left} 
	return
}
else if WinActive(" - VLC media player")
{
	SendInput {Right}
	return
}
else if WinActive("Edit Current") or WinActive("Add") or WinActive("Browse") ; anki
{
	sendInput ^v
	return
}	
else if WinActive("ahk_exe anki.exe")
{
	SendInput {F5} ; r - repeat
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
		SendInput ^v
	return
}		
else
{
	SendInput ^v
	return
}
return

F7 & F10:: 
send ^c
return

F7 & F11:: 
send ^v
return

~F7::
if (A_PriorHotkey != "~F7" or A_TimeSincePriorHotkey > 400)
{
    ; Too much time between presses, so this isn't a double-press.
	KeyWait, F7
	return
}
send ^x
return

F12::
if WinActive("ahk_exe Obsidian.exe")
SendRaw, ###
return
 
#IfWinActive  - VLC media player
MButton::
{
	SendInput {Space}
	return
}
#IfWinActive

