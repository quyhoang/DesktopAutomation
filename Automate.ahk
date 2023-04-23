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


LControl & ESC::
Send "{Ctrl up}"
Send "{Shift up}"
Send "{LWin up}"
Send "{RWin up}"
return

XButton1 & F24::
	Clipboard := ""
	SendInput, ^c
	ClipWait, 2
	searchKey := "https://youglish.com/pronounce/" . Clipboard . "/japanese?"
	Run %searchKey%
	return


; Open Japanese assignments
F24::
:*:1drive::
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
else if WinActive("ahk_exe anki.exe")
{
	SendInput {Enter}
	return
}	
else if WinActive("Netflix - Brave")
{
	SendInput s
	return
}	
/*
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
*/
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
/*
else if WinActive("Google Slides - Brave")
{
	MouseClick, Right
	SendInput {Down}{Down}{Down}{Down}
	SendInput {Enter}
	return
}
*/
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


F7 & F10:: ; refer synapse/razer
if WinActive("Netflix - Brave")
{
	SendInput a
	return
}
else
send ^x
return

F7 & F11:: ; yomichan search. Yomichan seperate search windows must exist.
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


F7 & MButton:: ;Mbutton to close current window
{
	;WinGetActiveTitle, TitleBefore
	SendInput ^w
	/*
		Sleep, 500
		WinGetActiveTitle, TitleAfter
		If (TitleBefore = TitleAfter)
			WinClose, A
	*/
	if Winactive("Edit Current") ; finish editing Anki Card
	 WinClose
	 
	return
}

Xbutton1 & Xbutton2:: ; quick switch window; exclude Creo Parametric
{
	;if not WinActive("ahk_exe xtop.exe") 
	{
		sendInput, #{Tab}
	}
	return
}

Xbutton2 & Xbutton1:: ; quick switch window; exclude Creo Parametric
{
	;if not WinActive("ahk_exe xtop.exe") 
	{
		SendInput !{Tab}
	}
	return
}

;==================================================
; Hotstrings
;==================================================


::qdn:: ;quaderno sync folder


::pi::𝝅 
return

:R0*:ntd:: ; send today in Notion
Send, @today{Enter}
return

:R0*:gkeep:: ;open google keep
if WinExist("Google Keep")
    WinActivate ;
else
run https://keep.google.com/u/0/
return


:R0*:gcal:: ;open google calendar
if WinExist("Google Calendar")
    WinActivate ;
else
run https://calendar.google.com/calendar/u/0/r/week
return

:R0*:nnote:: ;open note
if WinExist("Note - Brave")
    WinActivate ;
else
run https://www.notion.so/smk-toyama/Note-0d42256185d3454c94da9e23c0b05b2b
return

:R0*:mpage:: ;open Daily Notes mpa
if WinExist("Morning Pages - Brave")
    WinActivate ;
else
Run https://www.notion.so/smk-toyama/Morning-Pages-704073a15f0d4cd48a6ef2fcbafe6354
return





:R0*:dnote:: ;open Daily Notes
if WinExist("Nhật ký - Brave")
    WinActivate ;
else
Run https://www.notion.so/smk-toyama/Nh-t-k-1f61aa8d4d3e40af84e1968996e161ec
return

~ScrollLock & Pause:: ;edited 18-Oct-21 11:35:56
:R*?:tdy::
FormatTime, CurrentDateTime,, dd-MMM-yy
clipboard := CurrentDateTime
;SendInput %CurrentDateTime%
SendInput ^v
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
	:*?:vvi::
	:*?:.vi::
	!2::
	SetInputLang(0x042a) ; Vietnamese
	return
	
	:*?:.en::
	!1::
	SetInputLang(0x0409) ; English (USA)
	return
	
	:*?:.ja::
	!3::
	SetInputLang(0x0411) ; Japanese
	IME_SET(1)
	return
	
	
	SetInputLang(Lang)
	{
		WinExist("A")
		ControlGetFocus, CtrlInFocus
		PostMessage, 0x50, 0, % Lang, %CtrlInFocus%
	}
	return
	
	IME_SET(SetSts, WinTitle="A")    
	{
	ControlGet,hwnd,HWND,,,%WinTitle%
	if	(WinActive(WinTitle))	{
		ptrSize := !A_PtrSize ? 4 : A_PtrSize
	    VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
	    NumPut(cbSize, stGTI,  0, "UInt")   ;	DWORD   cbSize;
		hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
	             ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
	}

        return DllCall("SendMessage", UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwnd), UInt, 0x0283  ;Message : WM_IME_CONTROL
          ,  Int, 0x006   ;wParam  : IMC_SETOPENSTATUS
          ,  Int, SetSts) ;lParam  : 0 or 1
	}
	return
}




