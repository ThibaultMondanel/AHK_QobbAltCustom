;   ___             _   _               _    _ _                      
;  | __|  _ _ _  __| |_(_)___ _ _  ___ | |  (_) |__ _ _ __ _ _ _ _  _ 
;  | _| || | ' \/ _|  _| / _ \ ' \(_-< | |__| | '_ \ '_/ _` | '_| || |
;  |_| \_,_|_||_\__|\__|_\___/_||_/__/ |____|_|_.__/_| \__,_|_|  \_, |
;                                                                |__/ 


; All my custom functions


ReloadScript()
{
	SplashTextOn,125,25,,Updating Script...
	Sleep,400
	SplashTextOff
	Reload
	Return
}

RunChrome()
{
	FFY:="Floating for YouTube" . Chr(0x2122) ;
	if WinExist("ahk_class Chrome_WidgetWin_1") ; Except Floating for YouTube™
	{
		WinActivate
		WinGetTitle, Title, A
		IfEqual, Title, %FFY% ; Title == "Floating for YouTube™"
		{
			WinGet, WinClassCount, Count, ahk_class Chrome_WidgetWin_1
			If WinClassCount = 1
				Return
			Else
			{
				WinSet, Bottom,, A
				WinActivate, ahk_class Chrome_WidgetWin_1
				Return ;
			}
		}
		else
		{
			WinActivate
			Return 
		}
	}
	else
	{
		Run, chrome.exe
		WinActivate	;
		TrayTip,,No Chrome instance found
	}
	Return
}

RunP4V()
{
	if WinExist("ahk_exe p4v.exe")
	{
		WinActivate
		Sleep 50
		Send, ^+!d ; Show Dashboard
		Sleep 250
		Send, {F5}
	}
	else
	{
		Run, p4v.exe ;
		Sleep 250
		Send, {Enter} ; Auto-connect if connection ticket still valid
	}
	Return
}

RunUE4Editor()
{
	if WinExist("ahk_exe UE4Editor.exe")
	{
		WinActivate
	}
	else
	{
		Run, C:\Users\tmondanel\Desktop\editor.bat ;
	}
	Return
}

RunOutlook()
{
	if WinExist("ahk_class rctrl_renwnd32")
	{
		WinActivate
	}
	else
	{
		Run, OUTLOOK.EXE ;
	}
	Return
}

RunNotePad()
{
	if WinExist("ahk_class Notepad++")
	{
		WinActivate
	}
	else
	{
		Run, C:\Program Files (x86)\Notepad++\notepad++.exe ;
	}
	Return
}

RunStickyNotes()
{
	if WinExist("ahk_class Sticky_Notes_Note_Window")
	{
		WinActivate
	}
	else
	{
		Run, C:\Windows\system32\StikyNot.exe ;
	}
	Return
}

RunChromeNewTab()
{ 
	WinActivate, chrome.exe
	Run "https://www.google.ca/"
	Sleep 250
	Send, {F6} ; Set cursor in url bar
	Return
}

RunYoutube()
{
	WinActivate, chrome.exe
	Sleep 250
	Run, "https://www.youtube.com/"
	Return
}

GoogleSearch()
{
	Send, {ctrl down}c{ctrl up} ; More secure way to use Copy
	WinActivate, chrome.exe
	Sleep 150
	Run, "http://www.google.com/search?q=%clipboard%"
	Return
}

OpenWinExplorer()
{
	send, {ctrl down}c{ctrl up} 
	Send, #e ;
	Sleep 150
	Send, !d
	Send, %clipboard%
	Send, {Return}
	Return
}

ToggleAlwaysOnTop()
{
	Winset, Alwaysontop, , A ; 
	TrayTip AlwaysOnTop, Toggle, 3, 16 ; Display a TrayTip
	Return
}

TinyUrl()
{
IfWinExist, ahk_class MozillaUIWindowClass	;; modify ahk_class for use with other browsers
	WinActivate

	Send ^l
	Send ^c									;; put URL in clipboard

	Send ^t
	Send http://bit.ly/?url=
	Send ^v
	Send {Enter}

	Sleep %waitTimeLoad%
	Send  ^a

	Sleep %waitTimeKey%
	send ^c

	Sleep %waitTimeKey%						;; change this for your pc
	send ^w

	msgbox %clipboard%`n`nShortened URL Copied to clipboard

	return
}

; -------------------------------
; !`::	; Next window from same software
; WinGetClass, ActiveClass, A
; WinGet, WinClassCount, Count, ahk_class %ActiveClass%
; IF WinClassCount = 1
	; Return
; Else
; WinSet, Bottom,, A
; WinActivate, ahk_class %ActiveClass%
; Return ;

; -------------------------------
; !+`::	; Last window from same software
; WinGetClass, ActiveClass, A
; WinActivateBottom, ahk_class %ActiveClass%
; Return ;