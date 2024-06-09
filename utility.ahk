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
