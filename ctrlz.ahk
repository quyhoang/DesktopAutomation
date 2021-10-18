#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; 12:55 2021/10/18 Hoang 
; Undo shortcut, made for Murakami san

#singleInstance force

; only work in Excel
#IfWinActive ahk_exe EXCEL.EXE
Mbutton::
SendInput ^z
Return

~LControl & Mbutton::
; Original function of Mbutton in Excel
Send, {Mbutton}
Return
#IfWinActive

;work everywhere else
~Mbutton & Rbutton::
SendInput ^z
Return