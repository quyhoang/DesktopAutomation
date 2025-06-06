#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#singleInstance force
SetTitleMatchMode, 2

; for searchFunction, normalizeSearchkey, setClipboard
#include %A_ScriptDir%\supportFunction.ahk

; Search Google
~Xbutton2::
if (A_PriorHotkey != "Xbutton2" or A_TimeSincePriorHotkey > 400)
{
    ; Too much time between presses, so this isn't a double-press.
	KeyWait, Xbutton2
	return
}
searchFunction(normalizeSearchkey(setClipboard()), "https://www.google.com/search?q=")
return

RControl & Numpad0:: ;Copy selected text and search with Google in default browser----
!g::
searchFunction(normalizeSearchkey(setClipboard()), "https://www.google.com/search?q=")
return

RControl & Numpad1:: ;Copy selected text and translate with Google in default browser--
!t::
searchFunction(normalizeSearchkey(setClipboard(),, True), "https://translate.google.com/?sl=ja&tl=en&text=", "&op=translate")
return

RControl & Numpad2:: ; Copy selected text and search with mazii in default browser----
!m::
searchFunction(normalizeSearchkey(setClipboard(), False), "https://mazii.net/search/word?dict=javi&query=", "&hl=vi-VN")
return

RControl & Numpad3:: ; yomichan search. Yomichan seperate search windows must exist.
yomitanSearch:
!y::
setClipboard()
WinActivate, Yomitan Search
SendInput, {Home}
Click, 191 96
SendInput ^a^v{Enter}
return



