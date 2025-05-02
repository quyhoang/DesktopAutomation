#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 3
FileEncoding, UTF-8			

; ===============================================
; Hotkeys
; ===============================================

; Define the hotkeys to lookup online
<^0::
<^1::
<^2::
<^3::
<^4::
<^5::
<^6::
<^7::
<^8::
<^9::
index := SubStr(A_ThisHotkey, 0)
lookup(index+0)
return

; ===============================================
; Functions
; ===============================================

lookup(index) 
{
	global YukarilinkData

    Clipboard := "" ; Clear the clipboard
    Send, ^c ; Copy selected text
    ClipWait, 2 ; Wait for the clipboard to contain text
	coreLookup(index, Clipboard)
	return
}

coreLookup(index, searchKey := "")
{
	global YukarilinkData
	if (searchKey = "")
	{
        TrayTip, No text selected, Please select some text to use Danshari, 1, 17
        return
    }
	if ((YukarilinkData[index]  == "") or isInvalidLink(YukarilinkData[index]))
	{
		TrayTip, Hotkey not initialized or invalid link, Please check your lookup list., 1, 17
		return
	}
	danshariSearch(searchKey, analyzeSearchLink(YukarilinkData[index]))
	return
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
	; Find the position of "subarashii" in the link
    lastPos := InStr(link, "subarashii")
    if (lastPos = 0)
    {
        MsgBox, Error: "subarashii" not found in the link.
        return ""
    }

    ; Extract the parts of the URL
    preUrl := SubStr(link, 1, lastPos - 1)
	return  preUrl
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

launchYukarilink:
if ((A_Priorhotkey = "XButton1 & WheelUp") and (A_TimeSincePriorHotkey < 1000))
	return
YukarilinkUtilize:
; Copy selected content to clipboard
Clipboard := "" ; Clear the clipboard
Send, ^c ; Copy selected text
ClipWait, 2 ; Wait for the clipboard to contain text
if (ErrorLevel)
{
	TrayTip, No text selected, Please select some text to use Danshari, 1, 17
	return
}
selectedText := Clipboard

; Create the GUI only once
Gui, dynamicYukarilink: New, , Yukarilink Launch
Gui, dynamicYukarilink: Font, s12, Meiryo UI
; Show Initial Data
Gui, Add, Edit, y+20 w370 h60 vsearchKey, %selectedText%

Loop, 10
{
	index := A_Index-1
	text := "   " . regulate(LTrim(LTrim(LTrim(LTrim(YukarilinkData[index], "http"), "s"), "://"), "www."), 35)
	Gui, dynamicYukarilink: Add, Button, w370 h30 gYukarilinkLaunch vyl%index% Left, %text%
}
Gui, dynamicYukarilink: Add, Button, xm y+17 gYukarilinkCurrent, Yukarilink Editor
Gui, dynamicYukarilink: Add, Button, xm+150 yp gYukarilinkLaunchCancel, Cancel
Gui, dynamicYukarilink: Add, Text, xm y+4 h1 BackgroundColor ; Horizontal line (spacer)
Gui, dynamicYukarilink: Show, w400 h540,
return

YukarilinkLaunch:
GuiControlGet, searchKey
coreLookup(SubStr(A_GuiControl, 3), searchKey)
; SubStr(A_GuiControl, 3) remove first 2 chars, keep index number
Gui, dynamicYukarilink: Destroy
return

YukarilinkLaunchCancel:
dynamicYukarilinkGuiClose:
dynamicYukarilinkGuiEscape:
Gui, dynamicYukarilink: Destroy
return
; ============================================================
