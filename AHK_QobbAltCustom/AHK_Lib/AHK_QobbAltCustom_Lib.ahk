;   ___             _   _               _    _ _                      
;  | __|  _ _ _  __| |_(_)___ _ _  ___ | |  (_) |__ _ _ __ _ _ _ _  _ 
;  | _| || | ' \/ _|  _| / _ \ ' \(_-< | |__| | '_ \ '_/ _` | '_| || |
;  |_| \_,_|_||_\__|\__|_\___/_||_/__/ |____|_|_.__/_| \__,_|_|  \_, |
;                                                                |__/ 
; All my custom functions


ReloadScript()
{
	SplashTextOn,125,25,,Updating Script...
	Send,^s ; Save before reloading
	Sleep,500
	SplashTextOff
	Reload
	Return
}

RunChrome()
{
	FFY:="Floating for YouTube" . Chr(0x2122) ;
	if WinExist("ahk_exe chrome.exe") ; Except Floating for YouTube™
	{
		WinActivate
		Sleep,50
		WinGetTitle, ChromeTitle, A
		IfEqual, ChromeTitle, %FFY% ; ChromeTitle == "Floating for YouTube™"
		{
			While(ChromeTitle == FFY)
			{
				WinGet, WinClassCount, Count, ahk_exe chrome.exe
				If WinClassCount = 1
					Return
				Else 
				{
					WinSet, Bottom,, A
					WinActivate, ahk_exe chrome.exe
					WinGetTitle, ChromeTitle, A
				}
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
		Sleep,50
		WinGetTitle,P4VTitle, A
		IfNotEqual, P4VTitle, Open Connection
		{
			Send, ^+!d ; Show Dashboard
			Sleep 250
			Send, {F5}
		}
		else
			Return
	}
	else
	{
		Run, p4v.exe ;
		Sleep,250
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
		Run, C:\Users\tmondanel\Desktop\DD_Tools\editor.bat ;
	}
	Return
}

RunDeadlineMonitor()
{
	if WinExist("ahk_exe deadlinemonitor.exe")
	{
		WinActivate
	}
	else
	{
		Run, C:\Program Files\Thinkbox\Deadline8\bin\deadlinemonitor.exe
	}
	Return
}

RunOutlook()
{
	if WinExist("Mail - tmondanel@digitaldimension.com")
	{
		WinActivate
	}
	; else
	; {
		MsgBox doesn't exist MF ; Run, OUTLOOK.EXE ;
	; }
	Return
}


RunWinTeams()
{
	if WinExist("ahk_exe Teams.exe")
	{
		WinActivate
	}
	else
	{
		Run, C:\Users\tmondanel\AppData\Local\Microsoft\Teams\current\Teams.exe ;
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
	WinActivate, ahk_exe chrome.exe
	;Sleep,10
	Run "https://www.google.ca/"
	;Send, {ctrl down}t{ctrl up} 
	Sleep,250
	Send,{alt down}d{alt up}   ;{F6} ; Set cursor in url bar
	Return
}

DuplicateChromeTab()
{
	Send, +^{>} ; Need "Duplicate Tab Shortcut Key" Chrome extension and setup hotkey in settings
	Return
}

RunYoutube()
{
	WinActivate, chrome.exe
	Sleep,250
	Run, "https://www.youtube.com/"
	Return
}

GoogleSearch() ; Deprecated
{
	Send, {ctrl down}c{ctrl up} ; More secure way to use Copy
	WinActivate, chrome.exe
	Sleep,150
	Run, "http://www.google.com/search?q=%clipboard%"
	Return
}

OpenGoogleTranslate()
{
	WinActivate, chrome.exe
	Sleep, 200
	Send, +^{<} ; Need "Duplicate Tab Shortcut Key" Chrome extension and setup hotkey in settings
	Sleep, 200
	Send, {ctrl down}v{ctrl up} ;
	Return
}

OpenHighlighted()
{
	MyClipboard := "" ; Clears variable

	Send, {ctrl down}c{ctrl up} ; More secure way to Copy things
	sleep, 50 ; Delay
	MyClipboard := RegexReplace( clipboard, "^\s+|\s+$" ) ; Trim additional spaces and line return
	sleep, 50
	MyStripped := RegexReplace(MyClipboard, " ", "") ; Removes every fcking spaces in the string. There is aleady enough space in the internet.
	
	StringLeft, OutputVarUrl, MyStripped, 8 ; Takes the 8 firsts characters
	StringLeft, OutputVarLocal, MyStripped, 3 ; Takes the 3 first characters
	sleep, 50
	
	if (OutputVarUrl == "http://" || OutputVarUrl == "https://")
	{
		TrayTip,, URL: "%MyClipboard%" ;
		Sleep,50
		Run, "%MyStripped%"
		Return
	}
	else if (OutputVarLocal == "C:/" || OutputVarLocal == "C:\" || OutputVarLocal == "Z:/" || OutputVarLocal == "Z:\" || OutputVarLocal == "R:/" || OutputVarLocal == "R:\" ||)
	{
		TrayTip,, Windows: "%MyClipboard%" ;
		Sleep,50
		Run, %MyClipboard%
		Return
	}
	else
	{
		TrayTip,, GoogleSearch: "%MyClipboard%" ;
		Sleep,50
		Run, "http://www.google.com/search?q=%MyClipboard%"
		Return
	}
	Return
}



; Get highlighted without losing the clipboard
GetHighlighted()
{
	WinActive("A") ; sets last found window
	ControlGetFocus, ctrl
	if (RegExMatch(ctrl, "A)Edit\d+"))
		ControlGet, text, Selected,, %ctrl%
	else {
		clipboardOld := Clipboard
		Send, ^c
		if (Clipboard != clipboardOld) {
			text := Clipboard
			Clipboard := clipboardOld
		}
	}
MsgBox % text
}

OpenWinExplorer()
{
	send, {ctrl down}c{ctrl up} 
	Send, #e ;
	Sleep,150
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


waitTimeLoad = 1500  ;; for slower internet connections, this number needs to be larger (in milliseconds) 700
waitTimeKey = 500   ;; for slower computers, this number needs to be larger (in milliseconds) 200
TinyUrl()
{
  IfWinExist, ahk_class Chrome_WidgetWin_1  ;; modify ahk_class for use with other browsers
  {
    WinActivate
 
    send ^l               ; Select URL to be shortened
    send ^c               ; and copy it.
 
    send ^t               ; Open a new tab,
    send https://goo.gl   ; go to https://goo.gl
    send {enter}          ; ...
    sleep 1500  ; and wait for the site to load.
 
    send {tab}{tab}{tab}{tab}{tab}            ; Put focus on the input box,
    send ^v               ; paste the URL to be shortened
    send {enter}          ; into the Google URL Shortener
    sleep 500   ; and wait.
	
	Send,{tab}{tab}
    Send,{enter}              ; Copy the shortened URL,
    sleep 500   ; wait,
 ;  send ^w               ; and close the page.
  }
return
; IfWinExist, ahk_class MozillaUIWindowClass	;; modify ahk_class for use with other browsers
	; WinActivate

	; Send, ^l
	; Send, ^c									;; put URL in clipboard

	; Send, ^t
	; Send, https://goo.gl/
	; Send ^v
	; Send, {Enter}

	; Sleep, 1700
	; Send, ^a

	; Sleep, 100
	; send, ^c

	; Sleep, 100						;; change this for your pc
; ;	send, ^w

	; msgbox %clipboard%`n`nShortened URL Copied to clipboard

	; return
}

GogleIt()
{}

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