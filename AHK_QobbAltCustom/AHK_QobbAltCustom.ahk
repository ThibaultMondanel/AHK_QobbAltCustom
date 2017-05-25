; ===================================================================================
; ====== ____ ==== _ === _ ===== _   _ _ ===== ___ ======== _ =======================
; ===== /___ \___ | |__ | |__   /_\ | | |_ == / __\   _ ___| |_ ___  _ __ ___ =======
; ==== //  / / _ \| '_ \| '_ \ //_\\| | __|  / / | | | / __| __/ _ \| '_ ` _ \ ======
; === / \_/ / (_) | |_) | |_) /  _  \ | |_  / /__| |_| \__ \ || (_) | | | | | | =====
; === \___,_\\___/|_.__/|_.__/\_/ \_/_|\__| \____/\__,_|___/\__\___/|_| |_| |_| =====
; ===================================================================================
; ===================================================================================

#NoEnv
#InstallKeybdHook
#SingleInstance force
SetWorkingDir %A_ScriptDir%  ;
#Include AHK_Lib/AHK_QobbAltCustom_Lib.ahk ; Custom func Library
#Include AHK_Lib/AHK_TextConverter.ahk ; Text converter Library
SetTitleMatchMode 2
SendMode Input

;-----------------------------------------------------------------------------
;-----------------------------------------------------------------------------
; Change TrayIcon depending on the State
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

; -------------------------------
; Display a TrayTip at Start
TrayTip,,"AHK_QobbAltCustom: Hello!", 3, 16

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

; PrintScreen	: Run Editor.bat
; ScrollLock	: 
; Pause			: Pandion Contacts
; NumpadDiv		: Run P4V
; PageUp		: AlwaysOnTop

; -------------------------------
; Run P4V
NumpadDiv::RunP4V()

; -------------------------------
; Run Chrome
ScrollLock::RunChrome()

; -------------------------------
; Run NotePad++
NumpadMult::RunNotePad()

; -------------------------------
; Run Sticky Notes
NumpadSub::RunStickyNotes()

; -------------------------------
; Run Editor.bat
PrintScreen::RunUE4Editor()

; -------------------------------
;Run Deadline Monitor
Numpad7::RunDeadlineMonitor()

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
;###################################################################
;###################################################################

; -------------------------------
; Run WinTeams
ScrollLock::RunWinTeams()

; -------------------------------
; Run Chrome
CapsLock::RunChrome()

; -------------------------------
; Chrome: open a new tab in search mode
insert::RunChromeNewTab()

; -------------------------------
; Chrome/YouTube: open Youtube in a new tab.
+insert::RunYoutube()

;========================================
;==========  Custom shortcuts  ==========
;=============  System wide  ============
;========================================

; -------------------------------
; Chrome/Google: Search current text selection on Google in a new tab.
!^+c::GoogleSearch()

; -------------------------------
; Windows: Open a new window with selected path.
!^+e::OpenWinExplorer()

; -------------------------------
; Use F1 as Delete
F1::Send, {Delete} ;

; -------------------------------
; Run SnippingTool
PrintScreen::Run C:\Windows\system32\SnippingTool.exe ;

; -------------------------------
; Custom accents inputs
!a:: ;Send à
{
	ControlGetFocus, OutputVar, A
	if !ErrorLevel || WinActive("ahk_exe Teams.exe") ;
	Send,{ASC 133}
	Return
}


!e:: ;Send é
{
	ControlGetFocus, OutputVar, A
	if !ErrorLevel || WinActive("ahk_exe Teams.exe") ;
	Send,{ASC 130}
	Return
}

+!e:: ;Send è
{
	ControlGetFocus, OutputVar, A
	if !ErrorLevel || WinActive("ahk_exe Teams.exe") ;
	Send,{AltDown}{Numpad1}{Numpad3}{Numpad8}{AltUp} ;{ASC 138}
	Return
}

!u:: ;Send ù
{
	ControlGetFocus, OutputVar, A
	if !ErrorLevel || WinActive("ahk_exe Teams.exe") ;
	Send,{ASC 151}
	Return
}

; -------------------------------
; Use Shift+Num- as underscore
+NumpadSub::Send, _ ; 

; -------------------------------
; Use Shift+NumEnter as =
;+NumpadEnter::Send, = ; 

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
#IfWinActive

;=======================================
;=========== Unreal Engine 4 ===========
;=======================================
; Activate the following script only in Unreal Engine 4
#IfWinActive, ahk_class UnrealWindow ;
RWin:: MouseClick, right ; 	
~MButton Up::Send, {Escape}
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
;=========== Windows Explorer ==========
;=======================================
; Activate the following script only in Window Explorer
;			GroupAdd, WinExplorer, ahk_class CabinetWClass
;	tests	GroupAdd, WinExplorer, ahk_class #32770
;			#IfWinActive ahk_group WinExplorer
#IfWinActive, ahk_class CabinetWClass
; Press middle mouse button to move up a folder in Explorer
~MButton::Send !{Up} 
#IfWinActive
return