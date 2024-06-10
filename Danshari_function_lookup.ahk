#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is running
SetTitleMatchMode, 3
FileEncoding, UTF-8

linkComponentHolder := []
loop, 9
{
	linkComponentHolder[A_Index] := ""
}

lookup(index) 
{
	global linkComponentHolder

    Clipboard := "" ; Clear the clipboard
    Send, ^c ; Copy selected text
    ClipWait, 2 ; Wait for the clipboard to contain text
    if (ErrorLevel) 
	{		
        TrayTip, No text selected, Please select some text to use Danshari, 1, 17
        return
    }
    
	if (linkComponentHolder[index]  == "")
	{
		TrayTip, Hotkey not initialized, Please check your lookup list., 1, 17
		return
	}
	
	if (index == "0") ; Google search
	{
		danshariSearch(Clipboard, "https://www.google.com/search?q=")
		return
	}
	else
	{
		danshariSearch(Clipboard, linkComponentHolder[index])
		return
	} 
    

	return
}

updateLookupList()
{
	; Reset
	global linkComponentHolder
	loop, 9
	{
		linkComponentHolder[A_Index] := ""
	}
	
	; Open the file for reading
    FileRead, fileContents, lookup.txt

    ; Split the file contents into lines
    lines := StrSplit(fileContents, "`n")

    ; Loop through the first 5 lines (or until an empty line is encountered)
    for i, line in lines 
	{
        if isInvalidLink((Trim(line)))
		{
            ; If an empty line or an invalide link is encountered, stop reading
            break
        } 
		else if (i <= 9) 
		{
            ; Update the corresponding prompt in the prompts list
			linkComponentHolder[i] := analyzeSearchLink(line)
        }
    }
	TrayTip, Lookup list updated, Refer lookup.txt for details, 1, 17
}

isInvalidLink(link)
{
    if (SubStr(link, 1, 7) = "http://" || SubStr(link, 1, 8) = "https://")
    {
        return 0
    }
    else
    {
        return 1
    }
}


analyzeSearchLink(link)
{
	; Find the position of "nice" in the link
    nicePos := InStr(link, "nice")
    if (nicePos = 0)
    {
        MsgBox, Error: "nice" not found in the link.
        return ""
    }

    ; Find the position of "day" in the link
    dayPos := InStr(link, "day")
    if (dayPos = 0)
    {
        MsgBox, Error: "day" not found in the link.
        return ""
    }

    ; Extract the parts of the URL
    linkComponentHolder := SubStr(link, 1, nicePos - 1)
	return linkComponentHolder
	
    ; linkComponentHolder[2] := SubStr(link, nicePos + 4, dayPos - nicePos - 4)  ; 4 is the length of "nice" plus one space character
    ; linkComponentHolder[3] := SubStr(link, dayPos + 3)  ; 3 is the length of "day"
}

danshariSearch(searchKey, preUrl)
{
	if searchKey != ""
	{
		searchKey := preUrl . searchKey
		Run %searchKey%
	}
	else
	{
		MsgBox, 64, Invalid search key, Search key empty., 3
		return
	}
	return
}