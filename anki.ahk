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

F10::
sendInput, {Enter}
return

F11::
sendInput, r
return

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

F7 & WheelDown:: 
Send ^z
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

