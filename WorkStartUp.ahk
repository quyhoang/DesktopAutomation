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
If (wdir = "")
{
wdir := "O:\Free\FA_data\治具_creo\STD_\Experiment"
}
SetWorkingDir %wdir%

if not WinExist("ahk_exe xtop.exe") ;if Creo Parametric is not currently running
{
Run "C:\Program Files\PTC\Creo 7.0.9.0\Parametric\bin\parametric.exe" O:\Free\FA_data\Creo7CustomConfig2022\import_customconfig.txt
}
DetectHiddenWindows, On
Process, Exist , CreoAutomation.exe
If (ErrorLevel = 0) ; CreoAutomation is not running
{
	Run O:\Free\FA_data\Creo7CustomConfig2022\Creo7_Companion.exe
}
DetectHiddenWindows, Off

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
WinWait, ShareX 15.0 Portable,, 5
WinActivate, ShareX 15.0 Portable,, 5
WinMinimize
;WinMinimize ; Minimize the window
;TrayTip, Minimized, ShareX has been minimized to the system tray.,1, 17
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
	SendInput ^x
	if WinActive("ahk_exe xtop.exe")
	{
		sendInput ^c{Delete}
	}
	return
	
~F19 & Mbutton::
	SendInput ^w
	return


~XButton2 & WheelUp::
Clipboard := ""
SendInput, ^c
ClipWait, 2
; replace space and newline character with the corresponding characters used in address bar of GG translate
StringReplace, Clipboard, Clipboard, %A_Space%, +, All
StringReplace, Clipboard, Clipboard, `n, `%0A, All
searchKey := "https://www.bing.com/search?q=" . Clipboard . "&showconv=1&FORM=hpcodx"
Run %searchKey%
return 

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
/*
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
	*/
	return
}
return
; =====================================================================================


;=======================================================================================
; Numpad
; ======================================================================================


~F19 & F21:: ; yomichan search. Yomichan seperate search windows must exist.
Clipboard := ""
SendInput ^c ; select all and copy
ClipWait, 2

WinActivate, Yomichan Search
SendInput, {Home}
Click, 191 96
SendInput ^a^v{Enter}
return



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

;=======================================
; Ahk editor shortcut
; ======================================


#IfWinActive ahk_exe Notepad++.exe

F1:: ;help
If WinActive("ahk - Notepad++")
{
prefix := "https://www.autohotkey.com/docs/v1/lib/"
suffix := ".htm"
clipboard := ""
sendInput ^c
ClipWait
searchKey := clipboard
address := prefix . searchKey . suffix
run, %address%
}
return

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

~Mbutton & RButton::
!r:: ; run ahk from notepad**
If WinActive("ahk - Notepad++")
{
SendInput ^s
Sleep 500
WinGetActiveTitle, Title
scriptNameEnd := InStr(Title,".ahk")
scriptName := SubStr(Title,1,scriptNameEnd+3)
Run, %scriptName%
SoundPlay *-1
return
}

F5:: ; compile ahk from notepad**
If WinActive("ahk - Notepad++")
{
SendInput ^s
Sleep 500
WinGetActiveTitle, Title
scriptNameEnd := InStr(Title,".ahk")
scriptName := SubStr(Title,1,scriptNameEnd+3)
Run C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe /in %scriptName%
TrayTip, Success, %scriptName% is compiled, 1, 17

StrReplace(Title,"\",,count)		
folderEnd := InStr(Title,"\",,,count)
folder := SubStr(Title,1,folderEnd-1)
Run, %folder%
return
}

!f:: ; open containing folder
;If WinActive(" - Notepad++")
{
SendInput !ff{Enter}
return
}
#IfWinActive

/*
; wrap word in {}
RAlt & Ins::
SendInput, ^{Left}{{}^{Right}{}}
return
*/

/*
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
*/


; ======================================

^!r:: ; Ctrl Alt R to reload
Reload
Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
IfMsgBox, Yes, Edit
return




#IfWinNotActive ahk_exe xtop.exe

~XButton1 & WheelUp::
; Copy selected text and search with Google in default browser--------------------------------------------------------------
Clipboard := ""
SendInput ^c ;copy selected text
ClipWait, 2
StringReplace, Clipboard, Clipboard, %A_Space%, +, All
searchKey := "https://www.google.com/search?q=" . Clipboard
Run %searchKey%
return

~XButton2 & XButton1::
SendInput !{Tab}
return

/*
XButton1::^c
return
XButton2::^v
return
*/


/*
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
*/
;==================================================






/*
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
*/



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


/*
<#>+o:: ; LWin RShift o to open folder from selected text
Clipboard := ""
SendInput ^c
ClipWait, 2
Run, %Clipboard%
return
*/

:*?:editahk:: ; edit CreoAutomation.ahk
Run, edit "O:\Free\FA_data\治具_creo\STD_\_All\CreoAutomation.ahk"
return

:*?:openahkfolder:: ; open CreoAutomation.ahk containing folder
Run, O:\Free\FA_data\治具_creo\STD_\_All
return

:*?:sj::
SendInput 切断治具
return

:*?:jg::
SendInput 治具
return

