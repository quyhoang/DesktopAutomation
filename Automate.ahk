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

XButton1 & F24::
	Clipboard := ""
	SendInput, ^c
	ClipWait, 2
	searchKey := "https://youglish.com/pronounce/" . Clipboard . "/japanese?"
	Run %searchKey%
	return


; Open Japanese assignments
F24::
IfWinExist, Japanese Assignments
	WinActivate 
else
	Run https://onedrive.live.com/edit.aspx?cid=c00a6c307ebf80da&page=view&resid=C00A6C307EBF80DA!1116&parId=C00A6C307EBF80DA!1074&app=Excel
return

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
else if WinActive("Google Slides - Brave")
{
	Clipboard := ""
	SendInput, ^c
	ClipWait, 2
	; replace space and newline character with the corresponding characters used in address bar of GG translate
	StringReplace, Clipboard, Clipboard, %A_Space%, +, All
	StringReplace, Clipboard, Clipboard, `n, `%0A, All
	searchKey := "https://translate.google.com/?sl=en&tl=ja&text=" . Clipboard . "&op=translate"
	Run %searchKey%
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
else if WinActive("Google Slides - Brave")
{
	MouseClick, Right
	SendInput {Down}{Down}{Down}{Down}
	SendInput {Enter}
	return
}
else if WinActive("Hideki - Anki") ; Yomichan search in Anki
{
	Clipboard := ""
	SendInput ^c ; select all and copy
	ClipWait, 2
	
	WinActivate, Yomichan Search
	SendInput, {Home}
	Click, 172 110
	SendInput ^a^v{Enter}
}
else
{
	SendInput ^v
	return
}
return

F9 & F10:: ; refer synapse/razer
send ^x
return

F9 & F11:: ; yomichan search. Yomichan seperate search windows must exist.
Clipboard := ""
SendInput ^c ; select all and copy
ClipWait, 2

WinActivate, Yomichan Search
SendInput, {Home}
Click, 172 110
SendInput ^a^v{Enter}
return

/*
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
*/

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


F9 & MButton:: ;Mbutton to close current window
{
	;WinGetActiveTitle, TitleBefore
	SendInput ^w
	/*
		Sleep, 500
		WinGetActiveTitle, TitleAfter
		If (TitleBefore = TitleAfter)
			WinClose, A
	*/
	return
}

Xbutton1 & Xbutton2:: ; quick switch window; exclude Creo Parametric
{
	if not WinActive("ahk_exe xtop.exe") 
	{
		sendInput, #{Tab}
	}
	return
}

Xbutton2 & Xbutton1:: ; quick switch window; exclude Creo Parametric
{
	if not WinActive("ahk_exe xtop.exe") 
	{
		SendInput !{Tab}
	}
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
FormatTime, CurrentDateTime,, dd-MMM-yy
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



F9 & NumpadEnter::
Clipboard := ""
	SendInput, ^c
	ClipWait, 2
	Run https://keep.google.com/u/2/
	sleep, 2000
	SendInput, ^v
	return

/*
	;==================================================	
	Internet search
	;==================================================	
*/
{
	; Search thivien.net
	NumpadAdd::
	F9 & RButton::
	LShift & F11::
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
	Clipboard := ""
	SendInput, ^c
	ClipWait, 2
	StringReplace, Clipboard, Clipboard, %A_Space%, +, All
	searchKey := "https://www.google.com/search?q=" . Clipboard
	Run %searchKey%
	;sleep 1000
	;click MButton
	return
	
; Search Mazii
	NumpadSub::
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
~XButton1 & WheelDown:: ; run GoldenDict as a pop up
{
	Clipboard := ""
	SendInput ^c
	ClipWait  ; Wait for the clipboard to contain text.
	
	WinActivate, ahk_exe GoldenDict.exe
	WinWaitActive, ahk_exe GoldenDict.exe,,1
	if ErrorLevel
	{
		; invoke the program if it is not currently running
		Run C:\Program Files (x86)\GoldenDict\GoldenDict.exe
		WinActivate, GoldenDict
		WinWaitActive, GoldenDict,,5
		if ErrorLevel
		{
			MsgBox,,, Cannot start GoldenDict,2
			return
		}
	}
	Click, 100 64
	SendInput ^a^v{Enter}
	; ControlSend, QWidget14, %Clipboard%{Enter}
	; MouseMove, -10, -10, 0, R ; move mouse to close Lingoes pop-up
}
return

*/

/*
	;==================================================	
	Volume control
	;==================================================	
*/
{ ;*[Automate]
	F9 & WheelUp:: 
	if WinActive("ahk_exe Acrobat.exe")
	{
	SendInput ^{=}
	return
	}
	else
	Send {Volume_Up}  ; Raise the master volume by 1 interval (typically 5%).
	return

	F9 & WheelDown:: 
	if WinActive("ahk_exe Acrobat.exe")
	{
	SendInput ^-
	return
	}
	else
	Send {Volume_Down}  ; Lower the master volume by 3 intervals.
	return

	;F9 & MButton:: 
	if WinActive(".pdf")
	{
	SendInput ^2
	return
	}
	else
	Send {Volume_Mute}  ; Mute/unmute the master volume.
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

	~RControl::
	SendInput ^+d;
	Sleep 100
	Clipboard := "1"
	SendInput ^v
	SendInput {Enter}
	return
	

	F12::
	sendInput {Enter}
	return
	
	8::
	SendInput *
	return	

	XButton1 & RButton::
	SendInput {f5}
	return
	
	XButton1 & LButton::
	SendInput ^z
	return
	
	XButton2 & LButton:: ; hard 
	Send 2
	return
	
	XButton2 & MButton:: ; blue flag
	Send ^4
	return
	
	End::
	XButton2 & RButton:: ; easy
	Send 4
	Send 3
	Send 2
	return
	
	XButton1 & NumpadEnter:: ; blue flag
	SendInput d
	return
	
	F9 & WheelUp:: ; edit card
	Send e
	return
	
	F9 & WheelDown:: ; close editing box from the last editing field
	Send {Tab}
	Sleep 100
	Send {Tab}{Enter}
	return
	#IfWinActive 
}

#IfWinActive, Foxit PDF Reader
F9 & WheelUp::
Send ^2
return
#IfWinActive 


/*
	Brave
*/
{ ;Brave
	#IfWinActive, ahk_class Chrome_WidgetWin_1
	LControl & F24:: ; open Diary
	Run https://www.notion.so/smk-toyama/Nh-t-k-fbe8a99803694b23b525eec3f9dd3F10
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

; Get full path of a file
~Xbutton2 & RButton::
SendInput {F2}^a
Clipboard := ""
Sleep 100
SendInput ^c
ClipWait, 2
name := Clipboard
Clipboard := ""
Sleep 100
SendInput {Enter}!d
Sleep 100
SendInput ^c
ClipWait, 2
fullPathName := Clipboard . "\" . name
Clipboard := fullPathName
; msgBox, % fullPathName
return

~End & Pause:: ;minimize all windows and open sleep dialog
SendInput, #m
Sleep, 500
SendInput, !{F4} ; Open Shutdown Windows
WinWaitActive, Shut Down Windows
SendInput, {Up} ; default selection is Shutdown, Send Up to move to Sleep
return

/*
~Backspace::
if (A_PriorHotkey != "~Backspace" or A_TimeSincePriorHotkey > 400)
{
    ; Too much time between presses, so this isn't a double-press.
	KeyWait, Backspace
	return
}
else 
sendInput ^{Backspace}
return
*/


Pause & PgUp::LButton
return
Pause & PgDn::RButton
return

~RControl & ESC::Exitapp

!r:: ; run ahk from notepad**
If WinActive("ahk - Notepad++")
{
SendInput ^s
Sleep 500
WinGetActiveTitle, Title
scriptNameEnd := InStr(Title,".ahk")
scriptName := SubStr(Title,1,scriptNameEnd+3)
Run, %scriptName%
return
}

/*
~Xbutton1 & WheelUp::
send, {Ctrl down}
While GetKeyState("Xbutton1")
{
SendInput {WheelUp}
Sleep 150
}
;KeyWait Xbutton1
send, {Ctrl Up}
return


~Xbutton1 & WheelDown::
send, {Ctrl down}
While GetKeyState("Xbutton1")
{
SendInput {WheelDown}
Sleep 150
}
;KeyWait Xbutton1
send, {Ctrl Up}
return
*/

F12::
Clipboard := ""
SendInput ^c ; select all and copy
ClipWait, 2

WinActivate, Yomichan Search
SendInput, {Home}
Click, 172 110
SendInput ^a^v{Enter}
Return