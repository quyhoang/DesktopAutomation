#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 2
FileEncoding, UTF-8

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

!y::
F7::
yomitanSearch:
SetTitleMatchMode, 2  ; substring match
setClipboard()
WinActivate, Yomitan Search
WinWaitActive, Yomitan Search,, 2
SendInput ^v{Enter}
return
