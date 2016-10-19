; API can be called at the end of this document
; Here must have a plug-in file with the same name labels, Vimcore loading plug-ins, run it
< Temp > :
	; Generally used to define global variables
	Global Test
	; Add plug-ins corresponding description to help explain the operation in
	CustomActions ( " <TempAction1> " , " Example 1 " )
	; You can also add other pre-operational functions, such as TConly, the file is pre-loaded templates menu
	; Can refer TConly.ahk
return

;% Class% _CheckMode ()
; Vimcore distinguish operating mode, namely when is the normal mode, and when the edit mode
; Can be customized CheckMode () function to achieve
; Vimcore when parsing each hotkey WinGetClass will use to get the current window's class Class
; Then call% Class% _CheckMode (), as in TC calls TTOTAL_CMD_CheckMode ()
; If the function returns true, the equivalent of the edit mode, if the function returns False, the normal mode

; To control the following as an example notepad.exe
Notepad_CheckMode ()
{
	ControlGetFocus , Ctrl , ahk_class NotePad
	If  RegExMatch ( Ctrl , " Edit " )
		Return  True
	return  False
}

; Each plugin can take at least one action, action in the form of the label to describe
; Following <TempAction1> tag in an action is Temp.ahk
< TempAction1 > :
	TempAction1 ()
return
; Recommends calling the function through the label, thus reducing the impact of global variables among different people develop plug-ins
TempAction1 ()
{
	Msgbox % " Hello World "
}
; VimCore the API
; ================================================= ======

; RegisterHotkey (Scope, Key, Action, ViClass)
; Registered hotkey function, defined hotkeys will control mode
; ------------------------------------------------- ------

; Scope with S represents the global scope is available, only available with H Representative category ViClass window
; Key hotkeys, may be single, key combinations, case sensitive
; Speed ​​abc 1, <ctrl> a <alt> b, etc. ...
; Key combination ga oK JK J <ctrl> j <lwin> k, etc ...
; Action action, hotkeys corresponding action, this is generally in the form of: "<TempAcion1>"
; ViClass window class, you can view the corresponding window class by AHK the Windows Spy, if Scope designated as H when registered hotkey will take effect only in ViClass variable corresponding window classes

; ================================================= ======

; SetHotKey (sKey, sAction, Class)
; Set the hotkey, and RegisterHotkey () to distinguish, through this function is not defined hotkey mode affects
; Generally used to set Esc, such as SetHotkey ( "Escape", "<Esc_TC>", "TTOTAL_CMD")

; ------------------------------------------------- ------
; SKey hotkey can only be a single bond, and does not support the <ctrl> <alt> <shift> <win>
; Only AHK support hotkey variants
; SAction action, hotkeys, the corresponding action.
; Class definitions SetHotkey () function corresponding to the window class hotkey in force

; ================================================= ======
