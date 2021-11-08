#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;Run Automate_Anki.ahk
;Run Automate_Brave.ahk

#singleinstance, force

SetTitleMatchMode, 2

;==================================================
; Mouse
;==================================================

/*
	; Change keyboad layout
	~XButton2 & RButton::
	Send {LWin Down}
	while GetKeyState("LWin")
	{
		KeyWait, RButton, D, T.4
		If ErrorLevel
		{
			Send {LWin Up}
		}
		else
			Send {Space}
		KeyWait, RButton
	}
	return
	
*/

/*
	; tab switch using forward mouse button
	~XButton2::
	Send {Alt Down}
	while GetKeyState("Alt")
	{
		KeyWait, XButton2, D, T.4
		If ErrorLevel
		{
			Send {Alt Up}
		}
		else
			Send {Tab}
		KeyWait, XButton2
	}
	return
*/

RControl & F1:: ; mapped to mouse buttons
if WinActive("YouTube - Brave")
{
	SendInput {Left}
	return
}
else
{
	SendInput ^c
	return
}
return

RControl & F2::
if WinActive("YouTube - Brave")
{
	SendInput {Right}
	return
}
else
{
	SendInput ^v
	return
}
return

/*
	~MButton:: ;double Mbutton to close current window
	{
		if (A_PriorHotkey != "~MButton" or A_TimeSincePriorHotkey > 400)
		{
	    ; Too much time between presses, so this isn't a double-press.
			KeyWait, MButton
			return
		}
	;WinGetActiveTitle, beforeTitle
		WinGetActiveTitle, TitleBefore
		SendInput ^w
		Sleep, 500
		WinGetActiveTitle, TitleAfter
		If (TitleBefore = TitleAfter)
			WinClose, A
		return
	}
	
*/


~MButton:: ;Mbutton to close current window
{
	WinGetActiveTitle, TitleBefore
	SendInput ^w
	Sleep, 500
	WinGetActiveTitle, TitleAfter
	If (TitleBefore = TitleAfter)
		WinClose, A
	return
}

Xbutton1 & Xbutton2:: ; quick switch window; exclude Creo Parametric
{
	if not WinActive("ahk_exe xtop.exe") 
		SendInput !{Tab}
	return
}

;==================================================
; Hotstrings
;==================================================

::pi::𝝅 
return

:R0*:ntd:: ; send today in Notion
Send, @today{Enter}
return

~ScrollLock & Insert:: ;edited 18-Oct-21 11:35:56
:R*?:tdy::
FormatTime, CurrentDateTime,, dd-MMM-yy hh:mm:ss
SendInput %CurrentDateTime%
return

;==================================================
; Hotkeys
;==================================================

/*
	;==================================================	
	Toggle Input languages
	;==================================================	
*/
{
	;toggle languages, SetInputLang() def from AHK Community
	!2::
	SetInputLang(0x042a) ; Vietnamese
	return
	
	!1::
	SetInputLang(0x0409) ; English (USA)
	return
	
	!3::
	SetInputLang(0x0411) ; Japanese
	return
	
	SetInputLang(Lang)
	{
		WinExist("A")
		ControlGetFocus, CtrlInFocus
		PostMessage, 0x50, 0, % Lang, %CtrlInFocus%
	}
	return
}

/*
	;==================================================	
	Internet search
	;==================================================	
*/
{
	; Search alc
	Xbutton2 & WheelDown::
	Clipboard := ""
	
	SendInput, ^c
	ClipWait, 2
	searchKey := "https://eow.alc.co.jp/search?q=" . Clipboard
	Run %searchKey%
	return
	
; Search Google
	Xbutton2 & WheelUp::
	Clipboard := ""
	SendInput, ^c
	ClipWait, 2
	StringReplace, Clipboard, Clipboard, %A_Space%, +, All
	searchKey := "https://www.google.com/search?q=" . Clipboard
	Run %searchKey%
	return
	
; Search Mazii
	Xbutton2 & Enter::
	Clipboard := ""
	SendInput, ^c
	ClipWait, 2
	searchKey := "https://mazii.net/search/word?dict=javi&query=" . Clipboard . "&hl=vi-VN"
	Run %searchKey%
	return
}

/*
	;==================================================	
	Volume control
	;==================================================	
*/
{
	~LAlt & WheelUp:: Send {Volume_Up}  ; Raise the master volume by 1 interval (typically 5%).
	~LAlt & WheelDown:: Send {Volume_Down}  ; Lower the master volume by 3 intervals.
	~LAlt & MButton:: Send {Volume_Mute}  ; Mute/unmute the master volume.
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

/*
	AHK
*/
{ ;AHK
	^+j:: ;AHK editor
	if WinActive("ahk")
	{
		Clipboard := "`;==================================================`n"
		SendInput, ^v
	}
	return
	
	PgUp:: ;Reload
	if WinActive("ahk")
	{
		Reload
		Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
		MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
		IfMsgBox, Yes, Edit
			return
	}
}

/*
	Excel game
*/
{ ;The excel game 
	#IfWinActive, ahk_exe EXCEL.EXE
	pgdn::
	operation()
	return
	
	operation()
	{
		static state := 0
		state := 1-state
		if (state = 1)
		{
			sendInput ^v{esc}
			return
		}
		else 
		{
			sendInput {AppsKey}{Enter}
			return
		}
	}
	#IfWinActive
}
	
	
/*
	Anki - Context specific
*/
{ ; Anki
	#IfWinActive, ahk_exe anki.exe
	XButton1:: ; return
	Send ^z
	return
	
	XButton2 & LButton:: ; hard - repeat in one minute
	Send 1
	return
	
	XButton2 & MButton:: ; easy
	Send 3
	return
	
	XButton2 & RButton:: ; medium
	Send 2
	return
	
	Alt & PgDn:: ; red flag
	Send ^1
	return
	#IfWinActive 
}


/*
	Brave
*/
{ ;Brave
	#IfWinActive, ahk_class Chrome_WidgetWin_1
	Alt & PgDn:: ; open Diary
	Run https://www.notion.so/smk-toyama/Nh-t-k-fbe8a99803694b23b525eec3f9dd3f22
	return
	
	>#m:: ; open second mail with Left Windows M
	run https://mail.google.com/mail/u/1/#inbox
	return
	
	~Alt::MButton
	return
	#IfWinActive
}

/*
	Audacity
*/
{ ;Audacity
	#IfWinActive ahk_class wxWindowNR ;Audacity
	^T:: ;audacity shortcuts to truncate
	WinMenuSelectItem, ahk_class wxWindowNR, ,Effect, Truncate Silence
	return
	
	^S:: ; audacity shortcut save as
	WinMenuSelectItem, ahk_class wxWindowNR, ,File,Export,Export as MP3
	return
	#IfWinActive
	
}


/*
	VLC
*/
{ ;VLC
	#IfWinActive ahk_class Qt5QWindowIcon ; VLC
; A B repeat in VLC media player. l for loop. Right shift and l
	>+l::
	Click, 20, 920
; this is the position gotten by Windows Spy
	return
	#IfWinActive
}


/*
;==================================================	
	Script control
;==================================================	
*/

~End & Pause:: ;minimize all windows and open sleep dialog
SendInput, #m
Sleep, 500
SendInput, !{F4} ; Open Shutdown Windows
WinWaitActive, Shut Down Windows
SendInput, {Up} ; default selection is Shutdown, Send Up to move to Sleep
return

~RControl & ESC::Exitapp
