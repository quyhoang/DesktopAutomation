#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
FileEncoding, UTF-8			

#include %A_ScriptDir%\Danshari_initialization.ahk
#include %A_ScriptDir%\Danshari_function.ahk
#include %A_ScriptDir%\Danshari_Yukarilink.ahk
#include %A_ScriptDir%\Danshari_KaiwAI.ahk
#include %A_ScriptDir%\Danshari_ClipGenie.ahk
#include %A_ScriptDir%\Danshari_ClipGenieUtilize.ahk
#include %A_ScriptDir%\Danshari_Hayanabi.ahk
#include %A_ScriptDir%\Danshari_Megane.ahk
#include %A_ScriptDir%\Danshari_installocr.ahk
#include %A_ScriptDir%\Danshari_setValue.ahk

; ===============================================
; Initializing
; ===============================================
; ==========================================================================


;============================================================================

#+d:: ; Window Shift D to open the Gui
Gui, 1:New, +LabelDanshariGui
Gui, 1:Font, s15, Segoe UI  ; Set 18-point Meiryo UI.
;Gui, 1:Color, White
Gui, 1:add, Text, y+20, Today is a nice day!
Gui, 1:Add, Text, y+1 w300 h2 BackgroundColor ; Horizontal line (spacer)

; ===============================================
; Danshari Components
; ===============================================

buttonHeight := 42
xspace := 35
yk1 := 70
yk2 := yk1 + 50
yk3 := yk2 + 75
Gui, 1:Add, GroupBox, x10 y%yk1% w480 h190, Functions
Gui, 1:Add, Button, w130 h%buttonHeight% xm y%yk2% gKaiwAICurrent, KaiwAI
Gui, 1:Add, Button, w130 h%buttonHeight% x+%xspace% gYukarilinkCurrent, Yukarilink
Gui, 1:Add, Button, w130 h%buttonHeight% x+%xspace% gGamenyomi, Gamenyomi

Gui, 1:Add, Button, w130 h%buttonHeight% xm y%yk3% gClipGenieCurrent, ClipGenie
Gui, 1:Add, Button, w130 h%buttonHeight% x+%xspace% gHayanabiCurrent, Hayanabi
Gui, 1:Add, Button, w130 h%buttonHeight% x+%xspace% gGazoyomi, Gazoyomi


yk1 += 230
yk2 += 230
yk3 += 230
Gui, 1:Add, GroupBox, x10 y%yk1% w480 h190, Options and Controls
Gui, 1:Add, Button, w130 h%buttonHeight% xm y%yk2% gUpdate, Update
Gui, 1:Add, Button, w130 h%buttonHeight% x+%xspace% gExport, Export
Gui, 1:Add, Button, w130 h%buttonHeight% x+%xspace% gAutostart, Autostart

Gui, 1:Add, Button, w130 h%buttonHeight% xm y%yk3% gSuspendDanshari, Start/Stop
Gui, 1:Add, Button, w130 h%buttonHeight% x+%xspace% gContact, Contact
Gui, 1:Add, Button, w130 h%buttonHeight% x+%xspace% gExitDanshari, Exit

Gui, 1:Add, Link,xm+5 y+40, <a href="https://smk-toyama.notion.site/Danshari-9f18a2afa4154c5b84b5faafbd75b329">About Danshari</a>
; Gui, 1:Add, Text, x+10, %currentVersion%
Gui, 1:Add, Text, xm y+10 w300 h1 BackgroundColor ; Horizontal line (spacer)
; Set up custom tray menu
Menu, Tray, NoStandard
Menu, Tray, Add, Show, ShowGUI
Menu, Tray, Add ; Add a separator
Menu, Tray, Add, Reload, ReloadScript
Menu, Tray, Add, Toggle, SuspendDanshari
Menu, Tray, Add, Exit, ExitDanshari
Menu, Tray, Tip, Danshari
Menu, Tray, Default, Show
Gui, 1:Show,, Happy Danshari
return


activateDanshari:
gosub, opendanshari
return

opendanshari:
Gui, 1:Show,, Happy Danshari
return ; Do not open UI

ShowGui:
Gui, 1: Show
return


return
Gamenyomi:
WinMinimize, Happy Danshari
gosub, meganeReadScreen
return

Gazoyomi:
gosub, meganeReadImage
return

; ===============================================
; Danshari Options and Control
; ===============================================

Update:
;checkUpdate(currentVersion)
return

Autostart:
return

