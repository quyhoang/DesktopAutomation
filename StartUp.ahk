#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#singleInstance force
SetTitleMatchMode, 2

FileReadLine, wdir, D:\lastWorkingDir.txt, 1
If (wdir = "")
{
wdir := "O:\Free\FA_data\治具_creo\STD_\Experiment"
}
SetWorkingDir %wdir%

if not WinExist("ahk_exe xtop.exe") ;if Creo Parametric is not currently running
{
Run "C:\Program Files\PTC\Creo 7.0.9.0\Parametric\bin\parametric.exe" O:\PEC\Creo7CustomConfig2022\import_customconfig.txt
}
DetectHiddenWindows, On
Process, Exist , CreoAutomation.exe
If (ErrorLevel = 0) ; CreoAutomation is not running
{
	Run O:\PEC\Creo7CustomConfig2022\Creo7_Companion.exe
}
DetectHiddenWindows, Off

SetWorkingDir %A_ScriptDir% 


; ---------------------------------------
; Write log time
; ---------------------------------------
LogFile := "D:\Startup_log.txt"
FormatTime, CurrentDateTime,, yyyy-MM-dd HH:mm:ss

; Append current date and time to the log file
FileAppend, %CurrentDateTime%`n, %LogFile%

; Delete lines with a date different from the current date
FileRead, FileContents, %LogFile%
Loop, Parse, FileContents, `n
{
	CurrentLine := A_LoopField
	if (SubStr(CurrentLine, 1, 10) != SubStr(CurrentDateTime, 1, 10))
		StringReplace, FileContents, FileContents, %CurrentLine%`n, , All
}
FileDelete, %LogFile%
FileAppend, %FileContents%, %LogFile%
; ------------------------------------------



if not WinExist("ahk_exe msedge.exe")
{
Run "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
}

if not WinExist("ahk_exe NLNOTES.EXE")
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

; For unknown reason Teams is open on start
if WinExist("ahk_exe Teams.exe")
WinClose, Teams

mailfunction()
{
Sleep 1000 ; wait for Notesup to start and the button to fully show up. Sometimes the windows appears but there is no button.
If WinExist("SMKMSG")
{
WinClose
}
	message := "1012@timeflies"
	WinActivate, ahk_exe NotesUp.exe
	Click, 230 104 ; open NotesUp
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
;	Return
}

; Run ShareX. Evokable with last mouse button
if not WinExist("ahk_exe ShareX.exe")
{
Run D:\ShareX-15.0.0-portable\ShareX.exe
return
}


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

;=======================================================================================
; Cut - Copy - Paste
; ======================================================================================

~F20::
	Clipboard := ""
	SendInput ^c ;copy selected text
	ClipWait, 0.5
	if ErrorLevel
	{
		SendInput {Left}
	}
	return
	
~F21::
	SendInput ^v
	if (Clipboard == "")
	SendInput {Right}
	return
	
~F19 & F20::
	if WinActive("ahk_exe xtop.exe")
	{
		sendInput {Delete}
	}
	else
	SendInput ^x
	return
	
~F19 & Mbutton::
	SendInput ^w
	return



;=======================================================================================
; Numpad
; ======================================================================================
; ------------------Numpad 0----------------------------

LControl & Numpad0::
; using google search--------------------------------------------------------------
Run https://www.google.com
return


RControl & Numpad0::
; Copy selected text and search with Google in default browser--------------------------------------------------------------
Clipboard := ""
SendInput ^c ;copy selected text
ClipWait, 2
StringReplace, Clipboard, Clipboard, %A_Space%, +, All
searchKey := "https://www.google.com/search?q=" . Clipboard
Run %searchKey%
return


;-------------------Numpad 1----------------------------
LControl & Numpad1::
; right control   1: Open Google Translate in default browser--------------------------------------------------------------
Run https://translate.google.com/
return

~F19 & WheelUp::
; Copy selected text and translate with Google in default browser--------------------------------------------------------------
Clipboard := ""
SendInput, ^c
ClipWait, 2
; replace space and newline character with the corresponding characters used in address bar of GG translate
StringReplace, Clipboard, Clipboard, %A_Space%, +, All
StringReplace, Clipboard, Clipboard, `n, `%0A, All
searchKey := "https://translate.google.com/?sl=ja&tl=en&text=" . Clipboard . "&op=translate"
Run %searchKey%
return


;-------------------Numpad 2----------------------------
LControl & Numpad2::
; right control   2: Open Mazii dictionary in default browser--------------------------------------------------------------
Run https://mazii.net/search
return

RControl & Numpad2::
; Copy selected text and search with mazzi in default browser--------------------------------------------------------------
Clipboard := ""
SendInput, ^c
ClipWait, 2
searchKey := "https://mazii.net/search/word?dict=javi&query=" . Clipboard . "&hl=vi-VN"
Run %searchKey%
return


~F19 & F21:: ; yomichan search. Yomichan seperate search windows must exist.
Clipboard := ""
SendInput ^c ; select all and copy
ClipWait, 2
WinActivate, Yomichan Search
SendInput, {Home}
Click, 191 96
SendInput ^a^v{Enter}
return

;=======================================
; Ahk editor shortcut
; ======================================
#include %A_ScriptDir%\notepad++ahk.ahk
;=================================================
; Hotstrings
;=================================================
#include %A_ScriptDir%\hotstring.ahk


;=================================================
; FUNCTIONS
;=================================================
SetInputLang(Lang)
{
	WinExist("A")
	ControlGetFocus, CtrlInFocus
	PostMessage, 0x50, 0, % Lang, %CtrlInFocus%
}
return

^!r:: ; Ctrl Alt R to reload
Reload
Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
IfMsgBox, Yes, Edit
return

~RControl & Esc::Exitapp

	