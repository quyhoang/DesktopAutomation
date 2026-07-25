#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 3
FileEncoding, UTF-8			

; ===============================================
; Hotkeys
; ===============================================

LAlt & F2:: ; Hotkey to capture mouse position and window title
registerKaiwAIPos:
{
	MouseGetPos, MouseX, MouseY ; Get the current mouse position
	WinGetActiveTitle, WindowTitle ; Get the active window title
	WinGet, WindowExe, ProcessName, A
	WinGetClass, WindowClass, A
	; Provide feedback to the user
	MsgBox,64, Target window %WindowTitle%, Target window and Input field position saved.`nPlease register this information again with LAlt + F2 if you move or stretch target window., 10
	return
}

; Define the hotkeys to create a complete message
!0::
!1::
!2::
!3::
!4::
!5::
!6::
!7::
!8::
!9::
index := SubStr(A_ThisHotkey, 0)
kaiwa(index)
return 

; ===============================================
; Functions
; ===============================================

kaiwa(index) 
{
	global MouseX, MouseY, WindowTitle, WindowExe, WindowClass, KaiwAIData
    Clipboard := "" ; Clear the clipboard
    Send, ^c ; Copy selected text
    ClipWait, 2 ; Wait for the clipboard to contain text
    if (ErrorLevel) 
	{		
        TrayTip, No text selected, Please select some text to use Danshari, 1, 17
        return
    }
    
	; Combine the prompt with the selected text
	Clipboard := KaiwAIData[index + 0] . "`n" . Clipboard ; without + 0, index can be treated as char and KaiwAIData[index] returns nothing
    	
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

cycleThroughAllTabs(targetTitle, ahkExe, ahkClass)
{
    ; Get the list of Chromium-based browser windows (Chrome, Edge, Brave)
    WinGet, id, List, ahk_exe %ahkExe%

    if (id = 0)
    {
        MsgBox, No applicable windows found.
        return
    }

    ; Loop through each window
    Loop, %id%
    {
        this_id := id%A_Index%
		; only check for windows with same ahk_class and ahk_exe with target window
		WinGetClass, className, ahk_id %this_id%
		if (className != ahkClass)
			continue

        ; Check if the window is minimized
        WinGet, MinMaxState, MinMax, ahk_id %this_id%
        wasMinimized := (MinMaxState = -1)
		
        WinActivate, ahk_id %this_id%
        WinWaitActive, ahk_id %this_id%,,5
		if ErrorLevel
		{
			MsgBox, WinWait for %this_id% window timed out.
			return
		}

        ; Get the original window title and position
        WinGetTitle, originalTabTitle, ahk_id %this_id%
		previousTabTitle := originalTabTitle

        ; Cycle through all tabs in the current window
        Loop
        {
            ; Sleep, 100 ; Spend 1 second on the current
            Send, ^{Tab} ; Move to the next tab
			; Continuously check the current tab title
			loopCount := 0
            loop
            {
				Sleep, 5 ; Check every 10 milliseconds
				loopCount += 1
                WinGetActiveTitle, currentTabTitle
            } Until (previousTabTitle != currentTabTitle) or (loopCount > 10)

            ; If the tab title matches the target title, stop the process
            if (currentTabTitle = targetTitle) 
				return 1

            ; If the tab title matches the original tab title, break the loop
            if (currentTabTitle = originalTabTitle)
                break
			
			previousTabTitle := currentTabTitle
        }

        ; Minimize the window again if it was minimized
        if (wasMinimized)
            WinMinimize, ahk_id %this_id%
    }
	return 0
}