#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; force new attempt to run the program if it is already running
SetTitleMatchMode, 3
FileEncoding, UTF-8

OCR_prog := A_ScriptDir "\Tesseract-OCR\tesseract.exe"
Alt & F3:: ; assume that this will call SnippingTool
meganeReadScreen:
if !FileExist(OCR_prog)
{	
	if WinExist("ahk_exe SnippingTool.exe")
		WinClose 
	MsgBox, 4164, OCR Initialization, OCR program not found.`nDownload OCR to continue?, 30
	IfMsgBox Yes
	{
		gosub, installocr
	}
	else
	{
		MsgBox, 64, Megane will exit, Megane is unavailable without OCR`nYou can download manually later with the hotkey installocr + Enter to use Megane., 30
		return
	}
}
SendInput, #+s
OnClipboardChange("OCR") ; after screenshot is copied by SnippingTool
Return

Alt & F5::
meganeReadImage:
if !FileExist(OCR_prog)
{
	MsgBox, 4164, OCR Initialization, OCR program not found.`nDownload OCR to continue?, 30
	IfMsgBox Yes
	{
		gosub, installocr
	}
	else
	{
		MsgBox, 64, Megane will exit, Megane is unavailable without OCR`nYou can download manually later with the hotkey installocr + Enter to use Megane., 30
		return
	}
}
Gui, 2:New, +LabelMeganeGui
; Set the font for the GUI
Gui, 2:Font, s18, Meiryo UI

; Add a text control with a larger margin and background color for better visual appeal
Gui, 2:Color, White
Gui, 2:Add, Text, x20 y45 w560 h260 BackgroundTrans Center hwndhText,
(
Vui lòng kéo và thả ảnh JPG hoặc PNG vào đây.
`n
JPGまたはPNG画像をここにドラッグしてドロップしてください。
`n
Drag and drop your JPG or PNG image here.
`n
)

; Show the GUI window with a title
Gui, 2:Show, w600 h300, Danshari Megane
Return

MeganeGuiDropFiles:
TrayTip, Transcribing your image, `n%A_GuiEvent%, 5, 17

OCR_prog := "Tesseract-OCR\tesseract.exe" ; Tesseract-OCR\tesseract is required to be in working directory
outputFile := A_ScriptDir . "\DanshariOCR"
RunWait, %OCR_prog% "%A_GuiEvent%" %outputFile% -l jpn+eng+vie
outputFile := outputFile . ".txt"
Run, %outputFile%
Return

GuiEscape:
Gui, Destroy ; allow users to use the gui multiple times, as opposed to exitapp
Return

::ocresult::
lastResult:
if FileExist("DanshariOCR.txt")
	Run, DanshariOCR.txt
else
	MsgBox, 64, No result found, Could not find last OCR result., 3
return

OCR(DataType) 
{
	If (DataType = 2)
	{
		outputImagePath := A_ScriptDir "\DanshariMegane.png"
		psCommand := "Add-Type -AssemblyName System.Windows.Forms; $img = [System.Windows.Forms.Clipboard]::GetImage(); $img.Save('" outputImagePath "', [System.Drawing.Imaging.ImageFormat]::Png)"
		;RunWait, PowerShell -Command %psCommand%, , Hide

		; Run PowerShell command to save the clipboard image to a file
		RunWait, %ComSpec% /c powershell -command "%psCommand%", , Hide

		; Check if the image was saved successfully
		If !FileExist(outputImagePath)
		{
			MsgBox, 16, Error, Failed to save the clipboard image.
			Return
		}

		; Open the saved image
		global OCR_prog ; Tesseract-OCR\tesseract is required to be in working directory
		outputFile := A_ScriptDir . "\DanshariOCR"
		RunWait, %OCR_prog% "%outputImagePath%" %outputFile% -l jpn+eng+vie
		outputFile := outputFile . ".txt"
		;Run, %outputFile%
		FileRead, Clipboard, %outputFile%
		if ErrorLevel 
		{
			TrayTip, Exception, `nCould not set OCR text to clipboard, 5, 17
			return
		}
		MsgBox, 64, Text copied to Clipboard, %Clipboard%, 2
	}
	OnClipboardChange("OCR", 0) ; unregister the function. Without this, OCR is called everytime a photo is copied.
	return
}
