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
	ScrollLock Ins: Insert current date and time
	
	The comment-related hotkeys only work if active window title include .ahk
	Ctrl Alt j: add comment mark line
	Ctrl Shift j: uncomment line
	Ctrl j: comment line
	RAlt Ins: wrap word in {}
	
	ScrollLock & Left: Quick open folder by JobNumber
	RCtrl ESC: exit
*/

#singleInstance force
SetTitleMatchMode, 2

ScrollLock & Left:: ; lookup for a Job number and open corresponding folder if it exists
FormatTime, currentYear,, yy
InputBox, year , Year, Input the last 2 digits of a year, , , , , , Locale, 60, %currentYear%
if ErrorLevel
{
	MsgBox,,Operation Cancelled, Operation was cancelled
	return
}

InputBox, jobno , JobNumber, Input Job Number, , , , , , Locale, 60, 2222
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
	match := 1
	Break
}

if (match = 0)
{
	MsgBox, The specified job does not exist.
}

;MsgBox, 4,, Open in Creo Parametric?
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

LControl & Numpad0::
; using google search--------------------------------------------------------------
Run https://www.google.com
return

RControl & Numpad0::
; Copy selected text and search with Google in default browser--------------------------------------------------------------
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

;---------------------------------------------------------------------------
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
;---------------------------------------------------------------------------

; ScrollLock is also mapped to the sixth mouse button using SteelSeries Engine
ScrollLock::
FormatTime, CurrentDateTime,, dd-MMM-yy hh:mm:ss
SendInput %CurrentDateTime%
return
