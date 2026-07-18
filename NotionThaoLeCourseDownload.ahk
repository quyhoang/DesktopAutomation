#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 2
FileEncoding, UTF-8

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

inputFile := "E:\D_ LANGUAGES\日本語\Kotoba\Kotoba.txt"
SplitPath, inputFile, , workingDir
SetWorkingDir %workingDir%

    
    IfNotExist, %inputFile%
    {
        MsgBox, Error: File not found: %inputFile%
        return
    }
    
    FileRead, fileContent, %inputFile%
    videoCount := 0
    pos := 1
    
    Loop
    {
        pos := InStr(fileContent, "(", false, pos)
        if (pos = 0)
            break
        
        endPos := InStr(fileContent, ")", false, pos)
        if (endPos = 0)
            break
        
        videoUrl := SubStr(fileContent, pos + 1, endPos - pos - 1)
        
        if (InStr(videoUrl, "http"))
        {
            videoCount++
            
            FormatTime, timeStamp, , ddHHmmss
            outputName := timeStamp . "_" . videoCount . ".mp4"
            
            commandString := "C:\ffmpeg\bin\ffmpeg.exe -i """ . videoUrl . """ -c copy -bsf:a aac_adtstoasc " . outputName . " -y"
            
            ; Show CMD window (use /k to keep it open)
            Run, cmd /k %commandString%
            
            Sleep, 2000
        }
        
        pos := endPos + 1
    }
    
    MsgBox, Started %videoCount% downloads!
return
