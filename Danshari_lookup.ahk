#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 3
FileEncoding, UTF-8			

#include %A_ScriptDir%\Danshari_message.ahk
#include %A_ScriptDir%\Danshari_function_lookup.ahk

LAlt & F3::
updateLookupList()
return

RAlt & F3:: ; Hotkey to setup lookup
if (!FileExist("lookup.txt"))  ; Check if lookup.txt file exists
{
    FileAppend, , lookup.txt ; Create the file
	FileAppend,%initiallookupContent%, lookup.txt ; Write content to the file
}
Run, lookup.txt
return

; Define the hotkeys to create a complete message
!0::lookup(0)
return
!1::lookup(1)
return
!2::lookup(2)
return
!3::lookup(3)
return
!4::lookup(4)
return
!5::lookup(5)
return
!6::lookup(6)
return
!7::lookup(7)
return
!8::lookup(8)
return
!9::lookup(9)
return