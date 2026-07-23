#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

KaiwAIDefaultValue:
showEditGui(KaiwAIFunctionGuiNumber, KaiwAIFunctionality, KaiwAIDefaultSplittedData, KaiwAITriggerKey)
return
KaiwAICurrent:
showEditGui(KaiwAIFunctionGuiNumber, KaiwAIFunctionality, KaiwAIData, KaiwAITriggerKey)
return
KaiwAILoadTxt:
showEditGui(KaiwAIFunctionGuiNumber, KaiwAIFunctionality, loadTxt(KaiwAIFunctionality, KaiwAIInitialMessage, KaiwAIDefaultData), KaiwAITriggerKey)
return
KaiwAIEditTxt:
editTxt(KaiwAIFunctionality, KaiwAIInitialMessage, KaiwAIDefaultData)
return
KaiwAILoad:
showEditGui(KaiwAIFunctionGuiNumber, KaiwAIFunctionality, getDataFromFile(KaiwAIFunctionality), KaiwAITriggerKey)
return
KaiwAIApply:
KaiwAIData := setDataFromGui(KaiwAIFunctionGuiNumber)
return
KaiwAISave:
saveFromGui(KaiwAIFunctionGuiNumber, KaiwAIFunctionality)
KaiwAIData := import(KaiwAIFunctionality, KaiwAIDefaultData)
return
KaiwAIHelp:
run, https://smk-toyama.notion.site/KaiwAI-d7c0232912f94cd3a9f767343a073e61
return
KaiwAIGuiClose:
KaiwAIGuiEscape:
closeGui(KaiwAIFunctionGuiNumber)
return



; ==========================================================================
YukarilinkDefaultValue:
showEditGui(YukarilinkFunctionGuiNumber, YukarilinkFunctionality, YukarilinkDefaultSplittedData, YukarilinkTriggerKey)
return
YukarilinkCurrent:
showEditGui(YukarilinkFunctionGuiNumber, YukarilinkFunctionality, YukarilinkData, YukarilinkTriggerKey)
return
YukarilinkLoadTxt:
showEditGui(YukarilinkFunctionGuiNumber, YukarilinkFunctionality, loadTxt(YukarilinkFunctionality, YukarilinkInitialMessage, YukarilinkDefaultData), YukarilinkTriggerKey)
return
YukarilinkEditTxt:
editTxt(YukarilinkFunctionality, YukarilinkInitialMessage, YukarilinkDefaultData)
return
YukarilinkLoad:
showEditGui(YukarilinkFunctionGuiNumber, YukarilinkFunctionality, getDataFromFile(YukarilinkFunctionality), YukarilinkTriggerKey)
return
YukarilinkApply:
YukarilinkData := setDataFromGui(YukarilinkFunctionGuiNumber)
return
YukarilinkSave:
saveFromGui(YukarilinkFunctionGuiNumber, YukarilinkFunctionality)
YukarilinkData := import(YukarilinkFunctionality, YukarilinkDefaultData)
return
YukarilinkHelp:
run, https://smk-toyama.notion.site/Yukarilink-729f395094884fc3b4b9719eb20d64bf
return
YukarilinkGuiClose:
YukarilinkGuiEscape:
closeGui(YukarilinkFunctionGuiNumber)
return



; ==========================================================================
ClipGenieDefaultValue:
showEditGui(ClipGenieFunctionGuiNumber, ClipGenieFunctionality, ClipGenieDefaultSplittedData, ClipGenieTriggerKey)
return
::edcgn::
ClipGenieCurrent:
showEditGui(ClipGenieFunctionGuiNumber, ClipGenieFunctionality, ClipGenieData, ClipGenieTriggerKey)
return
ClipGenieLoadTxt:
showEditGui(ClipGenieFunctionGuiNumber, ClipGenieFunctionality, loadTxt(ClipGenieFunctionality, ClipGenieInitialMessage, ClipGenieDefaultData), ClipGenieTriggerKey)
return
ClipGenieEditTxt:
editTxt(ClipGenieFunctionality, ClipGenieInitialMessage, ClipGenieDefaultData)
return
ClipGenieLoad:
showEditGui(ClipGenieFunctionGuiNumber, ClipGenieFunctionality, getDataFromFile(ClipGenieFunctionality), ClipGenieTriggerKey)
return
ClipGenieApply:
ClipGenieData := setDataFromGui(ClipGenieFunctionGuiNumber)
If WinExist("Dynamic ClipGenie")
	gosub, ClipGenieUtilize ; reload after update
return
ClipGenieSave:
saveFromGui(ClipGenieFunctionGuiNumber, ClipGenieFunctionality)
ClipGenieData := import(ClipGenieFunctionality, ClipGenieDefaultData)
If WinExist("Dynamic ClipGenie")
	gosub, ClipGenieUtilize ; reload after update
return
ClipGenieHelp:
run, https://smk-toyama.notion.site/ClipGenie-511e36a668a34fe7b4fbfe1570deded5
return
ClipGenieGuiClose:
ClipGenieGuiEscape:
closeGui(ClipGenieFunctionGuiNumber)
return

; ==========================================================================
HayanabiDefaultValue:
showEditGui(HayanabiFunctionGuiNumber, HayanabiFunctionality, HayanabiDefaultSplittedData, HayanabiTriggerKey)
return
HayanabiCurrent:
showEditGui(HayanabiFunctionGuiNumber, HayanabiFunctionality, HayanabiData, HayanabiTriggerKey)
return
HayanabiLoadTxt:
showEditGui(HayanabiFunctionGuiNumber, HayanabiFunctionality, loadTxt(HayanabiFunctionality, HayanabiInitialMessage, HayanabiDefaultData), HayanabiTriggerKey)
return
HayanabiEditTxt:
editTxt(HayanabiFunctionality, HayanabiInitialMessage, HayanabiDefaultData)
return
HayanabiLoad:
showEditGui(HayanabiFunctionGuiNumber, HayanabiFunctionality, getDataFromFile(HayanabiFunctionality), HayanabiTriggerKey)
return
HayanabiApply:
HayanabiData := setDataFromGui(HayanabiFunctionGuiNumber)
If WinExist("Hayanabi Launch")
	gosub, HayanabiUtilize ; reload after update
return
HayanabiSave:
saveFromGui(HayanabiFunctionGuiNumber, HayanabiFunctionality)
HayanabiData := import(HayanabiFunctionality, HayanabiDefaultData)
If WinExist("Hayanabi Launch")
	gosub, HayanabiUtilize ; reload after update
return
HayanabiHelp:
run, https://smk-toyama.notion.site/Hayanabi-919758ab174848dca0602bb9555eb048
return
HayanabiGuiClose:
HayanabiGuiEscape:
closeGui(HayanabiFunctionGuiNumber)
return