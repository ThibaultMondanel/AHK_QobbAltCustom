#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

cycleNumber := 1

TextConvertCycle()
{
	If (cycleNumber==1)
	{
	TextConvertUpper()
	cycleNumber:= 2
	}
	Else If (cycleNumber==2)
	{
	TextConvertLower()
	cycleNumber:= 3
	}
	Else
	{
	TextConvertSentence()
	cycleNumber:= 1
	}
	Return
}

TextConvertUpper()
{
	clipSave := Clipboard
	Clipboard = ; Empty the clipboard so that ClipWait has something to detect
	SendInput, ^c ;copies selected text
	ClipWait
	StringReplace, Clipboard, Clipboard, `r`n, `n, All ;Fix for SendInput sending Windows linebreaks 
	StringUpper, Clipboard, Clipboard
	Len:= Strlen(Clipboard)
    SendInput, ^v ;pastes new text
	Send +{left %Len%}
    VarSetCapacity(OutputText, 0) ;free memory
	Clipboard := clipSave
}

TextConvertLower()
{
	clipSave := Clipboard
	Clipboard = ; Empty the clipboard so that ClipWait has something to detect
	SendInput, ^c ;copies selected text
	ClipWait
	StringReplace, Clipboard, Clipboard, `r`n, `n, All ;Fix for SendInput sending Windows linebreaks 
	StringLower, Clipboard, Clipboard
	Len:= Strlen(Clipboard)
    SendInput, ^v ;pastes new text
	Send +{left %Len%}
    VarSetCapacity(OutputText, 0) ;free memory
	Clipboard := clipSave
}
 
TextConvertSentence()
{
	clipSave := Clipboard
	Clipboard = ; Empty the clipboard so that ClipWait has something to detect
	SendInput, ^c ;copies selected text
	ClipWait
	StringReplace, Clipboard, Clipboard, `r`n, `n, All ;Fix for SendInput sending Windows linebreaks 
	StringLower, Clipboard, Clipboard
	Clipboard := RegExReplace(Clipboard, "(((^|([.!?]+\s+))[a-z])| i | i')", "$u1")
	Len:= Strlen(Clipboard)
    SendInput, ^v ;pastes new text
	Send +{left %Len%}
    VarSetCapacity(OutputText, 0) ;free memory
	Clipboard := clipSave
}