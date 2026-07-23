; AutoHotkey Script to Check for Updates and Download
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 3
FileEncoding, UTF-8

; Function to check for and download update.

checkUpdate(currentVersion)
{
	jsonUrl := "https://quyhoang.github.io/Danshari_Kanri/danshari.json"
	jsonFile := "update.json"
	FileDelete, %jsonFile%
	UrlDownloadToFile, %jsonUrl%, %jsonFile%

	FileRead, jsonData, %jsonFile%
	jsonUpdate := {}
	jsonUpdate := JSON_Load(jsonData)
	latestVersion := jsonUpdate["latest_version"]
	newVersionUrl := jsonUpdate["download_url"]
	
	if (currentVersion != latestVersion)
	{
		MsgBox, 68, Update Available, Your current version is Danshari %currentVersion%.`nWould you like to update to Danshari %latestVersion%?
		IfMsgBox Yes
		{
			TrayTip, Update Available, Updating to Danshari %latestVersion%, 1, 17
			update()
		}
	}
	else
	{
		MsgBox, 64, No Update Available, You are using Danshari %currentVersion% - the lastest version., 15
	}
	return
}

; This function also download an updater to delete current danshari and replace it with the newest version. (Danshari cannot delete itself.)
update()
{
	
	jsonUrl := "https://quyhoang.github.io/Danshari_Kanri/danshari.json"
	jsonFile := "update.json"
	FileDelete, %jsonFile%
	UrlDownloadToFile, %jsonUrl%, %jsonFile%
	FileRead, jsonData, %jsonFile%
	jsonUpdate := {}
	jsonUpdate := JSON_Load(jsonData)
	newVersionUrl := jsonUpdate["download_url"]
		
	; UPDATE
	updater :=  "Danshari_Updater.exe"
	FileDelete, %updater% ; make sure that the updater is new
	updaterUrl := "https://quyhoang.github.io/Danshari_Kanri/Danshari_Updater.exe"
	UrlDownloadToFile, %updaterUrl%, %updater%
	
	tempNewVersion := "newVersion.exe"
	FileDelete, %tempNewVersion% ; make sure that the tempNewVersion is new
	UrlDownloadToFile, %newVersionUrl%, %tempNewVersion%
	;TrayTip, Update Available, Updating to Danshari %latestVersion%, 1, 17
	Run, %updater%
	ExitApp
}

; JSON Parsing Function
; (You can use a library for JSON parsing, or write your own function)
JSON_Load(jsonText) 
{
    ; Simplified JSON parsing for the example
    obj := {}
    Loop, Parse, jsonText, `n, `r
    {
        if (RegExMatch(A_LoopField, """([^""]+)"":\s*""([^""]+)""", match)) 
		{
            obj[match1] := match2
        }
    }
    return obj
}
