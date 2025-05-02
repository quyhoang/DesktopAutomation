#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 2
FileEncoding, UTF-8

; for searchFunction, normalizeSearchkey, setClipboard
#include %A_ScriptDir%\supportFunction.ahk


F7 & F11:: ; yomichan search. Yomichan seperate search windows must exist.
setClipboard()
WinActivate, Yomitan Search
SendInput, {Home}
Click, 172 110
SendInput ^a^v{Enter}
return

; Search thivien.net
F7 & RButton::
searchFunction(normalizeSearchkey(setClipboard(), False), "https://hvdic.thivien.net/whv/")
return

; Search similar Kanji
RShift & F11::
searchFunction(normalizeSearchkey(setClipboard(), False), "https://niai.mrahhal.net/similar?q=")
return

; Search alc
Xbutton2 & NumpadEnter::
searchFunction(normalizeSearchkey(setClipboard(), False), "https://eow.alc.co.jp/search?q=")
sleep 1000
click MButton
return

/*
; Search Google
Xbutton2 & WheelUp::
::sgg::
searchFunction(normalizeSearchkey(setClipboard()), "https://www.google.com/search?q=")
return

; Search Mazii
Xbutton2 & WheelDown::
searchFunction(normalizeSearchkey(setClipboard(), False), "https://mazii.net/search/word?dict=javi&query=", "&hl=vi-VN")
return
*/