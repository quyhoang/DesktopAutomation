; AutoHotkey Script to Check for Updates and Download
; Ensure you have AutoHotkey installed on your system

; URL to the update JSON file
updateUrl := "https://quyhoang.github.io/currentVersion/danshari.json" 

; Function to check for updates
CheckForUpdates() {
    global currentVersion, updateUrl
    ; Create a temporary file to store the JSON response
    tempFile := A_Temp "\update.json"
    
    ; Download the JSON file
    UrlDownloadToFile, %updateUrl%, %tempFile%
    
    ; Read the JSON file
    FileRead, jsonData, %tempFile%
	
	jsonObj := {}
	jsonObj := JSON_Load(jsonData)
	
	; Extract the latest version and download URL
	latestVersion := jsonObj["latest_version"]
	
    downloadUrl := jsonObj["download_url"]
    releaseNotes := jsonObj["release_notes"]
    
    ; Check if there is a new version
    if (latestVersion != currentVersion) 
	{
        MsgBox, 36, Update Available, A new version (%latestVersion%) is available!`nDo you want to update?
        ; Prompt the user to download the update
		IfMsgBox Yes
            DownloadUpdate(downloadUrl)
    } 
	else 
	{
        MsgBox, 64, No Update, You are using the latest version.
    }
}

; Function to download the update
DownloadUpdate(downloadUrl) {
    ; Create a temporary file to store the downloaded update
    downloadFile := A_Temp "\update.zip"
    
    ; Download the update file
    UrlDownloadToFile, %downloadUrl%, %downloadFile%
    
    ; Inform the user about the download
    MsgBox, 64, Download Complete, The update has been downloaded to: %downloadFile%
    ; You can add code here to unzip and install the update if needed
	
	; Test the UnzipFile function
	ZipFile := downloadFile ; Replace with your zip file path
	ExtractTo := A_Temp . "\Danshari" ; Replace with your extraction path
	FileCreateDir, %ExtractTo%
	UnzipFile(ZipFile, ExtractTo)
	MsgBox, Done unzipping!
	Run, %ExtractTo%
}

; JSON Parsing Function
; (You can use a library for JSON parsing, or write your own function)
JSON_Load(jsonText) {
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

; Function to unzip a file using COM objects
UnzipFile(ZipFile, ExtractTo) {
    ; Create a Shell.Application object
    ComObj := ComObjCreate("Shell.Application")
    ; Get the zip file as a folder object
    ZipFolder := ComObj.NameSpace(ZipFile)
    ; Get the destination folder as a folder object
    DestFolder := ComObj.NameSpace(ExtractTo)
    
    ; Extract all items
    For Item in ZipFolder.Items
        DestFolder.CopyHere(Item)

    ; Optionally, wait for the operation to complete
    Sleep, 5000
}
