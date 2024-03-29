#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#singleinstance, force

SetTitleMatchMode, 2

Run, D:\AHK_CreoParametric\CreoAutomation.ahk

TrayTip, Be greater today!, Everyone believes in you, 1, 17

; Change keyboad layout
~RShift & LShift::
Send {LWin Down}{Space}{LWin Up}
return


Alt::
if (A_PriorHotkey != "Alt" or A_TimeSincePriorHotkey > 400)
{
    ; Too much time between presses, so this isn't a double-press.
	KeyWait, Xbutton1
	return
}
Clipboard := ""
SendInput, ^c
ClipWait, 2
searchKey := "https://mazii.net/search/word?dict=javi&query=" . Clipboard . "&hl=vi-VN"
Run %searchKey%
sleep 1000
click MButton
return


Alt::
if (A_PriorHotkey != "Alt" or A_TimeSincePriorHotkey > 400)
{
    ; Too much time between presses, so this isn't a double-press.
	KeyWait, Xbutton1
	return
}
Clipboard := ""
SendInput, ^c
ClipWait, 2
searchKey := "https://mazii.net/search/word?dict=javi&query=" . Clipboard . "&hl=vi-VN"
Run %searchKey%
sleep 1000
click MButton
return


Alt::
if (A_PriorHotkey != "Alt" or A_TimeSincePriorHotkey > 400)
{
    ; Too much time between presses, so this isn't a double-press.
	KeyWait, Xbutton1
	return
}
Clipboard := ""
SendInput, ^c
ClipWait, 2
searchKey := "https://mazii.net/search/word?dict=javi&query=" . Clipboard . "&hl=vi-VN"
Run %searchKey%
sleep 1000
click MButton
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
		SendInput ^v
		return
	}
	SendInput {Right} 
	return
}
else if WinActive("VNU Lic")
{
	if GetKeyState("XButton2", "P")
	{
		SendInput ^v
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
	sendInput ^v
}	
}
else if WinActive("Edit Current") or WinActive("Add") or WinActive("Browse") ;anki
{
	sendInput ^v
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
		SendInput ^v
	return
}	
}	
else
{
	SendInput ^v
}
return


;==================================================
; Mouse
;==================================================

ScrollLock & F10::Left
return
ScrollLock & F11::Right
return

F7 & F10:: ; refer synapse/razer
if WinActive("Netflix - Brave")
{
	SendInput a
	return
}
else
send ^x
return

Control & F11::
Clipboard := ""
SendInput, ^c
ClipWait, 2
Run https://keep.google.com/u/0/
sleep, 2000
SendInput, ^v
return

F7 & F11:: ; yomichan search. Yomichan seperate search windows must exist.
Clipboard := ""
SendInput ^c ; select all and copy
ClipWait, 2
If ErrorLevel
	return
If ErrorLevel
	return
WinActivate, Yomichan Search
SendInput, {Home}
Click, 172 110
SendInput ^a^v{Enter}
return


F7 & MButton:: ;Mbutton to close current window
{
	;WinGetActiveTitle, TitleBefore
	SendInput ^w
	if Winactive("Edit Current") ; finish editing Anki Card
	WinClose
	 
	return
}





/*
	;==================================================	
	Search
	;==================================================	
*/
{
	F12::
	if not WinActive("ahk_exe xtop.exe") 
	{
	Clipboard := ""
	SendInput ^c ; select all and copy
	ClipWait, 1

	WinActivate, Yomichan Search
	SendInput, {Home}
	Click, 172 110
	SendInput ^a^v{Enter}
	}
	return

	; Search thivien.net
	F7 & RButton::
	Clipboard := ""
	SendInput, ^c
	ClipWait, 2
	searchKey := "https://hvdic.thivien.net/whv/" . Clipboard
	Run %searchKey%
	return
	
	; Search similar Kanji
	RShift & F11::
	Clipboard := ""
	SendInput, ^c
	ClipWait, 2
	searchKey := "https://niai.mrahhal.net/similar?q=" . Clipboard
	Run %searchKey%
	return
	
	; Search alc
	Xbutton2 & NumpadEnter::
	Clipboard := ""
	
	SendInput, ^c
	ClipWait, 2
	searchKey := "https://eow.alc.co.jp/search?q=" . Clipboard
	Run %searchKey%
	sleep 1000
	click MButton
	return
	
; Search Google
	Xbutton2 & WheelUp::
	::sgg::
	Clipboard := ""
	SendInput, ^c
	ClipWait, 2
	StringReplace, Clipboard, Clipboard, %A_Space%, +, All
	searchKey := "https://www.google.com/search?q=" . Clipboard
	Run %searchKey%
	return
	
; Search Mazii
	Xbutton2 & WheelDown::
	Clipboard := ""
	SendInput, ^c
	ClipWait, 2
	searchKey := "https://mazii.net/search/word?dict=javi&query=" . Clipboard . "&hl=vi-VN"
	Run %searchKey%
	sleep 1000
	click MButton
	return
}


/*
	;==================================================	
	Volume control
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

/*
	;==================================================
	Invoke programs
	;==================================================
*/
{
	<+w:: ; windows spy
	Run C:\Program Files\AutoHotkey\WindowSpy.exe
	WinActivate
	return
	
	>!v:: ;VLC player
	Run "C:\Program Files (x86)\VideoLAN\VLC\vlc.exe" 
	WinWait, VLC media player
	WinMaximize ; Use the window found by WinWait.
;open VLC media player. Alt and v for vlc
;set full screen (to get position of the A-B repeat symbol
	return
}


/*
;==================================================
; Program specific
;==================================================
*/

#IfWinActive, Foxit PDF Reader
F7 & WheelUp::
Send ^2
return
#IfWinActive 

/*
	Audacity
*/
#IfWinActive ahk_class wxWindowNR ;Audacity
/*
<^T:: ;audacity shortcuts to truncate
WinMenuSelectItem, ahk_class wxWindowNR, ,Effect, Truncate Silence
return*/

>^S:: ; audacity shortcut save as
WinMenuSelectItem, ahk_class wxWindowNR, ,File,Export,Export as MP3
return
#IfWinActive	


/*
	VLC
*/
#IfWinActive ahk_class Qt5QWindowIcon ; VLC
; A B repeat in VLC media player. l for loop. Right shift and l
>+l::
Click, 20, 920
; this is the position gotten by Windows Spy
return
#IfWinActive


;=======================================
; Ahk editor shortcut
; ======================================
#include %A_ScriptDir%\notepad++ahk.ahk
;=======================================
; Hotstrings
;=======================================
#include %A_ScriptDir%\hotstring.ahk
;=======================================
; Anki shortcut
;=======================================
#include %A_ScriptDir%\anki.ahk
;=======================================
; Brave shortcut
;=======================================
#include %A_ScriptDir%\brave.ahk

~Pause & End:: ;minimize all windows and open sleep dialog
SendInput, #m
Sleep, 1000
SendInput, !{F4} ; Open Shutdown Windows
WinWaitActive, Shut Down Windows
SendInput, {Up} ; default selection is Shutdown, Send Up to move to Sleep
return  

~Pause & ESC::Exitapp