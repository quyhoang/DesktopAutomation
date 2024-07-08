#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#singleInstance force
SetTitleMatchMode, 2

; Danshari
Run, %A_ScriptDir%\..\Danshari\Danshari.exe

; Startup Items at work
#include %A_ScriptDir%\startupItem.ahk


; Apps used at work
#include %A_ScriptDir%\smkApp.ahk


; For copy, cut, paste
#include %A_ScriptDir%\copyPaste.ahk

; For searching on the internet or local app
#include %A_ScriptDir%\kensaku.ahk

; Ahk editor shortcut
#include %A_ScriptDir%\notepad++ahk.ahk

; Hotstrings
#include %A_ScriptDir%\hotstring.ahk

^!r:: ; Ctrl Alt R to reload
	Reload
	Sleep 1000 
	; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
	MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
	IfMsgBox, Yes, Edit
	return

~RControl & Esc::Exitapp

