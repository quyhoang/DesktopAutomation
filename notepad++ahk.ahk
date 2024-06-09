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





+!j:: ;AHK editor
if WinActive("ahk")
{
	Clipboard := "`;==================================================`n"
	SendInput, ^v
}
return

PgUp:: ;Reload
if WinActive("ahk")
{
	Reload
	Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
	MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
	IfMsgBox, Yes, Edit
		return
}

; comment a line
^j:: 
SendInput, {Home}`;
return

; uncomment a line
^+j:: 
SendInput, {Home}{Del}
return

; wrap word in {}
RControl & [::
SendInput, ^{Left}{{}^{Right}{}}
return

; wrap word in %%
LControl & 5::
SendInput, ^{Left}`%^{Right}`%
return

; wrap word in ""
RControl & '::
SendInput, ^{Left}`"^{Right}`" ;'
return
   
   
Mbutton & RButton::
!r:: ; run ahk from notepad**
If WinActive(".ahk")
{
	SendInput ^s
	Sleep 500
	WinGetActiveTitle, Title
	scriptNameEnd := InStr(Title,".ahk")
	scriptName := SubStr(Title,1,scriptNameEnd+3)
	Run C:\Program Files\AutoHotkey\AutoHotkey.exe %scriptName%
	SoundPlay *-1
	msgbox,64,,Script executed,2
	return
}
else
{  
	sendInput ^s
	return  
}    
return

F4::
If WinActive("ahk - Notepad++")
{
	SendInput ^s
	Sleep 500
	WinGetActiveTitle, Title
	scriptNameEnd := InStr(Title,".ahk")
	scriptName := SubStr(Title,1,scriptNameEnd+3)
	Run C:\Program Files\AutoHotkey\AutoHotkey.exe %scriptName%
	TrayTip, Success, %scriptName% is activated, 1, 17

	StrReplace(Title,"\",,count)		
	folderEnd := InStr(Title,"\",,,count)
	folder := SubStr(Title,1,folderEnd-1)
	Run, %folder%
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
	
	if (scriptName = "D:\AHK_CreoParametric\AHK_CreoParametric\CreoAutomation.ahk")
	{
		Sleep 2000
		destinationFile := "O:\PEC\Creo7CustomConfig2022\CreoAutomation.exe"
		FileMove, D:\AHK_CreoParametric\AHK_CreoParametric\CreoAutomation.exe, %destinationFile%, 1
		Sleep 1000
		Run, % "explorer /select," destinationFile
	}
	else
	{
		StrReplace(Title,"\",,count)		
		folderEnd := InStr(Title,"\",,,count)
		folder := SubStr(Title,1,folderEnd-1)
		Run, %folder%
	}
	return
}
return

F6:: ; compile ahk from notepad** and move exe file to O:\PEC\治具_creo\STD_\_All
; this is created specifically for CreoAutomation.exe
If WinActive("ahk - Notepad++")
{
	; Set the source and destination paths
	SourceFile := "D:\AHK_CreoParametric\AHK_CreoParametric\CreoAutomation.exe"
	DestinationFolder := "O:\PEC\治具_creo\STD_\_All"
	DestinationFile := "O:\PEC\治具_creo\STD_\_All\CreoAutomation.exe"

	; Move the file
	FileMove, %SourceFile%, %DestinationFolder%, 1

	; Check if the move was successful
	if ErrorLevel
		MsgBox, Error moving file: %ErrorLevel%
	else
	{
		Run, % "explorer /select," DestinationFile
	}
}
return

ScrollLock & Down::
!f:: ; open containing folder
{
SendInput !ff{Enter}
return
}

^t:: ; open test file
{
testFile = %A_Desktop%\test.ahk
;testFile = D:\AHK_CreoParametric\DesktopAutomation\test.ahk
if not FileExist(testFile) ; create test file if it does not exist
{
text := "
(
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 2
FileEncoding, UTF-8
)"
FileAppend, %text%, %testFile%
}
Run, edit %A_Desktop%\test.ahk
;Run, edit D:\AHK_CreoParametric\DesktopAutomation\test.ahk
return
}

RControl & Delete::
::deletethis:: ; delete a file when it is open in notepad**
If WinActive(" - Notepad++")
{
	SendInput ^s
	Sleep 500
	WinGetActiveTitle, Title
	fileName := SubStr(Title, 1, StrLen(Title)-12)
	FileDelete, %fileName%
	TrayTip, Success, %fileName% is deleted, 1, 17
	return
}
return

::rn:: ; rename
If WinActive(" - Notepad++")
{
	SendInput ^s
	Sleep 500
	WinGetActiveTitle, Title
	fileName := SubStr(Title, 1, StrLen(Title)-12)
	SplitPath, fileName ,, OutDir, OutExtension, OutNameNoExt
	InputBox, newNameNoExt , Rename, `nPlease input new file name, ,400 ,170 , , , Locale, 300, %OutNameNoExt%
	newFileName := OutDir . "\" . newNameNoExt . "." . OutExtension
	if FileExist(newFileName)
	{
		msgbox, 292, Overwrite confirmation, New name already exists. Overwrite?, 20
		IfMsgBox Yes
			gosub, forceRename
		else
			return
	}
	forceRename:
	FileMove, %fileName%, %newFileName%, 1
	If ErrorLevel
	{
		msgbox, 48, Rename unsuccessful, Could not rename %OutNameNoExt%, 300
	}
	else
	{
		TrayTip, Success, %OutNameNoExt%.%OutExtension% is renamed to %newNameNoExt%.%OutExtension%, 1, 17
		Run, edit %newFileName%
	}
	return
}
return

>^o:: ; Left Control O to open a file in the same folder as current file
WinGetActiveTitle, Title
fileName := SubStr(Title, 1, StrLen(Title)-12)
SplitPath, fileName ,, OutDir, OutExtension, OutNameNoExt
InputBox, file2open , Open File, `nWhich file do you want to open?, ,400 ,170 , , , Locale, 300, %OutNameNoExt%

foundFile := CheckFileNameInFolder(file2open, OutDir) 
if (foundFile)
{
	if (A_Username = "quyhoang")
		Run D:\npp.8.4.4.portable.x64\notepad++.exe %foundFile%
	else
		Run, edit %foundFile%
}
else
	msgbox, 64, File not found, No file name containing %file2open% was found in %OutDir%, 20
return

#IfWinActive

; Function to check whether there exists a file in a folder with a name containing a given string
CheckFileNameInFolder(str, folderPath) 
{
    ; Loop through all files in the folder
    Loop, %folderPath%\*.*
    {
        ; Check if the string is found in the current file name
        if InStr(A_LoopFileName, str)
		{	
            return %A_LoopFileFullPath% ; Return full path
		}
    }
    return 0 ; Return false if not found
}