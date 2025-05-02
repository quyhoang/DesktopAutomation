#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 2
FileEncoding, UTF-8

#include %A_ScriptDir%\supportFunction.ahk

~ScrollLock & o:: ; Open file/folder from selected text 
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
