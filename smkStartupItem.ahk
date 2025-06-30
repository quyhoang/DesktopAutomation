#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 2
FileEncoding, UTF-8

FileReadLine, wdir, D:\lastWorkingDir.txt, 1
If (wdir = "")
{
wdir := "O:\PEC\治具_creo\STD_\Experiment"
}
SetWorkingDir %wdir%

if not WinExist("ahk_exe xtop.exe") ;if Creo Parametric is not currently running
{
Run "C:\Program Files\PTC\Creo 7.0.12.0\Parametric\bin\parametric.exe" O:\PEC\Creo7CustomConfig2022\import_customconfig.txt
}

; DetectHiddenWindows, On
; Process, Exist , CreoAutomation.exe
; If (ErrorLevel = 0) ; CreoAutomation is not running
; {
	; Run O:\PEC\Creo7CustomConfig2022\Creo7_Companion.exe
; }
; DetectHiddenWindows, Off
Run, "D:\AHK_CreoParametric\AHK_CreoParametric\AHK_CreoParametric\CreoAutomation.ahk"

SetWorkingDir %A_ScriptDir%


if not WinExist("ahk_exe brave.exe")
{
Run "C:\Users\quyhoang\AppData\Local\BraveSoftware\Brave-Browser\Application\brave.exe"
}

if not WinExist("ahk_exe notes2.exe")
{
	Run "C:\Program Files (x86)\NotesUp\NotesUp.exe"

;---------------------------------------------------------------------------
; Open mail
;---------------------------------------------------------------------------

; InputBox, message, Let's do great things today!, I promise to be true to the best I know!, Hide
	if WinExist("ahk_exe NotesUp.exe")
	{
	mailfunction()
	}
	else
	{	
	WinWaitActive, NotesUp,,240
	if ErrorLevel
	{
		MsgBox, WinWait timed out.
		; Return (continue to the next line)
	}
	else
	{
		mailfunction()		
	}
	}
}

if WinExist("ahk_exe NLNOTES.EXE")
{
	message := "1012@timeflies"
	WinWaitActive, IBM Notes,,180
	;WinActivate ; for some reason the activated window is not in the front
	SendInput, %message%
	SendInput, {Enter}
	WinWaitActive, Workspace,,3
	WinWaitActive
	Sleep, 1000
	Click, 300 230
	Sleep, 100
	Click, 300 230
}
; For unknown reason Teams is open on start
if WinExist("ahk_exe Teams.exe")
WinClose, Teams

if WinExist("ahk_exe UnleashRGB.exe")
{
WinMinimize
}


mailfunction()
{
Sleep 1000 ; wait for Notesup to start and the button to fully show up. Sometimes the windows appears but there is no button.
If WinExist("SMKMSG")
{
WinClose
}
	message := "1012@timeflies"
	if WinExist("ahk_exe NotesUp.exe")
	WinActivate, ahk_exe NotesUp.exe
	Click, 230 104 ; open NotesUp
	WinWaitActive, Login to HCL Notes,,180
	;WinActivate ; for some reason the activated window is not in the front
	SendInput, %message%
	SendInput, {Enter}
	WinWaitActive, Workspace,,3
	WinWaitActive
	Sleep, 1000
	Click, 300 230
	Sleep, 100
	Click, 300 230
;	Return
}



