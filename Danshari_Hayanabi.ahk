#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 3
FileEncoding, UTF-8

<!<+0::
<!<+1::
<!<+2::
<!<+3::
<!<+4::
<!<+5::
<!<+6::
<!<+7::
<!<+8::
<!<+9::
index := SubStr(A_ThisHotkey, 0)
launchLink(index)
return ; prevent auto execute when the module is called

;================================================================
; Functions
;================================================================

launchLink(index)
{
	global HayanabiData
	Run, % HayanabiData[index+0]
	return
}

launchHayanabi:
if ((A_Priorhotkey = "XButton2 & WheelUp") and (A_TimeSincePriorHotkey < 1000))
	return
HayanabiUtilize:
length := HayanabiData.length()

; Create the GUI only once
Gui, dynamicHayanabi: New, , Hayanabi Launch
Gui, dynamicHayanabi: Font, s12, Meiryo UI
; Show Initial Data
Loop, %length%
{
	index := A_Index-1
	text := "  " . regulate(HayanabiData[index], 35)
	Gui, dynamicHayanabi: Add, Button, w390 h30 gHayanabiLaunch vhn%index% Left, %text%
}
Gui, dynamicHayanabi: Add, Button, xm y+15 gHayanabiCurrent, Hayanabi Editor
Gui, dynamicHayanabi: Add, Button, xm+150 yp gHayanabiLaunchCancel, Cancel
Gui, dynamicHayanabi: Add, Text, xm y+4 h1 BackgroundColor ; Horizontal line (spacer)
Gui, dynamicHayanabi: Show, w420 h460,
return

HayanabiLaunch:
Run, % HayanabiData[SubStr(A_GuiControl, 3)] ; remove first 2 chars, keep index number
Gui, dynamicHayanabi: Destroy
return

HayanabiLaunchCancel:
dynamicHayanabiGuiClose:
dynamicHayanabiGuiEscape:
Gui, dynamicHayanabi: Destroy
return
; ============================================================

