#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 2
FileEncoding, UTF-8

/*
	Anki - Context specific
*/
#IfWinActive, Hideki - Anki

/*
;!c:: ;look up on alc
Clipboard := ""
SendInput, ^c
ClipWait, 2
searchKey := "https://eow.alc.co.jp/search?q=" . Clipboard
Run %searchKey%
sleep 1000
click MButton
return
*/

F9::
SendInput ^+d;
Sleep 100
Clipboard := "1"
SendInput ^v
SendInput {Enter}
return

F7 & F10::
SendInput ^z
return



;starred 
F7 & WheelDown::
F12::
8::
SendInput *
return

F8::
Send 2
return

XButton2 & LButton:: ; hard and orange flag
SendInput ^2
sleep, 100
Send 2
return

XButton2 & MButton:: ; red flag
Send ^1
sleep, 200
send 2
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

F7 & WheelUp::
sendInput e
return

F6::
Clipboard := ""
Send ^c
Clipwait, 2
If ErrorLevel
{
	msgbox, Could not copy
	return
}
Send e
WinWaitActive, Edit Current,,3
If ErrorLevel
{
	msgbox, Could not open editing window
	return
}
Sleep 500
Send ^a
Sleep 100
Send ^v
Sleep 100
Send +{Tab}{Enter}
return

#IfWinActive 

LControl & F12::
if (A_TimeSincePriorHotkey > 800)
sendInput, ^z
return

~PgDn::
IfWinActive, Hideki - Anki
{
sendInput, e
WinWaitActive, Edit Current,,5
MouseMove, 238, 659
sleep 200
Click
return
}
IfWinActive, Edit Current
{
MouseMove, 742, 858
Click
return
}
return