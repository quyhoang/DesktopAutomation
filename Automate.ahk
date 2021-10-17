#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#singleinstance, force


/*
	List of shortcuts
	In Brave,  [backward mouse button] to copy (Lingoes search)
	[Right Win + m] to open vnu... gmail
	[ntd] for add today's date in Notion
	[Left Alt V] to open VLC
	[Right Shift L] AB repeat in VLC
	[Ctrl T] Truncate silence in Audacity
	[Ctrl S] Save as MP3 in Audacity
	~LButton & WheelUp:: Send {Volume_Up}  ; Raise the master volume by 1 interval (typically 5%).
	~LButton & WheelDown:: Send {Volume_Down}  ; Lower the master volume by 3 intervals.
	~LButton & MButton:: Send {Volume_Mute}  ; Mute/unmute the master volume.
	
	Switch Languages
	Backward mouse button and
	LButton: English
	RButton: Japanese
	MButton: Vietnamese
	
	Forward mouse button: tab switch (same as Alt Tab)
	
	Search
	Backward mouse button and
	WheelUp: copy text and search with Google
	WheelDown: copy text and search in Eijiro dictionary
*/


Xbutton1 & WheelDown::
SendInput, ^c
ClipWait, 2
searchKey := "https://eow.alc.co.jp/search?q=" . Clipboard
Run %searchKey%
return

Xbutton1 & WheelUp::
SendInput, ^c
ClipWait, 2
StringReplace, Clipboard, Clipboard, %A_Space%, +, All
searchKey := "https://www.google.com/search?q=" . Clipboard
Run %searchKey%
return

~m & WheelUp::
Clipboard := ""
SendInput, ^c
ClipWait, 2
searchKey := "https://mazii.net/search/word?dict=javi&query=" . Clipboard . "&hl=vi-VN"
Run %searchKey%
return


; tab switch using forward mouse button
~XButton2::
Send {Alt Down}
while GetKeyState("Alt")
{
	KeyWait, XButton2, D, T1
	If ErrorLevel
	{
		Send {Alt Up}
	}
	else
		Send {Tab}
	KeyWait, XButton2
}
return

;toggle languages, SetInputLang() def from AHK Community
~Xbutton1 & MButton::
!2::
SetInputLang(0x042a) ; Vietnamese
return

~Xbutton1 & LButton::
!1::
SetInputLang(0x0409) ; English (USA)
return

~Xbutton1 & RButton::
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


; mouse button to copy
#IfWinActive ahk_exe brave.exe
Xbutton1::
SendInput ^c
return
#IfWinActive

::pi::𝝅 
return

; ScrollLock is also mapped to the sixth mouse button using SteelSeries Engine
ScrollLock::
:R*?:tdy::
FormatTime, CurrentDateTime,, dd-MMM-yy hh:mm:ss
SendInput %CurrentDateTime%
return

>#m::
; open second mail with Left Windows M
run https://mail.google.com/mail/u/1/#inbox
return

>!m::
FormatTime, CurrentDateTime,, MMM-yy
SendInput %CurrentDateTime%
return


:R0*:ntd::
Send, @today{Enter}
return

>!v::
Run "C:\Program Files (x86)\VideoLAN\VLC\vlc.exe" 
WinWait, VLC media player
WinMaximize ; Use the window found by WinWait.
;open VLC media player. Alt and v for vlc
;set full screen (to get position of the A-B repeat symbol
return

#IfWinActive ahk_class Qt5QWindowIcon
; A B repeat in VLC media player. l for loop. Right shift and l
>+l::
Click, 20, 920
; this is the position gotten by Windows Spy
#IfWinActive
return

#IfWinActive ahk_class wxWindowNR
;audacity shortcuts to truncate
^T::
;Send, ^a
WinMenuSelectItem, ahk_class wxWindowNR, ,Effect, Truncate Silence
return

; audacity shortcut save as
^S::
WinMenuSelectItem, ahk_class wxWindowNR, ,File,Export,Export as MP3
#IfWinActive
return

#IfWinActive ahk_class Chrome_WidgetWin_1
<+f::
Click, 1801,55
Sleep, 50
Click, 1801, 55
MouseMove, 600,480
; activate IPA furigana
; this is the position gotten by Windows Spy
#IfWinActive
return

; control volume with mouse
~LButton & WheelUp:: Send {Volume_Up}  ; Raise the master volume by 1 interval (typically 5%).
~LButton & WheelDown:: Send {Volume_Down}  ; Lower the master volume by 3 intervals.
~LButton & MButton:: Send {Volume_Mute}  ; Mute/unmute the master volume.

/*
	#IfWinActive ahk_class Chrome_WidgetWin_1
	:R*?:noron::
	sendInput ^w
	run https://www.noron.vn/explore-v2
	#IfWinActive
	return
*/

<+w::
Run C:\Program Files\AutoHotkey\WindowSpy.exe
return
