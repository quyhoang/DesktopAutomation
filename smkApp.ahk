#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 2
FileEncoding, UTF-8

:*?:sharex:: ; Run ShareX. Evokable with last mouse button
Run D:\ShareX-15.0.0-portable\ShareX.exe
return

;==================================================
; Open daily report
;==================================================
:*?:dreport:: ; Open daily report
SetInputLang(0x0409) ; English (USA)
Run X:\SMKTOY\G-FA\G-FA2\412_日報集計\日報集計2019.accdb
WinWaitActive, 日報集計,, 180
if ErrorLevel
{
    MsgBox, WinWait timed out. Please open work log manually.
    return
}
MouseMove,375,474
Sleep 3000
Click, 375 474
WinWaitActive,日報集計,, 180
if ErrorLevel
{
    MsgBox, WinWait timed out. Could not open your profile.
    return
}
return

SetInputLang(Lang)
{
	WinExist("A")
	ControlGetFocus, CtrlInFocus
	PostMessage, 0x50, 0, % Lang, %CtrlInFocus%
}
return

