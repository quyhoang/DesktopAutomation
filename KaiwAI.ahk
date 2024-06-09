#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 3
FileEncoding, UTF-8			

#include %A_ScriptDir%\KaiwAI_message.ahk
;#include %A_ScriptDir%\KaiwAI_function_lookup.ahk
#include %A_ScriptDir%\KaiwAI_function_autopaste.ahk

TrayTip, Welcome to KaiwAI, You can start using KaiwAI now, 1, 17
SoundPlay *-1

; Default prompts value
prompts := ["Summarize the following research data: ", "Identify key insights and trends from this dataset: ", "Generate a detailed report based on the following survey results: ", "Analyze the statistical significance of the following data: ", "Provide a comprehensive literature review based on these references: "] 

; Check if prompts.txt file exists in the working directory
if FileExist("prompts.txt") 
	updatePromptList()
else
{
	Run, https://smk-toyama.notion.site/KaiwAI-Conversation-Accelerator-9f18a2afa4154c5b84b5faafbd75b329?pvs=4
	FileAppend, , prompts.txt ; Create the file
	FileAppend,%initialPromptsContent%, prompts.txt ; Write content to the file
	Run, prompts.txt
}

MsgBox,64, Getting started, %welcomeMessage%, 300

LControl & F2::
updatePromptList()
return

RControl & F2:: ; Hotkey to setup prompts
if (!FileExist("prompts.txt"))  ; Check if prompts.txt file exists
{
    FileAppend, , prompts.txt ; Create the file
	FileAppend,%initialPromptsContent%, prompts.txt ; Write content to the file
}
Run, prompts.txt
return

LAlt & F2:: ; Hotkey to capture mouse position and window title
MouseGetPos, MouseX, MouseY ; Get the current mouse position
WinGetActiveTitle, WindowTitle ; Get the active window title
WinGet, WindowExe, ProcessName, A
WinGetClass, WindowClass, A
; Provide feedback to the user
MsgBox,64, Target window %WindowTitle%, Target window and Input field position saved.`nPlease register this information again with LAlt + F2 if you move or stretch target window., 10
return

; Define hotkeys to pause/resume the script
; RAlt & F2::Suspend, Toggle

; Define the hotkeys to create a complete message
^0::kaiwa(0)
return
^1::kaiwa(1)
return
^2::kaiwa(2)
return
^3::kaiwa(3)
return
^4::kaiwa(4)
return
^5::kaiwa(5)
return
^6::kaiwa(6)
return
^7::kaiwa(7)
return
^8::kaiwa(8)
return
^9::kaiwa(9)
return