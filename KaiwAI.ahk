#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 2
FileEncoding, UTF-8			


TrayTip, Welcome to KaiwAI, You can start using KaiwAI now, 1, 17
SoundPlay *-1

; Declare global variables
global MouseX, MouseY, WindowTitle, prompts

; Default prompts value
prompts := ["Summarize the following research data: ", "Identify key insights and trends from this dataset: ", "Generate a detailed report based on the following survey results: ", "Analyze the statistical significance of the following data: ", "Provide a comprehensive literature review based on these references: "] 

; Check if prompts.txt file exists in the working directory
if FileExist("prompts.txt") {
    ; Open the file for reading
    FileRead, fileContents, prompts.txt

    ; Split the file contents into lines
    lines := StrSplit(fileContents, "`n")

    ; Loop through the first 5 lines (or until an empty line is encountered)
    for i, line in lines {
        if (Trim(line) == "") {
            ; If an empty line is encountered, stop reading
            break
        } else if (i <= 5) {
            ; Update the corresponding prompt in the prompts list
            prompts[i] := line
        }
    }
}
else
	Run, ChatGPT.html


; Hotkey to setup prompts
RControl & F2::
; Check if prompts.txt file exists
if (!FileExist("prompts.txt")) 
{
    ; Create the file
    FileAppend, , prompts.txt

    ; Write professional content to the file
    FileAppend,
    (
Greetings,

This file allows you to customize the prompts used by KaiwAI. Please follow the guidelines below:

1. Each line corresponds to a prompt and a shortcut key combination.
2. The first five lines (1-5) are used for the respective shortcut combinations: RControl + 1 to RControl + 5.
3. If a line is left blank, all subsequent lines will be ignored.
4. The prompts will be combined with the selected text and sent to the AI assistant of your choice (e.g., ChatGPT, Claude, Copilot).

Example:
If you write "Summarize the following: " on line two, you can use the RControl + 2 shortcut to request a summary of your selected text from the AI assistant.

Please note that only the first five non-empty lines will be considered.

Please delete this instruction and write your own prompts into this file.
If you want to edit your prompt list, just open this file and edit manually or press Right Control + F2 while KaiwAI is running.

Thank you for using KaiwAI and good luck with your endeavor!

Best regards,
The KaiwAI Development Team
    ), prompts.txt
}
Run, prompts.txt
return


; Hotkey to capture mouse position and window title
LAlt & F2::
    ; Get the current mouse position
    MouseGetPos, MouseX, MouseY

    ; Get the active window title
    WinGetActiveTitle, WindowTitle

    ; Provide feedback to the user
    MsgBox, Mouse position saved: %MouseX%, %MouseY%`nWindow title saved: %WindowTitle%
return


; Define hotkeys to pause/resume the script
RAlt & F2::Suspend, Toggle

; Define the prompts

; Define the hotkeys to create a complete message
^1::kaiwa(1)
^2::kaiwa(2)
^3::kaiwa(3)
^4::kaiwa(4)
^5::kaiwa(5)
return

kaiwa(index) {
	global MouseX, MouseY, WindowTitle, prompts

	
    Clipboard := "" ; Clear the clipboard
    Send, ^c ; Copy selected text
    ClipWait, 2 ; Wait for the clipboard to contain text
    if (ErrorLevel) {		
        TrayTip, No text selected, Please select some text to use KaiwaI, 1, 17
        return
    }
    
    ; Combine the prompt with the selected text
    Clipboard := prompts[index + 0] . "`n" . Clipboard ; without + 0, index can be treated as char and prompts[index] returns nothing
	
	if WinExist(WindowTitle)
	{
		WinActivate
		WinWaitActive
		MouseClick, left, %MouseX%, %MouseY%
		Sleep, 100
		SendInput, ^v{Enter}
	}
	return
}

