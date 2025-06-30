#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 2
FileEncoding, UTF-8
; Create a GUI window
Gui, +AlwaysOnTop
Gui, Add, Text, vLCtrl w220, LCtrl: L:Released P:Released
Gui, Add, Text, vRCtrl w220, RCtrl: L:Released P:Released
Gui, Add, Text, vLAlt w220, LAlt: L:Released P:Released
Gui, Add, Text, vRAlt w220, RAlt: L:Released P:Released
Gui, Add, Text, vLShift w220, LShift: L:Released P:Released
Gui, Add, Text, vRShift w220, RShift: L:Released P:Released
Gui, Add, Text, vLWin w220, LWin: L:Released P:Released
Gui, Add, Text, vRWin w220, RWin: L:Released P:Released

; Set a timer to check key states every 50ms
SetTimer, CheckKeyStates, 50

; Show the GUI
Gui, Show, w230 h220, Key Monitor
return

; Timer to check key states
CheckKeyStates:
    UpdateKeyState("LCtrl")
    UpdateKeyState("RCtrl")
    UpdateKeyState("LAlt")
    UpdateKeyState("RAlt")
    UpdateKeyState("LShift")
    UpdateKeyState("RShift")
    UpdateKeyState("LWin")
    UpdateKeyState("RWin")
return

; Function to update key state
UpdateKeyState(key) {
    logicalState := GetKeyState(key, "L") ? "Pressed" : "Released"
    physicalState := GetKeyState(key, "P") ? "Pressed" : "Released"
    GuiControl,, %key%, %key%: L:%logicalState% P:%physicalState%
}

; Exit the script when the GUI is closed
GuiClose:
ExitApp