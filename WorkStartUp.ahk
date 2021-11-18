#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


/*
	List of shortcuts
	LControl Numpad*: Open **
	RControl Numpad*: Copy selected text and search with **
	*		**
	0		Google
	1		Google Translate
	2		Mazii
	RControl Numpad5: Open Notion
	ScrollLock Insert: Insert current date and time
	ScrollLock Left arrow: Quick open job directory
	RAlt & Ins: Wrap word in {}
*/

#singleInstance force
SetTitleMatchMode, 2

FileReadLine, wdir, D:\lastWorkingDir.txt, 1
SetWorkingDir %wdir%

if not WinExist("ahk_exe xtop.exe") ;if Creo Parametric is not currently running
{
Run "C:\Program Files\PTC\Creo 7.0.3.0\Parametric\bin\parametric.exe"
}
Run "O:\Free\FA_data\治具_creo\STD_\_All\Creo7_Companion.ahk"
SetWorkingDir %A_ScriptDir% 

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

mailfunction()
{

If WinExist("SMKMSG")
{
WinClose
}
	message := "" ; DEBUG HERE
	WinActivate, ahk_exe NotesUp.exe
	Click, 230 104 ; open NotesUp
	WinWaitActive, IBM Notes,,180
	;WinActivate ; for some reason the activated window is not in the front
	SendInput, %message%
	SendInput, {Enter}
	WinWaitActive, Workspace,,3
	WinWaitActive
	Sleep, 1000
	Click, 231 200
	Sleep, 100
	Click, 231 200
	Return
}

;---------------------------------------------------------------------------





ScrollLock & Left:: ; lookup for a Job number and open corresponding folder if it exists
FormatTime, currentYear,, yy
InputBox, year , Year, Input the last 2 digits of a year, , , , , , Locale, 60, %currentYear%
if ErrorLevel
{
	MsgBox,,Operation Cancelled, Operation was cancelled
	return
}

InputBox, jobno , JobNumber, Input Job Number, , , , , , Locale, 60, ????
if ErrorLevel
{
MsgBox,,Operation Cancelled, Operation was cancelled
return
}

path := "O:\Free\FA_data\治具_creo\20" . year 

match := 0
Loop Files, %path%\A%year%*%jobno%_*, D
{
	Run %A_LoopFilePath%
	currentDir := A_LoopFilePath
	match := 1
	Break
}

if (match = 0)
{
	MsgBox, The specified job does not exist.
}
else
{
	MsgBox, 4,, Open in Creo Parametric with original configuration?
	SetTitleMatchMode, RegEx
	WinMaximize, A%year%*%jobno%_*	
	SetTitleMatchMode, 2
	ifMsgBox Yes
	{
		Loop Files, %currentDir%/*Creo*SMK*
		{
			Run %A_LoopFilePath%
			match := 2
			Break
		}
		if (match = 1) ; could not find the short cut Creo SMK
		{
			msgBox,,Shortcut not found, Could not find Creo SMK start file
		}
	}
}
return
; =====================================================================================

RControl & Numpad3::
Run https://mazii.net/note?hl=vi-VN
return

LControl & Numpad1::
; right control   1: Open Google Translate in default browser--------------------------------------------------------------
Run https://translate.google.com/
return

RControl & Numpad1::
; Copy selected text and search with Google in default browser--------------------------------------------------------------
Clipboard := ""
SendInput, ^c
ClipWait, 2
; replace space and newline character with the corresponding characters used in address bar of GG translate
StringReplace, Clipboard, Clipboard, %A_Space%, +, All
StringReplace, Clipboard, Clipboard, `n, `%0A, All
searchKey := "https://translate.google.com/?sl=ja&tl=en&text=" . Clipboard . "&op=translate"
Run %searchKey%
return




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

RControl & Numpad5::
; Open Notion--------------------------------------------------------------
Run https://www.notion.so/smk-toyama/Unified-Creo-notes-6132801b4a4b410097be05efded068cc
return

#IfWinActive, .ahk
; add comment mark line
^!j:: 
SendInput, `;---------------------------------------------------------------------------
return

; comment a line
^j:: 
SendInput, {Home}`;
return

; uncomment a line
^+j:: 
SendInput, {Home}{Del}
return

#IfWinActive



; wrap word in {}
RAlt & Ins::
SendInput, ^{Left}{{}^{Right}{}}
return

; Close current tab
~Xbutton1 & Mbutton::
If not winactive("ahk_exe xtop.exe")
{
	If winactive("IBM Notes")
	{
		SendInput, {esc}
		Return
	}
	else
	{
		SendInput, ^w
		return
	}
}

; ScrollLock is also mapped to the sixth mouse button using SteelSeries Engine
~ScrollLock & Ins::
FormatTime, CurrentDateTime,, dd-MMM-yy hh:mm:ss
SendInput %CurrentDateTime%
return

^!r:: ; Ctrl Alt R to reload
Reload
Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
IfMsgBox, Yes, Edit
return




#IfWinNotActive ahk_exe xtop.exe
;==========================================================================================================================
LControl & Numpad2::
; right control   2: Open Mazii dictionary in default browser--------------------------------------------------------------
Run https://mazii.net/search
return

~Xbutton2 & RButton::
RControl & Numpad2::
; Copy selected text and search with mazzi in default browser--------------------------------------------------------------
Clipboard := ""
SendInput, ^c
ClipWait, 2
searchKey := "https://mazii.net/search/word?dict=javi&query=" . Clipboard . "&hl=vi-VN"
Run %searchKey%
return


; Close current windows
~Xbutton2 & LButton::
;WinGetActiveTitle, beforeTitle
WinGetActiveTitle, TitleBefore
SendInput ^w
Sleep, 500
WinGetActiveTitle, TitleAfter
If (TitleBefore = TitleAfter)
	WinClose, A
return
;==================================================


;==================================================
; Open daily report
;==================================================
Control & Numpad7:: ; Open daily report
SetInputLang(0x0409) ; English (USA)
Run \\TOYAMA-SV41\Dept\SMKTOY\G-FA\G-FA2\412_日報集計\日報集計2019.accdb
WinWaitActive, 日報集計,, 180
if ErrorLevel
{
    MsgBox, WinWait timed out. Please open work log manually.
    return
}
Click, 670 420
WinWaitActive, ) - 日報集計,, 180
if ErrorLevel
{
    MsgBox, WinWait timed out. Could not open your profile.
    return
}
return


Control & Numpad8::
repeatInput:
InputBox, minute , Time, Input Number of hours, , , , , , Locale, 60
if ErrorLevel
{
MsgBox,,Operation Cancelled, Operation was cancelled
return
}
if (minute = 0)
{
	return
}
minute := minute*60
FormatTime, CurrentDateTime,, yyyy/MM/dd
SendInput, %CurrentDateTime%{Tab}5505{Tab}0{Tab}%minute%{Tab}{Tab}{Tab}
goto, repeatInput
return

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

~RControl & Esc::Exitapp
