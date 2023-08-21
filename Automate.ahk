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

{ ; Mouse
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
	SendInput {Enter}
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


;==================================================
; Mouse
;==================================================
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

Xbutton2 & Xbutton1:: ; quick switch window; exclude Creo Parametric
{
	if not WinActive("ahk_exe xtop.exe") 
	{
		SendInput !{Tab}
	}
	return
}

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
	Anki - Context specific
*/
{ ; Anki
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
}

#IfWinActive, Foxit PDF Reader
F7 & WheelUp::
Send ^2
return
#IfWinActive 

#IfWinActive, Brave
Control & F11::
Send ^+a
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
{  ;VLC
	#IfWinActive ahk_class Qt5QWindowIcon ; VLC
	; A B repeat in VLC media player. l for loop. Right shift and l
	>+l::
	Click, 20, 920
	; this is the position gotten by Windows Spy
	return
	#IfWinActive
}

;=======================================
; Ahk editor shortcut
; ======================================
#include %A_ScriptDir%\notepad++ahk.ahk
;=======================================
; Hotstrings
;=======================================
#include %A_ScriptDir%\hotstring.ahk

~Pause & End:: ;minimize all windows and open sleep dialog
SendInput, #m
Sleep, 1000
SendInput, !{F4} ; Open Shutdown Windows
WinWaitActive, Shut Down Windows
SendInput, {Up} ; default selection is Shutdown, Send Up to move to Sleep
return  

~Pause & ESC::Exitapp