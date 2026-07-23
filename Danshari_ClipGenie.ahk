#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 3
FileEncoding, UTF-8

;================================================================
; Hotkeys
;================================================================


; Define the hotkeys to create a complete message -------------------------------------------------
>^+0:: 
>^+1::
>^+2::
>^+3::
>^+4::
>^+5::
>^+6::
>^+7::
>^+8::
>^+9::
index := SubStr(A_ThisHotkey, 0)
copy(index)
return

>^0::
>^1::
>^2::
>^3::
>^4::
>^5::
>^6::
>^7::
>^8::
>^9::
index := SubStr(A_ThisHotkey, 0)
paste(index)
return



;================================================================
; Functions
;================================================================

copy(index)
{
	global ClipGenieData
	Clipboard := ""
	sendInput, ^c
	ClipWait, 2
	if ErrorLevel
	{
		MsgBox, 64, The clipboard is empty, Please try copying again., 3
		return
	}
	ClipGenieData[index] := Clipboard
	savedClipFile := "ClipGenie\" . index . ".txt"

	; Check if the folder exists
	if FileExist(savedClipFile)
	{
		FileDelete, %savedClipFile%
	}
	FileAppend, %Clipboard%, %savedClipFile% ; Create the file
	TrayTip, Saved to Right Control %index%, %Clipboard%, 1, 17
	return
}

paste(index)
{
	global ClipGenieData
	Clipboard := ""
	Clipboard := ClipGenieData[index]			
	ClipWait, 2
	if ErrorLevel
	{
		MsgBox, 64, The clipboard is empty, Please initialize clipboard with RControl + Shift + number., 3
		return
	}
	SendInput ^v
	return
}

