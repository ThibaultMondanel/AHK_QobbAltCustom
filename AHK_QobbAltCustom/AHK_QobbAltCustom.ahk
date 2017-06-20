; ===================================================================================
; ====== ____ ==== _ === _ ===== _   _ _ ===== ___ ======== _ =======================
; ===== /___ \___ | |__ | |__   /_\ | | |_ == / __\   _ ___| |_ ___  _ __ ___ =======
; ==== //  / / _ \| '_ \| '_ \ //_\\| | __|  / / | | | / __| __/ _ \| '_ ` _ \ ======
; === / \_/ / (_) | |_) | |_) /  _  \ | |_  / /__| |_| \__ \ || (_) | | | | | | =====
; === \___,_\\___/|_.__/|_.__/\_/ \_/_|\__| \____/\__,_|___/\__\___/|_| |_| |_| =====
; ===================================================================================
; ===================================================================================

; --------------------------------------------------------------
; NOTES  
; --------------------------------------------------------------
; ! = ALT
; ^ = CTRL
; + = SHIFT
; # = WIN
; $ = On release
; ~ = Keeps native function of the key
; < > = Specify Left/Right key

#NoEnv
#InstallKeybdHook
#SingleInstance force
SetWorkingDir %A_ScriptDir%  ;
#Include AHK_Lib/AHK_QobbAltCustom_Lib.ahk ; Custom func Library
#Include AHK_Lib/AHK_TextConverter.ahk ; Text converter Library
SetTitleMatchMode 2
SendMode Input

GroupAdd, GroupAccents, ahk_exe Teams.exe
GroupAdd, GroupAccents, ahk_exe chrome.exe

;-----------------------------------------------------------------------------
;-----------------------------------------------------------------------------
; Changes TrayIcon depending on the State
iconNormal := "AHK_QobbAltCustom_TrayIcon_Grey.ico"
iconSuspended := "AHK_QobbAltCustom_TrayIcon_Yellow.ico"
iconPaused := "AHK_QobbAltCustom_TrayIcon_Red.ico"

Menu, Tray, Icon,AHK_QobbAltCustom_TrayIcon_Grey.ico ,,1
; Call WM_COMMAND() whenever the WM_COMMAND (0x111) message is received.
OnMessage(0x111, "WM_COMMAND")

WM_COMMAND(wParam, lParam)
{
	static IsPaused, IsSuspended
	Critical
	SetFormat, Integer, D ; to be sure (since if..in compares alphabetically)
	id := wParam & 0xFFFF
	if id in 65305,65404,65306,65403
	{	; "Suspend Hotkeys" or "Pause Script"
		if id in 65306,65403  ; pause
			IsPaused := ! IsPaused
		else  ; at this point, A_IsSuspended has not yet been toggled.
			IsSuspended := ! A_IsSuspended

		; Icon switch
		if (IsSuspended)
			Menu, Tray, Icon,AHK_QobbAltCustom_TrayIcon_Yellow.ico,,1
		else if(IsPaused)
			Menu, Tray, Icon,AHK_QobbAltCustom_TrayIcon_Red.ico,,1
		else
			Menu, Tray, Icon,AHK_QobbAltCustom_TrayIcon_Grey.ico,,1
	}
}
 
; -------------------------------
; Disable this $@#&!% CapsLock and NumLock
SetCapsLockState, Off
SetCapsLockState, AlwaysOff
SetNumLockState, On
SetNumLockState, AlwaysOn
SetScrollLockState, Off
SetScrollLockState, AlwaysOff

TrayTip,,"AHK_QobbAltCustom: Hello!", 3, 16

;  _   _       _   _                  
; | | | | ___ | |_| | _____ _   _ ___ 
; | |_| |/ _ \| __| |/ / _ \ | | / __|
; |  _  | (_) | |_|   <  __/ |_| \__ \
; |_| |_|\___/ \__|_|\_\___|\__, |___/
;                           |___/     
						   
;=======================================
;========  Custom App Launchers ========
;=======================================

;###################################################################
;#################### ---- NumLock Layer ---- ######################
;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
NumLock::
	KeyWait, NumLock
		
#If, GetKeyState("NumLock", "P")
Return

; -------------------------------
NumpadDiv::RunP4V()				; Run P4V
ScrollLock::RunChrome() 		; Run Chrome
NumpadMult::RunNotePad() 		; Run NotePad++
NumpadSub::RunStickyNotes() 	; Run Sticky Notes
PrintScreen::RunUE4Editor() 	; Run Editor.bat
Numpad7::RunDeadlineMonitor() 	; Run Deadline Monitor

; -------------------------------
; Toggle Always On Top
;Pgup::ToggleAlwaysOnTop()

