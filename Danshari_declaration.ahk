#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is running
SetTitleMatchMode, 3
FileEncoding, UTF-8

global currentVersion := "7.6.7"
global xButtonLocked := false
global clearedData := ["", "", "", "", "", "", "", "", "", ""]
global OCR_prog := A_ScriptDir "\Tesseract-OCR\tesseract.exe"

; ===============================================
; KaiwAI - Start
; ===============================================
global MouseX, MouseY, WindowTitle, WindowExe, WindowClass

global KaiwAIFunctionGuiNumber := 11
global KaiwAIFunctionality := "KaiwAI"
global KaiwAITriggerKey := "Left Control + "
global KaiwAICounter := 9
global KaiwAIInitialMessage

KaiwAIInitialMessage =
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

global KaiwAIData := ["", "", "", "", "", "", "", "", "", ""]
global KaiwAIDefaultData := "
(
Summarize the following: 
Translate to polite Japanese to use in a business email: 
Explain the following Japanese word. Explain each Kanji in the word and how the meaning of the Kanji relates to meaning of the word. Also give âm Hán Việt of the Kanji:
Explain in details and give additional examples: 
How to say this in Japanese naturally. How do native Japanese speakers say to convey this:  
Generate a detailed report based on the following survey results: 
Analyze the statistical significance of the following data: 
Provide a comprehensive literature review based on these references: 
Translate the following from Japanese to Vietnamese: 
Translate the following from Vietnamese to Japanese: 
Prepare a professional presentation based on the following data:
Summarize the key points from this article: 
)"

global KaiwAIDefaultSplittedData := StrSplit(Trim(KaiwAIDefaultData), "`n", "`r")
Loop, 10 ; without this loop the array will start at 1
{
	KaiwAIDefaultSplittedData[A_index - 1] := KaiwAIDefaultSplittedData[A_index]
}

; ===============================================
; KaiwAI - End
; ===============================================

; ===============================================
; Yukarilink - Start
; ===============================================

global YukarilinkFunctionGuiNumber := 22
global YukarilinkFunctionality := "Yukarilink"
global YukarilinkTriggerKey := "Alt + "
global YukarilinkCounter := 9
global YukarilinkInitialMessage


