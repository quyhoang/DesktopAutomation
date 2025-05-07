#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
FileEncoding, UTF-8	

return

showEditGui(functionGuiNumber, functionality, Data, triggerKey)
{ 
	global Input0, Input1, Input2, Input3, Input4, Input5, Input6, Input7, Input8, Input9
	; Ensure this is the nth GUI in your project
	Gui, %functionGuiNumber%:New, +Label%functionality%Gui
	Gui, %functionGuiNumber%:Font, s16, Segoe UI 
	; Set a larger font (increased from 12 to 14)
	Gui, %functionGuiNumber%:Font, s12

	; Create 10 groups with text and input boxes in 2 columns
	Loop, 10
	{
		groupNum := A_Index - 1
		
		; Calculate position
		if (A_Index <= 5) 
		{
			xPos := 10
			yPos := (A_Index - 1) * 120 + 10
		} 
		else 
		{
			xPos := 470
			yPos := (A_Index - 6) * 120 + 10
		}
		
		Gui, %functionGuiNumber%:Add, GroupBox, x%xPos% y%yPos% w440 h110, %triggerKey% %groupNum%
		entry := Data[groupNum]
		; Add the input box with existing content (if any)
		Gui, %functionGuiNumber%:Add, Edit, vInput%groupNum% w420 h75 xp+10 yp+30, %entry%
	}
	
	; Add the save button
	buttonWidth := 87
	yval := 615
	xspace := 106

	Gui, %functionGuiNumber%:Add, Button, g%functionality%Help w%buttonWidth% xm+5 y%yval%, Guide
	Gui, %functionGuiNumber%:Add, Button, g%functionality%DefaultValue w%buttonWidth% xp+%xspace% y%yval%, Default
	Gui, %functionGuiNumber%:Add, Button, g%functionality%Current w%buttonWidth% xp+%xspace% y%yval%, Current
	; Gui, %functionGuiNumber%:Add, Button, g%functionality%LoadTxt w%buttonWidth% xp+%xspace% y%yval%, Import
	; Gui, %functionGuiNumber%:Add, Button, g%functionality%LoadTxt w%buttonWidth% xp+%xspace% y%yval%, Export
	Gui, %functionGuiNumber%:Add, Button, g%functionality%LoadTxt w%buttonWidth% xp+%xspace% y%yval%, Read TXT
	Gui, %functionGuiNumber%:Add, Button, g%functionality%EditTxt w%buttonWidth% xp+%xspace% y%yval%, Edit TXT
	Gui, %functionGuiNumber%:Add, Button, g%functionality%Load w98 xp+%xspace% y%yval%, Load Saved
	Gui, %functionGuiNumber%:Add, Button, g%functionality%Apply w76 xp+117 y%yval%, Apply
	Gui, %functionGuiNumber%:Add, Button, g%functionality%Save w145 xp+95 y%yval%, Save and Close
	Gui, %functionGuiNumber%:Font, s14
	;Gui, %functionGuiNumber%:Add, Text, xm yp+60 w800 h0.2 0x10
	;Gui, %functionGuiNumber%:Add, Text, cBlue xm+6 yp+50 g%functionality%Help, How to use %functionality%  ; Clickable Group Name with blue color

	; Show the GUI
	Gui, %functionGuiNumber%:Show, w925 h680, %functionality% Editor
	return
}

getDataFromFile(functionality)
{
	Data := ["", "", "", "", "", "", "", "", "", ""]
	Loop, 10
	{
		groupNum := A_Index - 1
		fileName := A_ScriptDir . "\" . functionality . "Folder\" . groupNum . ".txt"
		if FileExist(fileName)
		{
			FileRead, entry, %fileName%
			Data[groupNum] := entry
		}
	}
	return Data
}

