#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#singleInstance force
SetTitleMatchMode, 2

;=======================================================================================
; Temporary clipboard 
; ======================================================================================

global tempClip

LShift & XButton1::
Clipboard := ""
SendInput ^c ;copy selected text
ClipWait, 0.5
tempClip := Clipboard
return
	
LShift & XButton2::
clip := Clipboard
Clipboard := ""
Clipboard := tempClip
ClipWait, 0.5
SendInput ^v
sleep, 1000
Clipboard := clip ; return to original Clipboard
; using this mechanism instead of simply input clip to avoid problem with some languages
return

