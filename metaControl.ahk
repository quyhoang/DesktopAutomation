#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#singleinstance, force
SetTitleMatchMode, 2

::slp:: ;minimize all windows and open sleep dialog
SendInput, #m
Sleep, 1000							
SendInput, !{F4} ; Open Shutdown Windows
WinWaitActive, Shut Down Windows
SendInput, {Up} ; default selection is Shutdown, Send Up to move to Sleep
return
  
::keymonitor::
run, keymonitor.ahk
return

^!r:: ; Ctrl Alt R to reload
	Reload
	Sleep 1000 
	; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
	MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
	IfMsgBox, Yes, Edit
	return

~RControl & ESC::Exitapp	
return	