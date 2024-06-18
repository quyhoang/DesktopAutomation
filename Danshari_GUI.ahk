#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent %starting %directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 2
FileEncoding, UTF-8
; Set font to Arial with size 13
Gui, Font, s13, Arial

; Create the GUI
Gui, Add, Text,, Welcome to Danshari!

; GroupBox for Prompt section
Gui, Add, GroupBox, x10 y40 w400 h140, Prompt
Gui, Add, Button, x20 y70 w120 h40 gUpdateAction, Update
Gui, Add, Button, x150 y70 w120 h40 gEditAction, Edit
Gui, Add, Button, x280 y70 w120 h40 gGuideAction, Guide
Gui, Add, CheckBox, x20 y120 w120 h30, Tab Surf
Gui, Add, CheckBox, x130 y120 w120 h30, Send Enter
Gui, Add, CheckBox, x265 y120 w135 h30, Clear Occupied

; GroupBox for Look-up section
Gui, Add, GroupBox, x10 y190 w400 h100, Look-up
Gui, Add, Button, x20 y220 w120 h40 gUpdateAction, Update
Gui, Add, Button, x150 y220 w120 h40 gEditAction, Edit
Gui, Add, Button, x280 y220 w120 h40 gGuideAction, Guide

; GroupBox for Control section
Gui, Add, GroupBox, x10 y310 w400 h140, Control
Gui, Add, Button, x20 y340 w120 h40 gResetAction, Reset
Gui, Add, Button, x150 y340 w120 h40 gPauseResumeAction, Pause
Gui, Add, Button, x280 y340 w120 h40 gCloseAction, Close
Gui, Add, CheckBox, x20 y390 w200 h30, Start with Windows
Gui, Add, CheckBox, x240 y390 w120 h30, Manual

; Add author information (centered with smaller font)
Gui, Font, s10, Arial
Gui, Add, Text, x10 y460 w410 h40 +Center, 富山 2024 ホアンとグエンより

; Show the GUI
Gui, Show, w430 h540, Danshari
return

; Event handlers for buttons
UpdateAction:
MsgBox, Update button clicked.
Return

EditAction:
MsgBox, Edit button clicked.
Return

GuideAction:
MsgBox, Guide button clicked.
Return

ResetAction:
MsgBox, Reset button clicked.
Return

PauseResumeAction:
MsgBox, Pause button clicked.
Return

CloseAction:
MsgBox, Close button clicked.
ExitApp
