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


; RIGHT CLICK FIX WHEN USED AS A MODIFIER
; ------------------
IgnoreRightClick := false
#HotIf IgnoreRightClick
*RButton Up::{
	global IgnoreRightClick := false
}
#HotIf 


; XButton1 FIX WHEN USED AS A MODIFIER
; ------------------
IgnoreXButton1Click := false
#HotIf IgnoreXButton1Click
*XButton1 Up::{
	global IgnoreXButton1Click := false
}
#HotIf


; XButton2 FIX WHEN USED AS A MODIFIER
; ------------------
IgnoreXButton2Click := true
#HotIf IgnoreXButton2Click
XButton2::{
	global IgnoreXButton2Click := false
}
#HotIf

; GLOBAL
; ------------------


; copy and paste
XButton2 & LButton:: {
	global IgnoreXButton2Click := true
	Send("^c")
}
XButton2 & MButton:: {
	global IgnoreXButton2Click := true
	Send("^x")
}
XButton2 & RButton:: {
	global IgnoreXButton2Click := true
	global IgnoreRightClick := true
	Send("^v")
}



; ctrl + wheel ~ zoom
ScrollMode := false
MButton & WheelUp::
{
	if (AltTabMenu) {
		WinTabSend('{Left}') ; very ugly, code duplication, need to fix this
		return
	}
    global ScrollMode := true
	KeyWait "MButton"
    ScrollMode := false
}
#HotIf ScrollMode
MButton & WheelUp::
{
	Send "^{WheelUp}"
}
MButton & WheelDown::
{
	Send "^{WheelDown}"
}
#HotIf


; workspace scroll
RButton & WheelRight::{
	global IgnoreRightClick := true
	Send ("#^{Left}")
}
RButton & WheelLeft::{
	global IgnoreRightClick := true
	Send ("#^{Right}")
}

; tab scroll
!#WheelUp::Send("^+{Tab}")
!#WheelDown::Send("^{Tab}")

; move windows
XButton1::XButton1
XButton1 & WheelDown::Send("#{Right}")
XButton1 & WheelUp::Send("#{Left}")
XButton1 & MButton::Send("#{Down}")
XButton1 & LButton::Send("!{Tab}")
XButton1 & RButton::
{
	global IgnoreRightClick := true
	Send("!{F4}")
}

; alt tab scroll
AltTabMenu := false
~MButton & WheelDown::{	
	Send("{Alt down}")
	Send("{Tab}")
	global AltTabMenu := true
}

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

; taskbar quick launch apps scroll
TaskBarQuickLaunch := false
~XButton2 & WheelDown::{
	Send("#t")	
	global TaskBarQuickLaunch := true
}

#HotIf AltTabMenu OR WinTabMenu OR TaskBarQuickLaunch
	*WheelUp::WinTabSend('{Left}')
	*WheelDown::WinTabSend('{Right}')
#HotIf

#HotIf AltTabMenu
*RButton::{
	global IgnoreRightClick := true
	Send("{Del}")
}
~MButton Up::WinTabSend('{Alt up}', true)
#HotIf

#HotIf WinTabMenu
!#`::WinTabSend('{Enter}', true)
;!+`::WinTabSend('{Enter}', true)
#HotIf

#HotIf TaskBarQuickLaunch
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

#HotIf WinActive("ahk_exe chrome.exe")
!#RButton::{	
	global IgnoreRightClick := true
	Send("^w") ; close tab
}
!#LButton::Send("^+t") ; reopen closed tab
!#MButton::Send("^{F5}") ; refresh
#HotIf


; VS
; ------------------

#HotIf WinActive("ahk_exe devenv.exe")
!#MButton::Send("^{F12}") ; go to Implementation
!#LButton::Send("{F12}") ; go to definition
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
					
; SCROLL FAILSAFE (The Fix)
; ------------------
; Because WheelUp/Down are used as suffixes in combos (RButton & WheelUp) AND 
; as conditional hotkeys (*WheelUp), their native function is often lost.
; We explicitly restore them here at the global level.

#HotIf ; Reset to global context
WheelUp::Click "WheelUp"
WheelDown::Click "WheelDown"
