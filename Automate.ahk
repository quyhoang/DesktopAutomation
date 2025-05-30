#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#singleinstance, force
SetTitleMatchMode, 2


message := "Let's try our best"
TrayTip, Have a nice day!, %message%, 1, 17

;================================================
; Danshari instr
;================================================

#include %A_ScriptDir%\Danshari.ahk
;================================================
; Utility
;================================================
#include %A_ScriptDir%\utility.ahk
;================================================
; Search function
;================================================
#include %A_ScriptDir%\kensaku.ahk
;================================================
; Volume Control
;================================================
#include %A_ScriptDir%\volumeControl.ahk
;================================================
; Program specific shortcut
;================================================
#include %A_ScriptDir%\programSpecific.ahk
;================================================
; Ahk editor shortcut
;================================================
#include %A_ScriptDir%\notepad++ahk.ahk
;================================================
; Hotstrings
;================================================
#include %A_ScriptDir%\hotstring.ahk
;================================================
; Anki shortcut
;================================================
#include %A_ScriptDir%\anki.ahk
;================================================
; Brave shortcut
;================================================
#include %A_ScriptDir%\brave.ahk
;================================================
; Meta control
;================================================
#include %A_ScriptDir%\metaControl.ahk				
;================================================
; Mouse gesture - Device Specific
;================================================
#include %A_ScriptDir%\m-dux50bk.ahk