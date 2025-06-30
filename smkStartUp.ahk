#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#singleInstance force
SetTitleMatchMode, 2

; Startup Items at work
#include %A_ScriptDir%\smkStartupItem.ahk

; Danshari
#include %A_ScriptDir%\danshari.ahk

; Apps used at work
#include %A_ScriptDir%\smkApp.ahk

; For copy, cut, paste
#include %A_ScriptDir%\basiliskV2.ahk
#include %A_ScriptDir%\copyPaste.ahk

; For searching on the internet or local app
#include %A_ScriptDir%\kensaku.ahk

; Ahk editor shortcut
#include %A_ScriptDir%\notepad++ahk.ahk

; Hotstrings
#include %A_ScriptDir%\hotstring.ahk

; Metacontrol
#include %A_ScriptDir%\metaControl.ahk

; evgaX15
#include %A_ScriptDir%\evgaX15.ahk
