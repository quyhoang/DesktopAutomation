#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 2
FileEncoding, UTF-8

#include %A_ScriptDir%\supportFunction.ahk


#IfWinActive ahk_exe Obsidian.exe

F5::
colorText()
return

colorText()
{
	static colorNo := 0
	colorNo := colorNo + 1
	
	temp := Mod(colorNo, 4)
	
	color := (temp = 0) ? "white"
		   : (temp = 1) ? "orange"
		   : (temp = 2) ? "blue" : "black"
	
	clipboard := ""
	SendInput ^c
	ClipWait

	text := clipboard

	; If text already has a <span style="color: ...;">...</span>, remove it
	if RegExMatch(text, "<span style=""color:\s*[^""]+;"">") {
		text := RegExReplace(text, "<span style=""color:\s*[^""]+;"">", "")
		text := RegExReplace(text, "</span>", "")
	} 
	
	if (color != "black")
	{
		text := "<span style=""color: " . color . ";"">" . text . "</span>"
	}
	
	clipboard := text
	SendInput ^v
	return
}

#IfWinActive




!n:: ; Kachi Text File
currentFolder := GetActiveExplorerPath()
FormatTime, CurrentDateTime,, dd-MMM-yy

success := false
Loop, 1000
{
	fcounter += 1
	filePath :=  currentFolder . "\" . CurrentDateTime . "-" . fcounter . ".txt"
	if fileExist(filePath)
		continue
	else
	{ 
		success := true
		break
	}
}

if !success
{
	Msgbox, 64, Could not create file, Some error occur, 3
	return
}
	
FileAppend, %clipboard%, %filePath%
Run, %filePath%
return

!b:: ; bulk rename with bulk rename utility
If not Winactive("ahk_exe explorer.exe")
	return
folderName := GetActiveExplorerPath()
Run, "C:\Program Files\Bulk Rename Utility\Bulk Rename Utility.exe" %folderName%
return

!p:: ; Open current photo folder
; Get current year and month
FormatTime, year,, yyyy
FormatTime, monthNumber,, M
FormatTime, monthName,, MMM  ; Get the abbreviated month name (Jan, Feb, ...)

; Compose folder path
folder := "E:\A_ MY LIFETIME OF PHOTOS\" year "\" monthNumber " " monthName

; Create folder if it doesn't exist
IfNotExist, %folder%
	FileCreateDir, %folder%

; Open folder in Explorer
Run, explorer.exe "%folder%"
return

RAlt & Del:: ; Delete current folder
If not Winactive("ahk_exe explorer.exe")
	return
folderName := GetActiveExplorerPath()
MsgBox, 292, DELETE FOLDER, Would you like to delete `n%folderName%?
IfMsgBox Yes
    FileRemoveDir, %folderName%, 1
return

	

!e::   ; engineering
filePath := "D:\Code\My writings\Engineering.md" 
saveToFile(filePath)
return

!o::   ; Pocket
filePath := "D:\Code\My writings\Pocket.md" 
saveToFile(filePath)
return

!s::  ; japanese
filePath := "D:\Code\My writings\日本語ノート.md" 
saveToFile(filePath)
return

!k::  ;keep
filePath := "D:\Code\My writings\Keep.md" 
saveToFile(filePath)
return


saveToFile(filePath)
{
    ; Save the current clipboard content
    ; ClipSaved := ClipboardAll

    ; Clear the clipboard
    Clipboard := ""
    Send ^c  ; Copy selected text
    ClipWait, 1  ; Wait up to 1 second for clipboard to contain data
    if ErrorLevel
    {
        MsgBox, 48, Error, Failed to copy text. No text was selected or copy timed out.
        return
    }

    ; Open the file in append mode and write the clipboard text
    FileAppend, %Clipboard%`r`n`n, %filePath%

    ; Optional: Tray notification
	msgbox, 324, Text Saved, %Clipboard% has been appended to %filePath%. `n`nDo you want to open it?, 2
	IfMsgBox Yes
	{
		run, %filePath%
	}
		
    ; Restore the original clipboard content
    ; Clipboard := ClipSaved
    ; ClipSaved := ""
	return
}



~ScrollLock & o:: ; Open file/folder from selected text 
Ctrl & Numpad5::
Clipboard := ""
SendInput ^c
ClipWait, 3
if ErrorLevel
{
	MsgBox, 64, Could not copy, The attempt to copy text onto the clipboard failed., 3
	return
}
else
{
	Run, %Clipboard%
}
return


; Get full path of a file
~ScrollLock & c::
If Winactive("ahk_exe Explorer.EXE")
{
	SendInput {F2}^a
	Clipboard := ""
	Sleep 100
	SendInput ^c
	ClipWait, 2
	name := Clipboard
	Clipboard := ""
	Sleep 100
	SendInput {Enter}!d
	Sleep 100
	SendInput ^c
	ClipWait, 2
	fullPathName := Clipboard . "\" . name
	Clipboard := fullPathName
	TrayTip, Full path copied, %fullPathName%, 1, 17
}
else
{
	If Winactive("ahk_exe notepad++.exe")
	{
		WinGetTitle, Title, A
		Clipboard := Substr(Title, 1, StrLen(Title) - 12)
		notifyTray(Clipboard, "Full path copied")
	}
	else
		notifyTray("Notepad++ or Windows Explorer is required for this function")
}   
return


; Get active window title
~ScrollLock & a::
copyActiveWindow()
notifyTray(Clipboard, "Active window title copied")
return

RControl & Numpad7:: ;save text to a file to review later
{
    ; Save the currently highlighted text to a variable
    Clipboard := ""
	Send ^c  ; Copy selected text to clipboard
    ClipWait, 1  ; Wait for the clipboard to update (max 1 second)
    
    ; If the clipboard contains text, append it to the file
    if (Clipboard != "")
    {
        FileAppend, %Clipboard%`n, D:/wordlist.txt  ; Append text to a new line in the file
        MsgBox,64,,%Clipboard% added to D:/wordlist.txt!,1  ; Display confirmation message (optional)
    }
    else
    {
        MsgBox,64,,No text selected!,1  ; Show warning if no text was copied
    }

    return
}

~MButton & RButton::
SendInput ^s
return

~XButton2 & XButton1::
SendInput !{Tab}
return

~XButton1 & XButton2::
SendInput #{Tab}
return
