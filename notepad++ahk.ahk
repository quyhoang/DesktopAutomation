#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#singleInstance force
SetTitleMatchMode, 2

#IfWinActive ahk_exe Notepad++.exe

F1:: ; AHK help
If WinActive("ahk - Notepad++")
{
prefix := "https://www.autohotkey.com/docs/v1/lib/"
suffix := ".htm"
clipboard := ""
sendInput ^c
ClipWait
searchKey := clipboard
address := prefix . searchKey . suffix
run, %address%
}
return

; add comment mark line
^!j:: 
SendInput, `;---------------------------------------------------------------------------
return

; comment a line
^j:: 
SendInput, {Home}`;
return

; uncomment a line
^+j:: 
SendInput, {Home}{Del}
return

; wrap word in {}
RAlt & Ins::
SendInput, ^{Left}{{}^{Right}{}}
return

; wrap word in %%
RControl & Ins::
SendInput, ^{Left}`%^{Right}`%
return

~Mbutton & RButton::
!r:: ; run ahk from notepad**
If WinActive("ahk - Notepad++")
{
SendInput ^s
Sleep 500
WinGetActiveTitle, Title
scriptNameEnd := InStr(Title,".ahk")
scriptName := SubStr(Title,1,scriptNameEnd+3)
Run, %scriptName%
SoundPlay *-1
return
}
else
{
sendInput ^s
return
}
return

F5:: ; compile ahk from notepad**
If WinActive("ahk - Notepad++")
{
SendInput ^s
Sleep 500
WinGetActiveTitle, Title
scriptNameEnd := InStr(Title,".ahk")
scriptName := SubStr(Title,1,scriptNameEnd+3)
Run C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe /in %scriptName%
TrayTip, Success, %scriptName% is compiled, 1, 17

StrReplace(Title,"\",,count)		
folderEnd := InStr(Title,"\",,,count)
folder := SubStr(Title,1,folderEnd-1)
Run, %folder%
return
}

!f:: ; open containing folder
{
SendInput !ff{Enter}
return
}

#IfWinActive