saveFromGui(functionGuiNumber, functionality)
{
	global Input0, Input1, Input2, Input3, Input4, Input5, Input6, Input7, Input8, Input9
	Gui, %functionGuiNumber%:Submit, NoHide ; Move this line inside the label
	Loop, 10
	{
		groupNum := A_Index - 1
		fileName := A_ScriptDir . "\" . functionality . "Folder\" . groupNum . ".txt"	
		inputVar := Input%groupNum%
		
		; Only save if the input field is not empty
		if (inputVar != "") 
		{
			FileDelete, %fileName%
			FileAppend, %inputVar%, %fileName%
		} 
		else 
		{
			; If the input is empty and the file exists, delete it
			if (FileExist(fileName)) 
			{
				FileDelete, %fileName%
			}
		}
		Input%groupNum% := "" ; clear input
	}
	
	Gui, %functionGuiNumber%:Destroy ; then close
	return
}

setDataFromGui(functionGuiNumber)
{
	Data := ["", "", "", "", "", "", "", "", "", ""]
	global Input0, Input1, Input2, Input3, Input4, Input5, Input6, Input7, Input8, Input9
	Gui, %functionGuiNumber%:Submit, NoHide ; Move this line inside the label
	Loop, 10
	{
		groupNum := A_Index - 1	
		inputVar := Input%groupNum%
		
		; Only save if the input field is not empty
		if (inputVar != "") 
		{
			Data[groupNum] := inputVar
		} 
	}
	return Data
}


closeGui(functionGuiNumber)
{
	Gui, %functionGuiNumber%:Destroy
	return
}

generateTxt(functionality, initialMessage, defaultData)
{
	fileName := A_ScriptDir . "\" . functionality . ".txt"
	FileAppend,, %fileName% ; Create the file
	FileAppend,%defaultData%, %fileName% ; Write content to the file
	FileAppend,`r`n, %fileName% ; Append new line
	FileAppend,%initialMessage%, %fileName% ; Write content to the file
	return
}


loadTxt(functionality, initialMessage, defaultData)
{
	txtFile := A_ScriptDir . "\" . functionality . ".txt"
	if !FileExist(txtFile)
	{
		generateTxt(functionality, initialMessage, defaultData)
	}
	
	; Initialize data array with 10 empty strings
	data := ["", "", "", "", "", "", "", "", "", ""]

	; Read exactly 10 lines
	Loop 10
	{
		FileReadLine, line, %txtFile%, A_Index
		if ErrorLevel  ; File exhausted or line doesn't exist
			break
		; Remove carriage return if present
		line := StrReplace(line, "`r")
		data[A_Index-1] := line
	}
	return data
}

editTxt(functionality, initialMessage, defaultData)
{
	txtFile := A_ScriptDir . "\" . functionality . ".txt"
	if !FileExist(txtFile)
	{
		generateTxt(functionality, initialMessage, defaultData)
	}
	run, %txtFile%
	return
}


saveToFolder(functionality, data)
{
	Loop, 10
	{
		groupNum := A_Index - 1
		fileName := A_ScriptDir . "\" . functionality . "Folder\" . groupNum . ".txt"	
		
		; Only save if the input field is not empty
		if (data[A_Index] != "") 
		{
			FileDelete, %fileName%
			dataElement :=  data[A_Index]
			FileAppend, %dataElement%, %fileName%
		} 
		else 
		{
			; If the input is empty and the file exists, delete it
			if (FileExist(fileName)) 
			{
				FileDelete, %fileName%
			}
		}
	}
	return
}

regulate(text, maxLength)
{
    ; Check for newline characters and truncate if necessary
    if InStr(text, "`n") or InStr (text, "`t") 
    {
        text := StrReplace(text, "`n", " ")
        text := StrReplace(text, "`r", " ")
        text := StrReplace(text, "`t", " ")
        text := Trim(text," ")
    }
	textLen := StrLen(text)
    if (textLen >= maxLength) 
    {
        text := SubStr(text, 1, maxLength) . "..."
		return text
    }
	else
	{
		padLen := maxLength - textLen
		pad := " " ; space
		loop, % padLen
		{
			pad := pad . " "
		}
		return text . pad
	}
	
}
return
