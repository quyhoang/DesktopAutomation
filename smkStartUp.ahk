#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#singleInstance force
SetTitleMatchMode, 2

; Startup Items at work
#include %A_ScriptDir%\smkStartupItem.ahk

; Danshari
; #include %A_ScriptDir%\danshari.ahk

; Apps used at work
#include %A_ScriptDir%\smkApp.ahk

; For copy, cut, paste
#include %A_ScriptDir%\basiliskV2.ahk
#include %A_ScriptDir%\copyPaste.ahk

; For searching on the internet or local app
#include %A_ScriptDir%\kensaku.ahk

; Ahk editor shortcut
#include %A_ScriptDir%\notepad++ahk.ahk

; Hotstrings
#include %A_ScriptDir%\hotstring.ahk

; Metacontrol
#include %A_ScriptDir%\metaControl.ahk

; evgaX15
#include %A_ScriptDir%\evgaX15.ahk

!k::  ;keep
filePath := "D:\AHK_CreoParametric\AHK_CreoParametric\DesktopAutomation\keep_cdmi.txt" 
saveToFile(filePath)
return

saveToFile(filePath)
{
	clipboard := ""
    Send ^c  ; Copy selected text
    ClipWait, 1  ; Wait up to 1 second for clipboard to contain data
    if ErrorLevel
    {
		Run, %filePath%
        ;MsgBox, 48, Error, Failed to copy text. No text was selected or copy timed out.
        return
    }

    ; Open the file in append mode and write the clipboard text
    FileAppend, %Clipboard%`r`n`n, %filePath%

    ; Optional: Tray notification
	msgbox, 324, Text Saved, %Clipboard% has been appended to %filePath%. `n`nDo you want to open it?, 0.1
	KeyWait, LShift, D T2
	if GetKeyState("Shift")
	{
		run, %filePath%
	}
		
    ; Restore the original clipboard content
	return
}

::allexport::
exportFromEverything("O:\PEC ","OdriveallIndex.txt")
Return

::prtexport::
exportFromEverything("file: O:\PEC .prt | .asm","OdriveprtIndex.txt")
Return

::folderexport::
exportFromEverything("folder: O:\PEC ","D:\OdrivefolderIndex.txt")
Return


exportFromEverything(searchString,exportedFileName)
{
	run, D:\Everything\Everything.exe
	WinWaitActive, ahk_exe Everything.exe,,5
	Clipboard := searchString ; "O:\PEC "
	sendInput, ^v
	Sleep, 1000
	sendInput, ^s
	WinWaitActive, Export Result List,,5
	Clipboard := exportedFileName ; "OdriveallIndex.txt"
	sendInput, ^v
	Sleep, 1000
	sendInput, !s
	Sleep, 1000
	sendInput, y
	Return
}