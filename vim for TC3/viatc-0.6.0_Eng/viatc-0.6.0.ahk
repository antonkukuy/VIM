Setkeydelay -1 
SetControlDelay,-1
Detecthiddenwindows,on
Coordmode,Menu,Window
;=======================================================
Init()
Global VIATC_INI: = GetPath_VIATC_INI ()
Global TCEXE := GetPath_TCEXE()
Global TCINI := GetPath_TCINI()
Vim_HotkeyList .= " <> "
ReadConfigToRegHK ()
;Msgbox % Substr(Vim_HotkeyList,RegExMatch(Vim_HotkeyList,"\s<>\s"))
Traytip ,, ViATc finished loading ,, 17
Sleep,1800
Traytip
;RegisterHotkey("zf","<TCFullScreen>","TTOTAL_CMD")
;RegisterHotkey("zl","<TCLite>","TTOTAL_CMD")
;RegisterHotkey("zq","<QuitTC>","TTOTAL_CMD")
;RegisterHotkey("za","<ReloadTC>","TTOTAL_CMD")
; ==========================================
; Esc hotkey must be mapped in the following form
; Ensure Esc functions are not affected hotkeycontrol
; If not mapped, then returned to the normal mode will be disabled
; ==========================================
return
;===================================================
; Read the configuration and register hotkey
ReadConfigToRegHK ()
{
	Config_section := VIATC_IniRead()
	Loop,Parse,Config_section,`n
	{
		; Global is the global domain, registered global hotkey
		If RegExMatch(A_LoopField,"i)^Global$")
		{
			; At Global, Class empty
			CLASS :=
			; Gets Global hotkey list
			KeyList := VIATC_IniRead("Global")
			Loop,Parse,KeyList,`n
			{
				; Being part of the INI hotkey
				Key: = REGEXREPLACE (A_LoopField "= [<\ (\ {\ [] * [\] \.} \)>] $")
				; Get hotkeys corresponding Action
				Action: = substr (A_LoopField, strlen (Key) + 2, strlen (A_LoopField))
				; Registered hotkey
				If RegExMatch(Key,"^\$.*")
				{
					Key := SubStr(Key,2)
					If RegExMatch(Key,"^[^\$].*")
					{
						Key := ResolveHotkey(Key)
						SetHotkey (Key.1, Action, Class)
						Continue
					}
				}
				RegisterHotkey(Key,Action,CLASS)
			}
		}
		; All beginning to AHKC domain used to register the corresponding hotkey CLASS
		If REGEXMATCH (A_LoopField, "^ AHKC_")
		{
			; Get the class
			AHKC: = A_LoopField; get AHKC_XXXXX class, this time LoopField external loop
			; Obtaining the CLASS class from AHKC
			CLASS := SubStr(AHKC,6,Strlen(AHKC))
			; Get AHKC corresponding hotkey list
			KeyList = VIATC_IniRead (AHKC)
			Loop,Parse,KeyList,`n
			{
				; Being part of the INI hotkey
				Key: = REGEXREPLACE (A_LoopField "= [\ [<\ (\ {] * [\] \.} \)>] $")
				; Get hotkeys corresponding Action
				Action: = substr (A_LoopField, strlen (Key) + 2, strlen (A_LoopField))
				; Registered hotkey
				If RegExMatch(Key,"^\$.*")
				{
					Key := SubStr(Key,2)
					If RegExMatch(Key,"^[^\$].*")
					{
						Key := ResolveHotkey(Key)
						SetHotkey (Key.1, Action, Class)
						Continue
					}
				}
				RegisterHotkey(Key,Action,CLASS)
			}
		}
	}
}

; Read ini file, if the entry is read VIATC option is not created when read
VIATC_IniRead(section="",key="")
{
	IniRead,Value,%VIATC_INI%,%section%,%key%
	If RegExMatch(Value,"ERROR")
	{
		Value := Options(key)
		If Not RegExMatch(Value,"^ERROR$")
		{
			IniWrite,%Value%,%VIATC_INI%,%section%,%key%
		}
		Else
			Value := ""
	}
	Return Value
}
; Add INI
VIATC_IniWrite(section,key,value)
{
	IniWrite,%Value%,%VIATC_INI%,%section%,%key%
	Return ErrorLevel
}
; Delete INI
VIATC_IniDelete(section,key)
{
	IniDelete,% VIATC_INI%,% section%,% key%
	Return ErrorLevel
}
; Return options and their default values ​​in the array, the non-option returns ERROR
Options(opt)
{
	If RegExMatch(opt,"^TrayIcon$")
		Return True
	If RegExMatch(opt,"^VimMode$")
		Return True
	If RegExMatch(opt,"^TransParent$")
		Return False
	If RegExMatch(opt,"^Startup$")
		Return False
	If RegExMatch(opt,"^GroupWarn$")
		Return True
	If RegExMatch(opt,"^MaxCount$")
		Return 99
	If RegExMatch(opt,"^Toggle$")
		Return "<lwin>e"
	If RegExMatch(opt,"^TranspVar$")
		Return 220
	If RegExMatch(opt,"^SearchEng$")
		Return "http://www.baidu.com/s?wd={%1}"
	Return "ERROR"
}
; Get VIATC profile path
GetPath_VIATC_INI ()
{
	NeedRegWrite: = False
	Loop; here Loop useless, just used when a certain condition is satisfied, stop looking with
	{
	; Looks in the current directory
		gPath := A_ScriptDir "\viatc.ini"
		If FileExist(gPath)
			Break
	; Find VIATC registry
		RegRead,gPath,HKEY_CURRENT_USER,Software\ViATc,ViATcIni
			If FileExist(gPath) 
				Break
			Else
				NeedRegWrite: = True
	; Look in the TC directory
		TCEXE := GetPath_TCEXE()
		Splitpath,TCEXE,,TCDir
		gPath: = TCDir "\ viatc.ini"
		If FileExist(gPath)
			break
	; Use GUI look
		FileSelectFile, gPath, 3 ,, find TC profile (wincmd.ini), *. Ini
		If ErrorLevel
		{
			Msgbox Find ViATc.ini file failed
			return
		}
	; To save the registry VIATC
		break
	}
	If FileExist(gPath)
	{
		if NeedRegWrite
			Regwrite,REG_SZ,HKEY_CURRENT_USER,Software\VIATC,ViATcINI,%gPath%
		return gPath
	}
}
; Get wincmd.ini profile path
GetPath_TCINI()
{
	NeedRegWrite: = False
	Loop; here Loop useless, just used when a certain condition is satisfied, stop looking with
	{
	; The value of the registry to find the VIATC
		RegRead,gPath,HKEY_CURRENT_USER,Software\ViATc,IniFileName
		If FileExist(gPath) 
			Break
		Else
			NeedRegWrite: = True
	; Looks in the current directory
		gPath := A_ScriptDir "\wincmd.ini"
		If FileExist(gPath)
			Break
		TCEXE := GetPath_TCEXE()
		Splitpath,TCEXE,,TCDir
		gPath: = TCDir "\ wincmd.ini"
		If FileExist(gPath)
			break
	; Use GUI look
		FileSelectFile, gPath, 3 ,, find TC profile (wincmd.ini), *. Ini
		If ErrorLevel
		{
			Msgbox find TC profile fails
			return
		}
		break
	}
	; Save value in the registry to VIATC
	If FileExist(gPath)
	{
		if NeedRegWrite
			Regwrite,REG_SZ,HKEY_CURRENT_USER,Software\VIATC,IniFileName,%gPath%
		return gPath
	}
}
; Get Totalcmd.exe file path
GetPath_TCEXE()
{
	NeedRegWrite: = False; if you need to write registry
	Loop; here Loop useless, just used when a certain condition is satisfied, stop looking with
	{
		; The value of the registry to find the VIATC
		RegRead,gPath,HKEY_CURRENT_USER,Software\ViATc,InstallDir
		If FileExist(gPath) 
			Break
		Else
			NeedRegWrite: = True
		; Use the process to find
		Process,Exist,TOTALCMD.exe
		PID := ErrorLevel
		WinGet,gPath,ProcessPath,AHK_PID %PID%
		If gPath
			Break
		; Looks in the current directory
		gPath := A_ScriptDir "\totalcmd.exe"
		If FileExist(gPath)
			Break
		gPath := A_ScriptDir "\totalcmd64.exe"
		If FileExist(gPath)
			Break
		; Use GUI look
		FileSelectFile, gPath, 3 ,, Find TOTALCMD.exe or TOTALCMD64.exe, *. Exe
		If ErrorLevel
		{
			Msgbox Find Totalcmd.exe fail
			return
		}
		Break
	}
	If FileExist(gPath)
	{
		if NeedRegWrite
			Regwrite,REG_SZ,HKEY_CURRENT_USER,Software\VIATC,InstallDir,%gPath%
		Return gPath
	}
	; Save value in the registry to VIATC
}
EmptyMem ()
{
	return
}
;===================================================
#include vimcore.0.2.1.ahk
;#include Actions\Debug.ahk
#include Actions\General.ahk
#include actions \ TCCOMMAND.ahk
#include actions \ TConly.ahk
Actions include \ MSWord.ahk
#include Actions\temp.ahk
#include Actions\Tools.ahk
#include actions \ TCCOMMAND .ahk
#include actions \ QDir.ahk