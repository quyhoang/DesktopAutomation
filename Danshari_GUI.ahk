#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; Force new attempt to run the program if it is already running
SetTitleMatchMode, 3
FileEncoding, UTF-8

; Set font to Segoe UI with size 13 for a modern look
Gui, Font, s13, Segoe UI

; Create the GUI with tabs
Gui, Add, Tab2, x10 y10 w410 h500 vMainTab, Danshari|KaiwAI|Internomicon|ClipGenie

; --- Tab 1: Danshari ---
Gui, Tab, 1
Gui, Add, Text,, Welcome to Danshari!
Gui, Add, GroupBox, x20 y50 w370 h250, Danshari

CreateButtonSet(30, 70, "Reset (F7)", "Reset", "https://example.com/manual7", "ResetAction")
CreateButtonSet(160, 70, "Pause (F8)", "Pause", "https://example.com/manual8", "PauseResumeAction")
CreateButtonSet(290, 70, "Close (F9)", "Close", "https://example.com/manual9", "CloseAction")
Gui, Add, CheckBox, x30 y230 w200 h30, Start with Windows
Gui, Add, CheckBox, x240 y230 w120 h30, Manual

; --- Tab 2: KaiwAI ---
Gui, Tab, 2
Gui, Add, GroupBox, x20 y50 w370 h250, KaiwAI
CreateButtonSet(30, 70, "Update (F1)", "Update", "https://example.com/manual1", "UpdateAction")
CreateButtonSet(160, 70, "Edit (F2)", "Edit", "https://example.com/manual2", "EditAction")
CreateButtonSet(290, 70, "Guide (F3)", "Guide", "https://example.com/manual3", "GuideAction")
Gui, Add, CheckBox, x30 y230 w120 h30, Tab Surf
Gui, Add, CheckBox, x160 y230 w120 h30, Send Enter
Gui, Add, CheckBox, x290 y230 w120 h30, Clear Occupied

; --- Tab 3: Internomicon ---
Gui, Tab, 3
Gui, Add, GroupBox, x20 y50 w370 h250, Internomicon
CreateButtonSet(30, 70, "Update (F4)", "Update", "https://example.com/manual4", "UpdateAction")
CreateButtonSet(160, 70, "Edit (F5)", "Edit", "https://example.com/manual5", "EditAction")
CreateButtonSet(290, 70, "Guide (F6)", "Guide", "https://example.com/manual6", "GuideAction")

; --- Tab 4: ClipGenie ---
Gui, Tab, 4
Gui, Add, GroupBox, x20 y50 w370 h250, ClipGenie
CreateButtonSet(30, 70, "Reset (F7)", "Reset", "https://example.com/manual7", "ResetAction")
CreateButtonSet(160, 70, "Pause (F8)", "Pause", "https://example.com/manual8", "PauseResumeAction")
CreateButtonSet(290, 70, "Close (F9)", "Close", "https://example.com/manual9", "CloseAction")
Gui, Add, CheckBox, x30 y230 w200 h30, Start with Windows
Gui, Add, CheckBox, x240 y230 w120 h30, Manual

; Add author information (centered with smaller font)
Gui, Font, s10, Segoe UI
Gui, Add, Text, x10 y480 w410 h40 +Center, 富山 2024 ホアンとグエンより

; Hotkeys
Hotkey, F1, UpdateAction
Hotkey, F2, EditAction
Hotkey, F3, GuideAction
Hotkey, F4, UpdateAction
Hotkey, F5, EditAction
Hotkey, F6, GuideAction
Hotkey, F7, ResetAction
Hotkey, F8, PauseResumeAction
Hotkey, F9, CloseAction

; Show the GUI
Gui, Show, w430 h540, Danshari
return

; Function to create a button set
CreateButtonSet(x, y, hotkeyLabel, buttonLabel, manualLink, buttonAction) {
    buttonY := y + 20
    manualY := y + 55

    Gui, Font, s10, Segoe UI
    Gui, Add, Text, x%x% y%y% w120 h20, %hotkeyLabel%
    
    Gui, Font, s13, Segoe UI
    Gui, Add, Button, x%x% y%buttonY% w120 h30 g%buttonAction%, %buttonLabel%
    
    Gui, Font, s10, Segoe UI Underline cBlue
    Gui, Add, Text, x%x% y%manualY% w120 h20 gOpenManual, Manual
    Return
}

OpenManual:
    GuiControlGet, ctrl,, FocusV
    manualLink := ""
    if (ctrl = "Static105") {
        manualLink := "https://example.com/manual1"
    } else if (ctrl = "Static175") {
        manualLink := "https://example.com/manual2"
    } else if (ctrl = "Static245") {
        manualLink := "https://example.com/manual3"
    } else if (ctrl = "Static315") {
        manualLink := "https://example.com/manual4"
    } else if (ctrl = "Static385") {
        manualLink := "https://example.com/manual5"
    } else if (ctrl = "Static455") {
        manualLink := "https://example.com/manual6"
    } else if (ctrl = "Static525") {
        manualLink := "https://example.com/manual7"
    } else if (ctrl = "Static595") {
        manualLink := "https://example.com/manual8"
    } else if (ctrl = "Static665") {
        manualLink := "https://example.com/manual9"
    }
    Run, %manualLink%
    Return

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

GuiClose:
ExitApp
