#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 2
FileEncoding, UTF-8

setClipboard()
{
	Clipboard := ""
	SendInput ^c ;copy selected text
	ClipWait, 2
	if ErrorLevel
	{
		MsgBox, 64, Could not copy, The attempt to copy text onto the clipboard failed., 3
		return
	}
	return Clipboard
}

normalizeSearchkey(searchKey, modSpace:= True, modNewline:= False)
{
	if modSpace
		StringReplace, searchKey, searchKey, %A_Space%, +, All
	if modNewline
		StringReplace, searchKey, searchKey, `n, `%0A, All
	return searchKey
}

searchFunction(searchKey, preUrl, sufUrl:= "")
{
	if searchKey != ""
	{
		searchKey := preUrl . searchKey . sufUrl
		Run %searchKey%
	}
	else
	{
		MsgBox, 64, Invalid search key, Search key empty., 3
		return
	}
	return
}

GetActiveExplorerPath() ; This is referenced from a ahk forum
{
	explorerHwnd := WinActive("ahk_class CabinetWClass")
	if (explorerHwnd)
	{
		for window in ComObjCreate("Shell.Application").Windows
		{
			if (window.hwnd==explorerHwnd)
			{
				return window.Document.Folder.Self.Path
			}
		}
	}
} ; return Null if there is no Explorer Windows

notifyBox(text, title := "")
{
	MsgBox,64, %title%, %text%, 7
	return
}

notifyTray(text, title := "")
{
	TrayTip, %title%, %text%, 1, 17
	return
}