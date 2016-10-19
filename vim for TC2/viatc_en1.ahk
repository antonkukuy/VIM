; ViATc ver.0.5
; linxinhong.sky@gmail.com
; Use "vim+voom" to Write
; 2012-10-12
;============================
#SingleInstance Force 
#Persistent 
#NoEnv 
;#NoTrayIcon 
;============================
Setkeydelay,-1 
SetControlDelay,-1
Detecthiddenwindows,on
Coordmode,Menu,Window
;============================
; Initialization Variables {{{1
; String {{{2
Version := "0050" 
KeyTemp :=
Repeat := 
VimAction :=
; Int {{{2
KeyCount := 0
; Bool {{{2
Vim := true
InsertMode := False
; Arrays {{{2
GroupKey_Arr := object() 
MapKey_Arr := object() 
ExecFile_Arr := object() 
SendText_Arr := object() 
Command_Arr := object()
CmdHistory_Arr := object()
Mark_Arr := object()
HideControl_Arr := object()
;VimAction_Arr := object()
ActionInfo_Arr := object()
HelpInfo_Arr := object()
GroupInfo_Arr := object()
HideControl_Arr["Toggle"] := False
; FilePath {{{2
TcExe := FindPath("exe")
TcIni := FindPath("ini")
Splitpath,TcExe,,TcDir
ViatcIni := TcDir . "\viatc.ini"
; ConfigVar {{{2
GoSub,<ConfigVar>
; Menu Tray {{{1
If A_IsCompiled
	Menu,Tray,NoStandard
Menu,Tray,Add,&Open TC,<ToggleTC>
Menu,Tray,Add,&Disable,<EnableVIM>
Menu,Tray,Add,&Reload,<ReLoadVIATC>
Menu,Tray,Add
Menu,Tray,Add,O&ption,<Setting>
Menu,Tray,Add,&Help,<Help>
Menu,Tray,Add
Menu,Tray,Add,E&xit,<QuitVIATC>
Menu,Tray,Tip,Vim Mode At TotalCommander
Menu,Tray,Default,&Open TC
;Menu,Tray,Icon,%A_WorkingDir%\viatc.ico
If TrayIcon
	Menu,Tray,Icon
SetHelpInfo()
SetGroupInfo()
SetVimAction()
SetActionInfo()
ReadKeyFromIni()
SetDefaultKey()
Return
; Labels {{{1
<ConfigVar>:
Vim := GetConfig("Configuration","Vim")
Toggle := TransHotkey(GetConfig("Configuration","Toggle"),"ALL")
GlobalTogg := GetConfig("Configuration","GlobalTogg")
If GlobalTogg
{
	HotKey,Ifwinactive
	Hotkey,%Toggle%,<ToggleTC>,On,UseErrorLevel
	Toggle := GetConfig("Configuration","Toggle")
}
Else
{
	HotKey,Ifwinactive,AHK_CLASS TTOTAL_CMD
	Hotkey,%Toggle%,<ToggleTC>,On,UseErrorLevel
	Toggle := GetConfig("Configuration","Toggle")
}
Susp := TransHotkey(GetConfig("Configuration","Suspend"),"ALL")
GlobalSusp := GetConfig("Configuration","GlobalSusp")
If GlobalSusp
{
	HotKey,Ifwinactive
	Hotkey,%Susp%,<EnableVim>,On,UseErrorLevel
	Susp := GetConfig("Configuration","Suspend")
}
Else
{
	HotKey,Ifwinactive,AHK_CLASS TTOTAL_CMD
	Hotkey,%Susp%,<EnableVim>,On,UseErrorLevel
	Susp := GetConfig("Configuration","Suspend")
}
TrayIcon := GetConfig("Configuration","TrayIcon")
Service := GetConfig("Configuration","Service")
If Not Service
{
	IfWinExist,AHK_CLASS TTOTAL_CMD
		Winactivate,AHK_CLASS TTOTAL_CMD
	Else
	{
		Run,%TcExe%,,UseErrorLevel
		If ErrorLevel = ERROR
			TcExe := FindPath("exe")
	}
	WinWait,AHK_CLASS TTOTAL_CMD
	Settimer,<CheckTCExist>,100
}
StartUp := GetConfig("Configuration","Startup")
If StartUp
{
	RegRead,IsStartup,HKEY_CURRENT_USER,SOFTWARE\Microsoft\Windows\CurrentVersion\Run,ViATc
	If Not RegExMatch(IsStartup,A_ScriptFullPath)
	{
		RegWrite,REG_SZ,HKEY_CURRENT_USEr,SOFTWARE\Microsoft\Windows\CurrentVersion\Run,ViATc,%A_ScriptFullPath%
		If ErrorLevel
			Msgbox,16,ViATc,Set Logon Startup Failure,3 ;Lang
	}
} 
Else
	Regdelete,HKEY_CURRENT_USER,SOFTWARE\Microsoft\Windows\CurrentVersion\Run,ViATc	
GroupWarn := GetConfig("Configuration","GroupWarn")
GlobalSusp := GetConfig("Configuration","GlobalSusp")
TransParent := GetConfig("Configuration","TransParent")
TranspHelp := GetConfig("Configuration","TranspHelp")
MaxCount := GetConfig("Configuration","MaxCount")
TranspVar := GetConfig("Configuration","TranspVar")
DefaultSE := GetConfig("SearchEngine","Default")
SearchEng := GetConfig("SearchEngine",DefaultSE)
Return
; <32768> {{{2
; 测试32768类是否存在
<32768>:
	Get32768()
RETURN
Get32768()
{
	Global InsertMode
	WinGet,MenuID,ID,AHK_CLASS #32768
	IF MenuID
		InsertMode := True
	ELSE
	{
		InsertMode := False
		SetTimer,<32768>,OFF
	}
}
; <GroupKey> {{{2
<GroupKey>:
	GroupKey(A_ThisHotkey)
Return
; <CheckTCExist> {{{2
<CheckTCExist>:
IfWinNotExist,AHK_CLASS TTOTAL_CMD
	ExitApp
Return
; <RemoveToolTip> {{{2
<RemoveToolTip>:
	SetTimer,<RemoveToolTip>, Off
	ToolTip
return
; <RemoveToolTipEx> {{{2
<RemoveToolTipEx>:
	Ifwinnotactive,AHK_CLASS TTOTAL_CMD
	{
		SetTimer,<RemoveToolTipEx>, Off
		ToolTip
	}
	If A_ThisHotkey = Esc
		Tooltip
return
; <Exec> {{{2
<Exec>:
	If SendAction()
		ExecFile()
return
; <Text> {{{2
<Text>:
	If SendAction()
		SendText()
return
; <None> {{{2
<None>:
	If SendAction()
		Return
return
; <MsgVar> {{{2
<MsgVar>:
	Msgbox % "Text=" SendText_Arr["Hotkeys"] "`n" "Exec=" ExecFile_Arr["HotKeys"] "`n" "MapKeys=" MapKey_Arr["HotKeys"] "`nGroupkey=" GroupKey_Arr["Hotkeys"]
Return
; Actions {{{1
; <Esc> >>Переход в нормальный режим{{{2
<Esc>:
If SendAction()
{
	KeyCount := 0
	KeyCount := 
	InsertMode := False
	Tooltip
	ControlSetText,Edit1,,AHK_CLASS TTOTAL_CMD
	Settimer,<RemoveTooltipEx>,off
	Send,{Esc}
}
Return
; <ToggleTC> >>Открыть / минимизировать / активировать ТC {{{2
<ToggleTC>:
If SendAction()
{
	Ifwinexist,AHK_CLASS TTOTAL_CMD
	{
		WinGet,AC,MinMax,AHK_CLASS TTOTAL_CMD
		If Ac = -1
			Winactivate,AHK_ClASS TTOTAL_CMD
		Else
		Ifwinnotactive,AHK_CLASS TTOTAL_CMD
			Winactivate,AHK_CLASS TTOTAL_CMD
		Else
			Winminimize,AHK_CLASS TTOTAL_CMD
	}
	Else
	{
		Run,%TcExe%,,UseErrorLevel
		If ErrorLevel = ERROR
			TcExe := FindPath("exe")
		WinWait,AHK_CLASS TTOTAL_CMD,,3
		Winactivate,AHK_CLASS TTOTAL_CMD
		;IniRead,Transparent,%ViatcIni%,Configuration,Transparent
		If TransParent
			WinSet,Transparent,220,ahk_class TTOTAL_CMD
		;HideControl_Arr["Toggle"] := 0
	}
}
Return
; <EnableVIM> >>启用/禁用VIM模式 {{{2
<EnableVIM>:
	Suspend
	If Not IsSuspended
	{
		Menu,Tray,Rename,&Disable,&Enable
		TrayTip,,Disable VIM,10,17
		If A_IsCompiled
			Menu,Tray,icon,%A_ScriptFullPath%,5,1
		Else
			Menu,Tray,icon,%A_AHKPath%,5,1
		Settimer,<GetKey>,100
		IsSuspended := 1
	}
	Else
	{
		Menu,Tray,Rename,&Enable,&Disable
		TrayTip,,Enable VIM,10,17
		If A_IsCompiled
			Menu,Tray,icon,%A_ScriptFullPath%,1,1
		Else
			Menu,Tray,icon,%A_AHKPath%,1,1
		Settimer,<GetKey>,off
		IsSuspended := 0
		Suspend,off
	}
Return
<GetKey>:
	IfWinActive AHK_CLASS TTOTAL_CMD
		Suspend,on
	Else
		Suspend,off
Return
; <ReLoadVIATC> >>重启VIATC {{{2
<ReLoadVIATC>:
If SendAction()
	ReloadVIATC()
Return
ReloadVIATC()
{
	Global ToggleMenu
	ToggleMenu(1)
	If HideControl_arr["Toggle"]
 		HideControl()
	Reload
}
; <Enter> >>回车 {{{2
<Enter>:
	Enter()
Return
; <Setting> >>配置界面 {{{2
<Setting>:
If SendAction()
	Setting()
Return
; <Help> >>帮助界面 {{{2
<Help>:
If SendAction()
	Help()
Return
; <QuitViatc> >>重启VIATC{{{2
; 帮助界面
<QuitViatc>:
If SendAction()
	ExitApp
Return
; <Num*> >>数字 {{{2
; <Num0> >>数字0 {{{3
<Num0>:
	SendNum("0")
Return
; <Num1> >>数字1 {{{3
<Num1>:
	SendNum("1")
Return
; <Num2> >>数字2 {{{3
<Num2>:
	SendNum("2")
Return
; <Num3> >>数字3 {{{3
<Num3>:
	SendNum("3")
Return
; <Num4> >>数字4 {{{3
<Num4>:
	SendNum("4")
Return
; <Num5> >>数字5 {{{3
<Num5>:
	SendNum("5")
Return
; <Numr> >>数字6 {{{3
<Num6>:
	SendNum("6")
Return
; <Num7> >>数字7 {{{3
<Num7>:
	SendNum("7")
Return
; <Num8> >>数字8 {{{3
<Num8>:
	SendNum("8")
Return
; <Num9> >>数字9 {{{3
<Num9>:
	SendNum("9")
Return
; <Down> >>下方向 {{{2
<Down>:
	SendKey("{down}")
Return
; <up> >>上方向 {{{2
<Up>:
	SendKey("{up}")
Return
; <Left> >>左方向 {{{2
<Left>:
	SendKey("{Left}")
Return
; <Right> >>右方向 {{{2
<Right>:
	SendKey("{Right}")
Return
; <ForceDel> >> 强制删除 {{{2
<ForceDel>:
	SendKey("+{Delete}")
Return
; <UpSelect> >>向上选择{{{2
<UpSelect>:
	SendKey("+{Up}")
Return
; <DownSelect> >>向下选择 {{{2
<DownSelect>:
	SendKey("+{down}")
Return
; <PageUp> >>向下翻页 {{{2
<PageUp>:
	SendKey("{PgUp}")
Return
; <PageDown> >>向下翻页 {{{2
<PageDown>:
	SendKey("{PgDn}")
Return
; <Home> >>转到第一行，相当于HOME{{{2
<Home>:
	If SendAction()
		GG()
Return
GG()
{
	ControlGetFocus,ctrl,AHK_CLASS TTOTAL_CMD
	;ControlGet,text,List,,%ctrl%,AHK_CLASS TTOTAL_CMD
	;Stringsplit,T,Text,`n
	PostMessage, 0x185, 1, 0, %CTRL%, AHK_CLASS TTOTAL_CMD
}
; <End> >>转到最后一行，相当于End{{{2
<End>:
	If SendAction()
		G()
Return
G()
{
	ControlGetFocus,ctrl,AHK_CLASS TTOTAL_CMD
	ControlGet,text,List,,%ctrl%,AHK_CLASS TTOTAL_CMD
	Stringsplit,T,Text,`n
	Last := T0 - 1
	PostMessage, 0x185, 1, %Last% , %CTRL%, AHK_CLASS TTOTAL_CMD
}
; <Mark> >>标记功能{{{2
<Mark>:
	If SendPos(4003)
	{
		ControlSetText,Edit1,m,AHK_CLASS TTOTAL_CMD
		ControlSend,Edit1,{Right},AHK_CLASS TTOTAL_CMD
		SetTimer,<MarkTimer>,100
	}
Return
<MarkTimer>:
	MarkTimer()
Return
MarkTimer()
{
	Global Mark_Arr
	ControlGetFocus,ThisControl,AHK_CLASS TTOTAL_CMD
	ControlGetText,OutVar,Edit1,AHK_CLASS TTOTAL_CMD
	If Not RegExMatch(ThisControl,"i)^Edit1$") OR Not RegExMatch(Outvar,"i)^m.?")
	{
		Msgbox % ThisControl OutVar
		Settimer,<MarkTimer>,Off
		Return
	}
	If RegExMatch(OutVar,"i)^m.$")
	{
		SetTimer,<MarkTimer>,off
		ControlSetText,Edit1,,AHK_CLASS TTOTAL_CMD
		ControlSend,Edit1,{Esc},AHK_CLASS TTOTAL_CMD
		ClipSaved := ClipboardAll
		Clipboard :=
		Postmessage 1075, 2029, 0, , ahk_class TTOTAL_CMD
		ClipWait
		Path := Clipboard
		Clipboard := ClipSaved
		M := SubStr(OutVar,2,1)
		mPath := "&" . m . ">>" . Path
		If RegExMatch(Mark_Arr["ms"],m)
		{
			DelM := Mark_Arr[m]
			Menu,MarkMenu,Delete,%DelM%
			Menu,MarkMenu,Add,%mPath%,<AddMark>
			Mark_Arr["ms"] := Mark_Arr["ms"] . m
			Mark_Arr[m] := mPath
		}
		Else
		{
			Menu,MarkMenu,Add,%mPath%,<AddMark>
			Mark_Arr["ms"] := Mark_Arr["ms"] . m
			Mark_Arr[m] := mPath
		}
	}
}
<AddMark>:
	AddMark()
Return
AddMark()
{
	ThisMenuItem := SubStr(A_ThisMenuItem,5,StrLen(A_ThisMenuItem))
	If RegExMatch(ThisMenuItem,"i)\\\\桌面$")
	{
		Postmessage 1075, 2121, 0, , ahk_class TTOTAL_CMD
		Return
	}
	If RegExMatch(ThisMenuItem,"i)\\\\计算机$")
	{
		Postmessage 1075, 2122, 0, , ahk_class TTOTAL_CMD
		Return
	}
	If RegExMatch(ThisMenuItem,"i)\\\\所有控制面板项$")
	{
		Postmessage 1075, 2123, 0, , ahk_class TTOTAL_CMD
		Return
	}
	If RegExMatch(ThisMenuItem,"i)\\\\Fonts$")
	{
		Postmessage 1075, 2124, 0, , ahk_class TTOTAL_CMD
		Return
	}
	If RegExMatch(ThisMenuItem,"i)\\\\网络$")
	{
		Postmessage 1075, 2125, 0, , ahk_class TTOTAL_CMD
		Return
	}
	If RegExMatch(ThisMenuItem,"i)\\\\打印机$")
	{
		Postmessage 1075, 2126, 0, , ahk_class TTOTAL_CMD
		Return
	}
	If RegExMatch(ThisMenuItem,"i)\\\\回收站$")
	{
		Postmessage 1075, 2127, 0, , ahk_class TTOTAL_CMD
		Return
	}
	ControlSetText, Edit1, cd %ThisMenuItem%, ahk_class TTOTAL_CMD
	ControlSend, Edit1, {Enter}, ahk_class TTOTAL_CMD
	Return
}
; <ListMark> >>显示标记 {{{2
<ListMark>:
	If SendAction()
		ListMark()
Return
ListMark()
{
	Global Mark_Arr
	If Not Mark_Arr["ms"]
		Return
	ControlGetFocus,TLB,ahk_class TTOTAL_CMD
	ControlGetPos,xn,yn,,,%TLB%,ahk_class TTOTAL_CMD
	Menu,MarkMenu,Show,%xn%,%yn%
}
; <azHistory> >>在文件夹历史加上前缀，方便用a-z导航 {{{2
<azHistory>:
	If SendPos(572)
		azhistory()
Return
azhistory()
{
	;Postmessage,1075,%Num%,0,,ahk_class TTOTAL_CMD
	Sleep, 100
	if WinExist("ahk_class #32768")
	{
	SendMessage,0x01E1
    hmenu := ErrorLevel
    if hmenu!=0
    {
		If Not RegExMatch(GetMenuString(Hmenu,1),".*[\\|/]$")
			Return
		Menu,sh,add
		Menu,sh,deleteall
		a :=
        itemCount := DllCall("GetMenuItemCount", "Uint", hMenu, "Uint")
		Loop %itemCount%
	 	{
			a := chr(A_Index+64) . ">>" .  GetMenuString(Hmenu,A_Index-1)
			Menu,SH,add,%a%,azSelect
		}
		Send {Esc}
		ControlGetFocus,TLB,ahk_class TTOTAL_CMD
		ControlGetPos,xn,yn,,,%TLB%,ahk_class TTOTAL_CMD
		Menu,SH,show,%xn%,%yn%
		Return
    }
	}	
}
GetMenuString(hMenu, nPos)
{
      VarSetCapacity(lpString, 256) 
      length := DllCall("GetMenuString"
         , "UInt", hMenu
         , "UInt", nPos
         , "Str", lpString
         , "Int", 255
         , "UInt", 0x0400)
   	  return lpString
}
azSelect:
	azSelect()
Return
azSelect()
{
	nPos := A_ThisMenuItem
	nPos := Asc(Substr(nPos,1,1)) - 64
	Winactivate,ahk_class TTOTAL_CMD
	Postmessage,1075,572,0,,ahk_class TTOTAL_CMD
	Sleep,100
	if WinExist("ahk_class #32768")
	{
		Loop %nPos%
			SendInput {Down}
		Send {enter}
	}
}
; <azCmdHistory> >>查看命令历史记录 {{{2
<azCmdHistory>:
	If SendAction()
		ListCmdHistory()
Return
ListCmdHistory()
{
	Global TcIni
	Menu,cmdMenu,Add
	Menu,cmdMenu,DeleteAll
	VarSetCapacity(var,256)
	;Menu,cmdMenu,Add,命令行历史,en
	;Index := CmdHistory[0]
	Loop ;,%Index%
	{
		Index := A_Index - 1
		IniRead,CMD,%TcIni%,Command line history,%Index%
		If CMD = ERROR
			Break
		var := chr(A_Index+64) . ">>" . CMD ;CmdHistory[A_Index]
		Menu,CmdMenu,add,%var%,GetCmd
	}
	ControlGetPos,xn,yn,,hn,Edit1,AHK_CLASS TTOTAL_CMD
	yn := yn - 30 - ( (Index - 1) * 22 )
	Menu,CmdMenu,Show,%xn%,%yn%
}
GetCMD:
	GetCMD()
Return
GetCMD()
{
	var := Substr(A_ThisMenuItem,4,StrLen(A_ThisMenuItem))
	ControlSetText,Edit1,%var%,AHK_CLASS TTOTAL_CMD
	ControlFocus,Edit1,AHK_CLASS TTOTAL_CMD
	ControlSend,Edit1,{End},AHK_CLASS TTOTAL_CMD
}
; <Internetsearch> >>使用网络搜索引擎搜索当前文件 {{{2
<Internetsearch>:
	If SendAction()
		Internetsearch()
Return
Internetsearch()
{
	Global SearchEng
	If CheckMode()
	{
		ClipSaved := ClipboardAll ;保存原来剪切板里的内容UserInput
    	Clipboard = ;初始化剪切板
		PostMessage 1075, 2017, 0, , ahk_class TTOTAL_CMD
 		ClipWait
		rFileName := clipboard
    	clipboard := ClipSaved
		StringRight,lastchar,rFileName,1
		If(lastchar = "\" )
		Stringleft,rFileName,rFileName,Strlen(rFileName)-1
		;rFileName := rFileName
		rFileName := RegExReplace(SearchEng,"{%1}",rFileName)
		Run %rFileName%
	}
	Return
}
; <GoDesktop> >>切换到桌面{{{2
<GoDesktop>:
	If SendAction()
	{
		ControlSetText,Edit1,CD %A_Desktop%,AHK_CLASS TTOTAL_CMD
		ControlSend,Edit1,{Enter},AHK_CLASS TTOTAL_CMD
	}
Return
; <SingleRepeat> >>重复 {{{2
<SingleRepeat>:
	If SendPos(-1)
		SingleRepeat()
Return
; <TCLite> >>TC最简 {{{2
<TCLite>:
	If SendAction()
	{
		ToggleMenu()
 		HideControl()
		;ControlSend,{Esc},,AHK_CLASS TTOTAL_CMD
		Send,{Esc}
	}
Return
; <TCFullScreen> >>TC全屏 {{{2
<TCFullScreen>:
	If SendAction()
	{
		ToggleMenu()
 		HideControl()
		If HideControl_arr["Max"]
		{
			PostMessage 1075, 2016, 0, , ahk_class TTOTAL_CMD
			HideControl_arr["Max"] := 0
			Return
		}
		WinGet,AC,MinMax,AHK_CLASS TTOTAL_CMD
		If AC = 1
		{
			PostMessage 1075, 2016, 0, , ahk_class TTOTAL_CMD
			PostMessage 1075, 2015, 0, , ahk_class TTOTAL_CMD
			HideControl_arr["Max"] := 0
		}
		If AC = 0
		{
			PostMessage 1075, 2015, 0, , ahk_class TTOTAL_CMD
			HideControl_arr["Max"] := 1
		}
			
	}
Return
; <CreateNewFile> >>文件模板 {{{2
<CreateNewFile>:
	If SendAction()
		CreateNewFile()
Return
; <Editviatcini> >>直接编辑配置文件 {{{2
<Editviatcini>:
	If SendAction()
		Editviatcini()
Return
; <GoLastTab> >>切换到最后一个标签{{{2
<GOLastTab>:
	if SendAction()
	{
		PostMessage 1075, 5001, 0, , ahk_class TTOTAL_CMD
		PostMessage 1075, 3006, 0, , ahk_class TTOTAL_CMD
	}
Return
; <DeleteLHistory> >>删除左侧文件夹历史 {{{2
<DeleteLHistory>:
	If SendAction()
		DeleteHistory(1)
Return
; <DeleteRHistory> >>删除右侧文件夹历史 {{{2
<DeleteRHistory>:
	If SendAction()
		DeleteHistory(0)
Return
DeleteHistory(A)
{
	Global TCEXE,TCINI
	If A
	{
		H := "LeftHistory"
		DelMsg := "Delete left directroy history ?" ;Lang
	}
	Else
	{
		H := "RightHistory"
		DelMsg := "Delete right directroy history ?" ;Lang
	}
	Msgbox,4,ViATC,%DelMsg%
	Ifmsgbox YES
	{
		Winkill,AHK_CLASS TTOTAL_CMD
		n := 0
    	Loop 
    	{
    		IniRead,TempField,%TCINI%,%H%,%n%
    		If TempField = ERROR
       			Break
    		IniDelete,%TCINI%,%H%,%n%
    		n++
    	}	
		Run,%TCEXE%,,UseErrorLevel
		If ErrorLevel = ERROR
			TCEXE := findpath(1)
		WinWait,AHK_CLASS TTOTAL_CMD,3
		Winactivate,AHK_CLASS TTOTAL_CMD	
	}
	Else
		Winactivate,AHK_CLASS TTOTAL_CMD	
}
; <DelCmdHistory> >>删除命令行历史  {{{2
<DelCmdHistory>:
	If SendAction()
		DeleteCmd()
Return
DeleteCMD()
{
	Global TCEXE,TCINI,CmdHistory
	CmdHistory := Object()
	Msgbox,4,ViATc,Delete command history ?;Lang
	Ifmsgbox YES
	{
		Winkill ahk_class TTOTAL_CMD
		n := 0 
    	TempField := 
    	Loop 
    	{
    		IniRead,TempField,%TCINI%,Command line history,%n%
    		If TempField = ERROR
       			Break
    		IniDelete,%TCINI%,Command line history,%n%
    		n++
    	}	
		Run,%TCEXE%,,UseErrorLevel
		If ErrorLevel = ERROR
			TCEXE := findpath(1)
		WinWait,AHK_CLASS TTOTAL_CMD,3
		Winactivate,AHK_CLASS TTOTAL_CMD	
	}
	Else
		Winactivate ahk_class TTOTAL_CMD
}
; <ListMapKey> {{{2
<ListMapKey>:
	If SendAction()
		ListMapKey()
Return
ListMapKey()
{
	Global MapKey_Arr,ActionInfo_Arr,ExecFile_Arr,SendText_Arr
	Map := MapKey_Arr["Hotkeys"]
	Stringsplit,ListMap,Map,%A_Space% 
	Loop,% ListMap0
	{
		If ListMap%A_Index%
		{
			Action := MapKey_Arr[ListMap%A_Index%]
			If Action = <Exec>
			{
				EX := SubStr(ListMap%A_Index%,1,1) . TransHotkey(SubStr(ListMap%A_Index%,2))
				Action := "(" . ExecFile_Arr[EX] . ")"
			}
			If Action = <Text>
			{
				TX := SubStr(ListMap%A_Index%,1,1) . TransHotkey(SubStr(ListMap%A_Index%,2))
				Action := "{" . SendText_Arr[TX] . "}"
			}
			LM .= SubStr(ListMap%A_Index%,1,1) . "  " . SubStr(ListMap%A_Index%,2) . "  " . Action  . "`n"
		}
	}
	ControlGetPos,xn,yn,,hn,Edit1,AHK_CLASS TTOTAL_CMD
	yn := yn - hn - ( ListMap0 * 8 ) 
	Tooltip,%LM%,%xn%,%yn%
	Settimer,<RemoveToolTipEx>,100
}
; <FocusCmdLineEx> {{{2
<FocusCmdLineEx>:
	If SendPos(4003)
	{
		ControlSetText,Edit1,:,AHK_CLASS TTOTAL_CMD
		Send,{end}
	}
Return
; <WinMaxLeft> >>最大化左面板 {{{2
<WinMaxLeft>:
	If SendAction()
		WinMaxLeft()
Return
WinMaxLeft()
{
	ControlGetPos,x,y,w,h,TMyPanel8,ahk_class TTOTAL_CMD
	ControlGetPos,tm1x,tm1y,tm1W,tm1H,TPanel1,ahk_class TTOTAL_CMD
	If (tm1w < tm1h) ; 判断纵向还是横向 Ture为竖 false为横
		ControlMove,TPanel1,tm1x+w,,,,ahk_class TTOTAL_CMD
	else
		ControlMove,TPanel1,0,y+tm1H,,,ahk_class TTOTAL_CMD
	ControlClick, TPanel1,ahk_class TTOTAL_CMD 
	WinActivate ahk_class TTOTAL_CMD
}
; <WinMaxRight> >>最大化右面板 {{{2
<WinMaxRight>:
	If SendAction()
	{
		ControlMove,TPanel1,0,0,,,ahk_class TTOTAL_CMD
		ControlClick,TPanel1,ahk_class TTOTAL_CMD
		WinActivate ahk_class TTOTAL_CMD
	}
Return
; <AlwayOnTop> >>窗口最前 {{{2
<AlwayOnTop>:
	If SendAction()
		AlwayOnTop()
Return
AlwayOnTop()
{
	WinGet,ExStyle,ExStyle,ahk_class TTOTAL_CMD
	If (ExStyle & 0x8)
   		WinSet,AlwaysOnTop,off,ahk_class TTOTAL_CMD
	else
   		WinSet,AlwaysOnTop,on,ahk_class TTOTAL_CMD 
}
; <TransParent> >>TC透明 {{{2
<TransParent>:
	If SendAction()
		TransParent()
Return
TransParent()
{
	Global VIATCINI,Transparent,TranspVar
	IniRead,Transparent,%VIATCINI%,Configuration,Transparent
	If Transparent
	{
		WinSet,Transparent,255,ahk_class TTOTAL_CMD
		IniWrite,0,%VIATCINI%,Configuration,Transparent
		Transparent := 0
	}
	Else
	{
		WinSet,Transparent,%TranspVar%,ahk_class TTOTAL_CMD
		IniWrite,1,%VIATCINI%,Configuration,Transparent
		Transparent := 1
	}
}
;============================== 
; Functions {{{1
; SetDefaultKey() {{{2
; 设置VIATC的默认键
SetDefaultKey()
{
	Hotkey,Ifwinactive
	Hotkey,F7,<TestTH>
	Hotkey,F3,<MsgVar>
	Hotkey,Ifwinactive,AHK_Class TTOTAL_CMD
	HotKey,1,<Num1>,on,UseErrorLevel
	HotKey,2,<Num2>,on,UseErrorLevel
	HotKey,3,<Num3>,on,UseErrorLevel
	HotKey,4,<Num4>,on,UseErrorLevel
	HotKey,5,<Num5>,on,UseErrorLevel
	HotKey,6,<Num6>,on,UseErrorLevel
	HotKey,7,<Num7>,on,UseErrorLevel
	HotKey,8,<Num8>,on,UseErrorLevel
	HotKey,9,<Num9>,on,UseErrorLevel
	HotKey,0,<Num0>,on,UseErrorLevel
	HotKey,j,<Down>,on,UseErrorLevel
	HotKey,k,<up>,on,UseErrorLevel
	HotKey,h,<left>,on,UseErrorLevel
	HotKey,l,<right>,on,UseErrorLevel
	HotKey,+k,<UpSelect>,on,UseErrorLevel
	HotKey,+j,<DownSelect>,on,UseErrorLevel
	HotKey,+h,<GotoPreviousDir>,on,UseErrorLevel
	HotKey,+l,<GotoNextDir>,on,UseErrorLevel
	HotKey,d,<DirectoryHotlist>,on,UseErrorLevel
	HotKey,+d,<GoDesktop>,on,UseErrorLevel
	Hotkey,.,<SingleRepeat>,On,UseErrorLevel
	HotKey,e,<ContextMenu>,on,UseErrorLevel
	HotKey,+e,<ExecuteDOS>,on,UseErrorLevel
	HotKey,u,<GotoParent>,on,UseErrorLevel
	HotKey,+u,<GotoRoot>,on,UseErrorLevel
	Hotkey,i,<CreateNewFile>,on,UseErrorLevel
	Hotkey,x,<Delete>,On,UseErrorLevel
	Hotkey,+x,<ForceDel>,On,UseErrorLevel
	HotKey,o,<LeftOpenDrives>,on,UseErrorLevel
	HotKey,+o,<RightOpenDrive>,on,UseErrorLevel
	HotKey,q,<SrcQuickview>,on,UseErrorLevel
	HotKey,p,<PackFiles>,on,UseErrorLevel
	HotKey,+p,<UnpackFiles>,on,UseErrorLevel
	HotKey,t,<OpenNewTab>,on,UseErrorLevel
	HotKey,+t,<OpenNewTabBg>,on,UseErrorLevel
	Hotkey,r,<RenameSingleFile>,on,UseErrorLevel
	Hotkey,+r,<MultiRenameFiles>,on,UseErrorLevel
	Hotkey,f,<PageDown>,On,UseErrorLevel
	Hotkey,b,<PageUp>,On,UseErrorLevel
	Hotkey,y,<CopyNamesToClip>,On,UseErrorLevel
	Hotkey,+y,<CopyFullNamesToClip>,On,UseErrorLevel
	Hotkey,/,<ShowQuickSearch>,On,UseErrorLevel
	Hotkey,+/,<SearchFor>,On,UseErrorLevel
	Hotkey,`;,<FocusCmdLine>,On,UseErrorLevel
	Hotkey,:,<FocusCmdLineEx>,On,UseErrorLevel
	Hotkey,[,<SelectCurrentName>,On,UseErrorLevel
	Hotkey,+[,<UnselectCurrentName>,On,UseErrorLevel
	Hotkey,],<SelectCurrentExtension>,On,UseErrorLevel
	Hotkey,+],<UnselectCurrentExtension>,On,UseErrorLevel
	Hotkey,\,<ExchangeSelection>,On,UseErrorLevel
	Hotkey,+\,<ClearAll>,On,UseErrorLevel
	Hotkey,=,<MatchSrc>,On,UseErrorLevel
	Hotkey,-,<SwitchSeparateTree>,On,UseErrorLevelHotkey,\,<ExchangeSelection>,On,UseErrorLevel
	Hotkey,v,<SrcCustomViewMenu>,On,UseErrorLevel
	HotKey,a,<SetAttrib>,on,UseErrorLevel
	Hotkey,m,<Mark>,On,UseErrorLevel
	Hotkey,',<ListMark>,On,UseErrorLevel
	HotKey,+q,<Internetsearch>,on,UseErrorLevel
	Hotkey,+g,<End>,On,UseErrorLevel
	Hotkey,w,<EditComment>,On,UseErrorLevel
	Hotkey,n,<azhistory>,On,UseErrorLevel
	Hotkey,`,,<azCmdHistory>,On,UseErrorLevel
	Hotkey,Enter,<Enter>,On,UseErrorLevel
	Hotkey,Esc,<Esc>,On,UseErrorLevel
	Hotkey,<,<None>,On,UseErrorLevel
	Hotkey,>,<None>,On,UseErrorLevel
	Hotkey,+w,<None>,On,UseErrorLevel
/*
*/
	;Groupkey 定义
	; 实用工具热键
	GroupKeyAdd("zz","<50Percent>")
	GroupKeyAdd("zx","<100Percent>")
	GroupKeyAdd("zi","<WinMaxLeft>")
	GroupKeyAdd("zo","<WinMaxRight>")
	GroupKeyAdd("zt","<AlwayOnTop>")
	GroupKeyAdd("zn","<Minimize>")
	GroupKeyAdd("zm","<Maximize>")
	GroupKeyAdd("zr","<Restore>")
	GroupKeyAdd("zv","<VerticalPanels>")
	GroupKeyAdd("zs","<TransParent>")
	GroupKeyAdd("zf","<TCFullScreen>")
	GroupKeyAdd("zl","<TCLite>")
	GroupKeyAdd("zq","<QuitTC>")
	GroupKeyAdd("za","<ReLoadTC>")
	; 排序热键
	GroupKeyAdd("sn","<SrcByName>")
	GroupKeyAdd("se","<SrcByExt>")
	GroupKeyAdd("ss","<SrcBySize>")
	GroupKeyAdd("st","<SrcByDateTime>")
	GroupKeyAdd("sr","<SrcNegOrder>")
	GroupKeyAdd("s1","<SrcSortByCol1>")
	GroupKeyAdd("s2","<SrcSortByCol2>")
	GroupKeyAdd("s3","<SrcSortByCol3>")
	GroupKeyAdd("s4","<SrcSortByCol4>")
	GroupKeyAdd("s5","<SrcSortByCol5>")
	GroupKeyAdd("s6","<SrcSortByCol6>")
	GroupKeyAdd("s7","<SrcSortByCol7>")
	GroupKeyAdd("s8","<SrcSortByCol8>")
	GroupKeyAdd("s9","<SrcSortByCol9>")
	; 标签热键
	GroupKeyAdd("gn","<SwitchToNextTab>")
	GroupKeyAdd("gp","<SwitchToPreviousTab>")
	GroupKeyAdd("ga","<CloseAllTabs>")
	GroupKeyAdd("gc","<CloseCurrentTab>")
	GroupKeyAdd("gt","<OpenDirInNewTab>")
	GroupKeyAdd("gb","<OpenDirInNewTabOther>")
	GroupKeyAdd("ge","<Exchange>")
	GroupKeyAdd("gw","<ExchangeWithTabs>")
	GroupKeyAdd("g1","<SrcActivateTab1>")
	GroupKeyAdd("g2","<SrcActivateTab2>")
	GroupKeyAdd("g3","<SrcActivateTab3>")
	GroupKeyAdd("g4","<SrcActivateTab4>")
	GroupKeyAdd("g5","<SrcActivateTab5>")
	GroupKeyAdd("g6","<SrcActivateTab6>")
	GroupKeyAdd("g7","<SrcActivateTab7>")
	GroupKeyAdd("g8","<SrcActivateTab8>")
	GroupKeyAdd("g9","<SrcActivateTab9>")
	GroupKeyAdd("g0","<GoLastTab>")
	GroupKeyAdd("gg","<Home>")
	; 设置热键
	GroupKeyAdd("<Shift>vb","<VisButtonbar>")
	GroupKeyAdd("<Shift>vd","<VisDriveButtons>")
	GroupKeyAdd("<Shift>vo","<VisTwoDriveButtons>")
	GroupKeyAdd("<Shift>vr","<VisDriveCombo>")
	GroupKeyAdd("<Shift>vc","<VisCurDir>")
	GroupKeyAdd("<Shift>vt","<VisTabHeader>")
	GroupKeyAdd("<Shift>vs","<VisStatusbar>")
	GroupKeyAdd("<Shift>vn","<VisCmdLine>")
	GroupKeyAdd("<Shift>vf","<VisKeyButtons>")
	GroupKeyAdd("<Shift>vw","<VisDirTabs>")
	GroupKeyAdd("<Shift>ve","<CommandBrowser>")
	; 清除热键
	GroupKeyAdd("cl","<DeleteLHistory>")
	GroupKeyAdd("cr","<DeleteRHistory>")
	GroupKeyAdd("cc","<DelCmdHistory>")
}
; SendKey(HotKey) {{{2
; 发送普通热键  
SendKey(HotKey)
{
	Global KeyCount,KeyTemp,Repeat,MaxCount
	If CheckMode()
	{
		If KeyTemp
		{
			GroupKey(A_ThisHotkey)
			Return 
		}
		If KeyCount
		{
			ControlSetText,Edit1,,AHK_CLASS TTOTAL_CMD
			If KeyCount > %MaxCount%
				keyCount := MaxCount
			Repeat := KeyCount . ">>" . hotkey
			Loop,%KeyCount%
				Send %hotkey%
			KeyCount := 0
		}
		Else
			Send %hotkey%
	}
	Else
	{
		hotkey := TransSendKey(A_ThisHotkey)
		Send %hotkey%
	}
}
; SendNum(HotKey) {{{2
; 发送数字热键  
SendNum(HotKey)
{
	Global KeyCount,KeyTemp
	If CheckMode()
	{
		If KeyTemp
		{
			GroupKey(A_ThisHotkey)
			Return 
		}
		If KeyCount
			KeyCount := Hotkey + (KeyCount * 10 ) 
		Else
			KeyCount := HotKey + 0
		ControlSetText,Edit1,%KeyCount%,AHK_CLASS TTOTAL_CMD
	}
	Else
	{
		hotkey := TransSendKey(A_ThisHotkey)
		Send %hotkey%
	}
		;Send %A_Thishotkey%
}
; SendPos(Num) {{{2
; 执行PostMessage
SendPos(Num)
{
	Global KeyCount,KeyTemp,Repeat
	KeyCount := 0
	If CheckMode()
	{
		If KeyTemp
		{
			GroupKey(A_ThisHotkey)
			Return False
		}
		ControlSetText,Edit1,,AHK_CLASS TTOTAL_CMD
		If Num < 0
			Return True
		If Num
		{
			Repeat := Num
			PostMessage 1075, %Num%, 0, , AHK_CLASS TTOTAL_CMD	
		}
		Repeat := A_ThisLabel
		Return True
	}
	Else
	{
		;Send %A_ThisHotkey%
		hotkey := TransSendKey(A_ThisHotkey)
		Send %hotkey%
		Return False
	}
}
SendAction()
{
	Global KeyTemp,KeyCount,Repeat
	KeyCount := 0
	If CheckMode()
	{
		If KeyTemp
		{
			GroupKey(A_ThisHotkey)
			Return False
		}
		ControlSetText,Edit1,,AHK_CLASS TTOTAL_CMD
		Repeat := A_ThisLabel
		Return True
	}
	Else
	{
		Hotkey := TransSendKey(A_ThisHotkey)
		Send %Hotkey%
		Return False
	}
}
; ExecFile() {{{2
ExecFile()
{
	Global ExecFile_Arr,KeyTemp,GoExec,Repeat
	IfWinActive,AHK_CLASS TTOTAL_CMD
	{
		Key := "H" . A_ThisHotkey
		If Not ExecFile_Arr[Key]
			Key := "S" . A_ThisHotkey
	}
	Else
		Key := "S" . A_ThisHotkey
	If GoExec
		File := ExecFile_Arr[GoExec]
	Else
		File := ExecFile_Arr[Key]
	If FileExist(File)
	{
		Run,%File%,,UseErrorLevel,ExecID
		If ErrorLevel = ERROR
			Return
		WinWait,AHK_PID %ExecID%,,3
		WinActivate,AHK_PID %ExecID%
	}
	Else
		Msgbox % File " Not Exist !"
	Repeat := "(" . File . ")"
	GoExec := 
}
; SendText() {{{2
SendText()
{
	Global SendText_Arr,KeyTemp,Repeat,GoText
	IfWinActive,AHK_CLASS TTOTAL_CMD
	{
		Key := "H" . A_ThisHotkey
		If Not SendText_Arr[Key]
			Key := "S" . A_ThisHotkey
	}
	Else
		Key := "S" . A_ThisHotkey
	If GoExec
		Text := SendText_Arr[GoText]
	Else
		Text := SendText_Arr[Key]
	Send,%Text%
	Repeat := "{" . Text . "}"
	GoText :=
}
; GroupKey(Hotkey) {{{2
Groupkey(Hotkey)
{
	Global GroupKey_Arr,KeyTemp,KeyCount,GroupInfo_arr,GroupWarn,Repeat,SendText_Arr,ExecFile_Arr,GoExec,GoText
	If GroupWarn And ( Not KeyTemp ) And CheckMode() And GroupInfo_Arr[A_ThisHotkey]
	{
		Msg := GroupInfo_arr[A_ThisHotkey]
		StringSplit,Len,Msg,`n
		ControlGetPos,xn,yn,,hn,Edit1,AHK_CLASS TTOTAL_CMD
		yn := yn - hn - ( Len0 * 17 )
		Tooltip,%Msg%,%xn%,%yn% ;Lang
		SetTimer,<RemoveTooltipEx>,50
	}
	If checkMode()
	{
		KeyCount := 0
		KeyTemp .= A_ThisHotkey
		AllGK := Groupkey_Arr["Hotkeys"]
		MatchString := "[^&]\s" . RegExReplace(KeyTemp,"\+|\?|\.|\*|\{|\}|\(|\)|\||\^|\$|\[|\]|\\","\$0")
		If RegExMatch(AllGK,MatchString)
		{
			MatchString .= "\s" 
			If RegExMatch(AllGk,MatchString)
			{
				Settimer,<RemoveToolTipEx>,off
				Tooltip
				ControlSetText,Edit1,,AHK_CLASS TTOTAL_CMD
				Action := GroupKey_Arr[KeyTemp]
				If RegExMatch(Action,"<Text>")
					GoText := "G" . KeyTemp
				If RegExMatch(Action,"<Exec>")
					GoExec := "G" . KeyTemp
				KeyTemp := 
				If IsLabel(Action)
				{
					GoSub,%Action%
					Repeat := Action
				}
				Else
					Msgbox % KeyTemp "Action " Action " Error"
			}
			Else
				ControlSetText,Edit1,%KeyTemp%,AHK_CLASS TTOTAL_CMD
		}
		Else
		{
			ControlSetText,Edit1,,AHK_CLASS TTOTAL_CMD
			KeyTemp := 
			Tooltip
		}
	}
	Else
	{
		Key := TransSendKey(A_ThisHotkey)
		Send,%key%
	}
}
; GroupKeyAdd(Key,Action,IsGlobal=False) {{{2
; 传放参数无需转换
GroupKeyAdd(Key,Action,IsGlobal=False)
{
	Global GroupKey_Arr
	Key_T := TransHotkey(key,"ALL")
	GroupKey_Arr["Hotkeys"] .= A_Space . A_Space . Key_T . A_Space . A_Space
	GroupKey_Arr[Key_T] := Action
	Key_T := TransHotkey(key,"First")
	If IsGlobal
		Hotkey,Ifwinactive
	Else
		Hotkey,Ifwinactive,AHK_CLASS TTOTAL_CMD
	Hotkey,%Key_T%,<GroupKey>,On,UseErrorLevel
}
; GroupkeyDelete(Key) {{{2
GroupkeyDelete(Key,IsGlobal=False)
{
	Global GroupKey_Arr
	Key_T := "\s" . TransHotkey(Key,"ALL") . "\s"
	GroupKey_Arr["Hotkeys"] := RegExReplace(Groupkey_Arr["Hotkeys"],Key_T)
	Key_T := "\s" . TransHotkey(Key,"First")
	If RegExMatch(GroupKey_Arr["Hotkeys"],Key_T)
		Return
	If IsGlobal
		Hotkey,Ifwinactive
	Else
		Hotkey,Ifwinactive,AHK_CLASS TTOTAL_CMD
	Key_T := TransHotkey(Key,"First")
	Hotkey,%Key_T%,Off
}
; SingleRepeat() {{{2
SingleRepeat()
{
	Global Repeat
	If RegExMatch(Repeat,">>")
	{
		KeyCount := SubStr(Repeat,1,(RegExMatch(Repeat,">>") - 1))
		SendKey(SubStr(Repeat,(RegExMatch(Repeat,">>")+2,StrLen(Repeat))))
		Return
	}
	If RegExMatch(Repeat,"^<.*>$")
	{
		If IsLabel(Repeat) AND Not RegExMatch(Repeat,"i)<SingleRepeat>")
		GoSub,%Repeat%
		Return
	}
	If RegExMatch(Repeat,"[0-9]*")
		Postmessage 1075, %Repeat%, 0, , ahk_class TTOTAL_CMD
	If RegExMatch(Repeat,"^\(.*\)$")
	{
		File := SubStr(Repeat,2,StrLen(File)-1)
		If FileExist(File)
		{
			Run,%File%,,UseErrorLevel,ExecID
			WinWait,AHK_PID %ExecID%,,3
			WinActivate,AHK_PID %ExecID%
		}
	}
	If RegExMatch(Repeat,"^\{.*\}$")
	{
		Text := SubStr(Repeat,2,StrLen(Text)-1)
		Send,%Text%
	}
}
; CheckMode() {{{2
CheckMode() 
{
	IfWinNotActive,AHK_CLASS TTOTAL_CMD
		Return True
	WinGet,MenuID,ID,AHK_CLASS #32768
	IF MenuID
		Return False
	ControlGetFocus,ListBox,ahk_class TTOTAL_CMD
   	Ifinstring,ListBox,TMyListBox
		Return true
	Else
		Return False
}
; 测试TransHotkey(hotkey,"ALl")的功能

; TransHotkey(Hotkey) {{{2
; 将<>风格的热键替换为ahk能认识的热键 
TransHotkey(Hotkey,pos="ALL") ;默认all,则返回所有键
{
	If Pos = ALL
	{
		Loop
		{
			If RegExMatch(Hotkey,"^<[^<>]+><[^<>]+>.*$")
			{
				Hotkey1 := SubStr(Hotkey,2,RegExMatch(Hotkey,"><.*")-2)
				If RegExMatch(Hotkey1,"i)(l|r)?(ctrl|control|shift|win|alt)")
				{
					HK := SubStr(Hotkey,RegExMatch(Hotkey,"><.*")+2,Strlen(Hotkey)-RegExMatch(Hotkey,"><.*")-1)
					Hotkey2 := SubStr(HK,1,RegExMatch(HK,">")-1)
					Hotkey3 := SubStr(HK,RegExMatch(HK,">")+1)
					NewHotkey := Hotkey1 . " & " . Hotkey2 . Hotkey3
				}
				Else
					NewHotkey := Hotkey1  . HK := SubStr(Hotkey,RegExMatch(Hotkey,"><.*")+1,Strlen(Hotkey)-RegExMatch(Hotkey,"><.*"))
				Break
			}
			If RegExMatch(Hotkey,"^<[^<>]+>.+$")
			{
				Hotkey1 := SubStr(Hotkey,2,RegExMatch(Hotkey,">.+")-2)
				If RegExMatch(Hotkey1,"i)(l|r)?(ctrl|control|shift|win|alt)")
				{
					Hotkey2 := SubStr(Hotkey,RegExMatch(Hotkey,">.+")+1)
					NewHotkey := Hotkey1 . " & " . Hotkey2
				}
				Else
				{
					Hotkey2 := SubStr(Hotkey,RegExMatch(Hotkey,">.+")+1)
					NewHotkey := Hotkey1 . Hotkey2
				}
				Break
			}
			If RegExMatch(Hotkey,"^<[^<>]+>$")
			{
				NewHotkey := SubStr(Hotkey,2,Strlen(Hotkey)-2)
				Break
			}
			NewHotkey := Hotkey	
			Break
		}
	}
	Else
	{
		Loop
		{
			If RegExMatch(Hotkey,"^<[^<>]+><[^<>]+>.*")
			{
				Hotkey1 := SubStr(Hotkey,2,RegExMatch(Hotkey,"><")-2)
				If RegExMatch(Hotkey1,"i)(l|r)?(ctrl|control|shift|win|alt)")
				{
					HK := SubStr(Hotkey,RegExMatch(Hotkey,"><")+2,Strlen(Hotkey)-RegExMatch(Hotkey,"><")-1)
					Hotkey2 := SubStr(HK,1,RegExMatch(HK,">")-1)
					NewHotkey := Hotkey1 . " & " . Hotkey2
				}
				Else
					NewHotkey := Hotkey1
				Break
			}
			If RegExMatch(Hotkey,"^<[^<>]+>.+")
			{
				Hotkey1 := SubStr(Hotkey,2,RegExMatch(Hotkey,">")-2)
				If RegExMatch(Hotkey1,"i)(l|r)?(ctrl|control|shift|win|alt)")
				{
					NewHotkey := Hotkey1 . " & " . SubStr(Hotkey,RegExMatch(Hotkey,">")+1,1)
				}
				Else
					NewHotkey := Hotkey1
				Break
			}
			If RegExMatch(Hotkey,"i)^<(l|r)?(ctrl|control|shift|win|alt)>$")
			{
				NewHotkey := SubStr(Hotkey,2,Strlen(Hotkey)-2)
				Break
			}
			If RegExMatch(Hotkey,"^<[^<>]+>$")
			{
				NewHotkey := SubStr(Hotkey,2,Strlen(Hotkey)-2)
				Break
			}
			If RegExMatch(Hotkey,"^.*")
				NewHotkey := Substr(hotkey,1,1)
			Break
		}
	}
	Return NewHotkey 
}
/*
TransHotkey1(Hotkey,pos="ALL") ;默认只返回第一个键，如果all为1则返回所有键
{
	If pos = ALL
	{
		If RegExMatch(hotkey,"^<[^<>]+>.*")
		{
			tag := 0
			NewHotkey :=
			If RegExMatch(hotkey,"^<[^<>]+>$") ;只有一个键的话，不用用&连接多个键
				Add := ""
			Else
				Add := " & " ;add要等于&,才能转换成 ctrl & a 型的键，让ahk能够识别
			If RegExMatch(hotkey,"^<.+><.+>$")
			{
				d1 := 1
			}
			If RegExMatch(hotkey,"^<.*><.*>.+")
			{
				d2 := 1
			}
			Loop,parse,hotkey
			{
				If ( A_LoopField == "<" ) 
				{
					tag := 1
					Continue
				}
				If ( A_LoopField == ">" ) AND ( Tag == 1 )
				{
					tag := 0
					NewHotkey := NewHotkey . add
					if d2
						add := 
					Continue
				}
				NewHotkey .= A_LoopField
			}
			If d1
				NewHotkey := Substr(NewHotkey,1,Strlen(NewHotkey)-3)
			Return NewHotkey
		}
		Else
			Return hotkey
	}
	If ( StrLen(Hotkey) > 2 ) AND ( SubStr(hotkey,1,1)  == "<" )
	{
		tag := 0
		NewHotkey :=
		If RegExMatch(hotkey,"^<[^<>]*>$")
			Add := ""
		Else
			Add := " & "
		If RegExMatch(hotkey,"^<.*><.*>$")
		{
			Hotkey := RegExReplace(hotkey,"><"," & ")
			Return SubStr(hotkey,2,strlen(hotkey)-2)
		}
		If RegExMatch(hotkey,"^<.*><.*>.*")
		{
			Hotkey := Substr(hotkey,1,RegExMatch(hotkey,">+[^<]"))
			hotkey := RegExReplace(hotkey,"><"," & ")
			Return SubStr(hotkey,2,strlen(hotkey)-2)
		}
		Loop,parse,hotkey
		{
			If ( A_LoopField == "<" ) 
			{
				tag := 1
				Continue
			}
			If ( A_LoopField == ">" ) AND ( Tag == 1 )
			{
				tag := 0
				NewHotkey := NewHotkey . add
				Continue
			}
			NewHotkey .= A_LoopField
			If !Tag AND A_LoopField != "<"
				Break
		}
		Return NewHotkey
	}
	Else
		Return SubStr(Hotkey,1,1)
}
*/
; TransSendKey(hotkey) {{{2
TransSendKey(hotkey)
{
	Loop
	{
		If RegExMatch(Hotkey,"i)^Esc$")
		{
			Hotkey := "{Esc}"
			Break
		}
		If StrLen(hotkey) > 1 AND Not RegExMatch(Hotkey,"^\+.$")
		{
			Hotkey := "{" . hotkey . "}"
			If RegExMatch(hotkey,"i)(shift|lshift|rshift)(\s\&\s)?.+$")
				Hotkey := "+" . RegExReplace(hotkey,"i)(shift|lshift|rshift)(\s\&\s)?")
			If RegExMatch(hotkey,"i)(ctrl|lctrl|rctrl|control|lcontrol|rcontrol)(\s\&\s)?.+$")
				Hotkey := "^" . RegExReplace(hotkey,"i)(ctrl|lctrl|rctrl|control|lcontrol|rcontrol)(\s\&\s)?")
			If RegExMatch(hotkey,"i)(lwin|rwin)(\s\&\s)?.+$")
				Hotkey := "#" . RegExReplace(hotkey,"i)(lwin|rwin)(\s\&\s)?")
			If RegExMatch(hotkey,"i)(alt|lalt|ralt)(\s\&\s)?.+$")
				Hotkey := "!" . RegExReplace(hotkey,"i)(alt|lalt|ralt)(\s\&\s)?")
		}
		If RegExMatch(Hotkey,"^\+.$")
		{
			Hotkey := SubStr(Hotkey,1,1) . "{" . SubStr(Hotkey,2) . "}"
		}
		GetKeyState,Var,CapsLock,T
		If Var = D
		{
			If RegExMatch(Hotkey,"^\+\{[a-z]\}$")
			{
				Hotkey := SubStr(Hotkey,2)
				Break
			}
			If RegExMatch(Hotkey,"^[a-z]$")	
			{
				Hotkey := "+{" . Hotkey . "}"
				Break
			}
			If RegExMatch(Hotkey,"^\{[a-z]\}$")
			{
				Hotkey := "+" . Hotkey 
				Break
			}
		}
		;Else
		;{
		;}
		Break
	}
	Return hotkey
}
; FindPath(File) {{{2
; 寻找TC执行文件和配置文件的路径 
FindPath(File){
	If RegExMatch(File,"exe")
	{
		GetPath := A_WorkingDir . "\totalcmd.exe"
		Reg := "InstallDir"
		FileSF_Option := 3
		FileSF_FileName:= "Select TOTALCMD.EXE" ;Lang
		FileSF_Prompt := "TOTALCMD.EXE"
		FileSF_Filter := "TOTALCMD.EXE"
		FileSF_Error := "Find TOTALCMD.EXE Failure"
	}
	If RegExMatch(File,"ini")
	{
		GetPath := A_workingDir . "\wincmd.ini"
		Reg := "IniFileName"
		FileSF_Option := 3
		FileSF_FileName:= 
		FileSF_Prompt := "Select Wincmd.ini"
		FileSF_Filter := "*.INI"
		FileSF_Error := "Find Wincmd.ini Failure"
	}
	If Not FileExist(GetPath)
		RegRead,GetPath,HKEY_CURRENT_USER,Software\VIATC,%Reg%
	FilegetAttrib,Attrib,%GetPath%
	IfNotInString, Attrib, D
	{
		Regwrite,REG_SZ,HKEY_CURRENT_USER,Software\VIATC,%GetPath%,%Reg%
		Return GetPath
	}
	FileSelectFile,GetPath,%FileSF_Option%,%FileSF_FileName%,%FileSF_Prompt%,%FileSF_Filter%
	If ErrorLevel
	{
		Msgbox %FileSF_Error%
		Return 
	}
	Else
		Return GetPath
}
; ReadKeyFromIni() {{{2
ReadKeyFromIni()
{
	Global ViatcIni,ExecFile_Arr,SendText_Arr,MapKey_Arr,MapKey_Arr
	Loop,Read,%ViatcIni%
	{
		If RegExMatch(SubStr(RegExReplace(A_LoopReadLine,"\s"),1,1),";")
			Continue
		If RegExMatch(A_LoopReadLine,"i)\[.*\]")
			IsReadKey := False
		If RegExMatch(A_LoopReadLine,"i)\[Hotkey\]")
		{
			IsReadKey := True
			IsHotkey := True
			IsGlobalHotkey := False
			IsGroupkey := False
			Continue
		}
		If RegExMatch(A_LoopReadLine,"i)\[GlobalHotkey\]")
		{
			IsReadKey := True
			IsGlobalHotkey := True
			IsHotkey := False
			IsGroupkey := False
			Continue
		}
		If RegExMatch(A_LoopReadLine,"i)\[GroupKey\]")
		{
			IsReadKey := True
			IsGroupkey := True
			IsHotkey := False
			IsGlobalHotkey := False
			Continue
		}
		If IsReadkey
		{
			StringPos := RegExMatch(A_LoopReadLine,"=[<|\(|\{].*[>|\)\}]$",Action)
			If StringPos
			{
				Key := SubStr(A_LoopReadLine,1,StringPos-1)
				Action := SubStr(Action,2)
			}
			If IsGlobalHotkey
				MapKeyAdd(Key,Action,"S")
			If IsHotkey
				MapKeyAdd(Key,Action,"H")
			If IsGroupkey
				MapKeyAdd(Key,Action,"G")
		}
	}
}
; MapKeyAdd(Key,Action,Scope) {{{2
MapKeyAdd(Key,Action,Scope)
{
	Global MapKey_Arr,ExecFile_Arr,SendText_Arr
	If Not RegExMatch(Key,"[^<[^<>]+>$|^<[^<>]+><[^<>]+>$|^<[^<>]+>.$|^.$]")
		Scope := "G"
	If Not RegExMatch(Action,"^[<|\(|\{].*[>|\)\}]$")
		Return False
	If Not IsLabel(Action) AND RegExMatch(Action,"^<.*>$")
		return False
	If RegExMatch(Action,"^\(.*\)$")
	{
		Key_T := Scope . TransHotkey(Key)
		ExecFile_Arr["HotKeys"] .= A_Space . Key_T . A_Space
		ExecFile_Arr[Key_T] := Substr(Action,2,Strlen(Action)-2)
		Action := "<Exec>"
	}
	If RegExMatch(Action,"^\{.*\}$")
	{
		Key_T := Scope . TransHotkey(Key)
		SendText_Arr["HotKeys"] .= A_Space . Key_T . A_Space
		SendText_Arr[Key_T] := Substr(Action,2,Strlen(Action)-2)
		Action := "<Text>"
	}
	If Scope = S
	{
		HotKey,IfWinActive
		Key_T := TransHotkey(Key,"First")
		Hotkey,%Key_T%,%Action%,On,UseErrorLevel
	}
	If Scope = H
	{
		Hotkey,IfWinActive,AHK_CLASS TTOTAL_CMD
		Key_T := TransHotkey(Key,"First")
		Hotkey,%Key_T%,%Action%,On,UseErrorLevel
	}
	If Scope = G
		GroupKeyAdd(Key,Action)
	Key_T := "i)\s" . Scope . RegExReplace(Key,"\+|\?|\.|\*|\{|\}|\(|\)|\||\^|\$|\[|\]|\\","\$0") . "\s"
	If RegExMatch(MapKey_Arr["Hotkeys"],Key_T)
		Return true
	Else
	{
		Key := Scope . Key
		MapKey_Arr["Hotkeys"] .= A_space . Key . A_Space
	}
	MapKey_Arr[Key] := Action
	Return true
}
; MapKeyDelete(Key,Scope) {{{2
MapKeyDelete(Key,Scope)
{
	Global MapKey_Arr
	If Scope = S
	{
		Key_T := TransHotkey(Key)
		Hotkey,IfWinActive
		Hotkey,%Key_T%,Off
	}
	If Scope = H
	{
		Key_T := TransHotkey(Key)
		Hotkey,IfWinActive,AHK_CLASS TTOTAL_CMD
		Hotkey,%Key_T%,Off
	}
	If Scope = G
		GroupkeyDelete(Key)
	
	DelKey := "\s" . Scope . RegExReplace(Key,"\+|\?|\.|\*|\{|\}|\(|\)|\||\^|\$|\[|\]|\\","\$0") . "\s"
	Mapkey_Arr["Hotkeys"] := RegExReplace(MapKey_Arr["Hotkeys"],DelKey)
}
; GetConfig(Section,Key) {{{2
; 读取配置文件
GetConfig(Section,Key)
{
	Global ViatcIni
	IniRead,Getvar,%ViatcIni%,%Section%,%Key%
	If RegExMatch(Getvar,"^ERROR$")
		GetVar := CreateConfig(Section,key)
	Return GetVar
}
; CreateConfig(Section,Key) {{{2
; 创建配置文件
CreateConfig(Section,Key)
{
	Global ViatcIni
	If Section = Configuration
		If Key = TrayIcon
			SetVar := 1
		If Key = Vim
			SetVar := 1
		If Key = Toggle
			SetVar := "<lwin>w"
		If Key = GlobalTogg
			SetVar := 1
		If Key = Suspend
			SetVar := "<alt>``"
		If Key = GlobalSusp
			SetVar := 0
		If Key = Startup
			SetVar := 0
		If Key = Service
			SetVar := 1
		If Key = GroupWarn
			SetVar := 1
		If Key = TranspHelp
			SetVar := 0
		If Key = TransParent
			SetVar := 0
		If Key = TranspVar
			SetVar := 220
		If Key = MaxCount
			SetVar := 99
	If Section = SearchEngine
		If Key = Default
			SetVar := 1
		If Key = 1
			SetVar := "http://www.google.com.hk/search?q={%1}"
		If Key = 2
			SetVar := "http://www.baidu.com/s?wd={%1}"
	IniRead,GetVar,%ViatcIni%,%Section%,%Key%
	If Getvar = ERROR
		Iniwrite,%SetVar%,%ViatcIni%,%Section%,%Key%
	Return SetVar
}
; ToggleMenu(a=0) {{{2
ToggleMenu(a=0)
{
	Global TCMenuHandle
	WinGet,hwin,Id,AHK_CLASS TTOTAL_CMD
	If hwin
    	MenuHandle := DllCall("GetMenu", "uint", hWin)
	If MenuHandle
	{
        DllCall("SetMenu", "uint", hWin, "uint", 0)
		TCmenuHandle := MenuHandle
	}
	Else
		DllCall("SetMenu", "uint", hWin, "uint", TCmenuHandle )
	if a
	{
		WinSet,Style,+0xC10000,AHK_CLASS TTOTAL_CMD
		DllCall("SetMenu", "uint", hWin, "uint", TCmenuHandle )
	}
}
; HideControl() {{{2
HideControl()
{
	Global HideControl_arr,TcIni,TCmenuHandle
	if HideControl_arr["Toggle"]
	{
	    HideControl_arr["Toggle"] := False
		if HideControl_arr["KeyButtons"] 
			PostMessage 1075, 2911 , 0, , AHK_CLASS TTOTAL_CMD
		if HideControl_arr["drivebar1"] 
			PostMessage 1075, 2902 , 0, , AHK_CLASS TTOTAL_CMD
 		if HideControl_arr["DriveBar2"] 
			PostMessage 1075,  2903, 0, , AHK_CLASS TTOTAL_CMD
 		if HideControl_arr["DriveBarFlat"] 
			PostMessage 1075,  2904, 0, , AHK_CLASS TTOTAL_CMD
		if HideControl_arr["InterfaceFlat"] 
			PostMessage 1075,  2905, 0, , AHK_CLASS TTOTAL_CMD
		if HideControl_arr["DriveCombo"] 
			PostMessage 1075, 2906 , 0, , AHK_CLASS TTOTAL_CMD
		if HideControl_arr["DirectoryTabs"] 
			PostMessage 1075,  2916, 0, , AHK_CLASS TTOTAL_CMD
		if HideControl_arr["XPthemeBg"] 
			PostMessage 1075, 2923 , 0, , AHK_CLASS TTOTAL_CMD
		if HideControl_arr["CurDir"] 
			PostMessage 1075, 2907 , 0, , AHK_CLASS TTOTAL_CMD
		if HideControl_arr["TabHeader"] 
			PostMessage 1075, 2908 , 0, , AHK_CLASS TTOTAL_CMD
		if HideControl_arr["StatusBar"] 
			PostMessage 1075,  2909, 0, , AHK_CLASS TTOTAL_CMD
		if HideControl_arr["CmdLine"] 
			PostMessage 1075, 2910 , 0, , AHK_CLASS TTOTAL_CMD
		if HideControl_arr["HistoryHotlistButtons"] 
			PostMessage 1075, 2919 , 0, , AHK_CLASS TTOTAL_CMD
		if HideControl_arr["BreadCrumbBar"] 
			PostMessage 1075,  2926, 0, , AHK_CLASS TTOTAL_CMD
		if HideControl_arr["ButtonBar"] 
			PostMessage 1075,2901  , 0, , AHK_CLASS TTOTAL_CMD
		WinSet,Style,+0xC10000,AHK_CLASS TTOTAL_CMD
		winActivate,AHK_CLASS TTOTAL_CMD
		Settimer,FS,off
		WinGet,hwin,Id,AHK_CLASS TTOTAL_CMD
		If hwin
			DllCall("SetMenu", "uint", hWin, "uint", TCmenuHandle )
	}
	Else
	{
		HideControl_arr["Toggle"] := True
		IniRead,v_KeyButtons,%TCINI%,LayOut,KeyButtons
		HideControl_arr["KeyButtons"] := v_KeyButtons
		If v_KeyButtons
			PostMessage 1075, 2911 , 0, , AHK_CLASS TTOTAL_CMD
		IniRead,v_drivebar1,%TcIni%,layout,drivebar1
		HideControl_arr["drivebar1"] := v_drivebar1
		If v_DriveBar1
			PostMessage 1075, 2902 , 0, , AHK_CLASS TTOTAL_CMD
		IniRead,v_DriveBar2,%TcIni%,Layout,DriveBar2
 		HideControl_arr["DriveBar2"] := v_DriveBar2
		If v_DriveBar2
			PostMessage 1075,  2903, 0, , AHK_CLASS TTOTAL_CMD
		IniRead,v_DriveBarFlat,%TcIni%,Layout,DriveBarFlat
 		HideControl_arr["DriveBarFlat"] := v_DriveBarFlat
		If v_DriveBarFlat
			PostMessage 1075,  2904, 0, , AHK_CLASS TTOTAL_CMD
		IniRead,v_InterfaceFlat,%TcIni%,Layout,InterfaceFlat
		HideControl_arr["InterfaceFlat"] := v_InterfaceFlat
		If v_InterfaceFlat
			PostMessage 1075,  2905, 0, , AHK_CLASS TTOTAL_CMD
		IniRead,v_DriveCombo,%TcIni%,Layout,DriveCombo
		HideControl_arr["DriveCombo"] := v_DriveCombo
		If v_DriveCombo
			PostMessage 1075, 2906 , 0, , AHK_CLASS TTOTAL_CMD
		IniRead,v_DirectoryTabs,%TcIni%,Layout,DirectoryTabs
		HideControl_arr["DirectoryTabs"] := v_DirectoryTabs
		If v_DirectoryTabs
			PostMessage 1075,  2916, 0, , AHK_CLASS TTOTAL_CMD
		IniRead,v_XPthemeBg,%TcIni%,Layout,XPthemeBg
		HideControl_arr["XPthemeBg"] := v_XPthemeBg
		If v_XPthemeBg
			PostMessage 1075, 2923 , 0, , AHK_CLASS TTOTAL_CMD
		IniRead,v_CurDir,%TcIni%,Layout,CurDir
		HideControl_arr["CurDir"] := v_CurDir
		If v_CurDir
			PostMessage 1075, 2907 , 0, , AHK_CLASS TTOTAL_CMD
		IniRead,v_TabHeader,%TcIni%,Layout,TabHeader
		HideControl_arr["TabHeader"] := v_TabHeader
		If v_TabHeader
			PostMessage 1075, 2908 , 0, , AHK_CLASS TTOTAL_CMD
		IniRead,v_StatusBar,%TcIni%,Layout,StatusBar
		HideControl_arr["StatusBar"] := v_StatusBar
		If v_StatusBar
			PostMessage 1075,  2909, 0, , AHK_CLASS TTOTAL_CMD
		IniRead,v_CmdLine,%TcIni%,Layout,CmdLine
		HideControl_arr["CmdLine"] := v_CmdLine
		If v_CmdLine
			PostMessage 1075, 2910 , 0, , AHK_CLASS TTOTAL_CMD
		IniRead,v_HistoryHotlistButtons,%TcIni%,Layout,HistoryHotlistButtons
		HideControl_arr["HistoryHotlistButtons"] := v_HistoryHotlistButtons
		If v_HistoryHotlistButtons
			PostMessage 1075, 2919 , 0, , AHK_CLASS TTOTAL_CMD
		IniRead,v_BreadCrumbBar,%TcIni%,Layout,BreadCrumbBar
		HideControl_arr["BreadCrumbBar"] := v_BreadCrumbBar
		If v_BreadCrumbBar
			PostMessage 1075,  2926, 0, , AHK_CLASS TTOTAL_CMD
		IniRead,v_ButtonBar	,%TcIni%,Layout,ButtonBar	
		HideControl_arr["ButtonBar"] := v_ButtonBar
		If v_ButtonBar	
			PostMessage 1075,2901  , 0, , AHK_CLASS TTOTAL_CMD
		WinSet,Style,-0xC00000,AHK_CLASS TTOTAL_CMD
		;WinSet,Style,+0x10000L,AHK_CLASS TTOTAL_CMD
		winActivate,AHK_CLASS TTOTAL_CMD
		;Settimer,FS,300
	}
}
FS:
	FS()
Return
FS()
{
	WinGet,hwin,Id,AHK_CLASS TTOTAL_CMD
	If hwin
    	MenuHandle := DllCall("GetMenu", "uint", hWin)
	Else
		Settimer,FS,off
	If MenuHandle
        DllCall("SetMenu", "uint", hWin, "uint", 0)
}
; Enter() {{{2
Enter()
{
	Global MapKey_Arr,ActionInfo_Arr,ExecFile_Arr,SendText_Arr
	ControlGetFocus,ThisControl,AHK_CLASS TTOTAL_CMD
	If RegExMatch(ThisControl,"^Edit1$")
	{
		ControlGetText,CMD,Edit1,AHK_CLASS TTOTAL_CMD
		If RegExMatch(CMD,"^:.*")
		{
			ControlGetPos,xn,yn,,hn,Edit1,AHK_CLASS TTOTAL_CMD
			ControlSetText,Edit1,,AHK_CLASS TTOTAL_CMD
			CMD := SubStr(CMD,2)
			If RegExMatch(CMD,"i)^se?t?t?i?n?g?\s*$")
			{
				Setting()
				Return
			}
			If RegExMatch(CMD,"i)^he?l?p?\s*")
			{
				Help()
				Return
			}
			If RegExMatch(CMD,"i)^re?l?o?a?d?\s*$")
			{
				ReloadVIATC()
				Return
			}
			If RegExMatch(CMD,"i)^ma?p?\s*$")
			{
				Map := MapKey_Arr["Hotkeys"]
				Stringsplit,ListMap,Map,%A_Space% 
				Loop,% ListMap0
				{
					If ListMap%A_Index%
					{
						Action := MapKey_Arr[ListMap%A_Index%]
						If Action = <Exec>
						{
							EX := SubStr(ListMap%A_Index%,1,1) . TransHotkey(SubStr(ListMap%A_Index%,2))
							Action := "(" . ExecFile_Arr[EX] . ")"
						}
						If Action = <Text>
						{
							TX := SubStr(ListMap%A_Index%,1,1) . TransHotkey(SubStr(ListMap%A_Index%,2))
							Action := "{" . SendText_Arr[TX] . "}"
						}
						LM .= SubStr(ListMap%A_Index%,1,1) . "  " . SubStr(ListMap%A_Index%,2) . "  " . Action  . "`n"
					}
				}
				yn := yn - hn - ( ListMap0 * 8 ) - 2
				Tooltip,%LM%,%xn%,%yn%
				Settimer,<RemoveToolTipEx>,100
				Return
			}
			If RegExMatch(CMD,"i)^ma?p?\s*[^\s]*")
			{
				CMD1 := RegExReplace(CMD,"i)^ma?p?\s*")
				Key := SubStr(CMD1,1,RegExMatch(CMD1,"\s")-1)
				Action := SubStr(CMD1,RegExMatch(CMD1,"\s[^\s]")+1)
				yn := yn -  hn - 9
				If Not RegExMatch(Key,"[^<[^<>]+>$|^<[^<>]+><[^<>]+>$|^<[^<>]+>.$|^.$]")
					If Not MapKeyAdd(Key,Action,"G")
						Tooltip,Map Success`,Action"%Action%"Failure,%xn%,%yn%
					Else
						Tooltip,Map Failure,%xn%,%yn%
				Else
					If Not MapKeyAdd(Key,Action,"H")
						Tooltip,Map Failure,%xn%,%yn%
					Else
						Tooltip,Map Success,%xn%,%yn%
				Sleep,2000
				Tooltip
				Return
			}
			If RegExMatch(CMD,"i)^sma?p?\s*[^\s]*")
			{
				CMD1 := RegExReplace(CMD,"i)^sma?p?\s*")
				Key := SubStr(CMD1,1,RegExMatch(CMD1,"\s")-1)
				Action := SubStr(CMD1,RegExMatch(CMD1,"\s[^\s]")+1)
				yn := yn -  hn - 9
				If RegExMatch(Key,"^[^<][^>]+$|^<[^<>]*>[^<>][^<>]+$|^<[^<>]+><[^<>]+>.+$") ; "(^.+$|^<[^<>]*>.$|^<[^<>]*>$|^<[^<>*]><[^<>*]>$)")
					Tooltip,Map Success`,Global hotkeys does not support Groupkey ,%xn%,%yn%
				Else
					If Not MapKeyAdd(Key,Action,"S")
						Tooltip,Map Failure,%xn%,%yn%
					Else
						Tooltip,Map Success,%xn%,%yn%
				Sleep,2000
				Tooltip
				Return
			}
			If RegExMatch(CMD,"i)^e*")
			{
				Editviatcini()
				Return
			}
			yn := yn -  hn - 9
			Tooltip,Invalid command line,%xn%,%yn%
			Sleep,2000
			Tooltip
		}
		Else
			Send,{Enter}
	}
	Else
		Send,{Enter}
}
; CreateNewFile() {{{2
CreateNewFile()
{
	Global ViatcIni
	If CheckMode()
	{
	Menu,CreateNewFile,Add
	Menu,CreateNewFile,DeleteAll
	Index := 0
	Loop,23
	{
		IniRead,file,%ViatcIni%,ShellNew,%A_Index%
		If file <> ERROR
		{
			Splitpath,file,,,ext
			ext := "." . ext
			Icon_file :=
			Icon_idx :=
			RegRead,filetype,HKEY_CLASSES_ROOT,%ext%
			If Not filetype
			{
				Loop,HKEY_CLASSES_ROOT,%ext%,2
					If RegExMatch(A_LoopRegName,".*\.")
						filetype := A_LoopRegName
			}
			RegRead,iconfile,HKEY_CLASSES_ROOT,%filetype%\DefaultIcon
			Loop,% StrLen(iconfile)
			{
				If RegExMatch(SubStr(iconfile,Strlen(iconfile)-A_index+1,1),",")
				{
					icon_file := SubStr(iconfile,1,Strlen(iconfile)-A_index)
					icon_idx := Substr(iconfile,Strlen(iconfile)-A_index+2,A_index)
					Break
				}
			}
			file := "&" . chr(64+A_Index) . ">>" . Substr(file,2,RegExMatch(file,"\)")-2)
			Menu,CreateNewFile,Add,%file%,CreateFile
			Menu,CreateNewFile,Icon,%file%,%icon_file%,%icon_idx%
			Index++
			File := 
		}
	}
	If Index > 1
		Menu,CreateNewFile,Add
	Menu,CreateNewFile,Add,&Directory,MkDir
	Menu,CreateNewFile,Icon,&Directory,%A_WinDir%\system32\Shell32.dll,-4
	Menu,CreateNewFile,Add,&TextFile,CreateFile
	Menu,CreateNewFile,Icon,&TextFile,%A_WinDir%\system32\Shell32.dll,-152
	Menu,CreateNewFile,Add,&Link,Shortcut
	Menu,CreateNewFile,Icon,&Link,%A_WinDir%\system32\Shell32.dll,-30
	Menu,CreateNewFile,Add
	Menu,CreateNewFile,Add,Add Template(&X),template ;Lang
	Menu,CreateNewFile,Icon,Add Template(&X),%A_WinDir%\system32\Shell32.dll,-155
	Menu,CreateNewFile,Add,Configuration(&Z),M_EVI
	Menu,CreateNewFile,Icon,Configuration(&Z),%A_WinDir%\system32\Shell32.dll,-151
	ControlGetFocus,TLB,ahk_class TTOTAL_CMD
	ControlGetPos,xn,yn,,,%TLB%,ahk_class TTOTAL_CMD
	Menu,CreateNewFile,show,%xn%,%yn%
	}
}
MkDir:
	PostMessage 1075, 907, 0, , ahk_class TTOTAL_CMD
Return
Shortcut:
	PostMessage 1075, 1004, 0, , ahk_class TTOTAL_CMD	
Return
template:
	template()
Return
template()
{
	Global CNF
	ClipSaved := ClipboardAll
	Clipboard :=
	SendMessage 1075, 2018, 0, , ahk_class TTOTAL_CMD	
	ClipWait,2
	If Clipboard
		temp_File := Clipboard
	Else
		Return
	Clipboard := ClipSaved
	Filegetattrib,Attributes,%Temp_file%
	IfInString, Attributes, D
	{
		Msgbox ,,New Template , Please Select File ;Lang
		Return
	}
	Splitpath,temp_file,,,Ext
	WinGet,hwndtc,id,AHK_CLASS TTOTAL_CMD
	Gui,new,+Theme +Owner%hwndtc% +HwndCNF
	Gui,Add,Text,x10 y10,Temp Name
	Gui,Add,Edit,x50 y8 w205,%ext%
	Gui,Add,Text,x10 y42,Temp Source
	Gui,Add,Edit,x50 y40 w205 h20 +ReadOnly,%temp_File%
;	Gui,Add,button,x50 y68 gTemp_brow,浏览(&F)
	Gui,Add,button,x140 y68 default gTemp_save,&OK
	Gui,Add,button,x200 y68 g<Cancel>,&Cancel
	Gui,Show,,New Template ;Lang
	Controlsend,edit1,{ctrl a},ahk_id %CNF%
	Controlsend,edit2,{end},ahk_id %CNF%
}
Temp_save:
	temp_save()
Return
Temp_save()
{
	Global CNF,TCDir,ViatcIni
	ControlGettext,tempName,edit1,ahk_id %cnf%
	ControlGettext,tempPath,edit2,ahk_id %cnf%
	ShellNew := TCDir . "\ShellNew"
	If Not InStr(Fileexist(ShellNew),"D")
		FileCreateDir,%ShellNew%
	Filecopy,%tempPath%,%TCDir%\ShellNew,1
	Splitpath,tempPath,FileName
	New := 1
	Loop,23
	{
		IniRead,file,%ViatcIni%,ShellNew,%A_Index%
		If file = ERROR
			Break
		New++
	}
	IniWrite,(%tempName%)\%FileName%,%ViatcIni%,ShellNew,%New%
	Gui,Destroy
}
;CNF_conf:
;Return
CreateFile:
	CreateFile(SubStr(A_ThisMenuItem,5,Strlen(A_ThisMenuItem)))
Return
CreateFile(item)
{
	Global ViatcIni,TCDir,CNF_New
	ClipSaved := ClipboardAll
	Clipboard :=
	SendMessage 1075, 2029, 0, , ahk_class TTOTAL_CMD	
	ClipWait,2
	If Clipboard
		NewPath := Clipboard
	Else
		Return
	Clipboard := ClipSaved
	If RegExMatch(NewPath,"^\\\\计算机$")
		Return
	If RegExMatch(NewPath,"i)\\\\所有控制面板项$")
		Return
	If RegExMatch(NewPath,"i)\\\\Fonts$")
		Return
	If RegExMatch(NewPath,"i)\\\\网络$")
		Return
	If RegExMatch(NewPath,"i)\\\\打印机$")
		Return
	If RegExMatch(NewPath,"i)\\\\回收站$")	
		Return
	Loop,23
	{
		IniRead,file,%ViatcIni%,ShellNew,%A_Index%
		Match := Substr(file,2,RegExMatch(file,"\)")-2)
		if RegExMatch(Match,item) Or RegExMatch(Item,"^\(&V\)$")
		{
			If RegExMatch(Item,"^\(&V\)$")
			{
				File := A_Temp . "\viatcTemp"
				If Fileexist(file)
					Filedelete,%File%
				FileAppend,,%File%,UTF-8
			}
			Else
				file := TCDir . "\ShellNew" . Substr(file,RegExMatch(file,"\)")+1,Strlen(file))
			If Fileexist(file)
			{
				Splitpath,file,filename,,fileext
				WinGet,hwndtc,id,AHK_CLASS TTOTAL_CMD
				Gui,new,+Theme +Owner%hwndtc% +HwndCNF_New
				Gui,Add,Text,hidden ,%file%
				;Tooltip,%file%
				Gui,Add,Edit,x10 y10 w340 h22 -Multi,%filename%
				Gui,Add,button,x200 y40 w70 gTemp_create Default,&OK
				Gui,Add,button,x280 y40 w70 g<Cancel>,&Cancel
				Gui,Show,w360 h70,Create File ;Lang
				Controlsend,edit1,{ctrl a},ahk_id %CNF_New%
				If Fileext
				Loop,% strlen(fileext)+1
					Controlsend,edit1,+{left},ahk_id %CNF_New%
			}
			Else
			{
				Msgbox Temp Source has been deleted
				IniDelete,%ViatcIni%,ShellNew,%A_Index%
			}
			Break
		}
	}
}
Temp_Create:
	Temp_Create()
Return
Temp_Create()
{
	Global CNF_New
	ControlGetText,FilePath,Static1,AHK_ID %CNF_New%
	ControlGetText,NewFile,Edit1,AHK_ID %CNF_New%
	ClipSaved := ClipboardAll
	Clipboard :=
	SendMessage 1075, 2029, 0, , ahk_class TTOTAL_CMD	
	ClipWait,2
	If Clipboard
		NewPath := Clipboard
	Else
		Return
	If RegExmatch(NewPath,"^\\\\Desktop$")
		NewPath := A_Desktop
	NewFile := NewPath . "\" . NewFile
	If Fileexist(NewPath)
	{
		Filecopy,%FilePath%,%NewFile%,1
		If ErrorLevel
			Msgbox File Exist ;Lang
		Gui,Destroy
	}
	Clipboard := ClipSaved
	ControlGetFocus,focus_control,AHK_CLASS TTOTAL_CMD
	If RegExMatch(focus_control,"^TMyListBox\d$")
	{
		Splitpath,NewFile,NewFileName
		Matchstr := RegExReplace(newfileName,"\+|\?|\.|\*|\{|\}|\(|\)|\||\^|\$|\[|\]|\\","\$0")
		Loop,100
		{
			ControlGet,outvar,list,,%focus_control%,AHK_CLASS TTOTAL_CMD
			If RegExMatch(outvar,Matchstr) ;FileExist(newFile)
			{
				Matchstr := "^" . Matchstr 
				Loop,Parse,Outvar,`n
				{
					If RegExMatch(A_LoopField,MatchStr)
					{
						Focus := A_Index
						Break
					}
				}
				ControlSend,%Focus_Control%,{Home},AHK_Class TTOTAL_CMD
				Loop,% Focus-1
					ControlSend,%Focus_Control%,{Down},AHK_Class TTOTAL_CMD
				Break
			}
			Sleep,50
		}
	}
	Run,%newFile%,,UseErrorLevel
	Return
}
M_EVI:
	Editviatcini()
Return
Editviatcini()
{
	Global viatcini
	RegRead,path,HKEY_LOCAL_MACHINE,Software\vim\gvim,path
	match = `"$0
	INI := Regexreplace(viatcini,".*",match)
	path := path . " "
	If Fileexist(path)
		editini := path . a_space . ini
	Else
		editini := "notepad.exe" . a_space . ini
	Run,%editini%,,UseErrorLevel
	Return
}
<Cancel>:
	Gui,Cancel
Return
; Gui Functions {{{2
; Setting() {{{3
Setting()
{
	Global StartUp,Service,TrayIcon,Vim,GlobalTogg,Toggle,GlobalSusp,Susp,GroupWarn,TranspHelp,TransParent,SearchEng,DefaultSE,ViATcIni,TCExe,TCINI
	Global ListView
	Global MapKey_Arr,ActionInfo_Arr,ExecFile_Arr,SendText_Arr
	Gui,Destroy
	Gui,+Theme +hwndviatcsetting
	Gui,Add,Button,x10 y335 w80 g<EditViATCIni>,&Edit Config 
	Gui,Add,Button,x140 y335 w80 center Default g<GuiEnter>,&OK
	Gui,Add,Button,x230 y335 w80 center g<GuiCancel>,&Cancel
	Gui,Add,Tab2,x10 y6 +theme h320 center choose2,General(U)|Hotkeys(P)|&Path(&M)
	Gui,Add,GroupBox,x16 y32 H170 w290,Global Settings
	Gui,Add,CheckBox,x25 y50 h20 checked%startup% vStartup,Logon Startup(&R)
	Gui,Add,CheckBox,x180 y50 h20 checked%Service% vService,Service(&B)
	Gui,Add,CheckBox,x25 y70 h20 checked%TrayIcon% vTrayIcon,Tray Icon(&T)
	Gui,Add,CheckBox,x180 y70 h20 checked%Vim% vVim,Defalut VIM(&V)
	Gui,Add,Text,x25 y100 h20,Active/Minimal TC(&F)
	Gui,Add,Edit,x24 y120 h20 w140 vToggle ,%Toggle%
	Gui,Add,CheckBox,x180 y120 h20 checked%GlobalTogg% vGlobalTogg ,Global(&G)
	Gui,Add,Text,x25 y150 h20,Enable/Disable VIM keys(&A)
	Gui,Add,Edit,x25 y170 h20 w140 vSusp ,%Susp%
	Gui,Add,CheckBox,x180 y170 h20 checked%GlobalSusp% vGlobalSusp,Global(&L)
	Gui,Add,GroupBox,x16 y210 H110 w290,Other Settings
	Gui,Add,Text,x25 y228 h20,Search the selected file name or folders(&Q)
	D := 1
	Loop,15
	{
		IniRead,SE,%ViATcINI%,SearchEngine,%A_Index%
		If SE = ERROR
			IniDelete,%ViATcINI%,SearchEngine,%A_Index%
		Else
		{
			IniDelete,%ViATcINI%,SearchEngine,%A_Index%
			If A_Index = %DefaultSE%
			{
				DefaultSE := D
				IniWrite,%D%,%ViATcIni%,SearchEngine,Default
			}
			IniWrite,%SE%,%ViATcIni%,SearchEngine,%D%
			SE_Arr .= SE . "|"
			D++
		}
	}
	D--
	If DefaultSE > %D%
	{
		DefaultSE := D
		IniWrite,%D%,%ViATcIni%,SearchEngine,Default
	}
	Gui,Add,ComboBox,x25 y246 h20 w226 choose%DefaultSE% AltSubmit vDefaultSE R5 hwndaa g<SetDefaultSE>,%SE_Arr%
	Gui,Add,Button,x256 y246 h20 w22 g<AddSearchEng>,&+
	Gui,Add,Button,x280 y246 h20 w22 g<DelSearchEng>,&-
	Gui,Add,CheckBox,x25 y270 h20 checked%GroupWarn% vGroupWarn,Groupkey warning (&I)
	Gui,Add,CheckBox,x25 y295 h20 checked%transpHelp% vTranspHelp ,Transparent help(&I)
	Gui,Add,Button,x170 y280 h30 w120 Center g<Help>,Open Help(&H)
	Gui,Tab,2
	Gui,Add,ListView,x16 y32 h170 w290 count20 sortdesc  -Multi vListView g<ListViewDK>,*|Hotkey|Action|Information
	Lv_modifycol(2,100)
	Lv_modifycol(3,100)
	Lv_modifycol(4,300)
	lv := MapKey_Arr["Hotkeys"]
	Stringsplit,Index,lv,%A_Space%
	Index := Index0 - 1
	Loop,%Index%
	{
		If Index%A_Index% 
		{
			Scope := SubStr(Index%A_Index%,1,1)
			Key := SubStr(Index%A_Index%,2)
			Action := MapKey_Arr[Index%A_Index%]
			Info := ActionInfo_Arr[Action]
			If Action = <Exec>
			{
				Action := " Run"
				Key_T := Scope . TransHotkey(Key)
				Info := ExecFile_Arr[key_T]
			}
			If Action = <Text>
			{
				Action := " SendText"
				Key_T := Scope . TransHotkey(Key)
				Info := SendText_Arr[key_T]
			}
			LV_Add(vis,Scope,Key,Action,Info)
		}
	} 
	Gui,Add,GroupBox,x16 y210 h110 w290
	Gui,Add,Text,x22 y223 h20,Hotkey(&K)
	Gui,Add,Edit,x85 y220 h20 w80 g<CheckGorH>
	Gui,Add,CheckBox,x170 y221 h20 ,Global(&G)
	Gui,Add,Button,x250 y220 w50 g<TestTH>,Analyse
	Gui,Add,text,x22 y249 h20,Action(&W)
	Gui,Add,Edit,x85 y246 h20 w220 
	Gui,Add,Button,x21 y270 h20 w80 g<VimCMD> ,VIM(&V)
	Gui,Add,Button,x110 y270 h20 w80 g<TCCMD> ,TC(&T)
	Gui,Add,Button,x21 y294 h20 w80 g<RunFile> ,Run(&R)
	Gui,Add,Button,x110 y294 h20 w80 g<SendString> ,String(&S)
	Gui,Add,Button,x196 y274 h40 w50 g<CheckKey> ,Save(&L)
	Gui,Add,Button,x250 y274 h40 w50 g<DeleItem> ,Delete
	Gui,Tab,3
	Gui,Add,Text,x18 y35 h16 center,Totalcmd exe:
	Gui,Add,Edit,x18 y55 h20 +ReadOnly w250,%TCEXE%
	Gui,Add,Button,x275 y53 w30 g<GuiTCEXE>,...
	Gui,Add,Text,x18 y80 h16 center,Totalcmd ini:
	Gui,Add,Edit,x18 y100 h20 +ReadOnly w250,%TCINI%
	Gui,Add,Button,x275 y98 w30 g<GuiTCINI> ,...
	Gui,Tab
	Gui,Add,Button,x280 y5 w30 h20 center hide g<ChangeTab>,&U
	Gui,Add,Button,x280 y5 w30 h20 center hide g<ChangeTab>,&P
	Gui,Add,Button,x280 y5 w30 h20 center hide g<ChangeTab>,&M
	GUi,Show,h370 w320,VIATC Setting
}
; GuiContextMenu {{{4
GuiContextMenu:
	If A_GuiControl <> ListView
		Return
	EventInfo := A_EventInfo
	Menu,RightClick,Add
	Menu,RightClick,DeleteAll
	Menu,RightClick,Add,&Edit,<EditItem>
	Menu,RightClick,Add,&Delete,<DeleItem>
	Menu,RightClick,Show
Return
; GuiEscape {{{4
GuiEscape:
	Gui,Destroy
Return
; <AddSearchEng> {{{4
<AddSearchEng>:
	AddSearchEng()
Return
AddSearchEng()
{
	Global ViATcSetting,ViATcIni
	ControlgetText,SE,Edit3,AHK_ID %VIATCSetting%
	Controlget,SEList,list,,combobox1,AHK_ID %VIATCSetting%
	Stringsplit,List,SEList,`n
	List0++
	GuiControl,,combobox1,%SE%
	IniWrite,%SE%,%VIATCINI%,SearchEngine,%List0%
}
; <DelSearchEng> {{{4
<DelSearchEng>:
	DelSearchEng()
Return
DelSearchEng()
{
	Global ViATcSetting,ViATcIni,DefaultSE
	Controlget,SEList,list,,combobox1,AHK_ID %VIATCSetting%
	IniDelete,%ViATcIni%,SearchEngine,%DefaultSE%
	Stringsplit,List,SEList,`n
	Loop,%List0%
	{
		If A_Index = %DefaultSE%
			Continue
		NewSEList .= "|" . List%A_Index%
	}
	DefaultSE--
	GuiControl,,combobox1,%NewSEList%
	IniWrite,%DefaultSE%,%VIATCINI%,SearchEngine,Default
}
; <SetDefaultSE> {{{4
<SetDefaultSE>:
	SetDefaultSE()
Return
SetDefaultSE()
{
	Global ViATcSetting,DefaultSE,ViATcIni,SearchEng
	GuiControlget,SE,,combobox1,AHK_ID %VIATCSetting%
	If RegExMatch(SE,"^\d+$")
	{
		DefaultSE := SE
		IniRead,SearchEng,%VIATCINI%,SearchEngine,%DefaultSE%
		IniWrite,%SE%,%VIATCINI%,SearchEngine,Default
	}
}
; <GuiEnter> {{{4
<GuiEnter>:
	Gui,Submit
	IniWrite,%TrayIcon%,%ViATcIni%,Configuration,TrayIcon
	IniWrite,%Vim%,%ViATcIni%,Configuration,Vim
	IniWrite,%Toggle%,%ViATcIni%,Configuration,Toggle
	IniWrite,%Susp%,%ViATcIni%,Configuration,Suspend
	IniWrite,%GlobalTogg%,%ViATcIni%,Configuration,GlobalTogg
	IniWrite,%GlobalSusp%,%ViATcIni%,Configuration,GlobalSusp
	IniWrite,%StartUp%,%ViATcIni%,Configuration,StartUp
	IniWrite,%Service%,%ViATcIni%,Configuration,Service
	IniWrite,%GroupWarn%,%ViATcIni%,Configuration,GroupInfo
	IniWrite,%TranspHelp%,%ViATcIni%,Configuration,TranspHelp
	GoSub,<ConfigVar>
	;GoSub,<ReloadVIATC>
Return
; <GuiCancel> {{{4
<GuiCancel>:
	Gui,Destroy
Return
; <ListViewDK> {{{4
<ListViewDK>:
	If RegExMatch(A_GuiEvent,"DoubleClick")
	{
		EventInfo := A_EventInfo
		EditItem()
	}
	Tooltip
Return
; <EditItem> {{{4
<EditItem>:
	EditItem()
Return
EditItem()
{
	Global EventInfo,VIATCSetting
	If EventInfo
	{
		LV_GetText(Scope,EventInfo,1)
		LV_GetText(Key,EventInfo,2)
		LV_GetText(Action,EventInfo,3)
		LV_GetText(Info,EventInfo,4)
		If RegExMatch(Scope,"S")
			GuiControl,,Button18,1
		If RegExMatch(Scope,"[G|H]")
			GuiControl,,Button18,0
		If Key
			GuiControl,,Edit4,%Key%
		If Action = Run
			Action := "(" . Info . ")"
		If Action = SendText
			Action := "{" . Info . "}"
		If Action
			GuiControl,,Edit5,%Action%
	}
}
; <DeleItem> {{{4
<DeleItem>:
	DeleItem()
Return
DeleItem()
{
	Global EventInfo,ViATcIni,MapKey_Arr,VIATCSetting
	;If Not EventInfo
	;{
		ControlGet,Line,List,Count Focused,SysListView321,AHK_ID %VIATCSetting%
		EventInfo := Line
	;}
	If EventInfo
	{
		LV_GetText(Get,EventInfo,1)
		LV_GetText(GetText,EventInfo,2)
		Lv_Delete(EventInfo)
		Key := A_Space . Get . GetText . A_Space
		RegExReplace(MapKey_Arr["Hotkeys"],Key)
		MapKeyDelete(GetText,Get)
		If Get = H
			IniDelete,%ViATcIni%,Hotkey,%GetText%
		If Get = S
			IniDelete,%ViATcIni%,GlobalHotkey,%GetText%
		If Get = G
			IniDelete,%ViATcIni%,GroupKey,%GetText%
	}
}
; <VIMCMD> {{{4
<VIMCMD>:
	VimCMD()
Return
VimCMD()
{
	Global VimAction,ActionInfo_Arr
	Stringsplit,kk,VimAction,%A_Space%
	Gui,New
	Gui,+HwndVIMCMDHwnd
	Gui,Add,ListView,w400 h400 -Multi g<GetVIMCMD>,serial|Action|Information
	Lv_delete()
	Lv_modifycol(1,30)
	Lv_modifycol(2,150)
	Lv_modifycol(3,220)
	Loop,%kk0%
	{
		key := kk%A_Index%
		Info := ActionInfo_Arr[key]
		LV_ADD(vis,A_Index-1,key,info)
	}
	kk := kk%0% - 1
	lv_delete(1)
	Gui, Add, Button, x280 y420 w60 h24 Default g<VIMCMDB1>, &OK
	Gui, Add, Button, x350 y420 w60 h24 g<Cancel>, &Cancel
	Gui,Show,,VIATC Action
}
<VIMCMDB1>:
	ControlGet,EventInfo,List, Count Focused,SysListView321,ahk_id %VIMCMDHwnd%
	lv_gettext(actiontxt,EventInfo,2)
	ControlSetText,edit5,%actiontxt%,AHK_ID %VIATCSetting%
	Gui,Destroy
	Winactivate,AHK_ID %VIATCSetting%
Return
<GetVIMCMD>:
	lv_gettext(actiontxt,A_EventInfo,2)
	ControlSetText,edit5,%actiontxt%,AHK_ID %VIATCSetting%
	Gui,Destroy
	Winactivate,AHK_ID %VIATCSetting%
Return
; <TCCMD> {{{4
; 读取TC默认命令来做动作
<TCCMD>:
	tccmd()
Return
tccmd()
{
	Global VIATCSetting,TCEXE
	Ifwinexist,AHK_CLASS TTOTAL_CMD
		Winactivate,AHK_CLASS TTOTAL_CMD
	Else
	{
		Run,%TCEXE%
		WinWait,AHK_CLASS TTOTAL_CMD,1
		Winactivate,AHK_CLASS TTOTAL_CMD
	}
	Cli := ClipboardAll
	Clipboard := 
	Postmessage 1075, 2924, 0, , ahk_class TTOTAL_CMD
	Clipwait,0.5
	Loop
	{
		If Clipboard
			Break
		Else
		Ifwinexist,ahk_class TCmdSelForm
			Clipwait,0.5
		Else
			Break
	}
	If Clipboard
	{
		actiontxt := Clipboard
		actiontxt := Regexreplace(actiontxt,"^cm_","<") . ">"
	}
	Else
		actiontxt :=
	Clipboard := cli
	If actiontxt
	GuiControl,text,edit5,%actiontxt%
	Winactivate,AHK_ID %VIATCSetting%
}
; <RunFIle> {{{4
; 运行某程序 
<RunFile>:
	SelectFile()
Return
SelectFile()
{
	Global VIATCSetting
	Fileselectfile,outvar,,,VIATC Run
	If outvar
		outvar := "(" . outvar . ")"
	Winactivate,AHK_ID %VIATCSetting%
	GuiControl,text,edit5,%outvar%
}
; <SendString> {{{4
; 发送字符串 
<SendString>:
	GetSendString()
Return
GetSendString()
{
	Global VIATCSetting,VIATCSettingString
	Gui,New
	Gui,+Owner%VIATCSetting% ;+hwndVIATCSettingString
	Gui,Add,Edit,w500 h20 
	Gui,Add,Button,x390 y30 h20 g<GetSendStringEnter> Default w55,&OK
	Gui,Add,Button,x457 y30 h20 g<GetSendStringCancel> w55,&Cancel
	Gui,Show,,VIATC String
}
<GetSendStringEnter>:
	GuiControlGet,txt4,,Edit1 ;,ahk_id %VIATCSettingString%
	if txt4
		txt4 := "{" . txt4 . "}"
	;Control,,%txt4%,edit5,AHK_CLASS %VIATCSetting%
	ControlSetText,edit5,%txt4%,AHK_ID %VIATCSetting%
	GUi,Destroy
Return
<GetSendStringCancel>:
	GUi,Destroy
	Winactivate,AHK_ID %VIATCSetting%
Return
; <GuiTCEXE> {{{4
<GuiTCEXE>:
	GuiTCEXE()
return
GuiTCExe()
{
	Global TCEXE,VIATCSetting
	Fileselectfile,TCEXE,3,TOTALCMD.EXE,Find TOTALCMD.EXE,totalcmd.exe
	If ErrorLevel
		Return
	Regwrite,REG_SZ,HKEY_CURRENT_USER,Software\VIATC,InstallDir,%TCEXE%
	GuiControl,text,Edit6,%TCEXE%
}
; <GuiTCIni> {{{4
<GuiTCIni>:
	GuiTCIni()
return
GuiTCIni()
{
	Global TCINI,VIATCSetting
	Fileselectfile,TCINI,3,,Select totalcmd ini file，Default:WINCMD.INI,*.ini
	If ErrorLevel 
		Return
	Regwrite,REG_SZ,HKEY_CURRENT_USER,Software\VIATC,IniFileName,%TCINI%
	GuiControl,text,Edit7,%TCINI%
}
; <CheckGorH> {{{4
; 检查当前热键是否为组合键
<CheckGorH>:
	CheckGorH()
	Tooltip
Return
CheckGorH()
{
	Global ViATcSetting
	GuiControlGet,Key,,Edit4,AHK_CLASS %ViATcSetting%
	If Key
		If Not RegExMatch(Key,"(^.$|^<[^<>]*>.$|^<[^<>]*>$|^<[^<>*]><[^<>*]>$)")
			GuiControl,Disable,Button18
		Else
			GuiControl,Enable,Button18
	Else
		GuiControl,Enable,Button18
}
; <CheckKey> {{{4
; 检查并应用（映射）键
<CheckKey>:
	CheckKey()
Return
CheckKey()
{
	Global VIATCSetting,ViATcIni,MapKey_Arr,ExecFile_Arr,SendText_Arr,ActionInfo_Arr
	GuiControlGet,Scope,,Button18,AHK_CLASS %ViATcSetting%
	GuiControlGet,Key,,Edit4,AHK_CLASS %ViATcSetting%
	GuiControlGet,Action,,Edit5,AHK_CLASS %ViATcSetting%
	If Scope
		Scope := "S"
	Else
		Scope := "H"
	If Not RegExMatch(Key,"(^.$|^<[^<>]*>.$|^<[^<>]*>$|^<[^<>*]><[^<>*]>$)")
	{
		Scope := "G"
		GuiControl,,Button18,0
	}
	If Action And Key
	{
		If RegExMatch(Scope,"i)S")
		{
			If MapKeyAdd(Key,Action,Scope)
				Iniwrite,%Action%,%ViatcIni%,GlobalHotkey,%Key%
			Else
			{
				GuiControlGet,VarPos,Pos,Edit4
				Tooltip,Map Failure,%VarPosX%,%VarPosY%
				Sleep,2000
				Tooltip
				Return
			}
		}
		If RegExMatch(Scope,"i)H")
		{
			If MapKeyAdd(Key,Action,Scope)
				Iniwrite,%Action%,%ViatcIni%,Hotkey,%Key%
			Else
			{
				GuiControlGet,VarPos,Pos,Edit4
				Tooltip,Map Failure,%VarPosX%,%VarPosY%
				Sleep,2000
				Tooltip
				Return
			}
		}
		If RegExMatch(Scope,"i)G")
		{
			If MapKeyAdd(Key,Action,Scope)
				Iniwrite,%Action%,%ViatcIni%,GroupKey,%Key%
			Else
			{
				GuiControlGet,VarPos,Pos,Edit4
				Tooltip,Map Failure,%VarPosX%,%VarPosY%
				Sleep,2000
				Tooltip
				Return
			}
		}
		Loop,% LV_GetCount()
		{
			LV_GetText(GetScope,A_Index,1)
			LV_GetText(GetKey,A_Index,2)
			LV_GetText(GetAction,A_Index,3)
			Scope_M := "i)" . Scope
			Key_M := "i)" . RegExReplace(Key,"\+|\?|\.|\*|\{|\}|\(|\)|\||\^|\$|\[|\]|\\","\$0")
			Action_M := "i)" . RegExReplace(Action,"\+|\?|\.|\*|\{|\}|\(|\)|\||\^|\$|\[|\]|\\","\$0")
			If RegExMatch(GetScope,Scope_M) AND RegExMatch(GetKey,Key_M) AND RegExMatch(GetAction,Action_M)
				Return
			If RegExMatch(GetScope,Scope_M) AND RegExMatch(GetKey,Key_M) AND Not RegExMatch(GetAction,Action_M)
			{
				Info := ActionInfo_Arr[Action]
				If RegExMatch(Action,"^\(.*\)$")
				{
					Action := "Run"
					Key_T := Scope . TransHotkey(Key)
					Info := ExecFile_Arr[key_T]
				}
				If RegExMatch(Action,"^\{.*\}$")
				{
					Action := "SendText"
					Key_T := Scope . TransHotkey(Key)
					Info := SendText_Arr[key_T]
				}
				Lv_Modify(A_Index,vis,Scope,Key,Action,Info)
				Return
			}
		}
		Info := ActionInfo_Arr[Action]
		If RegExMatch(Action,"^\(.*\)$")
		{
			Action := "Run"
			Key_T := Scope . TransHotkey(Key)
			Info := ExecFile_Arr[key_T]
		}
		If RegExMatch(Action,"^\{.*\}$")
		{
			Action := "SendText"
			Key_T := Scope . TransHotkey(Key)
			Info := SendText_Arr[key_T]
		}
		LV_Add(vis,Scope,Key,Action,Info)
	}
	Else
	{
		GuiControlGet,VarPos,Pos,Edit4
		Tooltip,Hotkey or Action Error,%VarPosX%,%VarPosY%
		Sleep,2000
		Tooltip
	}
}
; <ChangeTab> {{{4
<ChangeTab>:
	ChangeTab()
Return
ChangeTab()
{
	If RegExMatch(A_GuiControl,"U")
		GuiControl,choose,SysTabControl321,1
	If RegExMatch(A_GuiControl,"P")
		GuiControl,choose,SysTabControl321,2
	If RegExMatch(A_GuiControl,"M")
		GuiControl,choose,SysTabControl321,3
}
; <TestTH> {{{4
<TestTH>:
	TH()
Return
TH() ;Lang
{
	GuiControlGet,Scope,,Button18,AHK_CLASS %ViATcSetting%
	GuiControlGet,Key,,Edit4,AHK_CLASS %ViATcSetting%
	If Not Key
		Return
	If Scope
		KeyType := "Global Hotkey"
	Else
		KeyType := "Hotkey"
	If Not RegExMatch(Key,"(^.$|^<[^<>]*>.$|^<[^<>]*>$|^<[^<>*]><[^<>*]>$)")
		KeyType := "Groupkey"
	Msg :=  KeyType . "`n"
	Key1 := TransHotkey(Key,"First")
	Msg .= "Key1:" . Key1 . "`n"
	Key2 := TransHotkey(Key,"ALL")
	KeyT := SubStr(Key2,Strlen(key1)+1)
	Stringsplit,T,KeyT
	N := 2
	Loop,%T0%
	{
		Msg .= "Key" . N . T%A_index% . "`n"
		N++
	}
	GuiControlGet,VarPos,Pos,Edit4
	VarPosY := VarPosY - VarPosH - ( T0 * 17)
	Tooltip,%Msg%,%VarPosX%,%VarPosY%
	Settimer,<RemoveTT>,50
}
<RemoveTT>:
	Ifwinnotactive,AHK_ID %ViATcSetting%
	{
		SetTimer,<RemoveTT>, Off
		ToolTip
	}
return
; Help() {{{3
Help()
{
	Global TranspHelp,HelpInfo_Arr
	Gui,New
	Gui,+HwndVIATCHELP
	Gui,Font,s8,Arial Bold
	Gui,Add,Text,x12 y10 w30 h18 center Border g<ShowHelp>,Esc
	Gui,Add,Text,x52 y10 w26 h18 center Border g<ShowHelp>,F1
	Gui,Add,Text,x80 y10 w26 h18 center Border g<ShowHelp>,F2
	Gui,Add,Text,x108 y10 w26 h18 center Border g<ShowHelp>,F3
	Gui,Add,Text,x136 y10 w26 h18 center Border g<ShowHelp>,F4
	Gui,Add,Text,x164 y10 w26 h18 center Border g<ShowHelp>,F5
	Gui,Add,Text,x192 y10 w26 h18 center Border g<ShowHelp>,F6
	Gui,Add,Text,x220 y10 w26 h18 center Border g<ShowHelp>,F7
	Gui,Add,Text,x248 y10 w26 h18 center Border g<ShowHelp>,F8
	Gui,Add,Text,x276 y10 w26 h18 center Border g<ShowHelp>,F9
	Gui,Add,Text,x304 y10 w26 h18 center Border g<ShowHelp>,F10
	Gui,Add,Text,x332 y10 w26 h18 center Border g<ShowHelp>,F11
	Gui,Add,Text,x360 y10 w26 h18 center Border g<ShowHelp>,F12
	Gui,Add,Text,x12 y35 w22 h18 center Border g<ShowHelp>,``~
	Gui,Add,Text,x36 y35 w22 h18 center Border g<ShowHelp>,1!
	Gui,Add,Text,x60 y35 w22 h18 center Border g<ShowHelp>,2@
	Gui,Add,Text,x84 y35 w22 h18 center Border g<ShowHelp>,3#
	Gui,Add,Text,x108 y35 w22 h18 center Border g<ShowHelp>,4$
	Gui,Add,Text,x132 y35 w22 h18 center Border g<ShowHelp>,5`%
	Gui,Add,Text,x156 y35 w22 h18 center Border g<ShowHelp>,6^
	Gui,Add,Text,x180 y35 w22 h18 center Border g<ShowHelp>,7&
	Gui,Add,Text,x204 y35 w22 h18 center Border g<ShowHelp>,8*
	Gui,Add,Text,x228 y35 w22 h18 center Border g<ShowHelp>,9(
	Gui,Add,Text,x252 y35 w22 h18 center Border g<ShowHelp>,0)
	Gui,Add,Text,x276 y35 w22 h18 center Border g<ShowHelp>,-_
	Gui,Add,Text,x300 y35 w22 h18 center Border g<ShowHelp>,=+
	Gui,Add,Text,x324 y35 w62 h18 center Border g<ShowHelp>,Backspace
	Gui,Add,Text,x12 y55 w40 h18 center Border g<ShowHelp>,Tab
	Gui,Add,Text,x54 y55 w22 h18 center Border g<ShowHelp>,Q
	Gui,Add,Text,x78 y55 w22 h18 center Border g<ShowHelp>,W
	Gui,Add,Text,x102 y55 w22 h18 center Border g<ShowHelp>,E
	Gui,Add,Text,x126 y55 w22 h18 center Border g<ShowHelp>,R
	Gui,Add,Text,x150 y55 w22 h18 center Border g<ShowHelp>,T
	Gui,Add,Text,x174 y55 w22 h18 center Border g<ShowHelp>,Y
	Gui,Add,Text,x198 y55 w22 h18 center Border g<ShowHelp>,U
	Gui,Add,Text,x222 y55 w22 h18 center Border g<ShowHelp>,I
	Gui,Add,Text,x246 y55 w22 h18 center Border g<ShowHelp>,O
	Gui,Add,Text,x270 y55 w22 h18 center Border g<ShowHelp>,P
	Gui,Add,Text,x294 y55 w22 h18 center Border g<ShowHelp>,[{
	Gui,Add,Text,x318 y55 w22 h18 center Border g<ShowHelp>,]}
	Gui,Add,Text,x342 y55 w44 h18 center Border g<ShowHelp>,\|
	Gui,Add,Text,x12 y75 w60 h18 center Border g<ShowHelp>,CapsLock
	Gui,Add,Text,x74 y75 w22 h18 center Border g<ShowHelp>,A
	Gui,Add,Text,x98 y75 w22 h18 center Border g<ShowHelp>,S
	Gui,Add,Text,x122 y75 w22 h18 center Border g<ShowHelp>,D
	Gui,Add,Text,x146 y75 w22 h18 center Border g<ShowHelp>,F
	Gui,Add,Text,x170 y75 w22 h18 center Border g<ShowHelp>,G
	Gui,Add,Text,x194 y75 w22 h18 center Border g<ShowHelp>,H
	Gui,Add,Text,x218 y75 w22 h18 center Border g<ShowHelp>,J
	Gui,Add,Text,x242 y75 w22 h18 center Border g<ShowHelp>,K
	Gui,Add,Text,x266 y75 w22 h18 center Border g<ShowHelp>,L
	Gui,Add,Text,x290 y75 w22 h18 center Border g<ShowHelp>,`;:
	Gui,Add,Text,x314 y75 w22 h18 center Border g<ShowHelp>,'`"
	Gui,Add,Text,x338 y75 w48 h18 center Border g<ShowHelp>,Enter
	Gui,Add,Text,x12 y95 w70 h18 center Border g<ShowHelp>,LShift
	Gui,Add,Text,x84 y95 w22 h18 center Border g<ShowHelp>,Z
	Gui,Add,Text,x108 y95 w22 h18 center Border g<ShowHelp>,X
	Gui,Add,Text,x132 y95 w22 h18 center Border g<ShowHelp>,C
	Gui,Add,Text,x156 y95 w22 h18 center Border g<ShowHelp>,V
	Gui,Add,Text,x180 y95 w22 h18 center Border g<ShowHelp>,B
	Gui,Add,Text,x204 y95 w22 h18 center Border g<ShowHelp>,N
	Gui,Add,Text,x228 y95 w22 h18 center Border g<ShowHelp>,M
	Gui,Add,Text,x252 y95 w22 h18 center Border g<ShowHelp>,`,<
	Gui,Add,Text,x276 y95 w22 h18 center Border g<ShowHelp>,.>
	Gui,Add,Text,x300 y95 w22 h18 center Border g<ShowHelp>,/?
	Gui,Add,Text,x324 y95 w62 h18 center Border g<ShowHelp>,RShift
	Gui,Add,Text,x12 y115 w40 h18 center Border g<ShowHelp>,LCtrl
	Gui,Add,Text,x54 y115 w40 h18 center Border g<ShowHelp>,LWin
	Gui,Add,Text,x96 y115 w40 h18 center Border g<ShowHelp>,LAlt
	Gui,Add,Text,x138 y115 w122 h18 center Border g<ShowHelp>,Space
	Gui,Add,Text,x262 y115 w40 h18 center Border g<ShowHelp>,RAlt
	Gui,Add,Text,x304 y115 w40 h18 center Border g<ShowHelp>,Apps
	Gui,Add,Text,x346 y115 w40 h18 center Border g<ShowHelp>,RCtrl
	Gui,Add,Groupbox,x12 y135 w374 h40 
	Gui,Add,Button,x20 y146 w58 gIntro,Intro(&I)
	Gui,Add,Button,x80 y146 w58 gFunck,Func(&K)
	Gui,Add,Button,x140 y146 w58 gGroupk,Group(&G)
	Gui,Add,Button,x200 y146 w58 gCmdl,CMD(&C)
	Gui,Add,Button,x260 y146 w58 gAction,Action(&J)
	Gui,Add,Button,x320 y146 w58 gAbout,About(&A)
	Intro := HelpInfo_Arr["Intro"]  ; Click the appropriate button to view the content.
	Gui,Add,Edit,x12 y180 w374 h200 +ReadOnly,%Intro%
	Gui,Show,w400 h400,VIATC Help
	If TranspHelp
	WinSet,Transparent,220,ahk_id %VIATCHELP%
	Return
}
Intro:
	var := HelpInfo_Arr["Intro"]
	GuiControl,Text,Edit1,%var%
Return
Funck:
	var := HelpInfo_Arr["funck"]
	GuiControl,Text,Edit1,%var%
Return
Groupk:
	var := HelpInfo_Arr["Groupk"]
	GuiControl,Text,Edit1,%var%
Return
cmdl:
	var := HelpInfo_Arr["cmdl"]
	GuiControl,Text,Edit1,%var%
Return
action:
	var := HelpInfo_Arr["action"]
	GuiControl,Text,Edit1,%var%
Return
about:
	var := HelpInfo_Arr["about"]
	GuiControl,Text,Edit1,%var%
Return
<ShowHelp>:
	ShowHelp(A_GuiControl)
Return
ShowHelp(control)
{
	Global HelpInfo_Arr
	Var := HelpInfo_Arr[Control]
	;ControlSetText,Edit1,%var%,AHK_ID %VIATCHELP%
	GuiControl,Text,Edit1,%var%
}
; SetArrays {{{1
; SetHelpInfo() {{{2
SetHelpInfo()
{
	Global HelpInfo_arr
	HelpInfo_arr["Esc"] :="Esc >>Reset of all actions"
	HelpInfo_arr["F1"] :="F1 >>No mapping`nOpen help TC"
	HelpInfo_arr["F2"] :="F2 >>No mapping`nReread source window"
	HelpInfo_arr["F3"] :="F3 >>No mapping`nList files"
	HelpInfo_arr["F4"] :="F4 >>No mapping`nEdit file"
	HelpInfo_arr["F5"] :="F5 >>No mapping`nCopying files"
	HelpInfo_arr["F6"] :="F6 >>No mapping`nRename or move files"
	HelpInfo_arr["F7"] :="F7 >>No mapping`nCreate directory"
	HelpInfo_arr["F8"] :="F8 >>No mapping`nDelete files to the Recycle Bin or directly deleted - depending on the configuration(or Delete)"
	HelpInfo_arr["F9"] :="F9 >>No mapping`nActivate menu above source window (left or right)"
	HelpInfo_arr["F10"] :="F10 >>No mapping`nActivate left menu or deactivate menu"
	HelpInfo_arr["F11"] :="F11 >>No mapping"
	HelpInfo_arr["F12"] :="F12 >>No mapping"
	HelpInfo_arr["``~"] :="`` >>No mapping`n~ >>No mapping"
	HelpInfo_arr["1!"] :="1 >>No mapping`n! >>No mapping"
	HelpInfo_arr["2@"] :="2 >>No mapping`n@ >>No mapping"
	HelpInfo_arr["3#"] :="3 >>No mapping`n# >>No mapping"
	HelpInfo_arr["4$"] :="4 >>No mapping`n$ >>No mapping"
	HelpInfo_arr["5%"] :="5 >>No mapping`n! >>No mapping"
	HelpInfo_arr["6^"] :="6 >>No mapping`n^ >>No mapping"
	HelpInfo_arr["7&"] :="7 >>No mapping`n& >>No mapping"
	HelpInfo_arr["8*"] :="8 >>No mapping`n* >>No mapping"
	HelpInfo_arr["9("] :="9 >>No mapping`n( >>No mapping"
	HelpInfo_arr["0)"] :="0 >>No mapping`n) >>No mapping"
	HelpInfo_arr["-_"] :="- >>Folder tree panel switch independent state`n_ >>No mapping"
	HelpInfo_arr["=+"] :="= >>The goal = Source`n+ >>No mapping"
	HelpInfo_arr["Backspace"] :="Backspace >>No mapping`nReturn to the previous folder or delete text in the edit mode"
	HelpInfo_arr["Tab"] :="Tab >>No mapping`nSwitch windows"
	HelpInfo_arr["Q"] :="q >>Quick view panel instead of file window`nQ >>Use the default browser search current file name / folder name"
	HelpInfo_arr["W"] :="w >>Edit file comment`nW >>No mapping"
	HelpInfo_arr["E"] :="e >>Display the context menu`nE >>In the current directory, run CMD.EXE"
	HelpInfo_arr["R"] :="r >>Renaming files`nR >>Batch rename files"
	HelpInfo_arr["T"] :="t >>Open new folder tab and activate it`nT >>Open new folder tab, but do not activate it"
	HelpInfo_arr["Y"] :="y >>Copy the file name`nY >>Copy the file name and full path"
	HelpInfo_arr["U"] :="u >>Return to parent directory`nU >>Returns the root directory"
	HelpInfo_arr["I"] :="i >>Insert new folder`nI >>No mapping"
	HelpInfo_arr["O"] :="o >>Open the left drive list`nO >>Open the right drive list"
	HelpInfo_arr["P"] :="p >>压缩文件/文件夹`nP >>解压缩"
	HelpInfo_arr["[{"] :="[ >>选择文件名相同的文件`n{ >>不选择文件名相同的文件"
	HelpInfo_arr["]}"] :="] >>选择扩展名相同的文件`n} >>不选择扩展名相同的文件"
	HelpInfo_arr["\|"] :="\ >>反选所有文件及文件夹 `n| >>只反选文件"
	HelpInfo_arr["CapsLock"] :="CapsLock No mapping"
	HelpInfo_arr["A"] :="a >>更改属性`n A >>No mapping"
	HelpInfo_arr["S"] :="s >>排序类热键`nS >>No mapping`nsn >>Source window: 按文件名排序`nse >>Source window: 按扩展名排序`nss >>Source window: 按大小排序`nst >>Source window: 按日期时间排序`nsr >>Source window: 反向排序`ns1 >>Source window: 按第 1 列排序`ns2 >>Source window: 按第2 列排序`ns3 >>Source window: 按第 3 列排序`ns4 >>Source window: 按第 4 列排序`ns5 >>Source window: 按第 5 列排序`ns6 >>Source window: 按第 6 列排序`ns7 >>Source window: 按第 7 列排序`ns8 >>Source window: 按第 8 列排序`ns9 >>Source window: 按第 9 列排序 >>"
	HelpInfo_arr["D"] :="d >>常用文件夹`nD >>打开桌面文件夹"
	HelpInfo_arr["F"] :="f >>向下翻页，相当于PageDown`nF >>No mapping"
	HelpInfo_arr["G"] :="g >>标签类组合键`nG >>焦点移动到文件列表未尾`ngg >>转到文件列表首行`ngn >>下一个标签(Ctrl+Tab)`ngp >>上一个标签(Ctrl+Shift+Tab)`nga >>关闭所有标签`ngc >>关闭当前标签`ngt >>新建标签(并打开光标处的文件夹)`ngb >>新建标签(在另一窗口打开文件夹)`nge >>交换左右窗口`ngw >>交换左右窗口及其标签`ngg >>转到文件列表首行`ng1 >>Source window: 激活标签 1`ng2 >>Source window: 激活标签 2`ng3 >>Source window: 激活标签 3`ng4 >>Source window: 激活标签 4`ng5 >>Source window: 激活标签 5`ng6 >>Source window: 激活标签 6`ng7 >>Source window: 激活标签 7`ng8 >>Source window: 激活标签 8`ng9 >>Source window: 激活标签 9`ng0 >>转到最后一个标签"
	HelpInfo_arr["H"] :="h >>向左移动Num次`nH >>后退"
	HelpInfo_arr["J"] :="j >>向下移动Num次`nJ >>向下选择Num个文件（夹）"
	HelpInfo_arr["K"] :="k >>向上移动Num次`nK >>向上选择Num个文件（夹）"
	HelpInfo_arr["L"] :="l >>向右移动Num次`nL >>前进"
	HelpInfo_arr["`;:"] :="; >>焦点位于命令行`n: >>进行VIATC命令行模式(带:)"
	HelpInfo_arr["'"""] :="' >>显示所有标记（标记由m键的标记功能产生）与VIM相似`n"" >>No mapping"
	HelpInfo_arr["Enter"] :="Enter >>回车"
	HelpInfo_arr["LShift"] :="Lshift >>左shift键，也可以由Shift代替"
	HelpInfo_arr["Z"] :="z >>工具类组合键`nZ >>No mapping`nzz >>Window divider bar located 50%`nzx >>Window divider bar located 100%`nzi >>最大化左面板`nzo >>最大化右面板`nzt >>TC窗口保持最前`nzn >>最小化 Total Commander`nzm >>最大化 Total Commander`nzr >>恢复正常大小`nzv >>纵向/横向排列`nzs >>TC透明`nzf >>最简TC`nzq >>退出TC`nza >>重启TC"
	HelpInfo_arr["X"] :="x >>删除文件(夹)`nX >>强制删除文件(夹)"
	HelpInfo_arr["C"] :="c >>清除类组合键`nC >>No mapping`ncl >>删除左侧文件夹历史`ncr >>删除右侧文件夹历史`ncc >>删除命令行历史"
	HelpInfo_arr["V"] :="v >>Show View menu(带a-z导航)`nV >>显示类组合键<Shift>vb >>显示/隐藏: 工具栏`n<Shift>vd >>显示/隐藏: 驱动器按钮`n<Shift>vo >>显示/隐藏: 两个驱动器按钮栏`n<Shift>vr >>显示/隐藏: 驱动器列表`n<Shift>vc >>显示/隐藏: 当前文件夹`n<Shift>vt >>显示/隐藏: 排序制表符`n<Shift>vs >>显示/隐藏: 状态栏`n<Shift>vn >>显示/隐藏: 命令行`n<Shift>vf >>显示/隐藏: 功能键按钮`n<Shift>vw >>显示/隐藏: 文件夹标签`n<Shift>ve >>浏览内部命令"
	HelpInfo_arr["B"] :="b >>向上翻页，相当于PageUp`nB >>No mapping"
	HelpInfo_arr["N"] :="n >>显示文件夹历史(带a-z导航)`nN >>No mapping"
	HelpInfo_arr["M"] :="m >>标记功能，标记当前文件夹`nM >>No mapping`n标记功能，类似于VIM中的m键。当按下m后，命令行会提示m，进入标记状态，再输入任意字符，可保存当前文件夹路径到标记。例如在正常状态下输入ma后，再按下'调出所有标记，此时按再a，可以转到相应标记的文件夹"
	HelpInfo_arr[",<"] :=", >>显示命令历史(带a-z导航)`n< >>No mapping"
	HelpInfo_arr[".>"] :=". >>重复上一次动作`n> >>No mapping`n重复上一次的动作，例如当你输入10j向下移动10行，又想再向下移动10行，无需再按10j只需要按一下.即可。按下gn移动到下一个标签，再次移动的话，也只需要按下."
	HelpInfo_arr["/?"] :="/ >>使用快速搜索`n? >>使用搜索文件功能(完全)"
	HelpInfo_arr["RShift"] :="Rshift >>右shift键，也可以由Shift代替"
	HelpInfo_arr["LCtrl"] :="Lctrl >>左ctrl键，也可以由control或ctrl代替"
	HelpInfo_arr["LWin"] :="LWin >>Win键 由于ahk的限制，win键必须由lwin来代替"
	HelpInfo_arr["LAlt"] :="LAlt >>左Alt键，也可以由alt代替"
	HelpInfo_arr["Space"] :="Space >>空格，No mapping"
	HelpInfo_arr["RAlt"] :="RAlt >>右Alt键，也可以由alt代替"
	HelpInfo_arr["Apps"] :="Apps >>打开上下文菜单（右键菜单）"
	HelpInfo_arr["RCtrl"] :="Rctrl >>右ctrl键，也可以由control或ctrl代替"
	HelpInfo_arr["Intro"] :="  Vim keyboard shortcuts system combined with TC, TC operations 'fast'. Maximum of two buttons you can accomplish most tasks need to be done with the mouse 'n if you've ever used Vim, and TC is in use, then you'll like ViATc'n if you use a TC, but also felt the mouse click is not sufficient to operate more quickly, so you'll want to use ViATc'n, the complex operation, with two hand tapping on the keyboard out. Is to write ViATc in the first place. 'NViATc: 'n TC mode with Vim, h,j,k,l and more; press: 'n to the command line mode is not required,Alt+~(You can modify) all VIATC key features disabled, or simply exit ViATc, had no effect on TC full. 'n any shortcut keys do not conflict with TC's own shortcut keys, green. 'N the permanent task bar icon, double-click the taskbar icon, or Win+E call TC'n repeatedly moving, key combinations, transparent TC, overhead TC, there is more ... ... 'n'n waiting for your suggestions, make ViATc more useful. 'n'n0.5 Update: 'n++ (setting)You can customize all the buttons `n ++ (function) button in addition to trigger internal actions (Action), you can also run a program or send the string` n ++ (Function) Supported Do not use VIM mode TC open `n ++ (function) Support Management add or remove search engine `n ++ (function) folder history, use the command line history az navigation` n ++ (function) to increase repeat the last action of the function, press. '.' key to peace of mind! `n - (function) Enhanced document templates` n - (function) to remove the save / restore function to select a list of `n - (function) is not used to remove the selection function` n - (function) removing less frequently used commands line Features (available button instead)"
	HelpInfo_arr["Funck"] :="功能键>>单次按键即可实现操作`n      功能键按文字类型分，可分为数字Num0-Num9，字符a-z各种字符等。默认情况下，输入数字时不会引起任务操作，只会记录数字的大小，然后通过按下允许多次操作的键来实现重复操作，例如按下10j，实现的是向下移动10行,按下10K，则是向上选择10行，由于文件管理器的特殊，所以只有在列表中移动(hjkl/JK)才可以使用多次操作。`n重要！  在VIATC中表达功能键（单次按键）可以带control,alt,win,shift四种修饰符和字符组成，但是每个字符都只能跟一个修饰符`n<LWin>e (有效，必须使用LWin而不是Win)`n<ctrl><F12> (有效，此时第二个<>中的字符会被解释成普通字符)`n<ctrl><shift>a (无效，超过单个修饰符的要求)`n      关于每个按键能实现什么功能，请点击上面的键盘，获得每个按键的详细信息。"
	HelpInfo_arr["GroupK"] :="组合键>>按两次或两次以上实现操作`n    与VIM相似，组合键可以非常灵活地映射某个功能，同时不局限于键盘的26个字母，与功能键不同，组合键可以由多个字符组成。但是有一点要注意，组合键的第一个按键只能带最多一个的修饰符(ctrl/lwin/shift/alt)，后面所有的按键都不可以带修饰符`n例如:`n<ctrl>ab (有效，按下ctrl+a后，再按b来实现某个功能)`n<ctrl>a<ctrl>b (无效，第一个按键可以最多一个的修饰符，第二个按键不能带)`nVIATC默认带了五组组合键，详细点击上面的键盘z,c,v,g,s"
	HelpInfo_arr["cmdl"] :="命令行>>`nVIATC的命令行支持缩写:h :s :r :m :sm :e，分别是`n:help 显示帮助信息`n:Setting VIATC设置界面`n:reload 重新运行VIATC`n:map 显示或者映射热键`n如果在命令行中输入:map 会显示所有自定义热键。`n如果输入的是:map key action，其中key代表要映射的热键，可以是组合键，也可以是功能键。action代表的是要执行的动作。这个功能适合的情景是临时需要某个功能的映射，同时关闭VIATC后不会保存。如果要进行永久映射，则可以打开VIATC设置界面进行映射，或者直接编辑位于TC根目录下的配置文件VIATC.ini。`n:smap 与map一样，不过映射的是全局热键，而且不支持映射组合键`n:edit 直接编辑ViATc.ini文件"
	HelpInfo_arr["action"] :="动作>>`n在VIATC中，所有的操作都可以理解为一个动作(action)，所有的动作可以在设置界面的热键映射界面里找到。动作分为四类：`n1、VIATC自带动作，由VIATC提供的一些TC增强功能，让你更加方便地操作TC。`n2、TC内部动作，也就是TC默认以cm_开头的内部命令，如cm_SrcComments等。`n3、运行某个程序或打开某个文件，这个比较方便常常需要结合TC运行的程序或需要编辑的文件，当然，TC内部也有类似的功能，等这个功能用多后，自然知道哪个比较好用:)。`n4、发送字符串，如果要经常在TC里输入某个文字，可以用组合键映射到发送字符串的动作，方便啊！！`n上述四种动作中，1和2必须是以<和>开头结尾的,3则是以(和)开头结尾的，4则是以{和}开头结尾的。`n举例`n:map <shift>a <TransParent> (映射shift a键为让TC透明的动作)`n:map ggg (E:\google\chrome.exe) (映射ggg组合键为运行chrome.exe程序`n:map abcd {cd E:\ {enter}} (映射abcd组合键为发送cd E:\ {enter}到TC的命令行中，其中{enter}还是被VIATC解释成按下回车键"
	HelpInfo_arr["About"] :="这个版本是0.5.1测试版，有什么问题请联系我linxinhong.sky@gmail.com"
}
; SetGroupInfo() {{{2
; 组合键提示时所用到
SetGroupInfo()
{
	Global GroupInfo_arr
	GroupInfo_arr["s"] :="sn >>Source window: Sorted by file name`nse >>Source window: 按扩展名排序`nss >>Source window: 按大小排序`nst >>Source window: 按日期时间排序`nsr >>Source window: 反向排序`ns1 >>Source window: 按第 1 列排序`ns2 >>Source window: 按第2 列排序`ns3 >>Source window: 按第 3 列排序`ns4 >>Source window: 按第 4 列排序`ns5 >>Source window: 按第 5 列排序`ns6 >>Source window: 按第 6 列排序`ns7 >>Source window: 按第 7 列排序`ns8 >>Source window: 按第 8 列排序`ns9 >>Source window: 按第 9 列排序"
	GroupInfo_arr["z"] :="zz >>Window divider bar located 50%`nzx >>Window divider bar located 100%`nzi >>最大化左面板`nzo >>最大化右面板`nzt >>TC窗口保持最前`nzn >>最小化 Total Commander`nzm >>最大化 Total Commander`nzr >>恢复正常大小`nzv >>纵向/横向排列`nzs >>TC透明`nzf >>全屏TC`nzl >>最简TC`nzq >>退出TC`nza >>重启TC"
	GroupInfo_arr["g"] :="gn >>下一个标签(Ctrl+Tab)`ngp >>上一个标签(Ctrl+Shift+Tab)`nga >>关闭所有标签`ngc >>关闭当前标签`ngt >>新建标签(并打开光标处的文件夹)`ngb >>新建标签(在另一窗口打开文件夹)`nge >>交换左右窗口`ngw >>交换左右窗口及其标签`ngg >>焦点转到文件列表首行`ng1 >>Source window: 激活标签 1`ng2 >>Source window: 激活标签 2`ng3 >>Source window: 激活标签 3`ng4 >>Source window: 激活标签 4`ng5 >>Source window: 激活标签 5`ng6 >>Source window: 激活标签 6`ng7 >>Source window: 激活标签 7`ng8 >>Source window: 激活标签 8`ng9 >>Source window: 激活标签 9`ng0 >>转到最后一个标签"
	GroupInfo_arr["Shift & v"] :="<Shift>vb >>显示/隐藏: 工具栏`n<Shift>vd >>显示/隐藏: 驱动器按钮`n<Shift>vo >>显示/隐藏: 两个驱动器按钮栏`n<Shift>vr >>显示/隐藏: 驱动器列表`n<Shift>vc >>显示/隐藏: 当前文件夹`n<Shift>vt >>显示/隐藏: 排序制表符`n<Shift>vs >>显示/隐藏: 状态栏`n<Shift>vn >>显示/隐藏: 命令行`n<Shift>vf >>显示/隐藏: 功能键按钮`n<Shift>vw >>显示/隐藏: 文件夹标签`n<Shift>ve >>浏览内部命令"
	GroupInfo_arr["c"] :="cl >>删除左侧文件夹历史`ncr >>删除右侧文件夹历史`ncc >>删除命令行历史"
}
; SetVimAction() {{{2
SetVimAction()
{
	Global VimAction
	VimAction := " <help> <Setting> <ToggleTC> <EnableVIM> <QuitTC> <ReloadTC> <QuitVIATC> <ReloadVIATC> <Enter> <singleRepeat> <Esc> <Num0> <Num1> <Num2> <Num3> <Num4> <Num5> <Num6> <Num7> <Num8> <Num9> <Down> <up> <Left> <Right> <DownSelect> <PageUp> <PageDown> <Home> <End> <UpSelect> <ForceDel> <Mark> <ListMark> <Internetsearch> <azHistory> <azCmdHistory> <ListMapKey> <WinMaxLeft> <WinMaxRight> <AlwayOnTop> <TransParent> <DeleteLHistory> <DeleteRHistory> <DelCmdHistory> <CreateNewFile> <GoLastTab> <TCLite> <TCFullScreen> <EditViATCIni>"
}
; SetActionInfo() {{{{2
SetActionInfo()
{
  Global ActionInfo_arr
; ActionInfo_Arr用于保存动作说明
;Config actions"] :="可配置动作"
  ActionInfo_Arr["<ReLoadVIATC>"] :="重启VIATC"
  ActionInfo_Arr["<ReLoadTC>"] :="重启TC"
  ActionInfo_Arr["<QuitTC>"] :="退出TC"
  ActionInfo_Arr["<QuitViATc>"] :="退出ViATc"
  ActionInfo_Arr["<None>"] :="无效果"
  ActionInfo_Arr["<Setting>"] :="配置界面"
  ActionInfo_Arr["<FocusCmdLine:>"] := "命令行模式 焦点置于命令行，并以:开头"
  ActionInfo_Arr["<CreateNewFile>"] := "文件模板功能，创建新文件或新目录"
  ActionInfo_Arr["<TCLite>"] := "最简TC"
  ActionInfo_Arr["<ExReName>"] := "增强重命名，不选择扩展名"
  ActionInfo_Arr["<Help>"] := "VIATC帮助"
  ActionInfo_Arr["<Setting>"] := "VIATC设置"
  ActionInfo_Arr["<ToggleTC>"] :="打开TC"
  ActionInfo_Arr["<EnableVIM>"] :="启用/禁用VIM模式"
  ActionInfo_Arr["<Enter>"] :="回车"
  ActionInfo_Arr["<SingleRepeat>"] :="重复上次的动作"
  ActionInfo_Arr["<Esc>"] :="复位并发送ESC"
  ActionInfo_Arr["<EditViATCIni>"] :="直接编辑ViATc配置文件"
  ActionInfo_Arr["<Num0>"] :="数字0"
  ActionInfo_Arr["<Num1>"] :="数字1"
  ActionInfo_Arr["<Num2>"] :="数字2"
  ActionInfo_Arr["<Num3>"] :="数字3"
  ActionInfo_Arr["<Num4>"] :="数字4"
  ActionInfo_Arr["<Num5>"] :="数字5"
  ActionInfo_Arr["<Num6>"] :="数字6"
  ActionInfo_Arr["<Num7>"] :="数字7"
  ActionInfo_Arr["<Num8>"] :="数字8"
  ActionInfo_Arr["<Num9>"] :="数字9"
  ActionInfo_Arr["<Down>"] :="下方向"
  ActionInfo_Arr["<up>"] :="上方向"
  ActionInfo_Arr["<Left>"] :="左方向"
  ActionInfo_Arr["<Right>"] :="右方向"
  ActionInfo_Arr["<DownSelect>"] :="向下选择"
  ActionInfo_Arr["<UpSelect>"] :="向上选择"
  ActionInfo_Arr["<Home>"] :="转到首行，相当于Home键"
  ActionInfo_Arr["<End>"] :="转到未行，相当于End键"
  ActionInfo_Arr["<PageUp>"] :="向上翻页"
  ActionInfo_Arr["<PageDown>"] :="向下翻页"
  ActionInfo_Arr["<ForceDel>"] :="强制删除"
  ActionInfo_Arr["<Mark>"] :="标记功能，标记当前文件夹，使用'可以打开相应的标记"
  ActionInfo_Arr["<ListMark>"] :="显示所有标记（标记由m键的标记功能产生）与VIM相似"
  ActionInfo_Arr["<Internetsearch>"] :="使用默认浏览器搜索当前文件"
  ActionInfo_Arr["<azHistory>"] :="在文件夹历史加上前缀，方便用a-z导航"
  ActionInfo_Arr["<azCmdHistory>"] :="查看命令历史记录"
  ActionInfo_Arr["<ListMapKey>"] :="显示自定义映射键"
  ActionInfo_Arr["<WinMaxLeft>"] :="最大化左面板"
  ActionInfo_Arr["<WinMaxRight>"] :="最大化右面板"
  ActionInfo_Arr["<AlwayOnTop>"] :="TC窗口保持最前"
  ActionInfo_Arr["<TransParent>"] :="TC透明"
  ActionInfo_Arr["<DeleteLHistory>"] :="删除左侧文件夹历史"
  ActionInfo_Arr["<DeleteRHistory>"] :="删除右侧文件夹历史"
  ActionInfo_Arr["<DelCmdHistory>"] :="删除命令行历史"
  ActionInfo_Arr["<GoLastTab>"] :="转到最后一个标签"
  ActionInfo_Arr["<TCLite>"] :="最简化TC"
  ActionInfo_Arr["<TCFullScreen>"] :="TC全屏"
;TC自带命令"
  ActionInfo_Arr["<SrcComments>"] :="Source window: 显示文件备注"
  ActionInfo_Arr["<SrcShort>"] :="Source window: 列表"
  ActionInfo_Arr["<SrcLong>"] :="Source window: 详细信息"
  ActionInfo_Arr["<SrcTree>"] :="Source window: 文件夹树"
  ActionInfo_Arr["<SrcQuickview>"] :="Source window: 快速查看"
  ActionInfo_Arr["<VerticalPanels>"] :="纵向/横向排列"
  ActionInfo_Arr["<SrcQuickInternalOnly>"] :="Source window: 快速查看(不用插件)"
  ActionInfo_Arr["<SrcHideQuickview>"] :="Source window: 关闭快速查看窗口"
  ActionInfo_Arr["<SrcExecs>"] :="Source window: 可执行文件"
  ActionInfo_Arr["<SrcAllFiles>"] :="Source window: 所有文件"
  ActionInfo_Arr["<SrcUserSpec>"] :="Source window: 上次选中的文件"
  ActionInfo_Arr["<SrcUserDef>"] :="Source window: 自定义类型"
  ActionInfo_Arr["<SrcByName>"] :="Source window: 按文件名排序"
  ActionInfo_Arr["<SrcByExt>"] :="Source window: 按扩展名排序"
  ActionInfo_Arr["<SrcBySize>"] :="Source window: 按大小排序"
  ActionInfo_Arr["<SrcByDateTime>"] :="Source window: 按日期时间排序"
  ActionInfo_Arr["<SrcUnsorted>"] :="Source window: 不排序"
  ActionInfo_Arr["<SrcNegOrder>"] :="Source window: 反向排序"
  ActionInfo_Arr["<SrcOpenDrives>"] :="Source window: 打开驱动器列表"
  ActionInfo_Arr["<SrcThumbs>"] :="Source window: 缩略图"
  ActionInfo_Arr["<SrcCustomViewMenu>"] :="Source window: 自定义视图菜单"
  ActionInfo_Arr["<SrcPathFocus>"] :="Source window: 焦点置于路径上"
  ActionInfo_Arr["<LeftComments>"] :="左窗口: 显示文件备注"
  ActionInfo_Arr["<LeftShort>"] :="左窗口: 列表"
  ActionInfo_Arr["<LeftLong>"] :="左窗口: 详细信息"
  ActionInfo_Arr["<LeftTree>"] :="左窗口: 文件夹树"
  ActionInfo_Arr["<LeftQuickview>"] :="左窗口: 快速查看"
  ActionInfo_Arr["<LeftQuickInternalOnly>"] :="左窗口: 快速查看(不用插件)"
  ActionInfo_Arr["<LeftHideQuickview>"] :="左窗口: 关闭快速查看窗口"
  ActionInfo_Arr["<LeftExecs>"] :="左窗口: 可执行文件"
  ActionInfo_Arr["<LeftAllFiles>"] :="	左窗口: 所有文件"
  ActionInfo_Arr["<LeftUserSpec>"] :="左窗口: 上次选中的文件"
  ActionInfo_Arr["<LeftUserDef>"] :="左窗口: 自定义类型"
  ActionInfo_Arr["<LeftByName>"] :="左窗口: 按文件名排序"
  ActionInfo_Arr["<LeftByExt>"] :="左窗口: 按扩展名排序"
  ActionInfo_Arr["<LeftBySize>"] :="左窗口: 按大小排序"
  ActionInfo_Arr["<LeftByDateTime>"] :="左窗口: 按日期时间排序"
  ActionInfo_Arr["<LeftUnsorted>"] :="左窗口: 不排序"
  ActionInfo_Arr["<LeftNegOrder>"] :="左窗口: 反向排序"
  ActionInfo_Arr["<LeftOpenDrives>"] :="左窗口: 打开驱动器列表"
  ActionInfo_Arr["<LeftPathFocus>"] :="左窗口: 焦点置于路径上"
  ActionInfo_Arr["<LeftDirBranch>"] :="左窗口: 展开所有文件夹"
  ActionInfo_Arr["<LeftDirBranchSel>"] :="左窗口: 只展开选中的文件夹"
  ActionInfo_Arr["<LeftThumbs>"] :="窗口: 缩略图"
  ActionInfo_Arr["<LeftCustomViewMenu>"] :="窗口: 自定义视图菜单"
  ActionInfo_Arr["<RightComments>"] :="右窗口: 显示文件备注"
  ActionInfo_Arr["<RightShort>"] :="右窗口: 列表"
  ActionInfo_Arr["<RightLong>"] :="详细信息"
  ActionInfo_Arr["<RightTre>"] :="右窗口: 文件夹树"
  ActionInfo_Arr["<RightQuickvie>"] :="右窗口: 快速查看"
  ActionInfo_Arr["<RightQuickInternalOnl>"] :="右窗口: 快速查看(不用插件)"
  ActionInfo_Arr["<RightHideQuickvie>"] :="右窗口: 关闭快速查看窗口"
  ActionInfo_Arr["<RightExec>"] :="右窗口: 可执行文件"
  ActionInfo_Arr["<RightAllFile>"] :="右窗口: 所有文件"
  ActionInfo_Arr["<RightUserSpe>"] :="右窗口: 上次选中的文件"
  ActionInfo_Arr["<RightUserDe>"] :="右窗口: 自定义类型"
  ActionInfo_Arr["<RightByNam>"] :="右窗口: 按文件名排序"
  ActionInfo_Arr["<RightByEx>"] :="右窗口: 按扩展名排序"
  ActionInfo_Arr["<RightBySiz>"] :="右窗口: 按大小排序"
  ActionInfo_Arr["<RightByDateTim>"] :="右窗口: 按日期时间排序"
  ActionInfo_Arr["<RightUnsorte>"] :="右窗口: 不排序"
  ActionInfo_Arr["<RightNegOrde>"] :="右窗口: 反向排序"
  ActionInfo_Arr["<RightOpenDrive>"] :="右窗口: 打开驱动器列表"
  ActionInfo_Arr["<RightPathFocu>"] :="右窗口: 焦点置于路径上"
  ActionInfo_Arr["<RightDirBranch>"] :="右窗口: 展开所有文件夹"
  ActionInfo_Arr["<RightDirBranchSel>"] :="右窗口: 只展开选中的文件夹"
  ActionInfo_Arr["<RightThumb>"] :="右窗口: 缩略图"
  ActionInfo_Arr["<RightCustomViewMen>"] :="右窗口: 自定义视图菜单"
  ActionInfo_Arr["<Lis>"] :="查看(用查看程序)"
  ActionInfo_Arr["<ListInternalOnly>"] :="查看(用查看程序, 但不用插件/多媒体)"
  ActionInfo_Arr["<Edi>"] :="编辑"
  ActionInfo_Arr["<Copy>"] :="复制"
  ActionInfo_Arr["<CopySamepanel>"] :="复制到当前窗口"
  ActionInfo_Arr["<CopyOtherpanel>"] :="复制到另一窗口"
  ActionInfo_Arr["<RenMov>"] :="重命名/移动"
  ActionInfo_Arr["<MkDir>"] :="新建文件夹"
  ActionInfo_Arr["<Delete>"] :="删除"
  ActionInfo_Arr["<TestArchive>"] :="测试压缩包"
  ActionInfo_Arr["<PackFiles>"] :="压缩文件"
  ActionInfo_Arr["<UnpackFiles>"] :="解压文件"
  ActionInfo_Arr["<RenameOnly>"] :="重命名(Shift+F6)"
  ActionInfo_Arr["<RenameSingleFile>"] :="重命名当前文件"
  ActionInfo_Arr["<MoveOnly>"] :="移动(F6)"
  ActionInfo_Arr["<Properties>"] :="显示属性"
  ActionInfo_Arr["<CreateShortcut>"] :="创建快捷方式"
  ActionInfo_Arr["<Return>"] :="模仿按 ENTER 键"
  ActionInfo_Arr["<OpenAsUser>"] :="以其他用户身份运行光标处的程序"
  ActionInfo_Arr["<Split>"] :="分割文件"
  ActionInfo_Arr["<Combine>"] :="合并文件"
  ActionInfo_Arr["<Encode>"] :="编码文件(MIME/UUE/XXE 格式)"
  ActionInfo_Arr["<Decode>"] :="解码文件(MIME/UUE/XXE/BinHex 格式)"
  ActionInfo_Arr["<CRCcreate>"] :="创建校验文件"
  ActionInfo_Arr["<CRCcheck>"] :="验证校验和"
  ActionInfo_Arr["<SetAttrib>"] :="更改属性"
  ActionInfo_Arr["<Config>"] :="配置: 布局"
  ActionInfo_Arr["<DisplayConfig>"] :="配置: 显示"
  ActionInfo_Arr["<IconConfig>"] :="配置: 图标"
  ActionInfo_Arr["<FontConfig>"] :="配置: 字体"
  ActionInfo_Arr["<ColorConfig>"] :="配置: 颜色"
  ActionInfo_Arr["<ConfTabChange>"] :="配置: 制表符"
  ActionInfo_Arr["<DirTabsConfig>"] :="配置: 文件夹标签"
  ActionInfo_Arr["<CustomColumnConfig>"] :="配置: 自定义列"
  ActionInfo_Arr["<CustomColumnDlg>"] :="更改当前自定义列"
  ActionInfo_Arr["<LanguageConfig>"] :="配置: 语言"
  ActionInfo_Arr["<Config2>"] :="配置: 操作方式"
  ActionInfo_Arr["<EditConfig>"] :="配置: 编辑/查看"
  ActionInfo_Arr["<CopyConfig>"] :="配置: 复制/删除"
  ActionInfo_Arr["<RefreshConfig>"] :="配置: 刷新"
  ActionInfo_Arr["<QuickSearchConfig>"] :="配置: 快速搜索"
  ActionInfo_Arr["<FtpConfig>"] :="配置: FTP"
  ActionInfo_Arr["<PluginsConfig>"] :="配置: 插件"
  ActionInfo_Arr["<ThumbnailsConfig>"] :="配置: 缩略图"
  ActionInfo_Arr["<LogConfig>"] :="配置: 日志文件"
  ActionInfo_Arr["<IgnoreConfig>"] :="配置: 隐藏文件"
  ActionInfo_Arr["<PackerConfig>"] :="配置: 压缩程序"
  ActionInfo_Arr["<ZipPackerConfig>"] :="配置: ZIP 压缩程序"
  ActionInfo_Arr["<Confirmation>"] :="配置: 其他/确认"
  ActionInfo_Arr["<ConfigSavePos>"] :="保存位置"
  ActionInfo_Arr["<ButtonConfig>"] :="更改工具栏"
  ActionInfo_Arr["<ConfigSaveSettings>"] :="保存设置"
  ActionInfo_Arr["<ConfigChangeIniFiles>"] :="直接修改配置文件"
  ActionInfo_Arr["<ConfigSaveDirHistory>"] :="保存文件夹历史记录"
  ActionInfo_Arr["<ChangeStartMenu>"] :="更改开始菜单"
  ActionInfo_Arr["<NetConnect>"] :="映射网络驱动器"
  ActionInfo_Arr["<NetDisconnect>"] :="断开网络驱动器"
  ActionInfo_Arr["<NetShareDir>"] :="共享当前文件夹"
  ActionInfo_Arr["<NetUnshareDir>"] :="取消文件夹共享"
  ActionInfo_Arr["<AdministerServer>"] :="显示系统共享文件夹"
  ActionInfo_Arr["<ShowFileUser>"] :="显示本地文件的远程用户"
  ActionInfo_Arr["<GetFileSpace>"] :="计算占用空间"
  ActionInfo_Arr["<VolumeId>"] :="设置卷标"
  ActionInfo_Arr["<VersionInfo>"] :="版本信息"
  ActionInfo_Arr["<ExecuteDOS>"] :="打开命令提示符窗口"
  ActionInfo_Arr["<CompareDirs>"] :="比较文件夹"
  ActionInfo_Arr["<CompareDirsWithSubdirs>"] :="比较文件夹(同时标出另一窗口没有的子文件夹)"
  ActionInfo_Arr["<ContextMenu>"] :="显示快捷菜单"
  ActionInfo_Arr["<ContextMenuInternal>"] :="显示快捷菜单(内部关联)"
  ActionInfo_Arr["<ContextMenuInternalCursor>"] :="显示光标处文件的内部关联快捷菜单"
  ActionInfo_Arr["<ShowRemoteMenu>"] :="媒体中心遥控器播放/暂停键快捷菜单"
  ActionInfo_Arr["<SyncChangeDir>"] :="两边窗口同步更改文件夹"
  ActionInfo_Arr["<EditComment>"] :="编辑文件备注"
  ActionInfo_Arr["<FocusLeft>"] :="焦点置于左窗口"
  ActionInfo_Arr["<FocusRight>"] :="焦点置于右窗口"
  ActionInfo_Arr["<FocusCmdLine>"] :="焦点置于命令行"
  ActionInfo_Arr["<FocusButtonBar>"] :="焦点置于工具栏"
  ActionInfo_Arr["<CountDirContent>"] :="计算所有文件夹占用的空间"
  ActionInfo_Arr["<UnloadPlugins>"] :="卸载所有插件"
  ActionInfo_Arr["<DirMatch>"] :="标出新文件, 隐藏相同者"
  ActionInfo_Arr["<Exchange>"] :="交换左右窗口"
  ActionInfo_Arr["<MatchSrc>"] :="目标 = 来源"
  ActionInfo_Arr["<ReloadSelThumbs>"] :="刷新选中文件的缩略图"
  ActionInfo_Arr["<DirectCableConnect>"] :="直接电缆连接"
  ActionInfo_Arr["<NTinstallDriver>"] :="加载 NT 并口驱动程序"
  ActionInfo_Arr["<NTremoveDriver>"] :="卸载 NT 并口驱动程序"
  ActionInfo_Arr["<PrintDir>"] :="打印文件列表"
  ActionInfo_Arr["<PrintDirSub>"] :="打印文件列表(含子文件夹)"
  ActionInfo_Arr["<PrintFile>"] :="打印文件内容"
  ActionInfo_Arr["<SpreadSelection>"] :="选择一组文件"
  ActionInfo_Arr["<SelectBoth>"] :="选择一组: 文件和文件夹"
  ActionInfo_Arr["<SelectFiles>"] :="选择一组: 仅文件"
  ActionInfo_Arr["<SelectFolders>"] :="选择一组: 仅文件夹"
  ActionInfo_Arr["<ShrinkSelection>"] :="不选一组文件"
  ActionInfo_Arr["<ClearFiles>"] :="不选一组: 仅文件"
  ActionInfo_Arr["<ClearFolders>"] :="不选一组: 仅文件夹"
  ActionInfo_Arr["<ClearSelCfg>"] :="不选一组: 文件和/或文件夹(视配置而定)"
  ActionInfo_Arr["<SelectAll>"] :="全部选择: 文件和/或文件夹(视配置而定)"
  ActionInfo_Arr["<SelectAllBoth>"] :="全部选择: 文件和文件夹"
  ActionInfo_Arr["<SelectAllFiles>"] :="全部选择: 仅文件"
  ActionInfo_Arr["<SelectAllFolders>"] :="全部选择: 仅文件夹"
  ActionInfo_Arr["<ClearAll>"] :="全部取消: 文件和文件夹"
  ActionInfo_Arr["<ClearAllFiles>"] :="全部取消: 仅文件"
  ActionInfo_Arr["<ClearAllFolders>"] :="全部取消: 仅文件夹"
  ActionInfo_Arr["<ClearAllCfg>"] :="全部取消: 文件和/或文件夹(视配置而定)"
  ActionInfo_Arr["<ExchangeSelection>"] :="反向选择"
  ActionInfo_Arr["<ExchangeSelBoth>"] :="反向选择: 文件和文件夹"
  ActionInfo_Arr["<ExchangeSelFiles>"] :="反向选择: 仅文件"
  ActionInfo_Arr["<ExchangeSelFolders>"] :="反向选择: 仅文件夹"
  ActionInfo_Arr["<SelectCurrentExtension>"] :="选择扩展名相同的文件"
  ActionInfo_Arr["<UnselectCurrentExtension>"] :="不选扩展名相同的文件"
  ActionInfo_Arr["<SelectCurrentName>"] :="选择文件名相同的文件"
  ActionInfo_Arr["<UnselectCurrentName>"] :="不选文件名相同的文件"
  ActionInfo_Arr["<SelectCurrentNameExt>"] :="选择文件名和扩展名相同的文件"
  ActionInfo_Arr["<UnselectCurrentNameExt>"] :="不选文件名和扩展名相同的文件"
  ActionInfo_Arr["<SelectCurrentPath>"] :="选择同一路径下的文件(展开文件夹+搜索文件)"
  ActionInfo_Arr["<UnselectCurrentPath>"] :="不选同一路径下的文件(展开文件夹+搜索文件)"
  ActionInfo_Arr["<RestoreSelection>"] :="恢复选择列表"
  ActionInfo_Arr["<SaveSelection>"] :="保存选择列表"
  ActionInfo_Arr["<SaveSelectionToFile>"] :="导出选择列表"
  ActionInfo_Arr["<SaveSelectionToFileA>"] :="导出选择列表(ANSI)"
  ActionInfo_Arr["<SaveSelectionToFileW>"] :="导出选择列表(Unicode)"
  ActionInfo_Arr["<SaveDetailsToFile>"] :="导出详细信息"
  ActionInfo_Arr["<SaveDetailsToFileA>"] :="导出详细信息(ANSI)"
  ActionInfo_Arr["<SaveDetailsToFileW>"] :="导出详细信息(Unicode)"
  ActionInfo_Arr["<LoadSelectionFromFile>"] :="导入选择列表(从文件)"
  ActionInfo_Arr["<LoadSelectionFromClip>"] :="导入选择列表(从剪贴板)"
  ActionInfo_Arr["<EditPermissionInfo>"] :="设置权限(NTFS)"
  ActionInfo_Arr["<EditAuditInfo>"] :="审核文件(NTFS)"
  ActionInfo_Arr["<EditOwnerInfo>"] :="获取所有权(NTFS)"
  ActionInfo_Arr["<CutToClipboard>"] :="剪切选中的文件到剪贴板"
  ActionInfo_Arr["<CopyToClipboard>"] :="复制选中的文件到剪贴板"
  ActionInfo_Arr["<PasteFromClipboard>"] :="从剪贴板粘贴到当前文件夹"
  ActionInfo_Arr["<CopyNamesToClip>"] :="复制文件名"
  ActionInfo_Arr["<CopyFullNamesToClip>"] :="复制文件名及完整路径"
  ActionInfo_Arr["<CopyNetNamesToClip>"] :="复制文件名及网络路径"
  ActionInfo_Arr["<CopySrcPathToClip>"] :="复制来源路径"
  ActionInfo_Arr["<CopyTrgPathToClip>"] :="复制目标路径"
  ActionInfo_Arr["<CopyFileDetailsToClip>"] :="复制文件详细信息"
  ActionInfo_Arr["<CopyFpFileDetailsToClip>"] :="复制文件详细信息及完整路径"
  ActionInfo_Arr["<CopyNetFileDetailsToClip>"] :="复制文件详细信息及网络路径"
  ActionInfo_Arr["<FtpConnect>"] :="FTP 连接"
  ActionInfo_Arr["<FtpNew>"] :="新建 FTP 连接"
  ActionInfo_Arr["<FtpDisconnect>"] :="断开 FTP 连接"
  ActionInfo_Arr["<FtpHiddenFiles>"] :="显示隐藏文件"
  ActionInfo_Arr["<FtpAbort>"] :="中止当前 FTP 命令"
  ActionInfo_Arr["<FtpResumeDownload>"] :="续传"
  ActionInfo_Arr["<FtpSelectTransferMode>"] :="选择传输模式"
  ActionInfo_Arr["<FtpAddToList>"] :="添加到下载列表"
  ActionInfo_Arr["<FtpDownloadList>"] :="按列表下载"
  ActionInfo_Arr["<GotoPreviousDir>"] :="后退"
  ActionInfo_Arr["<GotoNextDir>"] :="前进"
  ActionInfo_Arr["<DirectoryHistory>"] :="文件夹历史记录"
  ActionInfo_Arr["<GotoPreviousLocalDir>"] :="后退(非 FTP)"
  ActionInfo_Arr["<GotoNextLocalDir>"] :="前进(非 FTP)"
  ActionInfo_Arr["<DirectoryHotlist>"] :="常用文件夹"
  ActionInfo_Arr["<GoToRoot>"] :="转到根文件夹"
  ActionInfo_Arr["<GoToParent>"] :="转到上层文件夹"
  ActionInfo_Arr["<GoToDir>"] :="打开光标处的文件夹或压缩包"
  ActionInfo_Arr["<OpenDesktop>"] :="桌面"
  ActionInfo_Arr["<OpenDrives>"] :="我的电脑"
  ActionInfo_Arr["<OpenControls>"] :="控制面板"
  ActionInfo_Arr["<OpenFonts>"] :="字体"
  ActionInfo_Arr["<OpenNetwork>"] :="网上邻居"
  ActionInfo_Arr["<OpenPrinters>"] :="打印机"
  ActionInfo_Arr["<OpenRecycled>"] :="回收站"
  ActionInfo_Arr["<CDtree>"] :="更改文件夹"
  ActionInfo_Arr["<TransferLeft>"] :="在左窗口打开光标处的文件夹或压缩包"
  ActionInfo_Arr["<TransferRight>"] :="在右窗口打开光标处的文件夹或压缩包"
  ActionInfo_Arr["<EditPath>"] :="编辑来源窗口的路径"
  ActionInfo_Arr["<GoToFirstFile>"] :="光标移到列表中的第一个文件"
  ActionInfo_Arr["<GotoNextDrive>"] :="转到下一个驱动器"
  ActionInfo_Arr["<GotoPreviousDrive>"] :="转到上一个驱动器"
  ActionInfo_Arr["<GotoNextSelected>"] :="转到下一个选中的文件"
  ActionInfo_Arr["<GotoPrevSelected>"] :="转到上一个选中的文件"
  ActionInfo_Arr["<GotoDriveA>"] :="转到驱动器 A"
  ActionInfo_Arr["<GotoDriveC>"] :="转到驱动器 C"
  ActionInfo_Arr["<GotoDriveD>"] :="转到驱动器 D"
  ActionInfo_Arr["<GotoDriveE>"] :="转到驱动器 E"
  ActionInfo_Arr["<GotoDriveF>"] :="可自定义其他驱动器"
  ActionInfo_Arr["<GotoDriveZ>"] :="最多 26 个"
  ActionInfo_Arr["<HelpIndex>"] :="帮助索引"
  ActionInfo_Arr["<Keyboard>"] :="快捷键列表"
  ActionInfo_Arr["<Register>"] :="注册信息"
  ActionInfo_Arr["<VisitHomepage>"] :="访问 Totalcmd 网站"
  ActionInfo_Arr["<About>"] :="关于 Total Commander"
  ActionInfo_Arr["<Exit>"] :="退出 Total Commander"
  ActionInfo_Arr["<Minimize>"] :="最小化 Total Commander"
  ActionInfo_Arr["<Maximize>"] :="最大化 Total Commander"
  ActionInfo_Arr["<Restore>"] :="恢复正常大小"
  ActionInfo_Arr["<ClearCmdLine>"] :="清除命令行"
  ActionInfo_Arr["<NextCommand>"] :="下一条命令"
  ActionInfo_Arr["<PrevCommand>"] :="上一条命令"
  ActionInfo_Arr["<AddPathToCmdline>"] :="将路径复制到命令行"
  ActionInfo_Arr["<MultiRenameFiles>"] :="批量重命名"
  ActionInfo_Arr["<SysInfo>"] :="系统信息"
  ActionInfo_Arr["<OpenTransferManager>"] :="后台传输管理器"
  ActionInfo_Arr["<SearchFor>"] :="搜索文件"
  ActionInfo_Arr["<FileSync>"] :="同步文件夹"
  ActionInfo_Arr["<Associate>"] :="文件关联"
  ActionInfo_Arr["<InternalAssociate>"] :="定义内部关联"
  ActionInfo_Arr["<CompareFilesByContent>"] :="比较文件内容"
  ActionInfo_Arr["<IntCompareFilesByContent>"] :="使用内部比较程序"
  ActionInfo_Arr["<CommandBrowser>"] :="浏览内部命令"
  ActionInfo_Arr["<VisButtonbar>"] :="显示/隐藏: 工具栏"
  ActionInfo_Arr["<VisDriveButtons>"] :="显示/隐藏: 驱动器按钮"
  ActionInfo_Arr["<VisTwoDriveButtons>"] :="显示/隐藏: 两个驱动器按钮栏"
  ActionInfo_Arr["<VisFlatDriveButtons>"] :="切换: 平坦/立体驱动器按钮"
  ActionInfo_Arr["<VisFlatInterface>"] :="切换: 平坦/立体用户界面"
  ActionInfo_Arr["<VisDriveCombo>"] :="显示/隐藏: 驱动器列表"
  ActionInfo_Arr["<VisCurDir>"] :="显示/隐藏: 当前文件夹"
  ActionInfo_Arr["<VisBreadCrumbs>"] :="显示/隐藏: 路径导航栏"
  ActionInfo_Arr["<VisTabHeader>"] :="显示/隐藏: 排序制表符"
  ActionInfo_Arr["<VisStatusbar>"] :="显示/隐藏: 状态栏"
  ActionInfo_Arr["<VisCmdLine>"] :="显示/隐藏: 命令行"
  ActionInfo_Arr["<VisKeyButtons>"] :="显示/隐藏: 功能键按钮"
  ActionInfo_Arr["<ShowHint>"] :="显示文件提示"
  ActionInfo_Arr["<ShowQuickSearch>"] :="显示快速搜索窗口"
  ActionInfo_Arr["<SwitchLongNames>"] :="开启/关闭: 长文件名显示"
  ActionInfo_Arr["<RereadSource>"] :="刷新来源窗口"
  ActionInfo_Arr["<ShowOnlySelected>"] :="仅显示选中的文件"
  ActionInfo_Arr["<SwitchHidSys>"] :="开启/关闭: 隐藏或系统文件显示"
  ActionInfo_Arr["<Switch83Names>"] :="开启/关闭: 8.3 式文件名小写显示"
  ActionInfo_Arr["<SwitchDirSort>"] :="开启/关闭: 文件夹按名称排序"
  ActionInfo_Arr["<DirBranch>"] :="展开所有文件夹"
  ActionInfo_Arr["<DirBranchSel>"] :="只展开选中的文件夹"
  ActionInfo_Arr["<50Percent>"] :="Window divider bar located 50%"
  ActionInfo_Arr["<100Percent>"] :="Window divider bar located 100%"
  ActionInfo_Arr["<VisDirTabs>"] :="显示/隐藏: 文件夹标签"
  ActionInfo_Arr["<VisXPThemeBackground>"] :="显示/隐藏: XP 主题背景"
  ActionInfo_Arr["<SwitchOverlayIcons>"] :="开启/关闭: 叠置图标显示"
  ActionInfo_Arr["<VisHistHotButtons>"] :="显示/隐藏: 文件夹历史记录和常用文件夹按钮"
  ActionInfo_Arr["<SwitchWatchDirs>"] :="启用/禁用: 文件夹自动刷新"
  ActionInfo_Arr["<SwitchIgnoreList>"] :="启用/禁用: 自定义隐藏文件"
  ActionInfo_Arr["<SwitchX64Redirection>"] :="开启/关闭: 32 位 system32 目录重定向(64 位 Windows)"
  ActionInfo_Arr["<SeparateTreeOff>"] :="关闭独立文件夹树面板"
  ActionInfo_Arr["<SeparateTree1>"] :="一个独立文件夹树面板"
  ActionInfo_Arr["<SeparateTree2>"] :="两个独立文件夹树面板"
  ActionInfo_Arr["<SwitchSeparateTree>"] :="切换独立文件夹树面板状态"
  ActionInfo_Arr["<ToggleSeparateTree1>"] :="开启/关闭: 一个独立文件夹树面板"
  ActionInfo_Arr["<ToggleSeparateTree2>"] :="开启/关闭: 两个独立文件夹树面板"
  ActionInfo_Arr["<UserMenu1>"] :="用户菜单 1"
  ActionInfo_Arr["<UserMenu2>"] :="用户菜单 2"
  ActionInfo_Arr["<UserMenu3>"] :="用户菜单 3"
  ActionInfo_Arr["<UserMenu4>"] :="..."
  ActionInfo_Arr["<UserMenu5>"] :="5"
  ActionInfo_Arr["<UserMenu6>"] :="6"
  ActionInfo_Arr["<UserMenu7>"] :="7"
  ActionInfo_Arr["<UserMenu8>"] :="8"
  ActionInfo_Arr["<UserMenu9>"] :="9"
  ActionInfo_Arr["<UserMenu10>"] :="可定义其他用户菜单"
  ActionInfo_Arr["<OpenNewTab>"] :="新建标签"
  ActionInfo_Arr["<OpenNewTabBg>"] :="新建标签(在后台)"
  ActionInfo_Arr["<OpenDirInNewTab>"] :="新建标签(并打开光标处的文件夹)"
  ActionInfo_Arr["<OpenDirInNewTabOther>"] :="新建标签(在另一窗口打开文件夹)"
  ActionInfo_Arr["<SwitchToNextTab>"] :="下一个标签(Ctrl+Tab)"
  ActionInfo_Arr["<SwitchToPreviousTab>"] :="上一个标签(Ctrl+Shift+Tab)"
  ActionInfo_Arr["<CloseCurrentTab>"] :="关闭当前标签"
  ActionInfo_Arr["<CloseAllTabs>"] :="关闭所有标签"
  ActionInfo_Arr["<DirTabsShowMenu>"] :="显示标签菜单"
  ActionInfo_Arr["<ToggleLockCurrentTab>"] :="锁定/解锁当前标签"
  ActionInfo_Arr["<ToggleLockDcaCurrentTab>"] :="锁定/解锁当前标签(可更改文件夹)"
  ActionInfo_Arr["<ExchangeWithTabs>"] :="交换左右窗口及其标签"
  ActionInfo_Arr["<GoToLockedDir>"] :="转到锁定标签的根文件夹"
  ActionInfo_Arr["<SrcActivateTab1>"] :="Source window: 激活标签 1"
  ActionInfo_Arr["<SrcActivateTab2>"] :="Source window: 激活标签 2"
  ActionInfo_Arr["<SrcActivateTab3>"] :="..."
  ActionInfo_Arr["<SrcActivateTab4>"] :="最多 99 个"
  ActionInfo_Arr["<SrcActivateTab5>"] :="5"
  ActionInfo_Arr["<SrcActivateTab6>"] :="6"
  ActionInfo_Arr["<SrcActivateTab7>"] :="7"
  ActionInfo_Arr["<SrcActivateTab8>"] :="8"
  ActionInfo_Arr["<SrcActivateTab9>"] :="9"
  ActionInfo_Arr["<SrcActivateTab10>"] :="0"
  ActionInfo_Arr["<TrgActivateTab1>"] :="目标窗口: 激活标签 1"
  ActionInfo_Arr["<TrgActivateTab2>"] :="目标窗口: 激活标签 2"
  ActionInfo_Arr["<TrgActivateTab3>"] :="..."
  ActionInfo_Arr["<TrgActivateTab4>"] :="最多 99 个"
  ActionInfo_Arr["<TrgActivateTab5>"] :="5"
  ActionInfo_Arr["<TrgActivateTab6>"] :="6"
  ActionInfo_Arr["<TrgActivateTab7>"] :="7"
  ActionInfo_Arr["<TrgActivateTab8>"] :="8"
  ActionInfo_Arr["<TrgActivateTab9>"] :="9"
  ActionInfo_Arr["<TrgActivateTab10>"] :="0"
  ActionInfo_Arr["<LeftActivateTab1>"] :="左窗口: 激活标签 1"
  ActionInfo_Arr["<LeftActivateTab2>"] :="左窗口: 激活标签 2"
  ActionInfo_Arr["<LeftActivateTab3>"] :="..."
  ActionInfo_Arr["<LeftActivateTab4>"] :="最多 99 个"
  ActionInfo_Arr["<LeftActivateTab5>"] :="5"
  ActionInfo_Arr["<LeftActivateTab6>"] :="6"
  ActionInfo_Arr["<LeftActivateTab7>"] :="7"
  ActionInfo_Arr["<LeftActivateTab8>"] :="8"
  ActionInfo_Arr["<LeftActivateTab9>"] :="9"
  ActionInfo_Arr["<LeftActivateTab10>"] :="0"
  ActionInfo_Arr["<RightActivateTab1>"] :="右窗口: 激活标签 1"
  ActionInfo_Arr["<RightActivateTab2>"] :="右窗口: 激活标签 2"
  ActionInfo_Arr["<RightActivateTab3>"] :="..."
  ActionInfo_Arr["<RightActivateTab4>"] :="最多 99 个"
  ActionInfo_Arr["<RightActivateTab5>"] :="5"
  ActionInfo_Arr["<RightActivateTab6>"] :="6"
  ActionInfo_Arr["<RightActivateTab7>"] :="7"
  ActionInfo_Arr["<RightActivateTab8>"] :="8"
  ActionInfo_Arr["<RightActivateTab9>"] :="9"
  ActionInfo_Arr["<RightActivateTab10>"] :="0"
  ActionInfo_Arr["<SrcSortByCol1>"] :="Source window: 按第 1 列排序"
  ActionInfo_Arr["<SrcSortByCol2>"] :="Source window: 按第 2 列排序"
  ActionInfo_Arr["<SrcSortByCol3>"] :="..."
  ActionInfo_Arr["<SrcSortByCol4>"] :="最多 99 列"
  ActionInfo_Arr["<SrcSortByCol5>"] :="5"
  ActionInfo_Arr["<SrcSortByCol6>"] :="6"
  ActionInfo_Arr["<SrcSortByCol7>"] :="7"
  ActionInfo_Arr["<SrcSortByCol8>"] :="8"
  ActionInfo_Arr["<SrcSortByCol9>"] :="9"
  ActionInfo_Arr["<SrcSortByCol10>"] :="0"
  ActionInfo_Arr["<SrcSortByCol99>"] :="9"
  ActionInfo_Arr["<TrgSortByCol1>"] :="目标窗口: 按第 1 列排序"
  ActionInfo_Arr["<TrgSortByCol2>"] :="目标窗口: 按第 2 列排序"
  ActionInfo_Arr["<TrgSortByCol3>"] :="..."
  ActionInfo_Arr["<TrgSortByCol4>"] :="最多 99 列"
  ActionInfo_Arr["<TrgSortByCol5>"] :="5"
  ActionInfo_Arr["<TrgSortByCol6>"] :="6"
  ActionInfo_Arr["<TrgSortByCol7>"] :="7"
  ActionInfo_Arr["<TrgSortByCol8>"] :="8"
  ActionInfo_Arr["<TrgSortByCol9>"] :="9"
  ActionInfo_Arr["<TrgSortByCol10>"] :="0"
  ActionInfo_Arr["<TrgSortByCol99>"] :="9"
  ActionInfo_Arr["<LeftSortByCol1>"] :="左窗口: 按第 1 列排序"
  ActionInfo_Arr["<LeftSortByCol2>"] :="左窗口: 按第 2 列排序"
  ActionInfo_Arr["<LeftSortByCol3>"] :="..."
  ActionInfo_Arr["<LeftSortByCol4>"] :="最多 99 列"
  ActionInfo_Arr["<LeftSortByCol5>"] :="5"
  ActionInfo_Arr["<LeftSortByCol6>"] :="6"
  ActionInfo_Arr["<LeftSortByCol7>"] :="7"
  ActionInfo_Arr["<LeftSortByCol8>"] :="8"
  ActionInfo_Arr["<LeftSortByCol9>"] :="9"
  ActionInfo_Arr["<LeftSortByCol10>"] :="0"
  ActionInfo_Arr["<LeftSortByCol99>"] :="9"
  ActionInfo_Arr["<RightSortByCol1>"] :="右窗口: 按第 1 列排序"
  ActionInfo_Arr["<RightSortByCol2>"] :="右窗口: 按第 2 列排序"
  ActionInfo_Arr["<RightSortByCol3>"] :="..."
  ActionInfo_Arr["<RightSortByCol4>"] :="最多 99 列"
  ActionInfo_Arr["<RightSortByCol5>"] :="5"
  ActionInfo_Arr["<RightSortByCol6>"] :="6"
  ActionInfo_Arr["<RightSortByCol7>"] :="7"
  ActionInfo_Arr["<RightSortByCol8>"] :="8"
  ActionInfo_Arr["<RightSortByCol9>"] :="9"
  ActionInfo_Arr["<RightSortByCol10>"] :="0"
  ActionInfo_Arr["<RightSortByCol99>"] :="9"
  ActionInfo_Arr["<SrcCustomView1>"] :="Source window: 自定义列视图 1"
  ActionInfo_Arr["<SrcCustomView2>"] :="Source window: 自定义列视图 2"
  ActionInfo_Arr["<SrcCustomView3>"] :="..."
  ActionInfo_Arr["<SrcCustomView4>"] :="最多 29 个"
  ActionInfo_Arr["<SrcCustomView5>"] :="5"
  ActionInfo_Arr["<SrcCustomView6>"] :="6"
  ActionInfo_Arr["<SrcCustomView7>"] :="7"
  ActionInfo_Arr["<SrcCustomView8>"] :="8"
  ActionInfo_Arr["<SrcCustomView9>"] :="9"
  ActionInfo_Arr["<LeftCustomView1>"] :="左窗口: 自定义列视图 1"
  ActionInfo_Arr["<LeftCustomView2>"] :="左窗口: 自定义列视图 2"
  ActionInfo_Arr["<LeftCustomView3>"] :="..."
  ActionInfo_Arr["<LeftCustomView4>"] :="最多 29 个"
  ActionInfo_Arr["<LeftCustomView5>"] :="5"
  ActionInfo_Arr["<LeftCustomView6>"] :="6"
  ActionInfo_Arr["<LeftCustomView7>"] :="7"
  ActionInfo_Arr["<LeftCustomView8>"] :="8"
  ActionInfo_Arr["<LeftCustomView9>"] :="9"
  ActionInfo_Arr["<RightCustomView1>"] :="右窗口: 自定义列视图 1"
  ActionInfo_Arr["<RightCustomView2>"] :="右窗口: 自定义列视图 2"
  ActionInfo_Arr["<RightCustomView3>"] :="..."
  ActionInfo_Arr["<RightCustomView4>"] :="最多 29 个"
  ActionInfo_Arr["<RightCustomView5>"] :="5"
  ActionInfo_Arr["<RightCustomView6>"] :="6"
  ActionInfo_Arr["<RightCustomView7>"] :="7"
  ActionInfo_Arr["<RightCustomView8>"] :="8"
  ActionInfo_Arr["<RightCustomView9>"] :="9"
  ActionInfo_Arr["<SrcNextCustomView>"] :="Source window: 下一个自定义视图"
  ActionInfo_Arr["<SrcPrevCustomView>"] :="Source window: 上一个自定义视图"
  ActionInfo_Arr["<TrgNextCustomView>"] :="目标窗口: 下一个自定义视图"
  ActionInfo_Arr["<TrgPrevCustomView>"] :="目标窗口: 上一个自定义视图"
  ActionInfo_Arr["<LeftNextCustomView>"] :="左窗口: 下一个自定义视图"
  ActionInfo_Arr["<LeftPrevCustomView>"] :="左窗口: 上一个自定义视图"
  ActionInfo_Arr["<RightNextCustomView>"] :="右窗口: 下一个自定义视图"
  ActionInfo_Arr["<RightPrevCustomView>"] :="右窗口: 上一个自定义视图"
  ActionInfo_Arr["<LoadAllOnDemandFields>"] :="所有文件都按需加载备注"
  ActionInfo_Arr["<LoadSelOnDemandFields>"] :="仅选中的文件按需加载备注"
  ActionInfo_Arr["<ContentStopLoadFields>"] :="停止后台加载备注"
}
; TC自带命令 {{{1
;Source window ==使用VIM下的VOom 插件可以很方便的查看===
;Source window =========================================
;Source window =========================================
;<SrcComments>: >>Source window: 显示文件备注{{{2
<SrcComments>:
	SendPos(300)
Return
;<SrcShort>: >>Source window: 列表{{{2
<SrcShort>:
	SendPos(301)
Return
;<SrcLong>: >>Source window: 详细信息{{{2
<SrcLong>:
	SendPos(302)
Return
;<SrcTree>: >>Source window: 文件夹树{{{2
<SrcTree>:
	SendPos(303)
;<SrcQuickview>: >>Source window: 快速查看{{{2
<SrcQuickview>:
	SendPos(304)
Return
;<VerticalPanels>: >>纵向排列{{{2
<VerticalPanels>:
	SendPos(305)
Return
;<SrcQuickInternalOnly>: >>Source window: 快速查看(不用插件){{{2
<SrcQuickInternalOnly>:
	SendPos(306)
Return
;<SrcHideQuickview>: >>Source window: 关闭快速查看窗口{{{2
<SrcHideQuickview>:
	SendPos(307)
Return
;<SrcExecs>: >>Source window: 可执行文件{{{2
<SrcExecs>:
	SendPos(311)
Return
;<SrcAllFiles>: >>Source window: 所有文件{{{2
<SrcAllFiles>:
	SendPos(312)
Return
;<SrcUserSpec>: >>Source window: 上次选中的文件{{{2
<SrcUserSpec>:
	SendPos(313)
Return
;<SrcUserDef>: >>Source window: 自定义类型{{{2
<SrcUserDef>:
	SendPos(314)
Return
;<SrcByName>: >>Source window: 按文件名排序{{{2
<SrcByName>:
	SendPos(321)
Return
;<SrcByExt>: >>Source window: 按扩展名排序{{{2
<SrcByExt>:
	SendPos(322)
Return
;<SrcBySize>: >>Source window: 按大小排序{{{2
<SrcBySize>:
	SendPos(323)
Return
;<SrcByDateTime>: >>Source window: 按日期时间排序{{{2
<SrcByDateTime>:
	SendPos(324)
Return
;<SrcUnsorted>: >>Source window: 不排序{{{2
<SrcUnsorted>:
	SendPos(325)
Return
;<SrcNegOrder>: >>Source window: 反向排序{{{2
<SrcNegOrder>:
	SendPos(330)
Return
;<SrcOpenDrives>: >>Source window: 打开驱动器列表{{{2
<SrcOpenDrives>:
	SendPos(331)
Return
;<SrcThumbs>: >>Source window: 缩略图{{{2
<SrcThumbs>:
	SendPos(269	)
Return
;<SrcCustomViewMenu>: >>Source window: 自定义视图菜单{{{2
<SrcCustomViewMenu>:
	SendPos(270)
Return
;<SrcPathFocus>: >>Source window: 焦点置于路径上{{{2
<SrcPathFocus>:
	SendPos(332)
Return
;左窗口 ========================================4
;左窗口 =========================================
;左窗口 =========================================
Return
;<LeftComments>: >>左窗口: 显示文件备注{{{2
<LeftComments>:
	SendPos(100)
Return
;<LeftShort>: >>左窗口: 列表{{{2
<LeftShort>:
	SendPos(101)
Return
;<LeftLong>: >>左窗口: 详细信息{{{2
<LeftLong>:
	SendPos(102)
Return
;<LeftTree>: >>左窗口: 文件夹树{{{2
<LeftTree>:
	SendPos(103)
Return
;<LeftQuickview>: >>左窗口: 快速查看{{{2
<LeftQuickview>:
	SendPos(104)
Return
;<LeftQuickInternalOnly>: >>左窗口: 快速查看(不用插件){{{2
<LeftQuickInternalOnly>:
	SendPos(106)
Return
;<LeftHideQuickview>: >>左窗口: 关闭快速查看窗口{{{2
<LeftHideQuickview>:
	SendPos(107)
Return
;<LeftExecs>: >>左窗口: 可执行文件{{{2
<LeftExecs>:
	SendPos(111)
Return
;<LeftAllFiles>: >>	左窗口: 所有文件{{{2
<LeftAllFiles>:
	SendPos(112)
Return
;<LeftUserSpec>: >>左窗口: 上次选中的文件{{{2
<LeftUserSpec>:
	SendPos(113)
Return
;<LeftUserDef>: >>左窗口: 自定义类型{{{2
<LeftUserDef>:
	SendPos(114)
Return
;<LeftByName>: >>左窗口: 按文件名排序{{{2
<LeftByName>:
	SendPos(121)
Return
;<LeftByExt>: >>左窗口: 按扩展名排序{{{2
<LeftByExt>:
	SendPos(122)
Return
;<LeftBySize>: >>左窗口: 按大小排序{{{2
<LeftBySize>:
	SendPos(123)
Return
;<LeftByDateTime>: >>左窗口: 按日期时间排序{{{2
<LeftByDateTime>:
	SendPos(124)
Return
;<LeftUnsorted>: >>左窗口: 不排序{{{2
<LeftUnsorted>:
	SendPos(125)
Return
;<LeftNegOrder>: >>左窗口: 反向排序{{{2
<LeftNegOrder>:
	SendPos(130)
Return
;<LeftOpenDrives>: >>左窗口: 打开驱动器列表{{{2
<LeftOpenDrives>:
	SendPos(131)
Return
;<LeftPathFocus>: >>左窗口: 焦点置于路径上{{{2
<LeftPathFocus>:
	SendPos(132)
Return
;<LeftDirBranch>: >>左窗口: 展开所有文件夹{{{2
<LeftDirBranch>:
	SendPos(203)
Return
;<LeftDirBranchSel>: >>	左窗口: 只展开选中的文件夹{{{2
<LeftDirBranchSel>:
	SendPos(204)
Return
;<LeftThumbs>: >>窗口: 缩略图{{{2
<LeftThumbs>:
	SendPos(69)
Return
;<LeftCustomViewMenu>: >>	窗口: 自定义视图菜单{{{2
<LeftCustomViewMenu>:
	SendPos(70)
Return
;右窗口 ========================================4
;右窗口 =========================================
;右窗口 =========================================
Return
;<RightComments>: >>右窗口: 显示文件备注{{{2
<RightComments>:
	SendPos(200)
Return
;<RightShort>: >>右窗口: 列表{{{2
<RightShort>:
	SendPos(201)
Return
;<RightLong>: >> 详细信息{{{2
<RightLong>:
	SendPos(202)
Return
;<RightTre>: >>	右窗口: 文件夹树{{{2
<RightTre>:
		SendPos(203)
Return
;<RightQuickvie>: >>	右窗口: 快速查看{{{2
<RightQuickvie>:
		SendPos(204)
Return
;<RightQuickInternalOnl>: >>	右窗口: 快速查看(不用插件){{{2
<RightQuickInternalOnl>:
		SendPos(206)
Return
;<RightHideQuickvie>: >>	右窗口: 关闭快速查看窗口{{{2
<RightHideQuickvie>:
		SendPos(207)
Return
;<RightExec>: >>	右窗口: 可执行文件{{{2
<RightExec>:
		SendPos(211)
Return
;<RightAllFile>: >>	右窗口: 所有文件{{{2
<RightAllFile>:
		SendPos(212)
Return
;<RightUserSpe>: >>	右窗口: 上次选中的文件{{{2
<RightUserSpe>:
		SendPos(213)
Return
;<RightUserDe>: >>	右窗口: 自定义类型{{{2
<RightUserDe>:
		SendPos(214)
Return
;<RightByNam>: >>	右窗口: 按文件名排序{{{2
<RightByNam>:
		SendPos(221)
Return
;<RightByEx>: >>	右窗口: 按扩展名排序{{{2
<RightByEx>:
		SendPos(222)
Return
;<RightBySiz>: >>	右窗口: 按大小排序{{{2
<RightBySiz>:
		SendPos(223)
Return
;<RightByDateTim>: >>	右窗口: 按日期时间排序{{{2
<RightByDateTim>:
		SendPos(224)
Return
;<RightUnsorte>: >>	右窗口: 不排序{{{2
<RightUnsorte>:
		SendPos(225)
Return
;<RightNegOrde>: >>	右窗口: 反向排序{{{2
<RightNegOrde>:
		SendPos(230)
Return
;<RightOpenDrive>: >>	右窗口: 打开驱动器列表{{{2
<RightOpenDrive>:
		SendPos(231)
Return
;<RightPathFocu>: >>	右窗口: 焦点置于路径上{{{2
<RightPathFocu>:
		SendPos(232)
Return
;<RightDirBranch>: >>右窗口: 展开所有文件夹{{{2
<RightDirBranch>:
	SendPos(2035)
Return
;<RightDirBranchSel>: >>右窗口: 只展开选中的文件夹{{{2
<RightDirBranchSel>:
	SendPos(2048)
Return
;<RightThumb>: >>	右窗口: 缩略图{{{2
<RightThumb>:
		SendPos(169)
Return
;<RightCustomViewMen>: >>	右窗口: 自定义视图菜单{{{2
<RightCustomViewMen>:
		SendPos(170)
Return
;文件操作 ========================================4
;文件操作 =========================================
;文件操作 =========================================
Return
;<Lis>: >>	查看(用查看程序){{{2
<Lis>:
		SendPos(903)
Return
;<ListInternalOnly>: >>查看(用查看程序, 但不用插件/多媒体){{{2
<ListInternalOnly>:
	SendPos(1006)
Return
;<Edi>: >>	编辑{{{2
<Edi>:
		SendPos(904)
Return
;<Copy>: >>复制{{{2
<Copy>:
	SendPos(905)
Return
;<CopySamepanel>: >>复制到当前窗口{{{2
<CopySamepanel>:
	SendPos(3100)
Return
;<CopyOtherpanel>: >>复制到另一窗口{{{2
<CopyOtherpanel>:
	SendPos(3101)
Return
;<RenMov>: >>重命名/移动{{{2
<RenMov>:
	SendPos(906)
Return
;<MkDir>: >>新建文件夹{{{2
<MkDir>:
	SendPos(907)
Return
;<Delete>: >>删除{{{2
<Delete>:
	SendPos(908)
Return
;<TestArchive>: >>测试压缩包{{{2
<TestArchive>:
	SendPos(518)
Return
;<PackFiles>: >>压缩文件{{{2
<PackFiles>:
	SendPos(508)
Return
;<UnpackFiles>: >>解压文件{{{2
<UnpackFiles>:
	SendPos(509)
Return
;<RenameOnly>: >>重命名(Shift+F6){{{2
<RenameOnly>:
	SendPos(1002)
Return
;<RenameSingleFile>: >>重命名当前文件{{{2
<RenameSingleFile>:
	SendPos(1007)
Return
;<MoveOnly>: >>移动(F6){{{2
<MoveOnly>:
	SendPos(1005)
Return
;<Properties>: >>显示属性{{{2
<Properties>:
	SendPos(1003)
Return
;<CreateShortcut>: >>创建快捷方式{{{2
<CreateShortcut>:
	SendPos(1004)
Return
;<Return>: >>模仿按 ENTER 键{{{2
<Return>:
	SendPos(1001)
Return
;<OpenAsUser>: >>以其他用户身份运行光标处的程序{{{2
<OpenAsUser>:
	SendPos(2800)
Return
;<Split>: >>分割文件{{{2
<Split>:
	SendPos(560)
Return
;<Combine>: >>合并文件{{{2
<Combine>:
	SendPos(561)
Return
;<Encode>: >>编码文件(MIME/UUE/XXE 格式){{{2
<Encode>:
	SendPos(562)
Return
;<Decode>: >>解码文件(MIME/UUE/XXE/BinHex 格式){{{2
<Decode>:
	SendPos(563)
Return
;<CRCcreate>: >>创建校验文件{{{2
<CRCcreate>:
	SendPos(564)
Return
;<CRCcheck>: >>验证校验和{{{2
<CRCcheck>:
	SendPos(565)
Return
;<SetAttrib>: >>更改属性{{{2
<SetAttrib>:
	SendPos(502)
Return
;配置 ========================================4
;配置 =========================================
;配置 =========================================
Return
;<Config>: >>配置: 布局{{{2
<Config>:
	SendPos(490)
Return
;<DisplayConfig>: >>配置: 显示{{{2
<DisplayConfig>:
	SendPos(486)
Return
;<IconConfig>: >>配置: 图标{{{2
<IconConfig>:
	SendPos(477)
Return
;<FontConfig>: >>配置: 字体{{{2
<FontConfig>:
	SendPos(492)
Return
;<ColorConfig>: >>配置: 颜色{{{2
<ColorConfig>:
	SendPos(494)
Return
;<ConfTabChange>: >>配置: 制表符{{{2
<ConfTabChange>:
	SendPos(497)
Return
;<DirTabsConfig>: >>配置: 文件夹标签{{{2
<DirTabsConfig>:
	SendPos(488)
Return
;<CustomColumnConfig>: >>配置: 自定义列{{{2
<CustomColumnConfig>:
	SendPos(483)
Return
;<CustomColumnDlg>: >>更改当前自定义列{{{2
<CustomColumnDlg>:
	SendPos(2920)
Return
;<LanguageConfig>: >>配置: 语言{{{2
<LanguageConfig>:
	SendPos(499)
Return
;<Config2>: >>配置: 操作方式{{{2
<Config2>:
	SendPos(516)
Return
;<EditConfig>: >>配置: 编辑/查看{{{2
<EditConfig>:
	SendPos(496)
Return
;<CopyConfig>: >>配置: 复制/删除{{{2
<CopyConfig>:
	SendPos(487)
Return
;<RefreshConfig>: >>配置: 刷新{{{2
<RefreshConfig>:
	SendPos(478)
Return
;<QuickSearchConfig>: >>配置: 快速搜索{{{2
<QuickSearchConfig>:
	SendPos(479)
Return
;<FtpConfig>: >>配置: FTP{{{2
<FtpConfig>:
	SendPos(489)
Return
;<PluginsConfig>: >>配置: 插件{{{2
<PluginsConfig>:
	SendPos(484)
Return
;<ThumbnailsConfig>: >>配置: 缩略图{{{2
<ThumbnailsConfig>:
	SendPos(482)
Return
;<LogConfig>: >>配置: 日志文件{{{2
<LogConfig>:
	SendPos(481)
Return
;<IgnoreConfig>: >>配置: 隐藏文件{{{2
<IgnoreConfig>:
	SendPos(480)
Return
;<PackerConfig>: >>配置: 压缩程序{{{2
<PackerConfig>:
	SendPos(491)
Return
;<ZipPackerConfig>: >>配置: ZIP 压缩程序{{{2
<ZipPackerConfig>:
	SendPos(485)
Return
;<Confirmation>: >>配置: 其他/确认{{{2
<Confirmation>:
	SendPos(495)
Return
;<ConfigSavePos>: >>保存位置{{{2
<ConfigSavePos>:
	SendPos(493)
Return
;<ButtonConfig>: >>更改工具栏{{{2
<ButtonConfig>:
	SendPos(498)
Return
;<ConfigSaveSettings>: >>保存设置{{{2
<ConfigSaveSettings>:
	SendPos(580)
Return
;<ConfigChangeIniFiles>: >>直接修改配置文件{{{2
<ConfigChangeIniFiles>:
	SendPos(581)
Return
;<ConfigSaveDirHistory>: >>保存文件夹历史记录{{{2
<ConfigSaveDirHistory>:
	SendPos(582)
Return
;<ChangeStartMenu>: >>更改开始菜单{{{2
<ChangeStartMenu>:
	SendPos(700)
Return
;网络 ========================================4
;网络 =========================================
;网络 =========================================
Return
;<NetConnect>: >>映射网络驱动器{{{2
<NetConnect>:
	SendPos(512)
Return
;<NetDisconnect>: >>断开网络驱动器{{{2
<NetDisconnect>:
	SendPos(513)
Return
;<NetShareDir>: >>共享当前文件夹{{{2
<NetShareDir>:
	SendPos(514)
Return
;<NetUnshareDir>: >>取消文件夹共享{{{2
<NetUnshareDir>:
	SendPos(515)
Return
;<AdministerServer>: >>显示系统共享文件夹{{{2
<AdministerServer>:
	SendPos(2204)
Return
;<ShowFileUser>: >>显示本地文件的远程用户{{{2
<ShowFileUser>:
	SendPos(2203)
Return
;其他 ========================================4
;其他 =========================================
;其他 =========================================
Return
;<GetFileSpace>: >>计算占用空间{{{2
<GetFileSpace>:
	SendPos(503)
Return
;<VolumeId>: >>设置卷标{{{2
<VolumeId>:
	SendPos(505)
Return
;<VersionInfo>: >>版本信息{{{2
<VersionInfo>:
	SendPos(510)
Return
;<ExecuteDOS>: >>打开命令提示符窗口{{{2
<ExecuteDOS>:
	SendPos(511)
Return
;<CompareDirs>: >>比较文件夹{{{2
<CompareDirs>:
	SendPos(533)
Return
;<CompareDirsWithSubdirs>: >>比较文件夹(同时标出另一窗口没有的子文件夹){{{2
<CompareDirsWithSubdirs>:
	SendPos(536)
Return
;<ContextMenu>: >>显示快捷菜单{{{2
<ContextMenu>:
	SendPos(2500)
Return
;<ContextMenuInternal>: >>显示快捷菜单(内部关联){{{2
<ContextMenuInternal>:
	SendPos(2927)
Return
;<ContextMenuInternalCursor>: >>显示光标处文件的内部关联快捷菜单{{{2
<ContextMenuInternalCursor>:
	SendPos(2928)
Return
;<ShowRemoteMenu>: >>媒体中心遥控器播放/暂停键快捷菜单{{{2
<ShowRemoteMenu>:
	SendPos(2930)
Return
;<SyncChangeDir>: >>两边窗口同步更改文件夹{{{2
<SyncChangeDir>:
	SendPos(2600)
Return
;<EditComment>: >>编辑文件备注{{{2
<EditComment>:
	SendPos(2700)
Return
;<FocusLeft>: >>焦点置于左窗口{{{2
<FocusLeft>:
	SendPos(4001)
Return
;<FocusRight>: >>焦点置于右窗口{{{2
<FocusRight>:
	SendPos(4002)
Return
;<FocusCmdLine>: >>焦点置于命令行{{{2
<FocusCmdLine>:
	SendPos(4003)
Return
;<FocusButtonBar>: >>焦点置于工具栏{{{2
<FocusButtonBar>:
	SendPos(4004)
Return
;<CountDirContent>: >>计算所有文件夹占用的空间{{{2
<CountDirContent>:
	SendPos(2014)
Return
;<UnloadPlugins>: >>卸载所有插件{{{2
<UnloadPlugins>:
	SendPos(2913)
Return
;<DirMatch>: >>标出新文件, 隐藏相同者{{{2
<DirMatch>:
	SendPos(534)
Return
;<Exchange>: >>交换左右窗口{{{2
<Exchange>:
	SendPos(531)
Return
;<MatchSrc>: >>目标 = 来源{{{2
<MatchSrc>:
	SendPos(532)
Return
;<ReloadSelThumbs>: >>刷新选中文件的缩略图{{{2
<ReloadSelThumbs>:
	SendPos(2918)
Return
;并口 ========================================4
;并口 =========================================
;并口 =========================================
Return
;<DirectCableConnect>: >>直接电缆连接{{{2
<DirectCableConnect>:
	SendPos(2300)
Return
;<NTinstallDriver>: >>加载 NT 并口驱动程序{{{2
<NTinstallDriver>:
	SendPos(2301)
Return
;<NTremoveDriver>: >>卸载 NT 并口驱动程序{{{2
<NTremoveDriver>:
	SendPos(2302)
Return
;打印 ========================================4
;打印 =========================================
;打印 =========================================
Return
;<PrintDir>: >>打印文件列表{{{2
<PrintDir>:
	SendPos(2027)
Return
;<PrintDirSub>: >>打印文件列表(含子文件夹){{{2
<PrintDirSub>:
	SendPos(2028)
Return
;<PrintFile>: >>打印文件内容{{{2
<PrintFile>:
	SendPos(504)
Return
;选择 ========================================4
;选择 =========================================
;选择 =========================================
Return
;<SpreadSelection>: >>选择一组文件{{{2
<SpreadSelection>:
	SendPos(521)
Return
;<SelectBoth>: >>选择一组: 文件和文件夹{{{2
<SelectBoth>:
	SendPos(3311)
Return
;<SelectFiles>: >>选择一组: 仅文件{{{2
<SelectFiles>:
	SendPos(3312)
Return
;<SelectFolders>: >>选择一组: 仅文件夹{{{2
<SelectFolders>:
	SendPos(3313)
Return
;<ShrinkSelection>: >>不选一组文件{{{2
<ShrinkSelection>:
	SendPos(522)
Return
;<ClearFiles>: >>不选一组: 仅文件{{{2
<ClearFiles>:
	SendPos(3314)
Return
;<ClearFolders>: >>不选一组: 仅文件夹{{{2
<ClearFolders>:
	SendPos(3315)
Return
;<ClearSelCfg>: >>不选一组: 文件和/或文件夹(视配置而定){{{2
<ClearSelCfg>:
	SendPos(3316)
Return
;<SelectAll>: >>全部选择: 文件和/或文件夹(视配置而定){{{2
<SelectAll>:
	SendPos(523)
Return
;<SelectAllBoth>: >>全部选择: 文件和文件夹{{{2
<SelectAllBoth>:
	SendPos(3301)
Return
;<SelectAllFiles>: >>全部选择: 仅文件{{{2
<SelectAllFiles>:
	SendPos(3302)
Return
;<SelectAllFolders>: >>全部选择: 仅文件夹{{{2
<SelectAllFolders>:
	SendPos(3303)
Return
;<ClearAll>: >>全部取消: 文件和文件夹{{{2
<ClearAll>:
	SendPos(524)
Return
;<ClearAllFiles>: >>全部取消: 仅文件{{{2
<ClearAllFiles>:
	SendPos(3304)
Return
;<ClearAllFolders>: >>全部取消: 仅文件夹{{{2
<ClearAllFolders>:
	SendPos(3305)
Return
;<ClearAllCfg>: >>全部取消: 文件和/或文件夹(视配置而定){{{2
<ClearAllCfg>:
	SendPos(3306)
Return
;<ExchangeSelection>: >>反向选择{{{2
<ExchangeSelection>:
	SendPos(525)
Return
;<ExchangeSelBoth>: >>反向选择: 文件和文件夹{{{2
<ExchangeSelBoth>:
	SendPos(3321)
Return
;<ExchangeSelFiles>: >>反向选择: 仅文件{{{2
<ExchangeSelFiles>:
	SendPos(3322)
Return
;<ExchangeSelFolders>: >>反向选择: 仅文件夹{{{2
<ExchangeSelFolders>:
	SendPos(3323)
Return
;<SelectCurrentExtension>: >>选择扩展名相同的文件{{{2
<SelectCurrentExtension>:
	SendPos(527)
Return
;<UnselectCurrentExtension>: >>不选扩展名相同的文件{{{2
<UnselectCurrentExtension>:
	SendPos(528)
Return
;<SelectCurrentName>: >>选择文件名相同的文件{{{2
<SelectCurrentName>:
	SendPos(541)
Return
;<UnselectCurrentName>: >>不选文件名相同的文件{{{2
<UnselectCurrentName>:
	SendPos(542)
Return
;<SelectCurrentNameExt>: >>选择文件名和扩展名相同的文件{{{2
<SelectCurrentNameExt>:
	SendPos(543)
Return
;<UnselectCurrentNameExt>: >>不选文件名和扩展名相同的文件{{{2
<UnselectCurrentNameExt>:
	SendPos(544)
Return
;<SelectCurrentPath>: >>选择同一路径下的文件(展开文件夹+搜索文件){{{2
<SelectCurrentPath>:
	SendPos(537)
Return
;<UnselectCurrentPath>: >>不选同一路径下的文件(展开文件夹+搜索文件){{{2
<UnselectCurrentPath>:
	SendPos(538)
Return
;<RestoreSelection>: >>恢复选择列表{{{2
<RestoreSelection>:
	SendPos(529)
Return
;<SaveSelection>: >>保存选择列表{{{2
<SaveSelection>:
	SendPos(530)
Return
;<SaveSelectionToFile>: >>导出选择列表{{{2
<SaveSelectionToFile>:
	SendPos(2031)
Return
;<SaveSelectionToFileA>: >>导出选择列表(ANSI){{{2
<SaveSelectionToFileA>:
	SendPos(2041)
Return
;<SaveSelectionToFileW>: >>导出选择列表(Unicode){{{2
<SaveSelectionToFileW>:
	SendPos(2042)
Return
;<SaveDetailsToFile>: >>导出详细信息{{{2
<SaveDetailsToFile>:
	SendPos(2039)
Return
;<SaveDetailsToFileA>: >>导出详细信息(ANSI){{{2
<SaveDetailsToFileA>:
	SendPos(2043)
Return
;<SaveDetailsToFileW>: >>导出详细信息(Unicode){{{2
<SaveDetailsToFileW>:
	SendPos(2044)
Return
;<LoadSelectionFromFile>: >>导入选择列表(从文件){{{2
<LoadSelectionFromFile>:
	SendPos(2032)
Return
;<LoadSelectionFromClip>: >>导入选择列表(从剪贴板){{{2
<LoadSelectionFromClip>:
	SendPos(2033)
Return
;安全 ========================================4
;安全 =========================================
;安全 =========================================
Return
;<EditPermissionInfo>: >>设置权限(NTFS){{{2
<EditPermissionInfo>:
	SendPos(2200)
Return
;<EditAuditInfo>: >>审核文件(NTFS){{{2
<EditAuditInfo>:
	SendPos(2201)
Return
;<EditOwnerInfo>: >>获取所有权(NTFS){{{2
<EditOwnerInfo>:
	SendPos(2202)
Return
;剪贴板 ========================================4
;剪贴板 =========================================
;剪贴板 =========================================
Return
;<CutToClipboard>: >>剪切选中的文件到剪贴板{{{2
<CutToClipboard>:
	SendPos(2007)
Return
;<CopyToClipboard>: >>复制选中的文件到剪贴板{{{2
<CopyToClipboard>:
	SendPos(2008)
Return
;<PasteFromClipboard>: >>从剪贴板粘贴到当前文件夹{{{2
<PasteFromClipboard>:
	SendPos(2009)
Return
;<CopyNamesToClip>: >>复制文件名{{{2
<CopyNamesToClip>:
	SendPos(2017)
Return
;<CopyFullNamesToClip>: >>复制文件名及完整路径{{{2
<CopyFullNamesToClip>:
	SendPos(2018)
Return
;<CopyNetNamesToClip>: >>复制文件名及网络路径{{{2
<CopyNetNamesToClip>:
	SendPos(2021)
Return
;<CopySrcPathToClip>: >>复制来源路径{{{2
<CopySrcPathToClip>:
	SendPos(2029)
Return
;<CopyTrgPathToClip>: >>复制目标路径{{{2
<CopyTrgPathToClip>:
	SendPos(2030)
Return
;<CopyFileDetailsToClip>: >>复制文件详细信息{{{2
<CopyFileDetailsToClip>:
	SendPos(2036)
Return
;<CopyFpFileDetailsToClip>: >>复制文件详细信息及完整路径{{{2
<CopyFpFileDetailsToClip>:
	SendPos(2037)
Return
;<CopyNetFileDetailsToClip>: >>复制文件详细信息及网络路径{{{2
<CopyNetFileDetailsToClip>:
	SendPos(2038)
Return
;FTP ========================================4
;FTP =========================================
;FTP =========================================
Return
;<FtpConnect>: >>FTP 连接{{{2
<FtpConnect>:
	SendPos(550)
Return
;<FtpNew>: >>新建 FTP 连接{{{2
<FtpNew>:
	SendPos(551)
Return
;<FtpDisconnect>: >>断开 FTP 连接{{{2
<FtpDisconnect>:
	SendPos(552)
Return
;<FtpHiddenFiles>: >>显示隐藏文件{{{2
<FtpHiddenFiles>:
	SendPos(553)
Return
;<FtpAbort>: >>中止当前 FTP 命令{{{2
<FtpAbort>:
	SendPos(554)
Return
;<FtpResumeDownload>: >>续传{{{2
<FtpResumeDownload>:
	SendPos(555)
Return
;<FtpSelectTransferMode>: >>选择传输模式{{{2
<FtpSelectTransferMode>:
	SendPos(556)
Return
;<FtpAddToList>: >>添加到下载列表{{{2
<FtpAddToList>:
	SendPos(557)
Return
;<FtpDownloadList>: >>按列表下载{{{2
<FtpDownloadList>:
	SendPos(558)
Return
;导航 ========================================4
;导航 =========================================
;导航 =========================================
Return
;<GotoPreviousDir>: >>后退{{{2
<GotoPreviousDir>:
	SendPos(570)
Return
;<GotoNextDir>: >>前进{{{2
<GotoNextDir>:
	SendPos(571)
Return
;<DirectoryHistory>: >>文件夹历史记录{{{2
<DirectoryHistory>:
	SendPos(572)
Return
;<GotoPreviousLocalDir>: >>后退(非 FTP){{{2
<GotoPreviousLocalDir>:
	SendPos(573)
Return
;<GotoNextLocalDir>: >>前进(非 FTP){{{2
<GotoNextLocalDir>:
	SendPos(574)
Return
;<DirectoryHotlist>: >>常用文件夹{{{2
<DirectoryHotlist>:
	SendPos(526)
Return
;<GoToRoot>: >>转到根文件夹{{{2
<GoToRoot>:
	SendPos(2001)
Return
;<GoToParent>: >>转到上层文件夹{{{2
<GoToParent>:
	SendPos(2002)
Return
;<GoToDir>: >>打开光标处的文件夹或压缩包{{{2
<GoToDir>:
	SendPos(2003)
Return
;<OpenDesktop>: >>桌面{{{2
<OpenDesktop>:
	SendPos(2121)
Return
;<OpenDrives>: >>我的电脑{{{2
<OpenDrives>:
	SendPos(2122)
Return
;<OpenControls>: >>控制面板{{{2
<OpenControls>:
	SendPos(2123)
Return
;<OpenFonts>: >>字体{{{2
<OpenFonts>:
	SendPos(2124)
Return
;<OpenNetwork>: >>网上邻居{{{2
<OpenNetwork>:
	SendPos(2125)
Return
;<OpenPrinters>: >>打印机{{{2
<OpenPrinters>:
	SendPos(2126)
Return
;<OpenRecycled>: >>回收站{{{2
<OpenRecycled>:
	SendPos(2127)
Return
;<CDtree>: >>更改文件夹{{{2
<CDtree>:
	SendPos(500)
Return
;<TransferLeft>: >>在左窗口打开光标处的文件夹或压缩包{{{2
<TransferLeft>:
	SendPos(2024)
Return
;<TransferRight>: >>在右窗口打开光标处的文件夹或压缩包{{{2
<TransferRight>:
	SendPos(2025)
Return
;<EditPath>: >>编辑来源窗口的路径{{{2
<EditPath>:
	SendPos(2912)
Return
;<GoToFirstFile>: >>光标移到列表中的第一个文件{{{2
<GoToFirstFile>:
	SendPos(2050)
Return
;<GotoNextDrive>: >>转到下一个驱动器{{{2
<GotoNextDrive>:
	SendPos(2051)
Return
;<GotoPreviousDrive>: >>转到上一个驱动器{{{2
<GotoPreviousDrive>:
	SendPos(2052)
Return
;<GotoNextSelected>: >>转到下一个选中的文件{{{2
<GotoNextSelected>:
	SendPos(2053)
Return
;<GotoPrevSelected>: >>转到上一个选中的文件{{{2
<GotoPrevSelected>:
	SendPos(2054)
Return
;<GotoDriveA>: >>转到驱动器 A{{{2
<GotoDriveA>:
	SendPos(2061)
Return
;<GotoDriveC>: >>转到驱动器 C{{{2
<GotoDriveC>:
	SendPos(2063)
Return
;<GotoDriveD>: >>转到驱动器 D{{{2
<GotoDriveD>:
	SendPos(2064)
Return
;<GotoDriveE>: >>转到驱动器 E{{{2
<GotoDriveE>:
	SendPos(2065)
Return
;<GotoDriveF>: >>可自定义其他驱动器{{{2
<GotoDriveF>:
	SendPos(2066)
Return
;<GotoDriveZ>: >>最多 26 个{{{2
<GotoDriveZ>:
	SendPos(2086)
Return
;帮助 ========================================4
;帮助 =========================================
;帮助 =========================================
Return
;<HelpIndex>: >>帮助索引{{{2
<HelpIndex>:
	SendPos(610)
Return
;<Keyboard>: >>快捷键列表{{{2
<Keyboard>:
	SendPos(620)
Return
;<Register>: >>注册信息{{{2
<Register>:
	SendPos(630)
Return
;<VisitHomepage>: >>访问 Totalcmd 网站{{{2
<VisitHomepage>:
	SendPos(640)
Return
;<About>: >>关于 Total Commander{{{2
<About>:
	SendPos(690)
Return
;窗口 ========================================4
;窗口 =========================================
;窗口 =========================================
Return
;<Exit>: >>退出 Total Commander{{{2
<Exit>:
	SendPos(24340)
Return
;<Minimize>: >>最小化 Total Commander{{{2
<Minimize>:
	SendPos(2000)
Return
;<Maximize>: >>最大化 Total Commander{{{2
<Maximize>:
	SendPos(2015)
Return
;<Restore>: >>恢复正常大小{{{2
<Restore>:
	SendPos(2016)
Return
;命令行 ========================================4
;命令行 =========================================
;命令行 =========================================
Return
;<ClearCmdLine>: >>清除命令行{{{2
<ClearCmdLine>:
	SendPos(2004)
Return
;<NextCommand>: >>下一条命令{{{2
<NextCommand>:
	SendPos(2005)
Return
;<PrevCommand>: >>上一条命令{{{2
<PrevCommand>:
	SendPos(2006)
Return
;<AddPathToCmdline>: >>将路径复制到命令行{{{2
<AddPathToCmdline>:
	SendPos(2019)
Return
;工具 ========================================4
;工具 =========================================
;工具 =========================================
Return
;<MultiRenameFiles>: >>批量重命名{{{2
<MultiRenameFiles>:
	SendPos(2400)
Return
;<SysInfo>: >>系统信息{{{2
<SysInfo>:
	SendPos(506)
Return
;<OpenTransferManager>: >>后台传输管理器{{{2
<OpenTransferManager>:
	SendPos(559)
Return
;<SearchFor>: >>搜索文件{{{2
<SearchFor>:
	SendPos(501)
Return
;<FileSync>: >>同步文件夹{{{2
<FileSync>:
	SendPos(2020)
Return
;<Associate>: >>文件关联{{{2
<Associate>:
	SendPos(507)
Return
;<InternalAssociate>: >>定义内部关联{{{2
<InternalAssociate>:
	SendPos(519)
Return
;<CompareFilesByContent>: >>比较文件内容{{{2
<CompareFilesByContent>:
	SendPos(2022)
Return
;<IntCompareFilesByContent>: >>使用内部比较程序{{{2
<IntCompareFilesByContent>:
	SendPos(2040)
Return
;<CommandBrowser>: >>浏览内部命令{{{2
<CommandBrowser>:
	SendPos(2924)
Return
;视图 ========================================4
;视图 =========================================
;视图 =========================================
Return
;<VisButtonbar>: >>显示/隐藏: 工具栏{{{2
<VisButtonbar>:
	SendPos(2901)
Return
;<VisDriveButtons>: >>显示/隐藏: 驱动器按钮{{{2
<VisDriveButtons>:
	SendPos(2902)
Return
;<VisTwoDriveButtons>: >>显示/隐藏: 两个驱动器按钮栏{{{2
<VisTwoDriveButtons>:
	SendPos(2903)
Return
;<VisFlatDriveButtons>: >>切换: 平坦/立体驱动器按钮{{{2
<VisFlatDriveButtons>:
	SendPos(2904)
Return
;<VisFlatInterface>: >>切换: 平坦/立体用户界面{{{2
<VisFlatInterface>:
	SendPos(2905)
Return
;<VisDriveCombo>: >>显示/隐藏: 驱动器列表{{{2
<VisDriveCombo>:
	SendPos(2906)
Return
;<VisCurDir>: >>显示/隐藏: 当前文件夹{{{2
<VisCurDir>:
	SendPos(2907)
Return
;<VisBreadCrumbs>: >>显示/隐藏: 路径导航栏{{{2
<VisBreadCrumbs>:
	SendPos(2926)
Return
;<VisTabHeader>: >>显示/隐藏: 排序制表符{{{2
<VisTabHeader>:
	SendPos(2908)
Return
;<VisStatusbar>: >>显示/隐藏: 状态栏{{{2
<VisStatusbar>:
	SendPos(2909)
Return
;<VisCmdLine>: >>显示/隐藏: 命令行{{{2
<VisCmdLine>:
	SendPos(2910)
Return
;<VisKeyButtons>: >>显示/隐藏: 功能键按钮{{{2
<VisKeyButtons>:
	SendPos(2911)
Return
;<ShowHint>: >>显示文件提示{{{2
<ShowHint>:
	SendPos(2914)
Return
;<ShowQuickSearch>: >>显示快速搜索窗口{{{2
<ShowQuickSearch>:
	SendPos(2915)
Return
;<SwitchLongNames>: >>开启/关闭: 长文件名显示{{{2
<SwitchLongNames>:
	SendPos(2010)
Return
;<RereadSource>: >>刷新来源窗口{{{2
<RereadSource>:
	SendPos(540)
Return
;<ShowOnlySelected>: >>仅显示选中的文件{{{2
<ShowOnlySelected>:
	SendPos(2023)
Return
;<SwitchHidSys>: >>开启/关闭: 隐藏或系统文件显示{{{2
<SwitchHidSys>:
	SendPos(2011)
Return
;<Switch83Names>: >>开启/关闭: 8.3 式文件名小写显示{{{2
<Switch83Names>:
	SendPos(2013)
Return
;<SwitchDirSort>: >>开启/关闭: 文件夹按名称排序{{{2
<SwitchDirSort>:
	SendPos(2012)
Return
;<DirBranch>: >>展开所有文件夹{{{2
<DirBranch>:
	SendPos(2026)
Return
;<DirBranchSel>: >>只展开选中的文件夹{{{2
<DirBranchSel>:
	SendPos(2046)
Return
;<50Percent>: >>Window divider bar located 50%{{{2
<50Percent>:
	SendPos(909)
Return
;<100Percent>: >>Window divider bar located 100%{{{2
<100Percent>:
	SendPos(910)
Return
;<VisDirTabs>: >>显示/隐藏: 文件夹标签{{{2
<VisDirTabs>:
	SendPos(2916)
Return
;<VisXPThemeBackground>: >>显示/隐藏: XP 主题背景{{{2
<VisXPThemeBackground>:
	SendPos(2923)
Return
;<SwitchOverlayIcons>: >>开启/关闭: 叠置图标显示{{{2
<SwitchOverlayIcons>:
	SendPos(2917)
Return
;<VisHistHotButtons>: >>显示/隐藏: 文件夹历史记录和常用文件夹按钮{{{2
<VisHistHotButtons>:
	SendPos(2919)
Return
;<SwitchWatchDirs>: >>启用/禁用: 文件夹自动刷新{{{2
<SwitchWatchDirs>:
	SendPos(2921)
Return
;<SwitchIgnoreList>: >>启用/禁用: 自定义隐藏文件{{{2
<SwitchIgnoreList>:
	SendPos(2922)
Return
;<SwitchX64Redirection>: >>开启/关闭: 32 位 system32 目录重定向(64 位 Windows){{{2
<SwitchX64Redirection>:
	SendPos(2925)
Return
;<SeparateTreeOff>: >>关闭独立文件夹树面板{{{2
<SeparateTreeOff>:
	SendPos(3200)
Return
;<SeparateTree1>: >>一个独立文件夹树面板{{{2
<SeparateTree1>:
	SendPos(3201)
Return
;<SeparateTree2>: >>两个独立文件夹树面板{{{2
<SeparateTree2>:
	SendPos(3202)
Return
;<SwitchSeparateTree>: >>切换独立文件夹树面板状态{{{2
<SwitchSeparateTree>:
	SendPos(3203)
Return
;<ToggleSeparateTree1>: >>开启/关闭: 一个独立文件夹树面板{{{2
<ToggleSeparateTree1>:
	SendPos(3204)
Return
;<ToggleSeparateTree2>: >>开启/关闭: 两个独立文件夹树面板{{{2
<ToggleSeparateTree2>:
	SendPos(3205)
Return
;用户 ========================================4
;用户 =========================================
;用户 =========================================
Return
;<UserMenu1>: >>用户菜单 1{{{2
<UserMenu1>:
	SendPos(701)
Return
;<UserMenu2>: >>用户菜单 2{{{2
<UserMenu2>:
	SendPos(702)
Return
;<UserMenu3>: >>用户菜单 3{{{2
<UserMenu3>:
	SendPos(703)
Return
;<UserMenu4>: >>...{{{2
<UserMenu4>:
	SendPos(704)
Return
;<UserMenu5>: >>5{{{2
<UserMenu5>:
	SendPos(70)
Return
;<UserMenu6>: >>6{{{2
<UserMenu6>:
	SendPos(70)
Return
;<UserMenu7>: >>7{{{2
<UserMenu7>:
	SendPos(70)
Return
;<UserMenu8>: >>8{{{2
<UserMenu8>:
	SendPos(70)
Return
;<UserMenu9>: >>9{{{2
<UserMenu9>:
	SendPos(70)
Return
;<UserMenu10>: >>可定义其他用户菜单{{{2
<UserMenu10>:
	SendPos(710)
Return
;标签 ========================================4
;标签 =========================================
;标签 =========================================
Return
;<OpenNewTab>: >>新建标签{{{2
<OpenNewTab>:
	SendPos(3001)
Return
;<OpenNewTabBg>: >>新建标签(在后台){{{2
<OpenNewTabBg>:
	SendPos(3002)
Return
;<OpenDirInNewTab>: >>新建标签(并打开光标处的文件夹){{{2
<OpenDirInNewTab>:
	SendPos(3003)
Return
;<OpenDirInNewTabOther>: >>新建标签(在另一窗口打开文件夹){{{2
<OpenDirInNewTabOther>:
	SendPos(3004)
Return
;<SwitchToNextTab>: >>下一个标签(Ctrl+Tab){{{2
<SwitchToNextTab>:
	SendPos(3005)
Return
;<SwitchToPreviousTab>: >>上一个标签(Ctrl+Shift+Tab){{{2
<SwitchToPreviousTab>:
	SendPos(3006)
Return
;<CloseCurrentTab>: >>关闭当前标签{{{2
<CloseCurrentTab>:
	SendPos(3007)
Return
;<CloseAllTabs>: >>关闭所有标签{{{2
<CloseAllTabs>:
	SendPos(3008)
Return
;<DirTabsShowMenu>: >>显示标签菜单{{{2
<DirTabsShowMenu>:
	SendPos(3009)
Return
;<ToggleLockCurrentTab>: >>锁定/解锁当前标签{{{2
<ToggleLockCurrentTab>:
	SendPos(3010)
Return
;<ToggleLockDcaCurrentTab>: >>锁定/解锁当前标签(可更改文件夹){{{2
<ToggleLockDcaCurrentTab>:
	SendPos(3012)
Return
;<ExchangeWithTabs>: >>交换左右窗口及其标签{{{2
<ExchangeWithTabs>:
	SendPos(535)
Return
;<GoToLockedDir>: >>转到锁定标签的根文件夹{{{2
<GoToLockedDir>:
	SendPos(3011)
Return
;<SrcActivateTab1>: >>Source window: 激活标签 1{{{2
<SrcActivateTab1>:
	SendPos(5001)
Return
;<SrcActivateTab2>: >>Source window: 激活标签 2{{{2
<SrcActivateTab2>:
	SendPos(5002)
Return
;<SrcActivateTab3>: >>...{{{2
<SrcActivateTab3>:
	SendPos(5003)
Return
;<SrcActivateTab4>: >>最多 99 个{{{2
<SrcActivateTab4>:
	SendPos(5004)
Return
;<SrcActivateTab5>: >>5{{{2
<SrcActivateTab5>:
	SendPos(5005)
Return
;<SrcActivateTab6>: >>6{{{2
<SrcActivateTab6>:
	SendPos(5006)
Return
;<SrcActivateTab7>: >>7{{{2
<SrcActivateTab7>:
	SendPos(5007)
Return
;<SrcActivateTab8>: >>8{{{2
<SrcActivateTab8>:
	SendPos(5008)
Return
;<SrcActivateTab9>: >>9{{{2
<SrcActivateTab9>:
	SendPos(5009)
Return
;<SrcActivateTab10>: >>0{{{2
<SrcActivateTab10>:
	SendPos(5010)
Return
;<TrgActivateTab1>: >>目标窗口: 激活标签 1{{{2
<TrgActivateTab1>:
	SendPos(5101)
Return
;<TrgActivateTab2>: >>目标窗口: 激活标签 2{{{2
<TrgActivateTab2>:
	SendPos(5102)
Return
;<TrgActivateTab3>: >>...{{{2
<TrgActivateTab3>:
	SendPos(5103)
Return
;<TrgActivateTab4>: >>最多 99 个{{{2
<TrgActivateTab4>:
	SendPos(5104)
Return
;<TrgActivateTab5>: >>5{{{2
<TrgActivateTab5>:
	SendPos(5105)
Return
;<TrgActivateTab6>: >>6{{{2
<TrgActivateTab6>:
	SendPos(5106)
Return
;<TrgActivateTab7>: >>7{{{2
<TrgActivateTab7>:
	SendPos(5107)
Return
;<TrgActivateTab8>: >>8{{{2
<TrgActivateTab8>:
	SendPos(5108)
Return
;<TrgActivateTab9>: >>9{{{2
<TrgActivateTab9>:
	SendPos(5109)
Return
;<TrgActivateTab10>: >>0{{{2
<TrgActivateTab10>:
	SendPos(5110)
Return
;<LeftActivateTab1>: >>左窗口: 激活标签 1{{{2
<LeftActivateTab1>:
	SendPos(5201)
Return
;<LeftActivateTab2>: >>左窗口: 激活标签 2{{{2
<LeftActivateTab2>:
	SendPos(5202)
Return
;<LeftActivateTab3>: >>...{{{2
<LeftActivateTab3>:
	SendPos(5203)
Return
;<LeftActivateTab4>: >>最多 99 个{{{2
<LeftActivateTab4>:
	SendPos(5204)
Return
;<LeftActivateTab5>: >>5{{{2
<LeftActivateTab5>:
	SendPos(5205)
Return
;<LeftActivateTab6>: >>6{{{2
<LeftActivateTab6>:
	SendPos(5206)
Return
;<LeftActivateTab7>: >>7{{{2
<LeftActivateTab7>:
	SendPos(5207)
Return
;<LeftActivateTab8>: >>8{{{2
<LeftActivateTab8>:
	SendPos(5208)
Return
;<LeftActivateTab9>: >>9{{{2
<LeftActivateTab9>:
	SendPos(5209)
Return
;<LeftActivateTab10>: >>0{{{2
<LeftActivateTab10>:
	SendPos(5210)
Return
;<RightActivateTab1>: >>右窗口: 激活标签 1{{{2
<RightActivateTab1>:
	SendPos(5301)
Return
;<RightActivateTab2>: >>右窗口: 激活标签 2{{{2
<RightActivateTab2>:
	SendPos(5302)
Return
;<RightActivateTab3>: >>...{{{2
<RightActivateTab3>:
	SendPos(5303)
Return
;<RightActivateTab4>: >>最多 99 个{{{2
<RightActivateTab4>:
	SendPos(5304)
Return
;<RightActivateTab5>: >>5{{{2
<RightActivateTab5>:
	SendPos(5305)
Return
;<RightActivateTab6>: >>6{{{2
<RightActivateTab6>:
	SendPos(5306)
Return
;<RightActivateTab7>: >>7{{{2
<RightActivateTab7>:
	SendPos(5307)
Return
;<RightActivateTab8>: >>8{{{2
<RightActivateTab8>:
	SendPos(5308)
Return
;<RightActivateTab9>: >>9{{{2
<RightActivateTab9>:
	SendPos(5309)
Return
;<RightActivateTab10>: >>0{{{2
<RightActivateTab10>:
	SendPos(5310)
Return
;排序 ========================================4
;排序 =========================================
;排序 =========================================
Return
;<SrcSortByCol1>: >>Source window: 按第 1 列排序{{{2
<SrcSortByCol1>:
	SendPos(6001)
Return
;<SrcSortByCol2>: >>Source window: 按第 2 列排序{{{2
<SrcSortByCol2>:
	SendPos(6002)
Return
;<SrcSortByCol3>: >>...{{{2
<SrcSortByCol3>:
	SendPos(6003)
Return
;<SrcSortByCol4>: >>最多 99 列{{{2
<SrcSortByCol4>:
	SendPos(6004)
Return
;<SrcSortByCol5>: >>5{{{2
<SrcSortByCol5>:
	SendPos(6005)
Return
;<SrcSortByCol6>: >>6{{{2
<SrcSortByCol6>:
	SendPos(6006)
Return
;<SrcSortByCol7>: >>7{{{2
<SrcSortByCol7>:
	SendPos(6007)
Return
;<SrcSortByCol8>: >>8{{{2
<SrcSortByCol8>:
	SendPos(6008)
Return
;<SrcSortByCol9>: >>9{{{2
<SrcSortByCol9>:
	SendPos(6009)
Return
;<SrcSortByCol10>: >>0{{{2
<SrcSortByCol10>:
	SendPos(6010)
Return
;<SrcSortByCol99>: >>9{{{2
<SrcSortByCol99>:
	SendPos(6099)
Return
;<TrgSortByCol1>: >>目标窗口: 按第 1 列排序{{{2
<TrgSortByCol1>:
	SendPos(6101)
Return
;<TrgSortByCol2>: >>目标窗口: 按第 2 列排序{{{2
<TrgSortByCol2>:
	SendPos(6102)
Return
;<TrgSortByCol3>: >>...{{{2
<TrgSortByCol3>:
	SendPos(6103)
Return
;<TrgSortByCol4>: >>最多 99 列{{{2
<TrgSortByCol4>:
	SendPos(6104)
Return
;<TrgSortByCol5>: >>5{{{2
<TrgSortByCol5>:
	SendPos(6105)
Return
;<TrgSortByCol6>: >>6{{{2
<TrgSortByCol6>:
	SendPos(6106)
Return
;<TrgSortByCol7>: >>7{{{2
<TrgSortByCol7>:
	SendPos(6107)
Return
;<TrgSortByCol8>: >>8{{{2
<TrgSortByCol8>:
	SendPos(6108)
Return
;<TrgSortByCol9>: >>9{{{2
<TrgSortByCol9>:
	SendPos(6109)
Return
;<TrgSortByCol10>: >>0{{{2
<TrgSortByCol10>:
	SendPos(6110)
Return
;<TrgSortByCol99>: >>9{{{2
<TrgSortByCol99>:
	SendPos(6199)
Return
;<LeftSortByCol1>: >>左窗口: 按第 1 列排序{{{2
<LeftSortByCol1>:
	SendPos(6201)
Return
;<LeftSortByCol2>: >>左窗口: 按第 2 列排序{{{2
<LeftSortByCol2>:
	SendPos(6202)
Return
;<LeftSortByCol3>: >>...{{{2
<LeftSortByCol3>:
	SendPos(6203)
Return
;<LeftSortByCol4>: >>最多 99 列{{{2
<LeftSortByCol4>:
	SendPos(6204)
Return
;<LeftSortByCol5>: >>5{{{2
<LeftSortByCol5>:
	SendPos(6205)
Return
;<LeftSortByCol6>: >>6{{{2
<LeftSortByCol6>:
	SendPos(6206)
Return
;<LeftSortByCol7>: >>7{{{2
<LeftSortByCol7>:
	SendPos(6207)
Return
;<LeftSortByCol8>: >>8{{{2
<LeftSortByCol8>:
	SendPos(6208)
Return
;<LeftSortByCol9>: >>9{{{2
<LeftSortByCol9>:
	SendPos(6209)
Return
;<LeftSortByCol10>: >>0{{{2
<LeftSortByCol10>:
	SendPos(6210)
Return
;<LeftSortByCol99>: >>9{{{2
<LeftSortByCol99>:
	SendPos(6299)
Return
;<RightSortByCol1>: >>右窗口: 按第 1 列排序{{{2
<RightSortByCol1>:
	SendPos(6301)
Return
;<RightSortByCol2>: >>右窗口: 按第 2 列排序{{{2
<RightSortByCol2>:
	SendPos(6302)
Return
;<RightSortByCol3>: >>...{{{2
<RightSortByCol3>:
	SendPos(6303)
Return
;<RightSortByCol4>: >>最多 99 列{{{2
<RightSortByCol4>:
	SendPos(6304)
Return
;<RightSortByCol5>: >>5{{{2
<RightSortByCol5>:
	SendPos(6305)
Return
;<RightSortByCol6>: >>6{{{2
<RightSortByCol6>:
	SendPos(6306)
Return
;<RightSortByCol7>: >>7{{{2
<RightSortByCol7>:
	SendPos(6307)
Return
;<RightSortByCol8>: >>8{{{2
<RightSortByCol8>:
	SendPos(6308)
Return
;<RightSortByCol9>: >>9{{{2
<RightSortByCol9>:
	SendPos(6309)
Return
;<RightSortByCol10>: >>0{{{2
<RightSortByCol10>:
	SendPos(6310)
Return
;<RightSortByCol99>: >>9{{{2
<RightSortByCol99>:
	SendPos(6399)
Return
;自定义列视图 ========================================4
;自定义列视图 =========================================
;自定义列视图 =========================================
Return
;<SrcCustomView1>: >>Source window: 自定义列视图 1{{{2
<SrcCustomView1>:
	SendPos(271)
Return
;<SrcCustomView2>: >>Source window: 自定义列视图 2{{{2
<SrcCustomView2>:
	SendPos(272)
Return
;<SrcCustomView3>: >>...{{{2
<SrcCustomView3>:
	SendPos(273)
Return
;<SrcCustomView4>: >>最多 29 个{{{2
<SrcCustomView4>:
	SendPos(274)
Return
;<SrcCustomView5>: >>5{{{2
<SrcCustomView5>:
	SendPos(275)
Return
;<SrcCustomView6>: >>6{{{2
<SrcCustomView6>:
	SendPos(276)
Return
;<SrcCustomView7>: >>7{{{2
<SrcCustomView7>:
	SendPos(277)
Return
;<SrcCustomView8>: >>8{{{2
<SrcCustomView8>:
	SendPos(278)
Return
;<SrcCustomView9>: >>9{{{2
<SrcCustomView9>:
	SendPos(279)
Return
;<LeftCustomView1>: >>左窗口: 自定义列视图 1{{{2
<LeftCustomView1>:
	SendPos(710)
Return
;<LeftCustomView2>: >>左窗口: 自定义列视图 2{{{2
<LeftCustomView2>:
	SendPos(72)
Return
;<LeftCustomView3>: >>...{{{2
<LeftCustomView3>:
	SendPos(73)
Return
;<LeftCustomView4>: >>最多 29 个{{{2
<LeftCustomView4>:
	SendPos(74)
Return
;<LeftCustomView5>: >>5{{{2
<LeftCustomView5>:
	SendPos(75)
Return
;<LeftCustomView6>: >>6{{{2
<LeftCustomView6>:
	SendPos(76)
Return
;<LeftCustomView7>: >>7{{{2
<LeftCustomView7>:
	SendPos(77)
Return
;<LeftCustomView8>: >>8{{{2
<LeftCustomView8>:
	SendPos(78)
Return
;<LeftCustomView9>: >>9{{{2
<LeftCustomView9>:
	SendPos(79)
Return
;<RightCustomView1>: >>右窗口: 自定义列视图 1{{{2
<RightCustomView1>:
	SendPos(171)
Return
;<RightCustomView2>: >>右窗口: 自定义列视图 2{{{2
<RightCustomView2>:
	SendPos(172)
Return
;<RightCustomView3>: >>...{{{2
<RightCustomView3>:
	SendPos(173)
Return
;<RightCustomView4>: >>最多 29 个{{{2
<RightCustomView4>:
	SendPos(174)
Return
;<RightCustomView5>: >>5{{{2
<RightCustomView5>:
	SendPos(175)
Return
;<RightCustomView6>: >>6{{{2
<RightCustomView6>:
	SendPos(176)
Return
;<RightCustomView7>: >>7{{{2
<RightCustomView7>:
	SendPos(177)
Return
;<RightCustomView8>: >>8{{{2
<RightCustomView8>:
	SendPos(178)
Return
;<RightCustomView9>: >>9{{{2
<RightCustomView9>:
	SendPos(179)
Return
;<SrcNextCustomView>: >>Source window: 下一个自定义视图{{{2
<SrcNextCustomView>:
	SendPos(5501)
Return
;<SrcPrevCustomView>: >>Source window: 上一个自定义视图{{{2
<SrcPrevCustomView>:
	SendPos(5502)
Return
;<TrgNextCustomView>: >>目标窗口: 下一个自定义视图{{{2
<TrgNextCustomView>:
	SendPos(5503)
Return
;<TrgPrevCustomView>: >>目标窗口: 上一个自定义视图{{{2
<TrgPrevCustomView>:
	SendPos(5504)
Return
;<LeftNextCustomView>: >>左窗口: 下一个自定义视图{{{2
<LeftNextCustomView>:
	SendPos(5505)
Return
;<LeftPrevCustomView>: >>左窗口: 上一个自定义视图{{{2
<LeftPrevCustomView>:
	SendPos(5506)
Return
;<RightNextCustomView>: >>右窗口: 下一个自定义视图{{{2
<RightNextCustomView>:
	SendPos(5507)
Return
;<RightPrevCustomView>: >>右窗口: 上一个自定义视图{{{2
<RightPrevCustomView>:
	SendPos(5508)
Return
;<LoadAllOnDemandFields>: >>所有文件都按需加载备注{{{2
<LoadAllOnDemandFields>:
	SendPos(5512)
Return
;<LoadSelOnDemandFields>: >>仅选中的文件按需加载备注{{{2
<LoadSelOnDemandFields>:
	SendPos(5513)
Return
;<ContentStopLoadFields>: >>停止后台加载备注{{{2
<ContentStopLoadFields>:
	SendPos(5514)
Return
