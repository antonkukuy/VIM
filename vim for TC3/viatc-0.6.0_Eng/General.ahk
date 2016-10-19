; All Programs General 
<General>: 
	CustomActions ( "<1>", "a count 1") 
	CustomActions ( "<2>", "a count 2") 
	CustomActions ( "<3>", "a count 3") 
	CustomActions ( "<4>", "a count 4") 
	CustomActions ( "<5>", "a count 5") 
	CustomActions ( "<6>", "a count 6") 
	CustomActions ( "<7>", "count 7 prefix") 
	CustomActions ( "<8>", "8 count prefix") 
	CustomActions ( "<9>", "a count 9") 
	CustomActions ( "<0>", "count the prefix 0") 
	CustomActions ( "<left>", "move to the left [Count] times") 
	CustomActions ( "<right>", "move right [Count] times") 
	CustomActions ( "<down>", "move down [Count] times ") 
	CustomActions (" <up> "," move up [Count] times ") 
	CustomActions (" <AlwayOnTop> "," settings window overhead ") 
	CustomActions (" <transparent> "," settings window transparent ") 
	CustomActions ( "<repeat>", "repeat the last action") 
	CustomActions ( "<SaveClipBoard>", "save clipboard data") 
	CustomActions ( "<ReturnClipBoard>", "return to the saved data to the clipboard") 
return 
<1>: 
return 
<2>: 
return 
<3>: 
return 
<4>: 
return 
<5>: 
return 
<6>: 
return 
<7>: 
return 
<8>: 
return 
<9>: 
return 
<0>: 
return 
<left>: 
	Send, {left} 
return 
<Right>: 
	Send, {Right} 
return 
<Down>: 
	Send, {Down} 
return 
<Up>: 
	Send, {Up} 
return 
<Insert_Mode>: 
	WinGetClass, Class, A 
		Vim_HotKeyTemp [Class]: = "" 
	Hotkeycontrol (False) 
return 
<Normal_Mode>: 
	Hotkeycontrol (True) 
	WinGetClass, Class, A 
		Vim_HotKeyTemp [Class]: = "" 
	Vim_HotKeyCount: 0 = 
	Tooltip 
	Send, A_Thishotkey% {%} 
return 
; <AlwayOnTop> {{{1 
<AlwayOnTop>: 
		AlwayOnTop () 
Return 
AlwayOnTop () 
{ 
	win: = WinExist (A) 
	WinGet, ExStyle, ExStyle, ahk_id% win% 
	If (ExStyle & 0x8) 
   		WinSet, AlwaysOnTop, off, ahk_id% win% 
	else 
   		WinSet, AlwaysOnTop, on, ahk_id% win% 
} 
; <Transparent> {{{1 
<Transparent>: 
		Transparent () 
Return 
Transparent () 
{ 
	win: = WinExist (A) 
	WinGet, TranspVar, Transparent, ahk_id% win% 
	If Not TranspVar; usually the first to get a null value 
	{ 
		WinSet, Transparent, 220, ahk_id% win% 
		return 
	} 
	If TranspVar <> 255 
	{ 
		WinSet, Transparent, 255, ahk_id% win% 
	} 
	Else 
	{ 
		TranspVar: = 220 
		WinSet, Transparent ,% TranspVar%, ahk_id% win% 
	} 
} 
<SaveClipBoard>: 
	ClipboardSaved: = ClipboardALL 
return 
<ReturnClipBoard>: 
	Sleep, 100 
	Clipboard: = ClipboardSaved 
	ClipboardSaved: = "" 
return 
<Reload>: 
	Reload 
return
