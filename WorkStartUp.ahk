#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#singleInstance force
SetTitleMatchMode, 2

LControl & Numpad1::
; right control   1: Open Google Translate in default browser--------------------------------------------------------------
Run https://translate.google.com/
return

RControl & Numpad1::
; Copy selected text and search with Google in default browser--------------------------------------------------------------
SendInput ^c ;copy selected text
ClipWait, 5 ;wait for the copy operation to be completed

Run https://translate.google.com/ ; open google translate
WinWaitActive, Google Translate,,5
if ErrorLevel
{
    MsgBox, WinWait timed out.
    return
}
Sleep 1000
SendInput ^v{Enter} ;paste then hit Enter
return


LControl & Numpad2::
; right control   2: Open Mazii dictionary in default browser--------------------------------------------------------------
Run https://mazii.net/search
return


RControl & Numpad2::
; Copy selected text and search with mazzi in default browser--------------------------------------------------------------
Clipboard := ""
SendInput, ^c ;copy selected text
ClipWait, 2 ;wait for the copy operation to be completed
searchKey := "https://mazii.net/search/word?dict=javi&query=" . Clipboard . "&hl=vi-VN"
Run %searchKey%
return

LControl & Numpad0::--------------------------------------------------------------
; using google search
Run https://www.google.com
return

RControl & Numpad0::
; Copy selected text and search with Google in default browser--------------------------------------------------------------
SendInput ^c ;copy selected text
ClipWait, 2
StringReplace, Clipboard, Clipboard, %A_Space%, +, All
searchKey := "https://www.google.com/search?q=" . Clipboard
Run %searchKey%
return


RControl & Numpad5::--------------------------------------------------------------
; Open Notion
Run https://www.notion.so/smk-toyama/Unified-Creo-notes-6132801b4a4b410097be05efded068cc
return


; ScrollLock is also mapped to the sixth mouse button using SteelSeries Engine
ScrollLock::
FormatTime, CurrentDateTime,, dd-MMM-yy hh:mm:ss
SendInput %CurrentDateTime%
return