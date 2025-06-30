#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force

::installocr::
installocr:
; Define the URL and the working directory
URL :="https://drive.usercontent.google.com/download?id=1XyPATjA6UR5datp74jNgaFObVdtAoXnX&export=download&authuser=0&confirm=t&uuid=e5147c3b-b0f0-4f4d-b5af-a258d2feeff3&at=APZUnTWdyOuV-O1wr0vD2srfoZJU%3A1719858985607"

oldTesseract := A_ScriptDir "\Tesseract-OCR"
if FileExist(oldTesseract)
	FileRemoveDir, %oldTesseract%, 1
	
; Define the path to save the downloaded file
DownloadedFile := A_ScriptDir "\downloaded_file.zip"
FileDelete %DownloadedFile%


; Function to download a file from a URL with simulated progress
DownloadFile(URL, SaveAs) {
    global ProgressGui
    ProgressGui := 0

    ; Simulate download progress
    Loop 50 {
        Sleep, 50
        GuiControl,, ProgressBar, % A_Index
    }

    UrlDownloadToFile, %URL%, %SaveAs%
    if (ErrorLevel)
    {
        Gui, ProgressGui:Destroy
        MsgBox, 16, Error, Failed to download the file from %URL%.
        ExitApp
    }
}

ExtractZip(FilePath, Destination) {
    global ProgressGui
	Gui, ProgressGui:Show,, Installing Tesseract-OCR for Danshari
		; GuiControl,, ProgressBar, 50 ; Update progress to 50% for extraction start
    ; ProgressGui := 50
	Loop 50 
	{
        Sleep, 50
		progress := A_Index+49
        GuiControl,, ProgressBar, % progress
    }
	; GuiControl,, ProgressBar, 100 ; Update progress to 100% for completion
	
    if (!FileExist(Destination))
        FileCreateDir, %Destination%
    
    if (FileExist(FilePath)) {
        ComObjError(false)
        zip := ComObjCreate("Shell.Application")
        extract := zip.Namespace(Destination)
        items := zip.Namespace(FilePath).Items()
        totalItems := items.Count()
        step := 50 / totalItems
        
        Loop, % totalItems 
		{
            extract.CopyHere(items.Item(A_Index - 1), 4|16)
        }
        
        
    } else {
        Gui, ProgressGui:Destroy
        MsgBox, 16, Error, ZIP file does not exist at %FilePath%.
        ExitApp
    }
}

; Create a progress GUI
Gui, ProgressGui:New, +AlwaysOnTop +Owner
Gui, ProgressGui:Add, Text, Center, Downloading and Installing Tesseract-OCR for Danshari Megane...
Gui, ProgressGui:Add, Progress, vProgressBar w320 h20
Gui, ProgressGui:Show,, Downloading Tesseract-OCR for Danshari


; Download the file
DownloadFile(URL, DownloadedFile)

; Extract the downloaded file
ExtractZip(DownloadedFile, A_ScriptDir)

; Destroy the progress GUI
Gui, ProgressGui:Destroy

; Delete downloaded file
FileDelete %DownloadedFile%

; Notify the user of success
MsgBox, 64, Success, Tesseract-OCR for Danshari Megane has been installed successfully.,7
return
