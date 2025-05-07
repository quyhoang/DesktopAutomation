#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 3
FileEncoding, UTF-8		

; XButton2::
; KeyWait, XButton2
; If (!Instr(A_PriorHotkey, "XButton2 &") or A_TimeSincePriorHotkey > 500)
; {
	; Click, X2
; }
; return

; XButton1::
; KeyWait, XButton1
; If (!Instr(A_PriorHotkey, "XButton1 &") or A_TimeSincePriorHotkey > 500)
; {
	; Click, X1
; }
; return


; XButton1 & XButton2:: ; view all open windows
; SendInput, #{Tab}
; return

; XButton2 & XButton1::
; gosub, SuspendDanshari
; return
;==========================================

; XButton2 & MButton::
; SendInput {Enter}
; return

; XButton1 & MButton::
; SendInput {Alt Down}{Tab}
; KeyWait, MButton  ; wait until MButton is released
; SendInput {Alt Up}
; return
;==========================================

; XButton1 & LButton::
; xButtonLocked := true
; gosub, registerKaiwAIPos
; return

; XButton1 & RButton::
; xButtonLocked := true
; gosub, activateDanshari
; return

XButton2 & LButton::
SendInput, ^c
xButtonLocked := true
return

XButton2 & RButton::
SendInput, ^v
xButtonLocked := true
return
