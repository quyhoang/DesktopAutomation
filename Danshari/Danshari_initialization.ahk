#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 3
FileEncoding, UTF-8			

#include %A_ScriptDir%\Danshari_message.ahk
#include %A_ScriptDir%\Danshari_function_autoinsert.ahk
#include %A_ScriptDir%\Danshari_function_lookup.ahk

;================================================================
; LOOKUP
;================================================================
; Default lookup value
defaultlookup := "
(
https://www.google.com/search?q=nice+day
https://translate.google.com/?sl=auto&tl=en&text=nice%20day
https://scholar.google.com/scholar?hl=en&as_sdt=0%2C5&q=nice+day
https://www.ieee.org/searchresults/index.html?q=nice+day
https://mazii.net/vi-VN/search/word/javi/nice%20day
https://jisho.org/search/nice%20day
)"


; Check if lookup.txt file exists in the working directory
if FileExist("lookup.txt") 
	updateLookupList()
else
{
	lookup := StrSplit(defaultlookup, "`n") ; Parse the long string into an array
	; Run, https://smk-toyama.notion.site/KaiwAI-Conversation-Accelerator-9f18a2afa4154c5b84b5faafbd75b329?pvs=4
	FileAppend, , lookup.txt ; Create the file
	FileAppend,%defaultlookup%, lookup.txt ; Write content to the file
	FileAppend,%initiallookupContent%, lookup.txt ; Write content to the file
	Run, lookup.txt
}



;================================================================
; PROMPT
;================================================================
; Default prompts value
defaultPrompts := "
(
Summarize the following research data: 
Identify key insights and trends from this dataset: 
Generate a detailed report based on the following survey results: 
Analyze the statistical significance of the following data: 
Provide a comprehensive literature review based on these references: 
Translate the following from Japanese to Vietnamese: 
Translate the following from Vietnamese to Japanese: 
Prepare a professional presentation based on the following data: 
Summarize the key points from this article: 
)"

; Check if prompts.txt file exists in the working directory
if FileExist("prompts.txt") 
	updatePromptsList()
else
{
	promtpts := StrSplit(defaultPrompts, "`n") ; Parse the long string into an array
	Run, https://smk-toyama.notion.site/KaiwAI-Conversation-Accelerator-9f18a2afa4154c5b84b5faafbd75b329?pvs=4
	FileAppend, , prompts.txt ; Create the file
	FileAppend,%defaultPrompts%, prompts.txt ; Write content to the file
	FileAppend,%initialPromptsContent%, prompts.txt ; Write content to the file
	Run, prompts.txt
}

;================================================================
; CLIPBOARD
;================================================================
global savedClipboard := []
savedClipboard[0] := ""
loop, 9
{
	savedClipboard[A_Index] := ""
}
