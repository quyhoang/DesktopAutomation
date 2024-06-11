#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 3
FileEncoding, UTF-8

~^c::
return

; Define the hotkeys to create a complete message
>^0::copypaste(0)
return
>^1::copypaste(1)
return
>^2::copypaste(2)
return
>^3::copypaste(3)
return
>^4::copypaste(4)
return
>^5::copypaste(5)
return
>^6::copypaste(6)
return
>^7::copypaste(7)
return
>^8::copypaste(8)
return
>^9::copypaste(9)
return

copypaste(index)
{
	global savedClipboard
	if ((A_PriorHotkey == "~^c") and (A_TimeSincePriorHotkey < 10000) and (Clipboard != ""))
	{	
		savedClipboard[index] := Clipboard
		TrayTip, Saved to Left Control %index%, %Clipboard%, 1, 17
	}
	else
	{
		Clipboard := ""
		Clipboard := savedClipboard[index]			
		ClipWait, 2
		if ErrorLevel
		{
			MsgBox, 64, The clipboard is empty, Please start over again., 3
			return
		}
		SendInput ^v
	}
	return
}