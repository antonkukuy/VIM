<TCCOMMAND+>:
	CustomActions ( "<OpenDriveThis>", "open the drive listing: This side")
	CustomActions ( "<OpenDriveThat>", "open the drive listing: Another side")
	CustomActions ( "<MoveDirectoryHotlist>", "move to common folders")
	CustomActions ( "<CopyDirectoryHotlist>", "Copy to frequently used folders")
	CustomActions ( "<GotoPreviousDirOther>", "Back on the other side")
	CustomActions ( "<GotoNextDirOther>", "the other side forward")
	;RegisterHotkey("H","o","<OpenDriveThis>")
	;RegisterHotkey("H","O","<OpenDriveThat>")
	RegisterHotkey("fd","<MoveDirectoryHotlist>","TTOTAL_CMD")
	RegisterHotkey("fb","<CopyDirectoryHotlist>","TTOTAL_CMD")
	; Copy / move to the right to take f meaning file filecopy
	RegisterHotkey("fc","<cm_CopyOtherpanel>","TTOTAL_CMD")
	RegisterHotkey("fx","<cm_MoveOnly>","TTOTAL_CMD")
	; Ff fz copied to the clipboard to cut and paste clipboard fv
	RegisterHotkey("ff","<cm_CopyToClipboard>","TTOTAL_CMD")
	RegisterHotkey("fz","<cm_CutToClipboard>","TTOTAL_CMD")
	RegisterHotkey("fv","<cm_PasteFromClipboard>","TTOTAL_CMD")
	; Fb copied to a Favorites directory, a directory fd moving to favorites
	RegisterHotkey("fb","<CopyDirectoryHotlist>","TTOTAL_CMD")
	RegisterHotkey("fd","<MoveDirectoryHotlist>","TTOTAL_CMD")
	RegisterHotkey("ft","<cm_SyncChangeDir>","TTOTAL_CMD")
	RegisterHotkey("gh","<GotoPreviousDirOther>","TTOTAL_CMD")
	RegisterHotkey("gl","<GotoNextDirOther>","TTOTAL_CMD")
	RegisterHotkey("<shift>vh","<cm_SwitchIgnoreList>","TTOTAL_CMD")
return

; <OpenDriveThat>: >> Open a list of drives: Another side {{{2
<OpenDriveThis>:
	ControlGetFocus,CurrentFocus,AHK_CLASS TTOTAL_CMD
	if CurrentFocus not in TMyListBox2,TMyListBox1
		return
	if CurrentFocus in TMyListBox2
		SendPos (131)
	else
		SendPos (231)
Return

; <OpenDriveThis>: >> Open a list of drives: The side {{{2
<OpenDriveThat>:
	ControlGetFocus,CurrentFocus,AHK_CLASS TTOTAL_CMD
	if CurrentFocus not in TMyListBox2,TMyListBox1
		return
	if CurrentFocus in TMyListBox2
		SendPos (231)
	else
		SendPos (131)
Return

; <DirectoryHotlistother>: >> frequently used folders: the other side {{{2
<DirectoryHotlistother>:
	ControlGetFocus,CurrentFocus,AHK_CLASS TTOTAL_CMD
	if CurrentFocus not in TMyListBox2,TMyListBox1
		return
	if CurrentFocus in TMyListBox2
		otherlist = TMyListBox1
	else
		otherlist = TMyListBox2
	ControlFocus, %otherlist% ,ahk_class TTOTAL_CMD
	SendPos (526)
	SetTimer WaitMenuPop3
return
WaitMenuPop3:
	Winget, menupop ,, ahk_class # 32768
	if menupop
	{
		SetTimer, WaitMenuPop3, Off
		SetTimer, WaitMenuOff3
	}
return
WaitMenuOff3:
	Winget, menupop ,, ahk_class # 32768
	if not menupop
	{
		SetTimer, WaitMenuOff3, off
		goto, goonhot
	}
return
goonhot:
ControlFocus, %CurrentFocus% ,ahk_class TTOTAL_CMD
Return

; <CopyDirectoryHotlist>: >> Copy to frequently used folders {{{2
<CopyDirectoryHotlist>:
	ControlGetFocus,CurrentFocus,AHK_CLASS TTOTAL_CMD
	if CurrentFocus not in TMyListBox2,TMyListBox1
		return
	if CurrentFocus in TMyListBox2
		otherlist = TMyListBox1
	else
		otherlist = TMyListBox2
	ControlFocus, %otherlist% ,ahk_class TTOTAL_CMD
	SendPos (526)
	SetTimer WaitMenuPop1
return
WaitMenuPop1:
Winget, menupop ,, ahk_class # 32768
if menupop
	{
		SetTimer, WaitMenuPop1, Off
		SetTimer, WaitMenuOff1
	}
return
WaitMenuOff1:
	Winget, menupop ,, ahk_class # 32768
	if not menupop
	{
		SetTimer, WaitMenuOff1, off
		goto, gooncopy
	}
return
gooncopy:
	ControlFocus, %CurrentFocus% ,ahk_class TTOTAL_CMD
	SendPos (3101)
return

; <MoveDirectoryHotlist>: >> moved to frequently used folders {{{2
<MoveDirectoryHotlist>:
	If SendPos(0)
		ControlGetFocus,CurrentFocus,AHK_CLASS TTOTAL_CMD
	if CurrentFocus not in TMyListBox2,TMyListBox1
		return
	if CurrentFocus in TMyListBox2
		otherlist = TMyListBox1
	else
		otherlist = TMyListBox2
	ControlFocus, %otherlist% ,ahk_class TTOTAL_CMD
	SendPos (526)
	SetTimer WaitMenuPop2
return
WaitMenuPop2:
	Winget, menupop ,, ahk_class # 32768
	if menupop
	{
		SetTimer, WaitMenuPop2, Off
		SetTimer, WaitMenuOff2
	}
return
WaitMenuOff2:
	Winget, menupop ,, ahk_class # 32768
	if not menupop
	{
	SetTimer, WaitMenuOff2, off
	goto, goonmove
	}
return
GoonMove:
	ControlFocus, %CurrentFocus% ,ahk_class TTOTAL_CMD
	SendPos (1005)
return

; <GotoPreviousDirOther>: >> Back on the other side {{{2
<GotoPreviousDirOther>:
	Send {Tab}
	SendPos (570)
	Send {Tab}
Return

; <GotoNextDirOther>: >> forward on the other side {{{2
<GotoNextDirOther>:
	Send {Tab}
	SendPos (571)
	Send {Tab}
Return
