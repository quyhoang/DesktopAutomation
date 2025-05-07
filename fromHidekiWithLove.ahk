#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#singleinstance, force

SetTitleMatchMode, 2

TrayTip, Be greater today!, いい一日をね！, 1, 17

^m::
Clipboard := ""
SendInput, ^c
ClipWait, 2
searchKey := "https://mazii.net/search/word?dict=javi&query=" . Clipboard . "&hl=vi-VN"
Run %searchKey%
sleep 1000
click MButton
return

; Search Google
^g::
::sgg::
Clipboard := ""
SendInput, ^c
ClipWait, 2
StringReplace, Clipboard, Clipboard, %A_Space%, +, All
searchKey := "https://www.google.com/search?q=" . Clipboard
Run %searchKey%
return

^d::
; Copy selected text and translate with Google in default browser--------------------------------------------------------------
Clipboard := ""
SendInput, ^c
ClipWait, 2
; replace space and newline character with the corresponding characters used in address bar of GG translate
StringReplace, Clipboard, Clipboard, %A_Space%, +, All
StringReplace, Clipboard, Clipboard, `n, `%0A, All
searchKey := "https://translate.google.com/?sl=ja&tl=vi&text=" . Clipboard . "&op=translate"
Run %searchKey%
return

:*?:tm::
SendInput %A_Space%
SendInput Tên mục
return

:*?:yt::
SendInput %A_Space%
SendInput Yếu tố mục
return

:*?:nd::
SendInput %A_Space%
SendInput Nội dung
return

:*?:ndxr::
SendInput %A_Space%
SendInput Nội dung xuất ra
return

:*?:rb::
SendInput %A_Space%
SendInput Ràng buộc nhập
return

:*?:csc::
SendInput %A_Space%
SendInput Cơ sở chính
return

:*?:bshd::
SendInput %A_Space%
SendInput bác sĩ hướng dẫn
return

:*?:bsck::
SendInput %A_Space%
SendInput Bác sĩ chuyên khoa
return

:*?:ht::
SendInput %A_Space%
SendInput Hiển thị ban đầu
return

:*?:ct::
SendInput %A_Space%
SendInput Người chịu trách nhiệm tổng thể chương trình
return

:*?:md::
SendInput %A_Space%
SendInput Kiểm soát nhập vào theo model
return

:*?:ms::
SendInput %A_Space%
SendInput Hiển thị message xác nhận
return

:*?:dt::
SendInput %A_Space%
SendInput Kế hoạch đào tạo
return

:*?:nt::
SendInput %A_Space%
SendInput Như trên
return

:*?:dl::
SendInput %A_Space%
SendInput Dựa theo dữ liệu đã lấy
return

:*?:bd::
SendInput %A_Space%
SendInput Giá trị ban đầu
return

:*?:kt::
SendInput %A_Space%
SendInput Số ký tự
return

:*?:tso::
SendInput %A_Space%
SendInput Tham số
return

:*?:qt::
SendInput %A_Space%
SendInput Quy trình xử lý
return

:*?:qd::
SendInput %A_Space%
SendInput Quyết định giá trị trả về
return

:*?:thno::
SendInput %A_Space%
SendInput Trường hợp là No thì tạm dừng xử lý 
return

:*?:dg::
SendInput %A_Space%
SendInput đánh giá 
return


:*?:ty::
SendInput %A_Space%
SendInput Truyền data đã lấy cho nguồn gọi 
return

:*?:cl::
SendInput %A_Space%
SendInput control
return

:*?:lg::
SendInput %A_Space%
SendInput User name (thông tin login) 
return

:*?:cur::
SendInput %A_Space%
SendInput chương trình giảng dạy
return

:*?:ud::
SendInput %A_Space%
SendInput Thực hiện xử lý update 
return

:*?:xl::
SendInput %A_Space%
SendInput Lấy data bằng xử lý  
return

:*?:true::
SendInput %A_Space%
SendInput Kết thúc bình thường: True, kết thúc bất thường: False 
return

:*?:trans::
SendInput %A_Space%
SendInput Sử dụng transaction để thực hiện xử lý update
return

:*?:tv::
SendInput %A_Space%
SendInput Dịch sang tiếng Việt câu sau: 
return

:*?:tq::
SendInput %A_Space%
SendInput đã được truyền qua tham số
return

:*?:cd::
SendInput %A_Space%
SendInput di chuyển đến màn hình
return

:*?:bt::
SendInput %A_Space%
SendInput Nếu xử lý kết thúc bình thường thì
return

:*?:tx::
SendInput %A_Space%
SendInput Trích xuất data
return

:*?:123::
SendInput %A_Space%
SendInput 1.Cơ sở chính 2.Liên kết 3.Khu vực
return

Mbutton & RButton::
!r:: ; run ahk from notepad**
If WinActive(".ahk")
{
	SendInput ^s
	Sleep 500
	WinGetActiveTitle, Title
	scriptNameEnd := InStr(Title,".ahk")
	scriptName := SubStr(Title,1,scriptNameEnd+3)
	Run C:\Program Files\AutoHotkey\AutoHotkey.exe %scriptName%
	SoundPlay *-1
	TrayTip, Success, %scriptName% is executed, 1, 17
	return
}
else
{  
	sendInput ^s
	return  
}    
return

~Alt & F1:: ; Suspend the program
Suspend
If A_IsSuspended
{
	TrayTip, Assistant, Sleeping`nPress Alt + F1 to reactivate., 1, 17
}
else
{
	TrayTip, Assistant, Activated`nPress Alt + F1 to deactivate., 1, 17
}
return