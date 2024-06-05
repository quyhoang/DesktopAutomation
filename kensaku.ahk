#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#singleInstance force
SetTitleMatchMode, 2

; for searchFunction, normalizeSearchkey, setClipboard
#include %A_ScriptDir%\supportFunction.ahk

RControl & Numpad0:: ;Copy selected text and search with Google in default browser----
searchFunction(normalizeSearchkey(setClipboard()), "https://www.google.com/search?q=")
return

RControl & Numpad1:: ;Copy selected text and translate with Google in default browser--
searchFunction(normalizeSearchkey(setClipboard(),, True), "https://translate.google.com/?sl=ja&tl=en&text=", "&op=translate")
return

RControl & Numpad2:: ; Copy selected text and search with mazzi in default browser----
searchFunction(normalizeSearchkey(setClipboard(), False), "https://mazii.net/search/word?dict=javi&query=", "&hl=vi-VN")
return

~F19 & WheelDown:: ; Basilisk V2 mouse
RControl & Numpad3:: ; yomichan search. Yomichan seperate search windows must exist.
setClipboard()
WinActivate, Yomichan Search
SendInput, {Home}
Click, 191 96
SendInput ^a^v{Enter}
return