F7 & NumpadEnter::
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
	F7 & RButton::
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
	F7 & WheelUp:: 
	if WinActive("ahk_exe Acrobat.exe")
	{
	SendInput ^{=}
	return
	}
	else
	Send {Volume_Up}  ; Raise the master volume by 1 interval (typically 5%).
	return

	F7 & WheelDown:: 
	if WinActive("ahk_exe Acrobat.exe")
	{
	SendInput ^-
	return
	}
	else
	Send {Volume_Down}  ; Lower the master volume by 3 intervals.
	return

	;F7 & MButton:: 
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
; Anki
	#IfWinActive, ahk_exe anki.exe
	
	::lalc:: ;look up on alc
	Clipboard := ""
	
	SendInput, ^c
	ClipWait, 2
	searchKey := "https://eow.alc.co.jp/search?q=" . Clipboard
	Run %searchKey%
	sleep 1000
	click MButton
	return

	F3::
	SendInput, ^c
	return
	
	F4::
	SendInput ^v
	return

	F9::
	SendInput ^+d;
	Sleep 100
	Clipboard := "1"
	SendInput ^v
	SendInput {Enter}
	return

	8::
	SendInput *
	return	

	XButton1 & RButton::
	SendInput {f5}
	return
	
	XButton1 & F10::
	XButton1 & LButton::
	SendInput ^z
	return
	
	F8::
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
	
	XButton1 & NumPadEnter:: ; back to deck list
	SendInput d
	return
	
	F7 & WheelUp:: ; edit card
	Send e
	return
	
	F7 & WheelDown:: ; close editing box from the last editing field
	Send {Tab}
	Sleep 100
	Send {Tab}{Enter}
	return
	#IfWinActive 


#IfWinActive, Foxit PDF Reader
F7 & WheelUp::
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
;Audacity
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

~LShift & F1:: Exitapp
~RControl & ESC::Exitapp

#IfWinActive ahk_exe notepad++.exe
~Mbutton & RButton::
!r:: ; run ahk from notepad**
If WinActive("ahk - Notepad++")
{
SendInput ^s
Sleep 500
WinGetActiveTitle, Title
scriptNameEnd := InStr(Title,".ahk")
scriptName := SubStr(Title,1,scriptNameEnd+3)
Run, %scriptName%
SoundPlay *-1
return
}

F5:: ; compile ahk from notepad**
If WinActive("ahk - Notepad++")
{
SendInput ^s
Sleep 500
WinGetActiveTitle, Title
scriptNameEnd := InStr(Title,".ahk")
scriptName := SubStr(Title,1,scriptNameEnd+3)
Run C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe /in %scriptName%
TrayTip, Success, %scriptName% is compiled, 1, 17

StrReplace(Title,"\",,count)		
folderEnd := InStr(Title,"\",,,count)
folder := SubStr(Title,1,folderEnd-1)
Run, %folder%
return
}

!f:: ; open containing folder
;If WinActive(" - Notepad++")
{
SendInput !ff{Enter}
return
}
#IfWinActive



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
;if not WinActive("ahk_exe xtop.exe") 
{
Clipboard := ""
SendInput ^c ; select all and copy
ClipWait, 1

WinActivate, Yomichan Search
SendInput, {Home}
Click, 172 110
SendInput ^a^v{Enter}
}
Return

speaker := "dell"
;speaker := "razer"

F8::
CoordMode, Mouse, Screen
Click, 2352 1422
Sleep, 600
MouseMove, 2352, 1324
CoordMode, Mouse, Screen
MouseClick, left ;Click, 2352 1324
Sleep, 300
If (speaker = "dell")
{
	MouseMove, 2352, 1240
	Sleep, 100
	CoordMode, Mouse, Screen
	Sleep, 300
	MouseClick, left ;Click, 2352 1329
	speaker := "razer"
	return
}
else
{
	MouseMove, 2352, 1331
	Sleep, 100
	CoordMode, Mouse, Screen
	Sleep, 300
	MouseClick, left ;Click, 2352 1289
	speaker := "dell"
}
return