; -------------------------------
g::Send, thibault.stones@gmail.com ;
d::Send, tmondanel@digitaldimension.com ;
; -------------------------------
; Cycle TextConvert
;t::TextConvertCycle()

#If
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
;########################## NUM LOCK ###############################
;###################################################################
;################## ---- CAPS LOCK Layer ---- ######################
;vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
CapsLock::
	KeyWait, CapsLock
		
#If, GetKeyState("CapsLock", "P")
Return

a::RunChrome()
q::RunWinTeams()
z::RunP4V()
s::RunUE4Editor()
g::TinyUrl()
#If
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
;######################### CAPS LOCK ###############################
;###################################################################

ScrollLock::RunWinTeams() ; Run WinTeams
Pause::RunOutlook() ; Run Outlook
insert::RunChromeNewTab() ; Chrome: open a new tab in search mode
+insert::RunYoutube() ; Chrome/YouTube: open Youtube in a new tab.

;========================================
;==========  Custom shortcuts  ==========
;=============  System wide  ============
;========================================

!^+c::
#g::OpenHighlighted() 	; Chrome/Google: Search current text selection on Google in a new tab.
;#+e::OpenWinExplorer()	; Windows: Open a new window with selected path.
F1::Send, {Delete} 		; Use F1 as Delete
+NumpadSub::Send, _ 	; Use Shift+Num- as underscore
PrintScreen::Run C:\Windows\system32\SnippingTool.exe ; Run SnippingTool


; -------------------------------
; Custom accents inputs

;GroupAdd, GroupAccents, ahk_exe Teams.exe
;GroupAdd, GroupAccents, ahk_exe chrome.exe
#IfWinActive, ahk_group GroupAccents
!a::Send,{ASC 133} ;Send à
!e::Send,{ASC 130}	;Send é
+!e::Send,{AltDown}{Numpad1}{Numpad3}{Numpad8}{AltUp} ;{ASC 138} ;Send è
!u::Send,{ASC 151}	;Send ù
!c::Send,{ASC 0231};Send ç
#IfWinActive

; -------------------------------
; Right hand Alt-Tab
;RControl & RShift::AltTab  ; Hold down right-control then press right-shift repeatedly to move forward.
;RControl & Enter::ShiftAltTab  ; Without even having to release right-control, press Enter to reverse direction.

;=======================================
;============= GoogleChrome ============
;=======================================
; Activate the following script only in GoogleChrome
#IfWinActive, ahk_class Chrome_WidgetWin_1 ;

; -------------------------------
; Cycle between tabs with mouseWheel
!WheelUp::Send, ^{pgup}
!WheelDown::Send, ^{pgdn}

; -------------------------------
; Page up/down with mouseWheel
+WheelUp::Send, {Pgup} ;
+WheelDown::Send, {Pgdn} ;

; -------------------------------
; Home/End with mouseWheel
!+WheelUp::Send, {Home} ;
!+WheelDown::Send, {End} ;

; -------------------------------
; Duplicate the current tab
#d::DuplicateChromeTab()


#IfWinActive

;=======================================
;=========== Unreal Engine 4 ===========
;=======================================
; Activate the following script only in Unreal Engine 4
#IfWinActive, ahk_class UnrealWindow ;
RWin:: MouseClick, right ; 	
~MButton Up::
{
	GetKeyState, state, XButton1
	if state = D
		Send, g ;
	else
		Send, {Escape}
	Return
}	
#IfWinActive

;=======================================
;============== Notepad++ ==============
;=======================================
; Activate the following script only in Notepad++
#IfWinActive, ahk_class Notepad++ ;
; -------------------------------
; Reload this script
F5::ReloadScript()
#IfWinActive

;=======================================
;============== Photoshop ==============
;=======================================
; Activate the following script only in Photoshop
#IfWinActive ahk_class Photoshop ;
; Photoshop Life Saver. Remove the annoying Photoshop AltMenu
~LAlt Up::Send, {Alt} 
#IfWinActive 

;=======================================
;============== Photoshop ==============
;=======================================
; Activate the following script only in Photoshop
#IfWinActive ahk_exe rv.exe ;
; Clear Session shortcut
XButton1::Send, {ctrl down}{shift down}n{ctrl up}{shift up} 
#IfWinActive 

;=======================================
;=========== Windows Explorer ==========
;=======================================
; Activate the following script only in Window Explorer
#IfWinActive, ahk_class CabinetWClass
; Press middle mouse button to move up a folder in Explorer
~MButton::Send !{Up} 

; Page up/down with mouseWheel
+WheelUp::Send, {Pgup} ;
+WheelDown::Send, {Pgdn} ;
#IfWinActive
return