Export:
; Get the current date and time in ddmmyyhhmmss format
FormatTime, timestamp, , ddMMyyHHmmss

; Create the new ZIP file name and path on the desktop
zipFileName := "Danshari" timestamp ".zip"
desktop := A_Desktop
zipFilePath := desktop "\" zipFileName

; Define the working directory and the folders to be zipped
workingDir := A_WorkingDir
folderList := ["ClipGenieFolder", "HayanabiFolder", "KaiwAIFolder", "YukarilinkFolder"]

; Create a temporary folder to hold the folders to be zipped
tempZipDir := workingDir "\TempZipDir"
FileCreateDir, %tempZipDir%

; Copy each folder to the temporary folder
Loop, % folderList.MaxIndex()
{
    folderName := folderList[A_Index]
    sourcePath := workingDir "\" folderName
    destPath := tempZipDir "\" folderName
    
    ; Ensure the source path exists before copying
    IfExist, %sourcePath%
    {
        ; Use robocopy to copy the folder and its contents recursively
        RunWait, %ComSpec% /c robocopy "%sourcePath%" "%destPath%" /E /NFL /NDL /NJH /NJS /nc /ns /np,, Hide
    }
    else
    {
        MsgBox, 16, Error, The source folder "%sourcePath%" does not exist.
    }
}

; Create the ZIP file using PowerShell
RunWait, %ComSpec% /c powershell Compress-Archive -Path "%tempZipDir%\*" -DestinationPath "%zipFilePath%",, Hide

; Delete the temporary folder
FileRemoveDir, %tempZipDir%, 1

MsgBox, 64, Danshari Data Exported, %zipFilePath%`nDrag and drop the exported file to Danshari window to import., 10

openFolderCommand := "explorer /select," . zipFilePath
Run, %openFolderCommand%
return

; Function to handle the drag and drop
DanshariGuiDropFiles:
; Set the working directory
workingDir := A_WorkingDir
Loop, Parse, A_GuiEvent, `n
{
    ; Check if the file name matches the pattern Danshari followed by 12 digits and .zip
    if RegExMatch(A_LoopField, "i)Danshari\d{12}\.zip$")
    {
        ; Unzip the file and replace existing files
        UnzipAndReplace(A_LoopField, workingDir)
        
        ; Show a message box indicating the file has been imported
        MsgBox, 64, Data Imported, Data is imported from`n %A_LoopField%.`n "Load saved" in each editor to start using imported data., 60
        
        ; Break the loop after processing the first valid file
        break
    }
    else
    {
        MsgBox, 16, File Name Error, Please drop a valid ZIP file that starts with 'Danshari' followed by 12 digits and ends with '.zip'.,60
    }
}
return

; Function to unzip the file and replace existing files in the working directory
UnzipAndReplace(zipFile, targetDir)
{
    ; Create a temporary directory to unzip the files
    tempDir := A_Temp "\UnzipTemp"
    FileCreateDir, %tempDir%
    
    ; Unzip the file using PowerShell
    RunWait, %ComSpec% /c powershell -Command "Expand-Archive -Path '%zipFile%' -DestinationPath '%tempDir%' -Force",, Hide
    
    ; Replace existing files in the target directory
    Loop, Files, %tempDir%\*.*, R  ; R for recursive
    {
        ; Construct the destination file path
        destFilePath := StrReplace(A_LoopFileFullPath, tempDir, targetDir)
        
        ; Create necessary subdirectories
        FileCreateDir, % StrReplace(destFilePath, "\" . A_LoopFileName, "")
        
        ; Move the file to the target directory, replacing existing files
        FileMove, %A_LoopFileFullPath%, %destFilePath%, 1
    }
    ; Delete the temporary directory
    FileRemoveDir, %tempDir%, 1
}

ReloadScript:
Reload
return

ExitDanshari:
TrayTip, Good bye!, Danshari is closing..., 1, 17
ExitApp

Contact:
run, https://smk-toyama.notion.site/Li-n-h-994a7698304c4fb4b99a71e69a44fcd7
return

; Define hotkeys to pause/resume the script
~LControl & F1:: ; Toggle suspend the program
SuspendDanshari:
Suspend
If A_IsSuspended
{
	TrayTip, Danshari is sleeping..., Press Left Control +  F1 to reactivate., 1, 17
}
else
{
	TrayTip, Danshari is activated!, Press Left Control +  F1 to deactivate., 1, 17
}
return
