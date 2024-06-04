#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 2
FileEncoding, UTF-8			


TrayTip, Welcome to AutoChatGPT, You can start using AutoChatGPT now, 1, 17
Run, chatGPT.html
SoundPlay *-1

; Define hotkeys to pause/resume the script
LAlt & F2::Suspend, Toggle

; Define the prompts

; Define the hotkeys to create a complete message
^1::SendToChatGPT(1)
^2::SendToChatGPT(2)
^3::SendToChatGPT(3)
^4::SendToChatGPT(4)
^5::SendToChatGPT(5)
return

SendToChatGPT(index) {
	prompts := ["Summarize the following research data: ", "Identify key insights and trends from this dataset: ", "Generate a detailed report based on the following survey results: ", "Analyze the statistical significance of the following data: ", "Provide a comprehensive literature review based on these references: "]
	
    Clipboard := "" ; Clear the clipboard
    Send, ^c ; Copy selected text
    ClipWait, 2 ; Wait for the clipboard to contain text
    if (ErrorLevel) {		
        MsgBox, No text was selected.
        return
    }
    
    ; Combine the prompt with the selected text
    Clipboard := prompts[index + 0] . "`n" . Clipboard ; without + 0, index can be treated as char and prompts[index] returns nothing
	
	if WinExist("chatGPT ") 
    ; Open a new ChatGPT window in the default browser and send the message
    url := "https://chat.openai.com/chat"
    Run, % url
	WinWaitActive, chatGPT ahk_class Chrome_WidgetWin_1,,4
    Sleep, 1000 ; Wait for the browser to open
    
    ; Send the message to ChatGPT
    SendInput, ^v{Enter}
}

