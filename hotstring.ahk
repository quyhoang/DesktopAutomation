#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#singleInstance force
SetTitleMatchMode, 2


:*?:itmo:: ; itsumoosewa...
message := "
(
いつもお世話になっております。


よろしくお願いします。

- .... .- -. -.- ....... -.-- --- ..- 
Hoang Anh Quy  「ホアン」
SMK 株式会社　富山事業所　生産技術センター
quyhoang@smk.co.jp 
==============================
)"
clipboard := message
sendInput ^v
return

:*?:tmw:: ; teams message to wakabayashi san
:*?:wkb::
message := "
(
`%0A`%0A
若林さん、
`%0A`%0A
いつもお世話になっております。
`%0A`%0A
Teamsで新しいJobの部品手配依頼のメッセージをいくつか送信しましたので、ご確認ください。
`%0A`%0A
よろしくお願いします。
`%0A`%0A`%0A
- .... .- -. -.- ....... -.-- --- ..- 
`%0A`
生技センター
`%0A
ホアン
`%0A
quyhoang@smk.co.jp
`%0A
==============================
`%0A`%0A
)"
recipient := "tomoyo-w@smk.co.jp"
subject := "部品手配のお願い"
Run, mailto:%recipient%?subject=%subject%&body=%message%
SetTitleMatchMode, 2
WinActivate, 新規メール - HCL Notes
return




:*?:editahk:: ; edit CreoAutomation.ahk
Run, edit "O:\PEC\治具_creo\STD_\_All\CreoAutomation.ahk"
return

:*?:editconfig:: ; edit config.pro
destinationConfigFile := "O:\PEC\Creo7CustomConfig2022\config.pro"
FileSetAttrib, -R, %destinationConfigFile%
Run, %destinationConfigFile%
return

:*?:editmapkey:: ; edit config.pro
destinationConfigFile := "O:\PEC\Creo7CustomConfig2022\mapkeys.pro"
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

:*?:kumiaikara::
clipboard := "組合からの案内をお送りします。"
sendInput ^v
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

::lambda::λ 
return

::llambda::Λ 
return

::sigma::σ
return

::ssigma::Σ
return

::theta::θ
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

:R0*:igram:: ;open Instagram
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
if WinExist("Nhật ký 2025 - Brave")
    WinActivate ;
else
Run https://www.notion.so/smk-toyama/Nh-t-k-2025-1954cc8491b7807fa494e26ad5687802
Run https://www.notion.so/smk-toyama/Nh-t-k-2025-1954cc8491b7807fa494e26ad5687802
return

:R*?:tdy::
FormatTime, CurrentDateTime,, dd-MMM-yy
clipboard := CurrentDateTime
SendInput ^v
return

:R*?:tdt::
FormatTime, CurrentDateTime,, dd-MMM-yy-hhmmss
clipboard := CurrentDateTime
SendInput ^v
return

LShift & End:: ;complete code completion in VS Code
SendInput {Tab}
sleep 100
SendInput {End}
sleep 100
SendInput {Enter}
return

:*:///:: ; used with Notion
sendRaw, ###
return