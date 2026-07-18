SetWorkingDir C:\Users\Hoang\Desktop\thaolen1\Week21
#SingleInstance force 

F7::
    ; Clear clipboard
    Clipboard := ""
    
    ; Send Ctrl+C to copy
    Send, ^c
    
    ; Wait for clipboard to contain content
    ClipWait, 2
    if ErrorLevel
    {
        ToolTip, Error: Clipboard timeout - nothing copied!
        Sleep, 1000
        ToolTip
        return
    }
    
    ; Get URL from clipboard and trim whitespace
    videoUrl := Trim(Clipboard)
    
    ; Remove any leading/trailing spaces, tabs, newlines
    videoUrl := RegExReplace(videoUrl, "^\s+|\s+$", "")
    
    ; Check if clipboard contains valid URL
    if (videoUrl = "" || !InStr(videoUrl, "http"))
    {
        MsgBox, Error: Clipboard does not contain a valid URL!
        return
    }
    
    ; Append valid URL to urls.txt file
    FileAppend, %videoUrl%`n, urls.txt
    if ErrorLevel
    {
        MsgBox, Error: Could not write to urls.txt file!
        return
    }
    
    ; Generate output filename with timestamp (ddHHmmss format)
    FormatTime, timeStamp, , ddHHmmss
    outputName := "W21_" . timeStamp . ".mp4"
    
    ; Build ffmpeg command string
    commandString := "C:\ffmpeg\bin\ffmpeg.exe -i """ . videoUrl . """ -c copy -bsf:a aac_adtstoasc " . outputName
    
    ; Save command string to clipboard
    Clipboard := commandString
    Run, cmd /k %Clipboard%
    
    ; Show confirmation
    ToolTip, URL saved to urls.txt`nCommand running!`n%videoUrl%
    Sleep, 3000
    ToolTip
return
