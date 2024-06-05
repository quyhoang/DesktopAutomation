#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 2
FileEncoding, UTF-8

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
return

