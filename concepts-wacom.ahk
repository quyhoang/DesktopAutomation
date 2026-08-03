#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 2
FileEncoding, UTF-8

F13::
switchPenMouse()
return

F14::
MouseClick, left, 137, 228 ; click center to select color
return

switchPenMouse() 
{
    static funct := 0
    funct := 1-funct
    if (funct == 0)
    {
        MouseClick, left, 80, 157 ; click pen
        return
    }   
    if (funct == 1)
    {
        MouseClick, left, 228, 201 ; click mouse
        return
    }
    return
}


