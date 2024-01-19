#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 2
FileEncoding, UTF-8
/*
	Brave
*/
breakVideoLoop := 0

#IfWinActive, ahk_class Chrome_WidgetWin_1
F8 & WheelDown::
Send ^+a
return

F8 & F11:: ; mark video position, use with Chrome Speed Controller Extension
Send w
breakVideoLoop := 0
TrayTip, Start point, Loop start point marked, 5, 17
return

F8 & F10:: ; repeat from marked video position, use with Chrome Speed Controller Extension
duration := A_TimeSincePriorHotkey
WinGetActiveTitle, Title
TrayTip, Loop started, %duration% miliseconds video loop is started , 5, 17
Loop, 10
{
    Send ]
    Sleep, duration
	if (breakVideoLoop = 1)   
		break
	if not Winactive(Title)
		break
}
breakVideoLoop := 0
return


F8 & MButton::
;SendInput {LWin up}
breakVideoLoop := 1
TrayTip, Loop terminated, Video loop is terminated, 5, 17
return

F8 & RButton::F5
return

>#m:: ; open second mail with Left Windows M
run https://mail.google.com/mail/u/1/#inbox
return

~Alt::MButton
return
#IfWinActive

#IfWinActive, - Memrise - Brave
Space::Enter
#IfWinActive