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

;Set SysTray icon
Menu, Tray, Icon, AHK_QobbAltCustom_TrayIcon.ico

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
 
; -------------------------------
; Disable this $@#&!% CapsLock and NumLock
SetCapsLockState, Off
SetCapsLockState, AlwaysOff
SetNumLockState, On
SetNumLockState, AlwaysOn
SetScrollLockState, Off
SetScrollLockState, AlwaysOff

TrayTip AHK_QobbAltCustom, Hello!, 3, 16 ; Display a TrayTip

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
; Run Pandion
Pause::Run C:\Program Files (x86)\Pandion\Application\Pandion.exe ;

; -------------------------------
; Toggle Always On Top
;Pgup::ToggleAlwaysOnTop()

; -------------------------------
g::Send, thibault.stones@gmail.com ;

; -------------------------------
; Cycle TextConvert
;t::TextConvertCycle()

#If
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
;###################################################################
;###################################################################

; -------------------------------
; Run Outlook
ScrollLock::RunOutlook()

; -------------------------------
; Run Pandion
+Pause::Run C:\Program Files (x86)\Pandion\Application\Pandion.exe ;
Pause::WinActivate, ahk_class Pandion Window ;

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
; Use Shift+Num- as underscore
+NumpadSub::Send, _ ; 

; -------------------------------
; Use Shift+NumEnter as =
+NumpadEnter::Send, = ; 

; -------------------------------
; Right hand Alt-Tab
RControl & RShift::AltTab  ; Hold down right-control then press right-shift repeatedly to move forward.
RControl & Enter::ShiftAltTab  ; Without even having to release right-control, press Enter to reverse direction.

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
#IfWinActive

;=======================================
;============== Notepad++ ==============
;=======================================
; Activate the following script only in Notepad++
#IfWinActive, ahk_class Notepad++ ;
; -------------------------------
; Reload this script
+F5::ReloadScript()
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