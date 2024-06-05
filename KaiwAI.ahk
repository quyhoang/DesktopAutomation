#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 2
FileEncoding, UTF-8			


TrayTip, Welcome to KaiwAI, You can start using KaiwAI now, 1, 17
SoundPlay *-1

; Declare global variables
global MouseX, MouseY, WindowTitle, 


; Default prompts value
prompts := ["Summarize the following research data: ", "Identify key insights and trends from this dataset: ", "Generate a detailed report based on the following survey results: ", "Analyze the statistical significance of the following data: ", "Provide a comprehensive literature review based on these references: "] 



; Check if prompts.txt file exists in the working directory
if FileExist("prompts.txt") 
{
	updatePromptList()
}
else
{
	Run, https://smk-toyama.notion.site/KaiwAI-Conversation-Accelerator-9f18a2afa4154c5b84b5faafbd75b329?pvs=4
}

welcomeMessage := "
(
Hi " A_Username ",

Thanks for using KaiwAI.
This is a productivity tool that allows you to send selected text combined with customized prompt to any input field on your Windows computer using keyboard shortcuts. 

To start using KaiwAI, please open a window containing text input field, move your mouse cursor to the field then register window name and input position using Left Alt + F2. 
Then each time you use the shortcuts (Ctrl + 0 to Ctrl + 5), your selected text will be sent to that input field with a corresponding prompt prefix defined in prompts.txt.
To view and edit custom prefix, press RControl & F2. To pause or resume the program, right click its icon on the minimized application tray.

KaiwAI works with any window and input field, as long as the window title and input field position remain unchanged.
If you move or resize the window, you'll need to re-register the input field position using Left Alt + F2.

KaiwAI is compatible with a wide range of applications, including ChatGPT, Claude, Copilot, Zalo Desktop, Zalo Web, Skype, Teams, Line, and many more.

Enjoy the productivity boost with KaiwAI and have a nice day!
)"

MsgBox,64, Getting started, %welcomeMessage%, 300

if (!FileExist("prompts.txt")) 
{
{
	; Create the file
	FileAppend, , prompts.txt

	; Write professional content to the file
	FileAppend,
	(
Summarize the following research data: 
Identify key insights and trends from this dataset: 
Generate a detailed report based on the following survey results: 
Analyze the statistical significance of the following data: 
Provide a comprehensive literature review based on these references: 

Greetings,

This file allows you to customize the prompts used by KaiwAI. Please write your own prompts into this file following the guidelines below:

1. Each line corresponds to a prompt and a shortcut key combination.
2. The first five lines (1-5) are used for the respective shortcut combinations: Control + 1 to Control + 5.
3. Control + 0 will send selected text without custom prompt prefix.
4. If a line is left blank, all subsequent lines will be ignored.
5. The prompts will be combined with the selected text and sent to the AI assistant of your choice (e.g., ChatGPT, Claude, Copilot).
Although this tool is written to accelerate AI conversation (hence the name Kaiwa + AI), you can use it to send selected text to any input field of any application.

Example:
If you write "Summarize the following: " on line two, you can use the RControl + 2 shortcut to request a summary of your selected text from the AI assistant.

Please note that only the first five non-empty lines will be considered.

If you want to edit your prompt list, just open this file and edit manually or press Right Control + F2 while KaiwAI is running.
When you finish editing this file, press Left Control + F2 for the program to update prompt list.
For more information and lastest version, visit https://smk-toyama.notion.site/KaiwAI-Conversation-Accelerator-9f18a2afa4154c5b84b5faafbd75b329

Thank you for using KaiwAI and good luck with your endeavor!

Best regards,
The KaiwAI Development Team
	), prompts.txt
}
Run, prompts.txt
}

LControl & F2::
{
	updatePromptList()
	return
}

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
Summarize the following research data: 
Identify key insights and trends from this dataset: 
Generate a detailed report based on the following survey results: 
Analyze the statistical significance of the following data: 
Provide a comprehensive literature review based on these references: 

Greetings,

This file allows you to customize the prompts used by KaiwAI. Please write your own prompts into this file following the guidelines below:

1. Each line corresponds to a prompt and a shortcut key combination.
2. The first five lines (1-5) are used for the respective shortcut combinations: Control + 1 to Control + 5.
3. Control + 0 will send selected text without custom prompt prefix.
4. If a line is left blank, all subsequent lines will be ignored.
5. The prompts will be combined with the selected text and sent to the AI assistant of your choice (e.g., ChatGPT, Claude, Copilot).
Although this tool is written to accelerate AI conversation (hence the name Kaiwa + AI), you can use it to send selected text to any input field of any application.

Example:
If you write "Summarize the following: " on line two, you can use the RControl + 2 shortcut to request a summary of your selected text from the AI assistant.

Please note that only the first five non-empty lines will be considered.

If you want to edit your prompt list, just open this file and edit manually or press Right Control + F2 while KaiwAI is running.
When you finish editing this file, press Left Control + F2 for the program to update prompt list.
For more information and lastest version, visit https://smk-toyama.notion.site/KaiwAI-Conversation-Accelerator-9f18a2afa4154c5b84b5faafbd75b329

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
    MsgBox,64, Target window %WindowTitle%, Target window and Input field position saved.`nPlease register this information again with LAlt + F2 if you move or stretch target window., 10
return




; Define hotkeys to pause/resume the script
; RAlt & F2::Suspend, Toggle

; Define the prompts

; Define the hotkeys to create a complete message
^0::kaiwa(0)
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
        TrayTip, No text selected, Please select some text to use KaiwAI, 1, 17
        return
    }
    
	if (index != "0")
	{
		; Combine the prompt with the selected text
		Clipboard := prompts[index + 0] . "`n" . Clipboard ; without + 0, index can be treated as char and prompts[index] returns nothing
	}
	; Ctrl 0 sends selected text without custom prompt
    	
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

updatePromptList()
{
	; Open the file for reading
    FileRead, fileContents, prompts.txt

    ; Split the file contents into lines
    lines := StrSplit(fileContents, "`n")

    ; Loop through the first 5 lines (or until an empty line is encountered)
    for i, line in lines 
	{
        if (Trim(line) == "") 
		{
            ; If an empty line is encountered, stop reading
            break
        } 
		else if (i <= 5) 
		{
            ; Update the corresponding prompt in the prompts list
            prompts[i] := line
        }
    }
	TrayTip, Prompt list updated, Refer prompts.txt for details, 1, 17
}