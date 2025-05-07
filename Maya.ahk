#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#singleinstance, force
SetTitleMatchMode, 2

TrayTip, Have a nice day!, Let's try our best, 1, 17

;================================================
; from Hideki
;================================================
#include %A_ScriptDir%\fromHidekiWithLove.ahk
;================================================
; Utility
;================================================
#include %A_ScriptDir%\utility.ahk
;================================================
; Mouse gesture
;================================================
#include %A_ScriptDir%\multiButtonMouseGesture.ahk
;================================================
; Search function
;================================================
#include %A_ScriptDir%\kensaku.ahk
#include %A_ScriptDir%\lookUp.ahk
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

~Pause & End:: ;minimize all windows and open sleep dialog
SendInput, #m
Sleep, 1000							
SendInput, !{F4} ; Open Shutdown Windows
WinWaitActive, Shut Down Windows
SendInput, {Up} ; default selection is Shutdown, Send Up to move to Sleep
return  

~RControl & ESC::Exitapp						