YukarilinkInitialMessage =
(

Greetings,

This file allows you to customize the custom online dictionary used by Danshari. 
Please write your own dictionary definition into this file following the guidelines below:

1. Each line corresponds to a dictionary link.
2. A dictionary link is the link when you search for keyword "subarashii" using a any online dictionary.
For example, when you search for "subarashii" with Google, the result link will be https://www.google.com/search?q=nice+day
3. The first 9 lines (1-9) are used for the respective shortcut combinations: Alt + 1 to Alt + 9.
Alt + 1 will send the currently selected text to the dictionary defined in line 1 of this file.
4. Control + 0 will search selected text with Google search.
5. A line must start with https:// or http://, otherwise all lines starting from that line will be ignored.


Example:
If you want to use Jisho.org dictionary.
Open Jisho, then type "subarashii" into the search box. You will see this link on address bar.
https://jisho.org/search/subarashii
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

global YukarilinkData := ["", "", "", "", "", "", "", "", "", ""]
global YukarilinkDefaultData := "
(
https://www.google.com/search?q=subarashii
https://translate.google.com/?sl=auto&tl=en&text=subarashii
https://translate.google.com/?sl=auto&tl=vi&text=subarashii
https://translate.google.com/?sl=auto&tl=ja&text=subarashii
https://dictionary.cambridge.org/dictionary/english/subarashii
https://mazii.net/vi-VN/search/word/javi/subarashii
https://eow.alc.co.jp/search?q=subarashii
https://jisho.org/search/subarashii
https://scholar.google.com/scholar?hl=en&as_sdt=0%2C5&q=subarashii
https://www.ieee.org/searchresults/index.html?q=subarashii
)"
global YukarilinkDefaultSplittedData := StrSplit(Trim(YukarilinkDefaultData), "`n", "`r")
Loop, 10 ; without this loop the array will start at 1
{
	YukarilinkDefaultSplittedData[A_index - 1] := YukarilinkDefaultSplittedData[A_index]
}



; ===============================================
; Yukarilink - End
; ===============================================

; ===============================================
; ClipGenie - Start
; ===============================================

global ClipGenieFunctionGuiNumber := 33
global ClipGenieFunctionality := "ClipGenie"
global ClipGenieTriggerKey := "Right Control +"
global ClipGenieCounter := 9
global ClipGenieInitialMessage

ClipGenieInitialMessage =
(

Greetings,

This file allows you to manage clipboard entries. 
Please make your own entries following the guidelines below:

Each of the first 10 lines corresponds to a clipboard entry (i.e. text that can be put into clipboard and pasted later). Blank lines become blank entries.


For more information and lastest version, visit https://smk-toyama.notion.site/KaiwAI-Conversation-Accelerator-9f18a2afa4154c5b84b5faafbd75b329

Thank you for using Danshari and good luck with your endeavor!

Best regards,
The Danshari Development Team
)

global ClipGenieData := ["", "", "", "", "", "", "", "", "", ""]
global ClipGenieDefaultData := "
(
Quiet the mind and the soul will speak.
What you think, you become. What you feel, you attract. What you imagine, you create.
If you want to fly, give up everything that weighs you down.
Believe nothing, no matter where you read it, or who said it, no matter if I have said it, unless it agrees with your own reason and your own common sense.
Before you speak, let your words pass through three gates: Is it true? Is it necessary? Is it kind?
There are only two mistakes one can make along the road to truth; not going all the way, and not starting.
Change is never painful. Only resistance to change is painful.
The trouble is, you think you have time.
Your mind is a powerful thing. When you start to filter it with positive thoughts your life will start to change.
Be where you are; otherwise you will miss your life.
)"
global ClipGenieDefaultSplittedData := StrSplit(Trim(ClipGenieDefaultData), "`n", "`r")
Loop, 10 ; without this loop the array will start at 1
{
	ClipGenieDefaultSplittedData[A_index - 1] := ClipGenieDefaultSplittedData[A_index]
}

; ===============================================
; ClipGenie - End
; ===============================================

; ===============================================
; Hayanabi - Start
; ===============================================

global HayanabiFunctionGuiNumber := 55
global HayanabiFunctionality := "Hayanabi"
global HayanabiTriggerKey := "No. "
global HayanabiCounter := 9
global HayanabiInitialMessage


HayanabiInitialMessage =
(

Greetings,

This file allows you to customize your shortcut launcher. 

Each of the first 10 lines corresponds to a link to a website or a program in your computer. 

When you press forward mouse button and wheelup/down, the name of the link will appear on screen. If you release the forward mouse button within 2 seconds, the link will be launched. Otherwise, it will be ignored.

For more information and lastest version, visit https://smk-toyama.notion.site/KaiwAI-Conversation-Accelerator-9f18a2afa4154c5b84b5faafbd75b329

Thank you for using Danshari and good luck with your endeavor!

Best regards,
The Danshari Development Team
)

global HayanabiData := ["", "", "", "", "", "", "", "", "", ""]
global HayanabiDefaultData := "
(
chrome.exe
brave.exe
snippingtool.exe
C:\Program Files
https://smk-toyama.notion.site/Danshari-9f18a2afa4154c5b84b5faafbd75b329
https://www.google.com/
https://chatgpt.com/
https://mail.google.com/mail/u/0/#inbox
https://chatgpt.com/
https://claude.ai/
)"
global HayanabiDefaultSplittedData := StrSplit(Trim(HayanabiDefaultData), "`n", "`r")
Loop, 10 ; without this loop the array will start at 1
{
	HayanabiDefaultSplittedData[A_index - 1] := HayanabiDefaultSplittedData[A_index]
}

; ===============================================
; Hayanabi - End
; ===============================================

global welcomeMessage

; Declare global variables
welcomeMessage := "
(
Hi " A_Username ",

Thanks for using Danshari.
This is a productivity tool that allows you to send selected text combined with customized prompt to any input field on your Windows computer using keyboard shortcuts. 

To start using Danshari, please open a window containing text input field, move your mouse cursor to the field then register window name and input position using Left Alt + F2. 
Then each time you use the shortcuts (Ctrl + 0 to Ctrl + 9), your selected text will be sent to that input field with a corresponding prompt prefix defined in KaiwAI.txt.
To view and edit custom prefix, press RControl & F2. To pause or resume the program, right click its icon on the minimized application tray.

Danshari works with any window and input field, as long as the window title and input field position remain unchanged.
If you move or resize the window, you'll need to re-register the input field position using Left Alt + F2.

Enjoy the productivity boost with Danshari and have a nice day!
)"
