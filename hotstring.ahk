#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#singleInstance force
SetTitleMatchMode, 2

:*?:editahk:: ; edit CreoAutomation.ahk
Run, edit "O:\PEC\治具_creo\STD_\_All\CreoAutomation.ahk"
return

:*?:editconfig:: ; edit config.pro
destinationConfigFile := "O:\PEC\Creo7CustomConfig2022\config.pro"
FileSetAttrib, -R, %destinationConfigFile%
Run, %destinationConfigFile%
return

:*?:saveconfig:: ; done edit config.pro
destinationConfigFile := "O:\PEC\Creo7CustomConfig2022\config.pro"
FileSetAttrib, +R, %destinationConfigFile%
return

:*?:openahkfolder:: ; open CreoAutomation.ahk containing folder
Run, O:\PEC\治具_creo\STD_\_All
return

:*?:jg::
SendInput 治具
return

:*?:stt::
SendInput std::
return

:*?:incld::
SendInput {#}include<>
SendInput {Left}
return

; Open Japanese assignments
:*:1drive::
if WinExist("Japanese Assignments")
	WinActivate 
else
	Run https://onedrive.live.com/edit.aspx?cid=c00a6c307ebf80da&page=view&resid=C00A6C307EBF80DA!1116&parId=C00A6C307EBF80DA!1074&app=Excel
return

::pi::𝝅 
return

:R0*:gkeep:: ;open google keep
if WinExist("Google Keep")
    WinActivate ;
else
run https://keep.google.com/u/0/
return

:R0*:gphoto:: ;open google photo
if WinExist("Google Photos -")
    WinActivate
else
run https://photos.google.com/u/0/
return

:R0*:gcal:: ;open google calendar
if WinExist("Google Calendar")
    WinActivate ;
else
run https://calendar.google.com/calendar/u/0/r/week
return

:R0*:igram:: ;open google calendar
if WinExist("Instagram -")
    WinActivate ;
else
	run https://www.instagram.com/
return



:R0*:nnote:: ;open note
if WinExist("Note - Brave")
    WinActivate ;
else
run https://www.notion.so/smk-toyama/Note-0d42256185d3454c94da9e23c0b05b2b
return

:R0*:mpage:: ;open Morning page
if WinExist("Morning Pages - Brave")
    WinActivate ;
else
Run https://www.notion.so/smk-toyama/Morning-Pages-704073a15f0d4cd48a6ef2fcbafe6354
return

:R0*:dnote:: ;open Daily Notes
if WinExist("Nhật ký 2025 - Brave")
    WinActivate ;
else
Run https://www.notion.so/smk-toyama/Nh-t-k-2025-1954cc8491b7807fa494e26ad5687802
return

:R*?:tdy::
FormatTime, CurrentDateTime,, dd-MMM-yy
clipboard := CurrentDateTime
SendInput ^v
return

:R*?:pnm:: ; new photo name
FormatTime, CurrentDateTime,, dd-MMM-yy_hhmmss
clipboard := "JikePark_" . CurrentDateTime
SendInput ^v
return

:*:///:: ; used with Notion
sendInput /heading 1
sendInput {Enter}
return