#Requires AutoHotkey v2.0

; Instructions - Logi options+ -> Thumb button -> Keyboard shortcut -> Windows + Alt + ` (tilda)

; MEDIA - right click
; -------------------

RButton::RButton
RButton & WheelUp::Volume_Up
RButton & WheelDown::Volume_Down
RButton & MButton::Media_Play_Pause
RButton & XButton1::Media_Prev
RButton & XButton2::Media_Next



; GLOBAL
; ------------------

; workspace scroll
;RButton & WheelRight::#^Right
;RButton & WheelLeft::#^Left

; tab scroll
!#WheelUp::Send("^+{Tab}")
!#WheelDown::Send("^{Tab}")

; move windows
XButton1::XButton1
XButton1 & WheelDown::Send("#{Right}")
XButton1 & WheelUp::Send("#{Left}")

; alt tab scroll
AltTabMenu := false
~MButton & WheelDown::{	
	Send("{Alt down}")
	Send("{Tab}")
	global AltTabMenu := true
}
#HotIf AltTabMenu
*WheelUp::WinTabSend('+{Tab}')
*WheelDown::WinTabSend('{Tab}')
~MButton Up::WinTabSend('{Alt up}', true)
#HotIf

; menu tab and scroll through windows
WinTabMenu := false
!#`::{
    ; If after the Alt and LWin releases, no other hot key was pressed - do WinTab
	KeyWait "Alt"
    KeyWait "LWin"
	if (ThisHotkey != A_ThisHotkey)
	{
		return
	}
	Send("#{Tab}")
	global WinTabMenu := true
}
#HotIf WinTabMenu
*WheelUp::WinTabSend('{Left}')
*WheelDown::WinTabSend('{Right}')
*RButton::WinTabSend('{Enter}', true)	
*LButton::WinTabSend('{LButton}', true) ; maintain original functionality - select by left mouse button
!#`::WinTabSend('{Enter}', true)
#HotIf

; taskbar quick launch apps scroll
TaskBarQuickLaunch := false
~XButton2 & WheelDown::{
	Send("#t")	
	global TaskBarQuickLaunch := true
}
#HotIf TaskBarQuickLaunch
*WheelUp::WinTabSend('{Left}')
*WheelDown::WinTabSend('{Right}')
~XButton2 Up::WinTabSend('{Enter}', true)
#HotIf


WinTabSend(key, stop:=false) {
    Send(key)
    if stop = true {
        global WinTabMenu := false
		global AltTabMenu := false
		global TaskBarQuickLaunch := false
    }
}



; CHROME						

; ------------------
IgnoreRightClick := false
#HotIf WinActive("ahk_exe chrome.exe")
!#RButton::{	
	global IgnoreRightClick := true
	Send("^w") ; close tab
}
!#LButton::Send("^+t") ; reopen closed tab
!#MButton::Send("^{F5}") ; refresh
#HotIf

#HotIf IgnoreRightClick
*RButton Up::IgnoreRightClickFunc
#HotIf 

IgnoreRightClickFunc() {
	global IgnoreRightClick := false
}

; VS
; ------------------

#HotIf WinActive("ahk_exe devenv.exe")
!#LButton::Send("^{F12}") ; go to Implementation
!#MButton::Send("{F12}") ; go to definition
!#RButton::{
	global IgnoreRightClick := true
	Send("+{F12}") ; view references popup
}
#HotIf					


; VSCode
; ------------------

#HotIf WinActive("ahk_exe Code.exe")
!#MButton::Send("^{F12}") ; go to Implementation
!#LButton::Send("{F12}") ; go to definition
!#RButton::{
	global IgnoreRightClick := true
	Send("+{F12}") ; view references popup
}
#HotIf					
					
