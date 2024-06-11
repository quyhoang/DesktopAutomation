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
Then each time you use the shortcuts (Ctrl + 0 to Ctrl + 9), your selected text will be sent to that input field with a corresponding prompt prefix defined in prompts.txt.
To view and edit custom prefix, press RControl & F2. To pause or resume the program, right click its icon on the minimized application tray.

Danshari works with any window and input field, as long as the window title and input field position remain unchanged.
If you move or resize the window, you'll need to re-register the input field position using Left Alt + F2.



Enjoy the productivity boost with Danshari and have a nice day!
)"

initialPromptsContent =
(
 
Greetings,

This file allows you to customize the prompts used by Danshari. Please write your own prompts into this file following the guidelines below:

1. Each line corresponds to a prompt and a shortcut key combination.
2. The first 9 lines (1-9) are used for the respective shortcut combinations: Control + 1 to Control + 9.
3. Control + 0 will send selected text without custom prompt prefix.
4. If a line is left blank, all subsequent lines will be ignored.
5. The prompts will be combined with the selected text and sent to the AI assistant of your choice (e.g., ChatGPT, Claude, Copilot).
Although this tool is written to accelerate AI conversation (hence the name Kaiwa + AI), you can use it to send selected text to any input field of any application.

Example:
If you write "Summarize the following: " on line two, you can use the RControl + 2 shortcut to request a summary of your selected text from the AI assistant.

Please note that only the first 9 lines will be considered.

If you want to edit your prompt list, just open this file and edit manually or press Right Control + F2 while Danshari is running.
When you finish editing this file, press Left Control + F2 for the program to update prompt list.

This functionality is applicable to a wide range of applications, including ChatGPT, Claude, Copilot, Zalo Desktop, Zalo Web, Skype, Teams, Line, and many more.

For more information and lastest version, visit https://smk-toyama.notion.site/KaiwAI-Conversation-Accelerator-9f18a2afa4154c5b84b5faafbd75b329

Thank you for using Danshari and good luck with your endeavor!

Best regards,
The Danshari Development Team
)


initiallookupContent =
(

Greetings,

This file allows you to customize the custom online dictionary used by Danshari. 
Please write your own dictionary definition into this file following the guidelines below:

1. Each line corresponds to a dictionary link.
2. A dictionary link is the link when you search for keyword "nice day" using a any online dictionary.
For example, when you search for "nice day" with Google, the result link will be https://www.google.com/search?q=nice+day
3. The first 9 lines (1-9) are used for the respective shortcut combinations: Alt + 1 to Alt + 9.
Alt + 1 will send the currently selected text to the dictionary defined in line 1 of this file.
4. Control + 0 will search selected text with Google search.
5. A line must start with https:// or http://, otherwise all lines starting from that line will be ignored.


Example:
If you want to use Jisho.org dictionary.
Open Jisho, then type "nice day" into the search box. You will see this link on address bar.
https://jisho.org/search/nice%20day
If you copy this link and paste it into line number 6 of this file, any time you select some text and press Alt 9, Jisho.org will be opened with search result for your selected text.

Please note that only the first 9 non-empty lines will be considered.

If you want to edit your dictionary list, just open this file and edit manually or press Right Alt + F3 while Danshari is running.
When you finish editing this file, press Left Alt + F3 for the program to update dictionary list.

This functionality is applicable to any online dictionary-like websites, eg. Google, Google Translate, CALD, OALD, Mazii, Takoboto, Weblio, etc.

For more information and lastest version, visit https://smk-toyama.notion.site/KaiwAI-Conversation-Accelerator-9f18a2afa4154c5b84b5faafbd75b329

Thank you for using Danshari and good luck with your endeavor!

Best regards,
The Danshari Development Team
)