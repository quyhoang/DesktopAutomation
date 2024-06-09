#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is running
SetTitleMatchMode, 3
FileEncoding, UTF-8

#include %A_ScriptDir%\supportFunction.ahk

global preUrl, sufUrl, spaceUrl

lookup(index) 
{
	global preUrl, sufUrl, spaceUrl

    Clipboard := "" ; Clear the clipboard
    Send, ^c ; Copy selected text
    ClipWait, 2 ; Wait for the clipboard to contain text
    if (ErrorLevel) 
	{		
        TrayTip, No text selected, Please select some text to use KaiwAI, 1, 17
        return
    }
    
	if (index != "0") ; Ctrl 0 sends selected text without custom prompt
	{
		; Combine the prompt with the selected text
		Clipboard := prompts[index + 0] . "`n" . Clipboard ; without + 0, index can be treated as char and prompts[index] returns nothing
	} 
    	
	if WinExist(WindowTitle)
	{
		WinActivate, %WindowTitle%
		WinWaitActive
		MouseClick, left, %MouseX%, %MouseY%
		Sleep, 100
		SendInput, ^v{Enter}
	}
	else
	{
		if cycleThroughAllTabs(WindowTitle, WindowExe, WindowClass)
		{
			WinActivate, %WindowTitle%
			MouseClick, left, %MouseX%, %MouseY%
			Sleep, 100
			SendInput, ^v{Enter}
		}
		else
		{
			TrayTip, Target window not found!, Please register text field using Left Alt + F2, 1, 17
		}
	}
	return
}

updateLookupList()
{
	; Open the file for reading
    FileRead, fileContents, lookup.txt

    ; Split the file contents into lines
    lines := StrSplit(fileContents, "`n")

    ; Loop through the first 5 lines (or until an empty line is encountered)
    for i, line in lines 
	{
        if (Trim(line) == "") 
		{
            ; If an empty line is encountered, stop reading
            break
        } 
		else if (i <= 9) 
		{
            ; Update the corresponding prompt in the prompts list
            lookup[i] := line
        }
    }
	TrayTip, Prompt list updated, Refer prompts.txt for details, 1, 17
}

analyzeSearchLink(link)
{
    global preUrl, sufUrl, spaceUrl

    ; Find the position of "nice" in the link
    nicePos := InStr(link, "nice")
    if (nicePos = 0)
    {
        MsgBox, Error: "nice" not found in the link.
        return
    }

    ; Find the position of "day" in the link
    dayPos := InStr(link, "day")
    if (dayPos = 0)
    {
        MsgBox, Error: "day" not found in the link.
        return
    }

    ; Extract the parts of the URL
    preUrl := SubStr(link, 1, nicePos - 1)
    sufUrl := SubStr(link, dayPos + 3)  ; 3 is the length of "day"
    spaceUrl := SubStr(link, nicePos + 4, dayPos - nicePos - 4)  ; 4 is the length of "nice" plus one space character

    ; Display the results (for debugging purposes)
    ; MsgBox, preUrl: %preUrl%`nsufUrl: %sufUrl%`nspaceUrl: %spaceUrl%
}