#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 3
FileEncoding, UTF-8

; Set the font for the GUI
Gui, 1:Font, s18, Meiryo UI

; Add a text control with a larger margin and background color for better visual appeal
Gui, 1:Color, White
Gui, 1:Add, Text, x20 y45 w560 h260 BackgroundTrans Center hwndhText,
(
Vui lòng kéo và thả ảnh JPG hoặc PNG vào đây.
`n
JPGまたはPNG画像をここにドラッグしてドロップしてください。
`n
Drag and drop your JPG or PNG image here.
`n
)

; Show the GUI window with a title
Gui, 1:Show, w600 h300, Danshari Megane
Return

GuiDropFiles:
TrayTip, Reading your image, `n%A_GuiEvent%, 5, 17

OCR_prog := "Tesseract-OCR\tesseract.exe" ; Tesseract-OCR\tesseract is required to be in working directory
outputFile := A_Temp . "\DanshariOCR"
RunWait, %OCR_prog% "%A_GuiEvent%" %outputFile% -l jpn+eng+vie
outputFile := outputFile . ".txt"
Run, %outputFile%
Return

GuiEscape:
Gui, Destroy ; allow users to use the gui multiple times, as opposed to exitapp
Return

