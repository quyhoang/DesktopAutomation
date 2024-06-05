#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#singleInstance force
SetTitleMatchMode, 2


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