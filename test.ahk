#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 2
FileEncoding, UTF-8

#i:: ; Win+I
SetTitleMatchMode, 2
WinActivate, - Microsoft​ Edge
browser := GetDefaultBrowser()
msgbox, %browser%
return

; Function to get the default browser
GetDefaultBrowser() {
    RegRead, browser, HKEY_CLASSES_ROOT, http\shell\open\command
    if ErrorLevel
        return
    StringReplace, browser, browser, `%1,, All
    StringReplace, browser, browser, `"",,All
    return browser
}


