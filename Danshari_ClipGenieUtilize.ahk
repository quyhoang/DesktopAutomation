#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
FileEncoding, UTF-8


launchClipGenie:
if ((A_Priorhotkey = "XButton2 & WheelDown") and (A_TimeSincePriorHotkey < 1000))
	return
gosub, ClipGenieUtilize
return

Alt & F6:: 
ClipGenieUtilize:
OnClipboardChange("ClipChanged")
dynamicClipGenieData := []
loop, 10
{
	dynamicClipGenieData[A_Index] := ClipGenieData[A_index-1]
}
length := dynamicClipGenieData.length()

; Create the GUI only once
Gui, dynamicClipGenie: New, +AlwaysOnTop, Dynamic ClipGenie
Gui, dynamicClipGenie: Font, s12, Meiryo UI
Gui, dynamicClipGenie: Add, Text, cBlue xm y405 gClipGenieEditCurrent, ClipGenie Editor
Gui, dynamicClipGenie: Add, Text, cBlue xm+170 y405 gLoadDynamicClipGenieData, Load Recent Data
; Gui, dynamicClipGenie: Add, Text, xm y+4 h1 BackgroundColor ; Horizontal line (spacer)
; Show Initial Data
Loop, %length%
{
	text := regulate(dynamicClipGenieData[A_Index], 30)
	if (A_Index = 1)
		Gui, dynamicClipGenie: Add, Radio, w330 h30 xm y12 gCopyText vno%A_Index% Left, %text%
	else
		Gui, dynamicClipGenie: Add, Radio, w330 h30 xm y+9 gCopyText vno%A_Index% Left, %text%
}

Gui, dynamicClipGenie: Show, w380 h855,
return

ClipGenieEditCurrent:
gosub, saveDynamicClipGenieData
gosub, ClipGenieCurrent
return

CopyText:
Clipboard := dynamicClipGenieData[SubStr(A_GuiControl, 3)]
return

updateGui:
newlyCopied := dynamicClipGenieData.MaxIndex() - 10
Loop, % newlyCopied
{
	Gui, dynamicClipGenie: Default ; The Gui, dynamicClipGenie: Default line is used to ensure that subsequent GUI commands apply to the dynamicClipGenie GUI.
	
	index := A_Index + 10
	text := regulate(dynamicClipGenieData[index], 30)
	controlName := "no" . index
	
	GuiControlGet, exists, dynamicClipGenie:, %controlName%
	if (ErrorLevel) ; Control doesn't exist, so create it
	{
		if (index = 11)
			Gui, dynamicClipGenie: Add, Radio, w300 h30 xm y+47 gCopyText v%controlName% Checked Left, %text%
		else
			Gui, dynamicClipGenie: Add, Radio, w300 h30 xm y+9 gCopyText v%controlName% Checked Left, %text%
	}
	else ; Control exists, so update its text
	{
		GuiControl,, %controlName%, %text%
	}
	GuiControlGet, exists, dynamicClipGenie:, no20
	if (!ErrorLevel) ; Last control, always contains current Clipboard
		GuiControl,, no20, 1
}
return

ClipChanged(Type) 
{ 
    global dynamicClipGenieData, length
    if (Type = 1) 
    {
        newClip := Clipboard
        for index, item in dynamicClipGenieData ; count from 1
        {
            if (item = newClip)
                return ; do nothing if Clipboard content is already in dynamicClipGenieData
        }
        
        ; If Clipboard contents is not in dynamicClipGenieData
        if (dynamicClipGenieData.Length() >= 20) 
        {
            dynamicClipGenieData.RemoveAt(11)
        }
        dynamicClipGenieData.Push(newClip)
		gosub, updateGUI
    }
	return
}

LoadDynamicClipGenieData:
loop, 10
{
	index := A_Index + 10
	filePath := A_ScriptDir . "\ClipGenieFolder\Dynamic" . index . ".txt"

	if FileExist(filePath)
	{
		FileRead, fileContent, %filePath%
		dynamicClipGenieData[index] := fileContent
	}
	gosub, updateGUI
}
return

saveDynamicClipGenieData:
dynamicClipGenieLength := dynamicClipGenieData.length() - 10
Loop, % dynamicClipGenieLength
{
	index := A_Index + 10
	fileName := A_ScriptDir . "\ClipGenieFolder\Dynamic" . index . ".txt"	
	inputVar := dynamicClipGenieData[index]
	
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
}
return

dynamicClipGenieGuiClose:
dynamicClipGenieGuiEscape:
gosub, saveDynamicClipGenieData
Gui, dynamicClipGenie: Destroy
return

