#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is running
SetTitleMatchMode, 3
FileEncoding, UTF-8

global welcomeMessage, initialPromptsContent, initiallookupContent

; Declare global variables
welcomeMessage := "
(
Hi " A_Username ",

Thanks for using Danshari.
This is a productivity tool that allows you to send selected text combined with customized prompt to any input field on your Windows computer using keyboard shortcuts. 

To start using Danshari, please open a window containing text input field, move your mouse cursor to the field then register window name and input position using Left Alt + F2. 
Then each time you use the shortcuts (Ctrl + 0 to Ctrl + 5), your selected text will be sent to that input field with a corresponding prompt prefix defined in prompts.txt.
To view and edit custom prefix, press RControl & F2. To pause or resume the program, right click its icon on the minimized application tray.

Danshari works with any window and input field, as long as the window title and input field position remain unchanged.
If you move or resize the window, you'll need to re-register the input field position using Left Alt + F2.

Danshari is compatible with a wide range of applications, including ChatGPT, Claude, Copilot, Zalo Desktop, Zalo Web, Skype, Teams, Line, and many more.

Enjoy the productivity boost with Danshari and have a nice day!
)"

initialPromptsContent =
(

Greetings,

This file allows you to customize the prompts used by Danshari. Please write your own prompts into this file following the guidelines below:

1. Each line corresponds to a prompt and a shortcut key combination.
2. The first five lines (1-5) are used for the respective shortcut combinations: Control + 1 to Control + 5.
3. Control + 0 will send selected text without custom prompt prefix.
4. If a line is left blank, all subsequent lines will be ignored.
5. The prompts will be combined with the selected text and sent to the AI assistant of your choice (e.g., ChatGPT, Claude, Copilot).
Although this tool is written to accelerate AI conversation (hence the name Kaiwa + AI), you can use it to send selected text to any input field of any application.

Example:
If you write "Summarize the following: " on line two, you can use the RControl + 2 shortcut to request a summary of your selected text from the AI assistant.

Please note that only the first five non-empty lines will be considered.

If you want to edit your prompt list, just open this file and edit manually or press Right Control + F2 while Danshari is running.
When you finish editing this file, press Left Control + F2 for the program to update prompt list.
For more information and lastest version, visit https://smk-toyama.notion.site/KaiwAI-Conversation-Accelerator-9f18a2afa4154c5b84b5faafbd75b329

Thank you for using Danshari and good luck with your endeavor!

Best regards,
The Danshari Development Team
)


initiallookupContent =
(

Greetings,

This file allows you to customize the prompts used by Danshari. Please write your own prompts into this file following the guidelines below:

1. Each line corresponds to a prompt and a shortcut key combination.
2. The first five lines (1-5) are used for the respective shortcut combinations: Control + 1 to Control + 5.
3. Control + 0 will send selected text without custom prompt prefix.
4. If a line is left blank, all subsequent lines will be ignored.
5. The prompts will be combined with the selected text and sent to the AI assistant of your choice (e.g., ChatGPT, Claude, Copilot).
Although this tool is written to accelerate AI conversation (hence the name Kaiwa + AI), you can use it to send selected text to any input field of any application.

Example:
If you write "Summarize the following: " on line two, you can use the RControl + 2 shortcut to request a summary of your selected text from the AI assistant.

Please note that only the first five non-empty lines will be considered.

If you want to edit your prompt list, just open this file and edit manually or press Right Control + F2 while Danshari is running.
When you finish editing this file, press Left Control + F2 for the program to update prompt list.
For more information and lastest version, visit https://smk-toyama.notion.site/KaiwAI-Conversation-Accelerator-9f18a2afa4154c5b84b5faafbd75b329

Thank you for using Danshari and good luck with your endeavor!

Best regards,
The Danshari Development Team
)