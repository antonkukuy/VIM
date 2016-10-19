; TC comes with the command {{{1 
; ======================================== ========== 
; ======= use VOom under VIM plugin can easily view ======= 
; ============= ===================================== 
<TCCOMMAND>: 
  CustomActions ( "<cm_SrcComments>", " source window: display file Notes ") 
  CustomActions (" <cm_SrcShort> "," source window: list ") 
  CustomActions (" <cm_SrcLong> "," source window: For more information ") 
  CustomActions (" <cm_SrcTree> "," source window : folder tree ") 
  CustomActions (" <cm_SrcQuickview> "," source window: Quick View ") 
  CustomActions (" <cm_VerticalPanels> "," portrait / landscape arrangement ") 
  CustomActions (" <cm_SrcQuickInternalOnly> "," source window: fast View (without plug-in) ") 
  CustomActions (" <cm_SrcHideQuickview> "," source window: Close the Quick View window ") 
  CustomActions (" <cm_SrcExecs> "," source window: an executable file ") 
  CustomActions (" <cm_SrcAllFiles> ", "source window: All files") 
  CustomActions ( "<cm_SrcUserSpec>", "source window: the last selected files") 
  CustomActions ( "<cm_SrcUserDef>", "source window: custom types") 
  CustomActions ( "<cm_SrcByName> "" source window: sorted by file name ") 
  CustomActions (" <cm_SrcByExt> "," source window: Sort by extension ") 
  CustomActions (" <cm_SrcBySize> "," source window: Sort by size ") 
  CustomActions (" <cm_SrcByDateTime> "," source window: Sort by date and time ") 
  CustomActions (" <cm_SrcUnsorted> "," source window: no Sort ") 
  CustomActions (" <cm_SrcNegOrder> "," source window: reverse sort ") 
  CustomActions ( "<cm_SrcOpenDrives>", "source window: open the drive list") 
  CustomActions ( "<cm_SrcThumbs>", "source window: thumbnails") 
  CustomActions ( "<cm_SrcCustomViewMenu>", "source window: custom view menu") 
  CustomActions ( "<cm_SrcPathFocus>", "source window: the focus on the path") 
  CustomActions ( "<cm_LeftComments>", "left window: display file Notes") 
  CustomActions ( "<cm_LeftShort>", "left window: list") 
  CustomActions ( "<cm_LeftLong>", "left window: For more information") 
  CustomActions ( "<cm_LeftTree>", "left window: folder tree") 
  CustomActions ( "<cm_LeftQuickview>", "left window: Quick View") 
  CustomActions ( "<cm_LeftQuickInternalOnly>", "left window: Quick View (without plug-in)") 
  CustomActions ( "<cm_LeftHideQuickview>", "left window: Close the Quick View window") 
  CustomActions ( "<cm_LeftExecs>", "left window: You can execute the file ") 
  CustomActions (" <cm_LeftAllFiles> "," left window: All files ") 
  CustomActions (" <cm_LeftUserSpec> "," left window: the last selected files ") 
  CustomActions (" <cm_LeftUserDef> "," left window : custom types ") 
  CustomActions (" <cm_LeftByName> "," left window: sorted by file name ") 
  CustomActions (" <cm_LeftByExt> "," left window: Sort by extension ") 
  CustomActions (" <cm_LeftBySize> ", "left window: Sort by size") 
  CustomActions ( "<cm_LeftByDateTime>", "left window: Sort by date and time") 
  CustomActions ( "<cm_LeftUnsorted>", "left window: no Sort") 
  CustomActions ( "<cm_LeftNegOrder>" "left window: reverse sort") 
  CustomActions ( "<cm_LeftOpenDrives>", "left window: open the drive list") 
  CustomActions ( "<cm_LeftPathFocus>", "left window: the focus is placed on the path") 
  CustomActions ( "< cm_LeftDirBranch> "," in the left window: expand All folders ") 
  CustomActions (" <cm_LeftDirBranchSel> "," in the left window: expand only selected folders ") 
  CustomActions (" <cm_LeftThumbs> "," window: thumbnails ") 
  CustomActions ( "<cm_LeftCustomViewMenu>", "window: custom view menu") 
  CustomActions ( "<cm_RightComments>", "Right window: display file Notes") 
  CustomActions ( "<cm_RightShort>", "the right window: list") 
  CustomActions ( "<cm_RightLong>", "detail") 
  CustomActions ( "<cm_RightTre>", "the right window: folder tree") 
  CustomActions ( "<cm_RightQuickvie>", "the right window: Quick View") 
  CustomActions ( "<cm_RightQuickInternalOnl> "" right window: Quick View (without plug-in) ") 
  CustomActions (" <cm_RightHideQuickvie> "," the right window: Close the Quick View window ") 
  CustomActions (" <cm_RightExec> "," the right window: the executable file ") 
  CustomActions ( "<cm_RightAllFile>", "the right window: All files") 
  CustomActions ( "<cm_RightUserSpe>", "the right window: the last selected files") 
  CustomActions ( "<cm_RightUserDe>", "the right window: custom types" ) 
  CustomActions ( "<cm_RightByNam>", "the right window: sorted by file name") 
  CustomActions ( "<cm_RightByEx>", "the right window: Sort by extension") 
  CustomActions ( "<cm_RightBySiz>", "the right window: press Sort by size ") 
  CustomActions (" <cm_RightByDateTim> "," the right window: Sort by date and time ") 
  CustomActions (" <cm_RightUnsorte> "," the right window: no Sort ") 
  CustomActions (" <cm_RightNegOrde> "," the right window: reverse order ") 
  CustomActions (" <cm_RightOpenDrives> "," the right window: open the drive list ") 
  CustomActions (" <cm_RightPathFocu> "," the right window: the focus on the path ") 
  CustomActions (" <cm_RightDirBranch> "," Right window: expand All folders ") 
  CustomActions (" <cm_RightDirBranchSel> "," the right window: expand only selected folders ") 
  CustomActions (" <cm_RightThumb> "," the right window: thumbnails ") 
  CustomActions (" <cm_RightCustomViewMen > "," the right window: custom View menu ") 
  CustomActions (" <cm_List> "," view (with Viewer) ") 
  CustomActions (" <cm_ListInternalOnly> "," view (with the viewer, but do not plug / multimedia ) ") 
  CustomActions (" <cm_Edit> "," edit ") 
  CustomActions (" <cm_Copy> "," copy ") 
  CustomActions (" <cm_CopySamepanel> "," copy to current window ") 
  CustomActions (" <cm_CopyOtherpanel> ", "copy to another window") 
  CustomActions ( "<cm_RenMov>", "rename / move") 
  CustomActions ( "<cm_MkDir>", "New folder") 
  CustomActions ( "<cm_Delete>", "delete") 
  CustomActions ( "<cm_TestArchive>", "test archive") 
  CustomActions ( "<cm_PackFiles>", "archive") 
  CustomActions ( "<cm_UnpackFiles>", "extracting file") 
  CustomActions ( "<cm_RenameOnly>", "rename (Shift + F6) ") 
  CustomActions (" <cm_RenameSingleFile> "," rename the current file ") 
  CustomActions (" <cm_MoveOnly> "," mobile (F6) ") 
  CustomActions (" <cm_Properties> "," display properties ") 
  CustomActions ( "<cm_CreateShortcut>", "Create shortcut") 
  CustomActions ( "<cm_Return>", "press ENTER imitation") 
  CustomActions ( "<cm_OpenAsUser>", "as another user to run the program at the cursor") 
  CustomActions ( "<cm_Split>", "split file") 
  CustomActions ( "<cm_Combine>", "merge files") 
  CustomActions ( "<cm_Encode>", "encoded file (MIME / UUE / XXE format)") 
  CustomActions ( "< cm_Decode> "," decode the file (MIME / UUE / XXE / BinHex format) ") 
  CustomActions (" <cm_CRCcreate> "," Creating the checksum file ") 
  CustomActions (" <cm_CRCcheck> "," verification and validation ") 
  CustomActions ( "<cm_SetAttrib>", "change properties") 
  CustomActions ( "<cm_Config>", "configuration: layout") 
  CustomActions ( "<cm_DisplayConfig>", "configuration: Shows") 
  CustomActions ( "<cm_IconConfig>", "configuration : icon ") 
  CustomActions (" <cm_FontConfig> "," configuration: fonts ") 
  CustomActions (" <cm_ColorConfig> "," configuration: color ") 
  CustomActions (" <cm_ConfTabChange> "," configuration: tab ") 
  CustomActions ( "<cm_DirTabsConfig>", "configuration: folders tab") 
  CustomActions ( "<cm_CustomColumnConfig>", "configuration: customize columns") 
  CustomActions ( "<cm_CustomColumnDlg>", "change current customize columns") 
  CustomActions ( "< cm_LanguageConfig> "," configuration: language ") 
  CustomActions (" <cm_Config2> "," configuration: operation mode ") 
  CustomActions (" <cm_EditConfig> "," configuration: edit / View ") 
  CustomActions (" <cm_CopyConfig> "," configuration: copy / delete ") 
  CustomActions (" <cm_RefreshConfig> "," configuration: refresh ") 
  CustomActions (" <cm_QuickSearchConfig> "," configuration: Quick Search ") 
  CustomActions (" <cm_FtpConfig> "," configuration: FTP ") 
  CustomActions ( "<cm_PluginsConfig>", "configuration: plug-in") 
  CustomActions ( "<cm_ThumbnailsConfig>", "configuration: thumbnails") 
  CustomActions ( "<cm_LogConfig>", "configuration: log files") 
  CustomActions ( "<cm_IgnoreConfig> "" configuration: hidden files ") 
  CustomActions (" <cm_PackerConfig> "," configuration: compression program ") 
  CustomActions (" <cm_ZipPackerConfig> "," configuration: ZIP compression program ") 
  CustomActions (" <cm_Confirmation> "," configuration : other / confirm ") 
  CustomActions (" <cm_ConfigSavePos> "," save position ") 
  CustomActions (" <cm_ButtonConfig> "," change toolbar ") 
  CustomActions (" <cm_ConfigSaveSettings> "," save settings ") 
  CustomActions (" < cm_ConfigChangeIniFiles> "," directly modify the configuration file ") 
  CustomActions (" <cm_ConfigSaveDirHistory> "," save folder history ") 
  CustomActions (" <cm_ChangeStartMenu> "," change start menu ") 
  CustomActions (" <cm_NetConnect> "," map network drive ") 
  CustomActions (" <cm_NetDisconnect> "," disconnect network drive ") 
  CustomActions (" <cm_NetShareDir> "," share current folder ") 
  CustomActions (" <cm_NetUnshareDir> "," cancel the folder sharing ") 
  CustomActions ( "<cm_AdministerServer>", "display system shared folder") 
  CustomActions ( "<cm_ShowFileUser>", "remote user to display local files") 
  CustomActions ( "<cm_GetFileSpace>", "computing space") 
  CustomActions ( " <cm_VolumeId> "," volume label ") 
  CustomActions (" <cm_VersionInfo> "," version ") 
  CustomActions (" <cm_ExecuteDOS> "," open a command prompt window ") 
  CustomActions (" <cm_CompareDirs> "," comparison folder ") 
  CustomActions (" <cm_CompareDirsWithSubdirs> "," Comparing folders (subfolders marked another window while no folder) ") 
  CustomActions (" <cm_ContextMenu> "," display the shortcut menu ") 
  CustomActions (" <cm_ContextMenuInternal > "," display the shortcut menu (internal association) ") 
  CustomActions (" <cm_ContextMenuInternalCursor> "," inter-related shortcut menu cursor files ") 
  CustomActions (" <cm_ShowRemoteMenu> "," media Center remote control play / Pause quick menu ") 
  CustomActions (" <cm_SyncChangeDir> "," both sides of the window changes are synchronized folders ") 
  CustomActions (" <cm_EditComment> "," edit file Notes ") 
  CustomActions (" <cm_FocusLeft> "," focus in the left window. " ) 
  CustomActions ( "<cm_FocusRight>", "focus in the right window") 
  CustomActions ( "<cm_FocusCmdLine>", "focus on the command line") 
  CustomActions ( "<cm_FocusButtonBar>", "focus on the toolbar") 
  CustomActions ( "<cm_CountDirContent>", "calculate the space occupied by all folders") 
  CustomActions ( "<cm_UnloadPlugins>", "uninstall all plug-ins") 
  CustomActions ( "<cm_DirMatch>", "mark a new file, hide the same person.") 
  CustomActions ( "<cm_Exchange>", "swap around window") 
  CustomActions ( "<cm_MatchSrc>", "target = source") 
  CustomActions ( "<cm_ReloadSelThumbs>", "refresh selected files thumbnails") 
  CustomActions ( "<cm_DirectCableConnect > "," direct cable connection ") 
  CustomActions (" <cm_NTinstallDriver> "," load NT parallel port driver ") 
  CustomActions (" <cm_NTremoveDriver> "," uninstall NT parallel port driver ") 
  CustomActions (" <cm_PrintDir> "," Print file list ") 
  CustomActions (" <cm_PrintDirSub> "," Print a list of files (including subfolders) ") 
  CustomActions (" <cm_PrintFile> "," print the contents of the file ") 
  CustomActions (" <cm_SpreadSelection> "," select a group files ") 
  CustomActions (" <cm_SelectBoth> "," select a group: files and folders ") 
  CustomActions (" <cm_SelectFiles> "," select a group: only file ") 
  CustomActions (" <cm_SelectFolders> "," select a group: only folders ") 
  CustomActions (" <cm_ShrinkSelection> "," do not choose a group of files ") 
  CustomActions (" <cm_ClearFiles> "," do not choose a group: only file ") 
  CustomActions (" <cm_ClearFolders> ", "Do not choose a group: only folders") 
  CustomActions ( "<cm_ClearSelCfg>", "do not choose a group: files and / or folders (depending on configuration)") 
  CustomActions ( "<cm_SelectAll>", "Select all : files and / or folders (depending on configuration) ") 
  CustomActions (" <cm_SelectAllBoth> "," Select all: files and folders ") 
  CustomActions (" <cm_SelectAllFiles> "," Select all: file only ") 
  CustomActions ( "<cm_SelectAllFolders>", "Select all: only folders") 
  CustomActions ( "<cm_ClearAll>", "cancel all: files and folders") 
  CustomActions ( "<cm_ClearAllFiles>", "cancel all: only files") 
  CustomActions ( "<cm_ClearAllFolders>", "cancel all: only folder") 
  CustomActions ( "<cm_ClearAllCfg>", "cancel all: the files and / or folders (depending on configuration)") 
  CustomActions ( "<cm_ExchangeSelection>" "Invert selection") 
  CustomActions ( "<cm_ExchangeSelBoth>", "Invert selection: files and folders") 
  CustomActions ( "<cm_ExchangeSelFiles>", "Invert selection: file only") 
  CustomActions ( "<cm_ExchangeSelFolders>" "Invert selection: only folders") 
  CustomActions ( "<cm_SelectCurrentExtension>", "choose the same file extension") 
  CustomActions ( "<cm_UnselectCurrentExtension>", "do not choose the same name as the file extension") 
  CustomActions ( "< cm_SelectCurrentName> "," select a file with the same filename ") 
  CustomActions (" <cm_UnselectCurrentName> "," do not choose a file with the same filename ") 
  CustomActions (" <cm_SelectCurrentNameExt> "," select the file name and extension of the same file ") 
  CustomActions ( "<cm_UnselectCurrentNameExt>", "do not choose a file name and extension of the same file") 
  CustomActions ( "<cm_SelectCurrentPath>", "select the file in the same path under (expand the folder + Search file)") 
  CustomActions ( "<cm_UnselectCurrentPath > "," do not choose the same path of the file (+ expand the folder to search for files) ") 
  CustomActions (" <cm_RestoreSelection> "," restore selection list ") 
  CustomActions (" <cm_SaveSelection> "," save the selection list ") 
  CustomActions ( "<cm_SaveSelectionToFile>", "export Selected list") 
  CustomActions ( "<cm_SaveSelectionToFileA>", "export selection list (ANSI)") 
  CustomActions ( "<cm_SaveSelectionToFileW>", "export selection list (Unicode)") 
  CustomActions ( " <cm_SaveDetailsToFile> "," export detail ") 
  CustomActions (" <cm_SaveDetailsToFileA> "," export the details (ANSI) ") 
  CustomActions (" <cm_SaveDetailsToFileW> "," export the details (Unicode) ") 
  CustomActions (" <cm_LoadSelectionFromFile > "," import selection list (from file) ") 
  CustomActions (" <cm_LoadSelectionFromClip> "," import selection list (from the clipboard) ") 
  CustomActions (" <cm_EditPermissionInfo> "," set permissions (NTFS) ") 
  CustomActions ( "<cm_EditAuditInfo>", "audit file (NTFS)") 
  CustomActions ( "<cm_EditOwnerInfo>", "take ownership (NTFS)") 
  CustomActions ( "<cm_CutToClipboard>", "cut the selected file to the clipboard") 
  CustomActions ( "<cm_CopyToClipboard>", "copy the selected file to the clipboard") 
  CustomActions ( "<cm_PasteFromClipboard>", "from the clipboard into the current folder") 
  CustomActions ( "<cm_CopyNamesToClip>", "copy filename") 
  CustomActions ( "<cm_CopyFullNamesToClip>", "copy the full path and file name") 
  CustomActions ( "<cm_CopyNetNamesToClip>", "copy the file name and network path") 
  CustomActions ( "<cm_CopySrcPathToClip>", "copy source path") 
  CustomActions ( "<cm_CopyTrgPathToClip>", "copy destination path") 
  CustomActions ( "<cm_CopyFileDetailsToClip>", "copy the file details") 
  CustomActions ( "<cm_CopyFpFileDetailsToClip>", "copy the full path and file details") 
  CustomActions ( "<cm_CopyNetFileDetailsToClip > "," copy the file details and network paths ") 
  CustomActions (" <cm_FtpConnect> "," FTP connection ") 
  CustomActions (" <cm_FtpNew> "," New FTP connection ") 
  CustomActions (" <cm_FtpDisconnect> "," broken open FTP connection ") 
  CustomActions (" <cm_FtpHiddenFiles> "," show hidden files ") 
  CustomActions (" <cm_FtpAbort> "," abort the current FTP command ") 
  CustomActions (" <cm_FtpResumeDownload> "," resume ") 
  CustomActions (" <cm_FtpSelectTransferMode> "," Select the transmission mode ") 
  CustomActions (" <cm_FtpAddToList> "," Add to Download list ") 
  CustomActions (" <cm_FtpDownloadList> "," press the download list ") 
  CustomActions (" <cm_GotoPreviousDir> "," Back ") 
  CustomActions (" <cm_GotoNextDir> "," forward ") 
  CustomActions (" <cm_DirectoryHistory> "," folders history ") 
  CustomActions (" <cm_GotoPreviousLocalDir> "," back (non-FTP) ") 
  CustomActions (" <cm_GotoNextLocalDir > "," forward (non-FTP) ") 
  CustomActions (" <cm_DirectoryHotlist> "," common folders ") 
  CustomActions (" <cm_GoToRoot> "," go to the root folder ") 
  CustomActions (" <cm_GoToParent> "," Go to the parent folder ") 
  CustomActions (" <cm_GoToDir> "," open cursor folder or archive ") 
  CustomActions (" <cm_OpenDesktop> "," Desktop ") 
  CustomActions (" <cm_OpenDrives> "," my computer ") 
  CustomActions (" <cm_OpenControls> "," control panel ") 
  CustomActions (" <cm_OpenFonts> "," font ") 
  CustomActions (" <cm_OpenNetwork> "," Network neighborhood ") 
  CustomActions (" <cm_OpenPrinters> "," printer ") 
  CustomActions (" <cm_OpenRecycled> "," Recycle Bin ") 
  CustomActions (" <cm_CDtree> "," change folder ") 
  CustomActions (" <cm_TransferLeft> "," open at the cursor in the left window or compressed folder package ") 
  CustomActions (" <cm_TransferRight> "," open the cursor in the right window folder or archive ") 
  CustomActions (" <cm_EditPath> "," edit source path window ") 
  CustomActions (" <cm_GoToFirstFile> ", "move the cursor to the first file in the list") 
  CustomActions ( "<cm_GotoNextDrive>", "Go to the next drive") 
  CustomActions ( "<cm_GotoPreviousDrive>", "go on a drive") 
  CustomActions ( "<cm_GotoNextSelected > "," go to the next selected file ") 
  CustomActions (" <cm_GotoPrevSelected> "," go on a selected file ") 
  CustomActions (" <cm_GotoDriveA> "," Go drive a ") 
  CustomActions (" < cm_GotoDriveC> "," Go to drive C ") 
  CustomActions (" <cm_GotoDriveD> "," change to drive D ") 
  CustomActions (" <cm_GotoDriveE> "," change to drive E ") 
  CustomActions (" <cm_GotoDriveF> "," customizable other drives ") 
  CustomActions (" <cm_GotoDriveZ> "," up to 26 ") 
  CustomActions (" <cm_HelpIndex> "," help index ") 
  CustomActions (" <cm_Keyboard> "," shortcut list ") 
  CustomActions ( "<cm_Register>", "registration information") 
  CustomActions ( "<cm_VisitHomepage>", "access Totalcmd site") 
  CustomActions ( "<cm_About>", "About Total Commander") 
  CustomActions ( "<cm_Exit>", "exit Total Commander ") 
  CustomActions (" <cm_Minimize> "," minimize Total Commander ") 
  CustomActions (" <cm_Maximize> "," maximize Total Commander ") 
  CustomActions (" <cm_Restore> "," normal size ") 
  CustomActions (" <cm_ClearCmdLine> "," clear the command line ") 
  CustomActions (" <cm_NextCommand> "," next command ") 
  CustomActions (" <cm_PrevCommand> "," on a command ") 
  CustomActions (" <cm_AddPathToCmdline> "," path copy the command line ") 
  CustomActions (" <cm_MultiRenameFiles> "," batch rename ") 
  CustomActions (" <cm_SysInfo> "," system information ") 
  CustomActions (" <cm_OpenTransferManager> "," background transfer Manager ") 
  CustomActions ( "<cm_SearchFor>", "Search for files") 
  CustomActions ( "<cm_FileSync>", "sync folder") 
  CustomActions ( "<cm_Associate>", "file association") 
  CustomActions ( "<cm_InternalAssociate>", "inter-related definitions ") 
  CustomActions (" <cm_CompareFilesByContent> "," Compare file content ") 
  CustomActions (" <cm_IntCompareFilesByContent> "," to use the internal comparison program ") 
  CustomActions (" <cm_CommandBrowser> "," browse internal command ") 
  CustomActions (" <cm_VisButtonbar > "," show / Hide: The toolbar ") 
  CustomActions (" <cm_VisDriveButtons> "," show / Hide: drive button ") 
  CustomActions (" <cm_VisTwoDriveButtons> "," show / Hide: two drives button bar ") 
  CustomActions ( "<cm_VisFlatDriveButtons>", "switch: flat / stereo drive button") 
  CustomActions ( "<cm_VisFlatInterface>", "switch: flat / three-dimensional user interface") 
  CustomActions ( "<cm_VisDriveCombo>", "show / Hide: drives list ") 
  CustomActions (" <cm_VisCurDir> "," show / Hide: current folder ") 
  CustomActions (" <cm_VisBreadCrumbs> "," show / Hide: route navigation bar ") 
  CustomActions (" <cm_VisTabHeader> "," show / Hide : Sort tabs ") 
  CustomActions (" <cm_VisStatusbar> "," show / Hide: status bar ") 
  CustomActions (" <cm_VisCmdLine> "," show / Hide: command line ") 
  CustomActions (" <cm_VisKeyButtons> "," show / Hide: function key buttons ") 
  CustomActions (" <cm_ShowHint> "," display file prompt ") 
  CustomActions (" <cm_ShowQuickSearch> "," show Quick Search window ") 
  CustomActions (" <cm_SwitchLongNames> "," On / Off : long file names display ") 
  CustomActions (" <cm_RereadSource> "," refresh sources window ") 
  CustomActions (" <cm_ShowOnlySelected> "," show only selected files ") 
  CustomActions (" <cm_SwitchHidSys> "," On / Off: show hidden or system files ") 
  CustomActions (" <cm_Switch83Names> "," On / Off: 8.3-type file names in lowercase ") 
  CustomActions (" <cm_SwitchDirSort> "," On / Off: folder Sort by name ") 
  CustomActions ( "<cm_DirBranch>", "expand all folders") 
  CustomActions ( "<cm_DirBranchSel>", "expand only selected folders") 
  CustomActions ( "<cm_50Percent>", "window divider bar located 50%") 
  CustomActions ( " <cm_100Percent> "," window divider bar located 100% TC 8.0+ ") 
  CustomActions (" <cm_VisDirTabs> "," show / Hide: folders tab ") 
  CustomActions (" <cm_VisXPThemeBackground> "," show / Hide: XP Themes background ") 
  CustomActions (" <cm_SwitchOverlayIcons> "," On / Off: stacking icon display ") 
  CustomActions (" <cm_VisHistHotButtons> "," show / Hide: folder history and common folders button ") 
  CustomActions (" < cm_SwitchWatchDirs> "," enable / disable: The folder automatically refresh ") 
  CustomActions (" <cm_SwitchIgnoreList> "," enable / disable: custom hidden files ") 
  CustomActions (" <cm_SwitchX64Redirection> "," On / Off: 32 system32 directory redirection (Windows 64-bit) ") 
  CustomActions (" <cm_SeparateTreeOff> "," close the folder tree panel of independent ") 
  CustomActions (" <cm_SeparateTree1> "," a separate folder tree panel ") 
  CustomActions (" <cm_SeparateTree2> "" two separate folder tree panel ") 
  CustomActions (" <cm_SwitchSeparateTree> "," folder tree panel switch independent state ") 
  CustomActions (" <cm_ToggleSeparateTree1> "," On / Off: a separate folder tree panel " ) 
  CustomActions ( "<cm_ToggleSeparateTree2>", "On / Off: two separate folder tree panel") 
  CustomActions ( "<cm_UserMenu1>", "user menu 1") 
  CustomActions ( "<cm_UserMenu2>", "user menu 2" ) 
  CustomActions ( "<cm_UserMenu3>", "user menu 3") 
  CustomActions ( "<cm_UserMenu4>", "user menu 4") 
  CustomActions ( "<cm_UserMenu5>", "user menu 5") 
  CustomActions ( "<cm_UserMenu6>" "user menu 6") 
  CustomActions ( "<cm_UserMenu7>", "user menu 7") 
  CustomActions ( "<cm_UserMenu8>", "user menu 8") 
  CustomActions ( "<cm_UserMenu9>", "user menu 9") 
  CustomActions ( "<cm_UserMenu10>", "define additional user menu") 
  CustomActions ( "<cm_OpenNewTab>", "New label") 
  CustomActions ( "<cm_OpenNewTabBg>", "New label (in the background)") 
  CustomActions ( "<cm_OpenDirInNewTab > "," New label (and open the cursor folder) ") 
  CustomActions (" <cm_OpenDirInNewTabOther> "," New label (open a folder in another window) ") 
  CustomActions (" <cm_SwitchToNextTab> "," next label (Ctrl + tab) ") 
  CustomActions (" <cm_SwitchToPreviousTab> "," on a label (Ctrl + Shift + tab) ") 
  CustomActions (" <cm_CloseCurrentTab> "," close the current tab ") 
  CustomActions (" <cm_CloseAllTabs> " "Close all tabs") 
  CustomActions ( "<cm_DirTabsShowMenu>", "display tab") 
  CustomActions ( "<cm_ToggleLockCurrentTab>", "lock / unlock current tab") 
  CustomActions ( "<cm_ToggleLockDcaCurrentTab>", "lock / unlock current tags (folders can be changed) ") 
  CustomActions (" <cm_ExchangeWithTabs> "," swap around window and its label ") 
  CustomActions (" <cm_GoToLockedDir> "," Go to the root folder of the locking tab ") 
  CustomActions (" <cm_SrcActivateTab1 > "," source window: activate tab 1 ") 
  CustomActions (" <cm_SrcActivateTab2> "," source window: activate tab 2 ") 
  CustomActions (" <cm_SrcActivateTab3> "," source window: activate tab 3 ") 
  CustomActions (" < cm_SrcActivateTab4> "," source window: activate tab 4 ") 
  CustomActions (" <cm_SrcActivateTab5> "," source window: activate tab 5 ") 
  CustomActions (" <cm_SrcActivateTab6> "," source window: activate tab 6 ") 
  CustomActions (" <cm_SrcActivateTab7> "," source window: activate tab 7 ") 
  CustomActions (" <cm_SrcActivateTab8> "," source window: activate tab 8 ") 
  CustomActions (" <cm_SrcActivateTab9> "," source window: activate tab 9 ") 
  CustomActions ( "<cm_SrcActivateTab10> "," Source window: Activate tab 10 ") 
  CustomActions (" <cm_TrgActivateTab1> "," Target window: Activate tab 1 ") 
  CustomActions (" <cm_TrgActivateTab2> "," Target window: Activate tab 2 ") 
  CustomActions (" <cm_TrgActivateTab3> "," target window: activate tab 3 ") 
  CustomActions (" <cm_TrgActivateTab4> "," target window: activate tab 4 ") 
  CustomActions (" <cm_TrgActivateTab5> "," target window: activate tab 5 ") 
  CustomActions ( "<cm_TrgActivateTab6>", "target window: activate tab 6") 
  CustomActions ( "<cm_TrgActivateTab7>", "target window: activate tab 7") 
  CustomActions ( "<cm_TrgActivateTab8>", "target window: activate tab 8") 
  CustomActions ( "<cm_TrgActivateTab9>", "target window: activate tab 9") 
  CustomActions ( "<cm_TrgActivateTab10>", "target window: activate tab 10") 
  CustomActions ( "<cm_LeftActivateTab1>", "left window: activate tab 1") 
  CustomActions ( "<cm_LeftActivateTab2>", "left window: activate tab 2") 
  CustomActions ( "<cm_LeftActivateTab3>", "left window: activate tab 3") 
  CustomActions ( "<cm_LeftActivateTab4>", "left window: activate tab 4" ) 
  CustomActions ( "<cm_LeftActivateTab5>", "left window: activate tab 5") 
  CustomActions ( "<cm_LeftActivateTab6>", "left window: activate tab 6") 
  CustomActions ( "<cm_LeftActivateTab7>", "left window: activate tab 7 ") 
  CustomActions (" <cm_LeftActivateTab8> "," left window: activate tab 8 ") 
  CustomActions (" <cm_LeftActivateTab9> "," left window: activate tab 9 ") 
  CustomActions (" <cm_LeftActivateTab10> "," left window: active tab 10 ") 
  CustomActions (" <cm_RightActivateTab1> "," the right window: activate tab 1 ") 
  CustomActions (" <cm_RightActivateTab2> "," the right window: activate tab 2 ") 
  CustomActions (" <cm_RightActivateTab3> "," the right window: activate label 3 ") 
  CustomActions (" <cm_RightActivateTab4> "," the right window: activate tab 4 ") 
  CustomActions (" <cm_RightActivateTab5> "," the right window: activate tab 5 ") 
  CustomActions (" <cm_RightActivateTab6> "," the right window: activate tab 6 ") 
  CustomActions (" <cm_RightActivateTab7> "," the right window: activate tab 7 ") 
  CustomActions (" <cm_RightActivateTab8> "," the right window: activate tab 8 ") 
  CustomActions (" <cm_RightActivateTab9> "," right window : activation tab 9 ") 
  CustomActions (" <cm_RightActivateTab10> "," the right window: activate tab 10 ") 
  CustomActions (" <cm_SrcSortByCol1> "," source window: Sort by section 1 ") 
  CustomActions (" <cm_SrcSortByCol2> ", "source window: Sort by section 2") 
  CustomActions ( "<cm_SrcSortByCol3>", "source window: Sort by section 3") 
  CustomActions ( "<cm_SrcSortByCol4>", "source window: Sort by section 4") 
  CustomActions ( "<cm_SrcSortByCol5>", "source window: Sort by section 5") 
  CustomActions ( "<cm_SrcSortByCol6>", "source window: Sort by section 6") 
  CustomActions ( "<cm_SrcSortByCol7>", "source window: press Article 7 Sort ") 
  CustomActions (" <cm_SrcSortByCol8> "," source window: Sort by section 8 ") 
  CustomActions (" <cm_SrcSortByCol9> "," source window: Sort by Article 9 ") 
  CustomActions (" <cm_SrcSortByCol10> "" source window: Sort by section 10 ") 
  CustomActions (" <cm_TrgSortByCol1> "," target window: Sort by section 1 ") 
  CustomActions (" <cm_TrgSortByCol2> "," target window: in section 2 Sort " ) 
  CustomActions ( "<cm_TrgSortByCol3>", "target window: Sort by section 3") 
  CustomActions ( "<cm_TrgSortByCol4>", "target window: in accordance with article 4 Sort") 
  CustomActions ( "<cm_TrgSortByCol5>", "target window : Sort by section 5 ") 
  CustomActions (" <cm_TrgSortByCol6> "," target window: Sort by section 6 ") 
  CustomActions (" <cm_TrgSortByCol7> "," target window: in accordance with article 7 Sort ") 
  CustomActions (" < cm_TrgSortByCol8> "," target window: in accordance with article 8 Sort ") 
  CustomActions (" <cm_TrgSortByCol9> "," target window: Sort by section 9 ") 
  CustomActions (" <cm_TrgSortByCol10> "," target window: in accordance with article 10 Sort ") 
  CustomActions (" <cm_LeftSortByCol1> "," left window: Sort by section 1 ") 
  CustomActions (" <cm_LeftSortByCol2> "," left window: Sort by section 2 ") 
  CustomActions (" <cm_LeftSortByCol3> "," left window: Sort by section 3 ") 
  CustomActions (" <cm_LeftSortByCol4> "," left window: Sort by section 4 ") 
  CustomActions (" <cm_LeftSortByCol5> "," left window: Sort by section 5 ") 
  CustomActions ( "<cm_LeftSortByCol6>", "left window: Sort by section 6") 
  CustomActions ( "<cm_LeftSortByCol7>", "left window: Sort by section 7") 
  CustomActions ( "<cm_LeftSortByCol8>", "left window: press article 8 Sort ") 
  CustomActions (" <cm_LeftSortByCol9> "," left window: Sort by section 9 ") 
  CustomActions (" <cm_LeftSortByCol10> "," left window: Sort by section 10 ") 
  CustomActions (" <cm_RightSortByCol1> " "Right window: Sort by section 1") 
  CustomActions ( "<cm_RightSortByCol2>", "the right window: Sort by section 2") 
  CustomActions ( "<cm_RightSortByCol3>", "the right window: Sort by Article 3") 
  CustomActions ( "<cm_RightSortByCol4>", "the right window: Sort by section 4") 
  CustomActions ( "<cm_RightSortByCol5>", "the right window: Sort by section 5") 
  CustomActions ( "<cm_RightSortByCol6>", "the right window: Sort by section 6 ") 
  CustomActions (" <cm_RightSortByCol7> "," the right window: Sort by section 7 ") 
  CustomActions (" <cm_RightSortByCol8> "," the right window: Sort by section 8 ") 
  CustomActions (" <cm_RightSortByCol9 > "," the right window: Sort by section 9 ") 
  CustomActions (" <cm_RightSortByCol10> "," the right window: Sort by section 10 ") 
  CustomActions (" <cm_SrcCustomView1> "," source window: custom columns view 1 ") 
  CustomActions (" <cm_SrcCustomView2> "," source window: custom column view 2 ") 
  CustomActions (" <cm_SrcCustomView3> "," source window: custom column view 3 ") 
  CustomActions (" <cm_SrcCustomView4> "," Origin window: custom column view 4 ") 
  CustomActions (" <cm_SrcCustomView5> "," source window: custom column view 5 ") 
  CustomActions (" <cm_SrcCustomView6> "," source window: custom column view 6 ") 
  CustomActions (" <cm_SrcCustomView7> "," source window: custom column view 7 ") 
  CustomActions (" <cm_SrcCustomView8> "," source window: custom column view 8 ") 
  CustomActions (" <cm_SrcCustomView9> "," source window: customize columns view 9 ") 
  CustomActions (" <cm_SrcCustomView10> "," source window: custom column view 10 ") 
  CustomActions (" <cm_LeftCustomView1> "," left window: custom column view 1 ") 
  CustomActions (" <cm_LeftCustomView2> ", "left window: custom column view 2") 
  CustomActions ( "<cm_LeftCustomView3>", "left window: custom column view 3") 
  CustomActions ( "<cm_LeftCustomView4>", "left window: custom column view 4") 
  CustomActions ( "<cm_LeftCustomView5>", "left window: custom column view 5") 
  CustomActions ( "<cm_LeftCustomView6>", "left window: custom column view 6") 
  CustomActions ( "<cm_LeftCustomView7>", "left window: self customize columns view 7 ") 
  CustomActions (" <cm_LeftCustomView8> "," left window: custom column view 8 ") 
  CustomActions (" <cm_LeftCustomView9> "," left window: custom column view 9 ") 
  CustomActions (" <cm_LeftCustomView10> "" left window: custom column view 10 ") 
  CustomActions (" <cm_RightCustomView1> "," the right window: custom column view 1 ") 
  CustomActions (" <cm_RightCustomView2> "," the right window: custom column view 2 " ) 
  CustomActions ( "<cm_RightCustomView3>", "the right window: custom column view 3") 
  CustomActions ( "<cm_RightCustomView4>", "the right window: custom column view 4") 
  CustomActions ( "<cm_RightCustomView5>", "right window : custom column view 5 ") 
  CustomActions (" <cm_RightCustomView6> "," the right window: custom column view 6 ") 
  CustomActions (" <cm_RightCustomView7> "," the right window: custom column view 7 ") 
  CustomActions (" < cm_RightCustomView8> "," the right window: custom column view 8 ") 
  CustomActions (" <cm_RightCustomView9> "," the right window: custom column view 9 ") 
  CustomActions (" <cm_RightCustomView10> "," the right window: custom column view 10 ") 
  CustomActions (" <cm_SrcNextCustomView> "," source window: next custom view ") 
  CustomActions (" <cm_SrcPrevCustomView> "," source window: a custom view ") 
  CustomActions (" <cm_TrgNextCustomView> "," target window: next custom view ") 
  CustomActions (" <cm_TrgPrevCustomView> "," target window: a custom view ") 
  CustomActions (" <cm_LeftNextCustomView> "," left window: next custom view ") 
  CustomActions ( "<cm_LeftPrevCustomView>", "left window: a custom view") 
  CustomActions ( "<cm_RightNextCustomView>", "the right window: next custom view") 
  CustomActions ( "<cm_RightPrevCustomView>", "the right window: a custom view ") 
  CustomActions (" <cm_LoadAllOnDemandFields> "," all the files are loaded on demand Notes ") 
  CustomActions (" <cm_LoadSelOnDemandFields> "," only the selected file is loaded on demand Notes ") 
  CustomActions (" <cm_ContentStopLoadFields> ", "stop loading background notes") 
return 
SendPos (Number) 
{ 
	PostMessage 1075,% Number%, 0,, ahk_class TTOTAL_CMD 
} 
; <cm_SrcComments>: >> source window: display file Notes {{{2 
<cm_SrcComments>: 
	SendPos (300 ) 
Return 
; <cm_SrcShort>: >> source window: list {{{2 
<cm_SrcShort>: 
	SendPos (301) 
Return 
; <cm_SrcLong>: >> source window: detailed {{{2 
<cm_SrcLong>: 
	SendPos (302) 
return 
; <cm_SrcTree>: >> source window: folder tree {{{2 
<cm_SrcTree>: 
	SendPos (303) 
; <cm_SrcQuickview>: >> source window: Quick View {{{2 
<cm_SrcQuickview>: 
	SendPos (304) 
return 
; <cm_VerticalPanels>: >> longitudinally aligned {{{2 
<cm_VerticalPanels>: 
	SendPos (305) 
return 
; <cm_SrcQuickInternalOnly>: >> source window: Quick View (without plug) {{{2 
<cm_SrcQuickInternalOnly>: 
	SendPos (306 ) 
Return
; <cm_SrcHideQuickview>: >> Source window: Close the Quick View window {{{2 
<cm_SrcHideQuickview>: 
	SendPos (307) 
Return 
; <cm_SrcExecs>: >> Source window: The executable file {{{2 
<cm_SrcExecs>: 
	SendPos ( 311) 
Return 
; <cm_SrcAllFiles>: >> source window: All files {{{2 
<cm_SrcAllFiles>: 
	SendPos (312) 
Return 
; <cm_SrcUserSpec>: >> source window: the last selected file {{{2 
<cm_SrcUserSpec> : 
	SendPos (313) 
Return 
; <cm_SrcUserDef>: >> source window: custom type {{{2 
<cm_SrcUserDef>: 
	SendPos (314) 
Return 
; <cm_SrcByName>: >> source window: sorted by file name {{{2 
<cm_SrcByName>: 
	SendPos (321) 
Return 
; <cm_SrcByExt>: >> source window: Sort by extension {{{2 
<cm_SrcByExt>: 
	SendPos (322) 
Return 
; <cm_SrcBySize>: >> source window: Sort by size { {{2 
<cm_SrcBySize>: 
	SendPos (323) 
Return 
; <cm_SrcByDateTime>: >> source window: date time Sort by {{{2 
<cm_SrcByDateTime>: 
	SendPos (324) 
Return 
; <cm_SrcUnsorted>: >> source window: no Sort {{{2 
<cm_SrcUnsorted>: 
	SendPos (325) 
Return 
; <cm_SrcNegOrder>: >> source window: reverse sort {{{2 
<cm_SrcNegOrder>: 
	SendPos (330) 
Return 
; <cm_SrcOpenDrives>: >> source window: open the drive list {{{2 
<cm_SrcOpenDrives>: 
	SendPos (331) 
Return 
; <cm_SrcThumbs>: >> source window: thumbnails {{{2 
<cm_SrcThumbs>: 
	SendPos (269) 
Return 
; <cm_SrcCustomViewMenu>: >> source window : custom views menu {{{2 
<cm_SrcCustomViewMenu>: 
	SendPos (270) 
Return 
; <cm_SrcPathFocus>: >> source window: the focus on the path {{{2 
<cm_SrcPathFocus>: 
	SendPos (332) 
Return 
; the left window = ======================================== 
Return 
; <cm_LeftComments>: >> left window : displays files.NOTE {{{2 
<cm_LeftComments>: 
	SendPos (100) 
Return 
; <cm_LeftShort>: >> left window: list {{{2 
<cm_LeftShort>: 
	SendPos (101) 
Return 
; <cm_LeftLong>: >> left window : detailed {{{2 
<cm_LeftLong>: 
	SendPos (102) 
Return 
; <cm_LeftTree>: >> left window: folder tree {{{2 
<cm_LeftTree>: 
	SendPos (103) 
Return 
; <cm_LeftQuickview>: left >> window: Quick View {{{2 
<cm_LeftQuickview>: 
	SendPos (104) 
Return 
; <cm_LeftQuickInternalOnly>: >> left window: Quick View (without plug) {{{2 
<cm_LeftQuickInternalOnly>: 
	SendPos (106) 
Return 
; <cm_LeftHideQuickview> : >> left window: Close the Quick View window {{{2 
<cm_LeftHideQuickview>: 
	SendPos (107) 
Return 
; <cm_LeftExecs>: >> left window: the executable file {{{2 
<cm_LeftExecs>: 
	SendPos (111) 
Return 
; <cm_LeftAllFiles>: >> left window: All files {{{2 
<cm_LeftAllFiles>: 
	SendPos (112) 
Return 
; <cm_LeftUserSpec>: >> left window: the last selected file {{{2 
<cm_LeftUserSpec>: 
	SendPos (113 ) 
Return 
; <cm_LeftUserDef>: >> left window: custom type {{{2 
<cm_LeftUserDef>: 
	SendPos (114) 
Return 
; <cm_LeftByName>: >> left window: sorted by file name {{{2 
<cm_LeftByName>: 
	SendPos (121) 
Return 
; <cm_LeftByExt>: >> left window: Sort by extension {{{2 
<cm_LeftByExt>: 
	SendPos (122) 
Return 
; <cm_LeftBySize>: >> left window: Sort by size {{{2 
< cm_LeftBySize>: 
	SendPos (123) 
Return 
; <cm_LeftByDateTime>: >> left window: Sort by date and time {{{2 
<cm_LeftByDateTime>: 
	SendPos (124) 
Return 
; <cm_LeftUnsorted>: >> left window: not sort {{{ 2 
<cm_LeftUnsorted>: 
	SendPos (125) 
Return 
; <cm_LeftNegOrder>: >> left window: reverse sort {{{2 
<cm_LeftNegOrder>: 
	SendPos (130) 
Return 
; <cm_LeftOpenDrives>: >> left window: open the drive list { {{2 
<cm_LeftOpenDrives>: 
	SendPos (131) 
Return 
; <cm_LeftPathFocus>: >> left window: the focus is placed on the path {{{2 
<cm_LeftPathFocus>: 
	SendPos (132) 
Return 
; <cm_LeftDirBranch>: >> left window: expand all folders {{{2 
<cm_LeftDirBranch>: 
	SendPos (203) 
Return 
; <cm_LeftDirBranchSel>: >> in the left window: expand only the selected folder {{{2 
<cm_LeftDirBranchSel>: 
	SendPos (204) 
Return 
; <cm_LeftThumbs> : >> window: thumbnail {{{2 
<cm_LeftThumbs>: 
	SendPos (69) 
Return 
; <cm_LeftCustomViewMenu>: >> window: custom views menu {{{2 
<cm_LeftCustomViewMenu>: 
	SendPos (70) 
Return 
; Right window = ======================================== 
Return 
; <cm_RightComments>: >> right window : displays files.NOTE {{{2 
<cm_RightComments>: 
	SendPos (200) 
Return 
; <cm_RightShort>: >> Right window: list {{{2 
: <cm_RightShort> 
	SendPos (201) 
Return 
details >>:; <cm_RightLong> {{{2 
<cm_RightLong>: 
	SendPos (202) 
Return 
; <cm_RightTre>: >> right window: folder tree {{{2 
<cm_RightTre>: 
		SendPos (203) 
Return 
; <cm_RightQuickvie>: >> Right window: fast See {{{2 
<cm_RightQuickvie>: 
		SendPos (204) 
Return 
; <cm_RightQuickInternalOnl>: >> Right window: Quick View (without plug) {{{2 
<cm_RightQuickInternalOnl>: 
		SendPos (206) 
Return 
; <cm_RightHideQuickvie>: >> Right window: Close the Quick View window {{{2 
<cm_RightHideQuickvie>: 
		SendPos (207) 
Return 
; <cm_RightExec>: >> Right window: executable file {{{2 
<cm_RightExec>: 
		SendPos (211) 
Return 
; <cm_RightAllFile> : >> right window: All files {{{2 
<cm_RightAllFile>: 
		SendPos (212) 
Return 
; <cm_RightUserSpe>: >> Right window: the last selected file {{{2 
<cm_RightUserSpe>: 
		SendPos (213) 
Return 
; <cm_RightUserDe>: >> Right window: custom type {{{2 
<cm_RightUserDe>: 
		SendPos (214) 
Return 
; <cm_RightByNam>: >> Right window: sorted by file name {{{2 
<cm_RightByNam>: 
		SendPos (221 ) 
Return 
; <cm_RightByEx>: >> Right window: Sort by extension {{{2 
<cm_RightByEx>: 
		SendPos (222) 
Return 
; <cm_RightBySiz>: >> Right window: Sort by size {{{2 
<cm_RightBySiz>: 
		SendPos (223) 
Return 
; <cm_RightByDateTim>: >> Right window: Sort by date and time {{{2 
<cm_RightByDateTim>: 
		SendPos (224) 
Return 
; <cm_RightUnsorte>: >> Right window: {{{2 does not sort 
<cm_RightUnsorte >: 
		SendPos (225) 
Return 
; <cm_RightNegOrde>: >> Right window: reverse sort {{{2 
<cm_RightNegOrde>: 
		SendPos (230) 
Return 
; <cm_RightOpenDrive>: >> right window: open the drive list {{{2 
<cm_RightOpenDrives>: 
		SendPos (231) 
Return 
; <cm_RightPathFocu>: >> Right window: the focus is placed on the path {{{2 
<cm_RightPathFocu>: 
		SendPos (232) 
Return 
; <cm_RightDirBranch>: >> Right window: expand All files folder {{{2 
<cm_RightDirBranch>: 
	SendPos (2035) 
Return 
; <cm_RightDirBranchSel>: >> Right window: expand only the selected folder {{{2 
<cm_RightDirBranchSel>: 
	SendPos (2048) 
Return 
; <cm_RightThumb>: >> Right window: thumbnails {{{2 
<cm_RightThumb>: 
	SendPos (169) 
Return 
; <cm_RightCustomViewMen>: >> Right window: custom views menu {{{2 
<cm_RightCustomViewMen>: 
	SendPos (170) 
Return 
; file operations == ======================================= 
Return 
; <cm_List>: >> View (with Viewer) {{{2 
<cm_List>: 
	SendPos (903) 
Return 
; <cm_ListInternalOnly>: >> View (with viewer, but do not plug / multimedia) {{{2 
<cm_ListInternalOnly>: 
	SendPos (1006) 
Return 
; < cm_Edit>: >> edit {{{2 
<cm_Edit>: 
		SendPos (904) 
Return 
; <cm_Copy>: >> copy {{{2 
<cm_Copy>: 
	SendPos (905) 
Return 
; <cm_CopySamepanel>: >> copied to the current window {{{2 
<cm_CopySamepanel>: 
	SendPos (3100) 
Return 
; <cm_CopyOtherpanel>: >> copied to another window {{{2 
<cm_CopyOtherpanel>: 
	SendPos (3101) 
Return 
; <cm_RenMov>: >> rename / move {{{2 
<cm_RenMov>: 
	SendPos (906) 
Return 
; <cm_MkDir>: >> New folder {{{2 
<cm_MkDir>: 
	SendPos (907) 
Return 
; <cm_Delete>: >> remove {{{2 
<cm_Delete >: 
	SendPos (908) 
Return 
; <cm_TestArchive>: >> test compression package {{{2 
<cm_TestArchive>: 
	SendPos (518) 
Return 
; <cm_PackFiles>: >> archive {{{2 
<cm_PackFiles>: 
	SendPos (508 ) 
Return 
; <cm_UnpackFiles>: >> unzip the file {{{2 
<cm_UnpackFiles>: 
	SendPos (509) 
Return 
; <cm_RenameOnly>: >> rename (Shift + F6) {{{2 
<cm_RenameOnly>: 
	SendPos (1002) 
return 
; <cm_RenameSingleFile>: >> rename the current file {{{2 
<cm_RenameSingleFile>: 
	SendPos (1007) 
return 
; <cm_MoveOnly>: >> mobile (F6) {{{2 
<cm_MoveOnly>: 
	SendPos (1005) 
return 
; <cm_Properties>: >> display attributes {{{2 
<cm_Properties>: 
	SendPos (1003) 
Return 
; <cm_CreateShortcut>: >> Create shortcut {{{2 
<cm_CreateShortcut>: 
	SendPos (1004) 
Return 
; <cm_Return>:> > press ENTER imitation {{{2 
<cm_Return>: 
	SendPos (1001) 
Return 
; <cm_OpenAsUser>: >> {{{2 program to run as another user's cursor 
<cm_OpenAsUser>: 
	SendPos (2800) 
Return 
; <cm_Split >: >> split file {{{2 
<cm_Split>: 
	SendPos (560) 
Return 
; <cm_Combine>: >> merge file {{{2 
<cm_Combine>: 
	SendPos (561) 
Return 
; <cm_Encode>: >> encoded file (MIME / UUE / XXE format) {{{2 
<cm_Encode>: 
	SendPos (562) 
Return 
; <cm_Decode>: >> decode the file (MIME / UUE / XXE / BinHex format) {{{2 
<cm_Decode>: 
	SendPos ( 563) 
Return 
; <cm_CRCcreate>: >> Creating the checksum file {{{2 
<cm_CRCcreate>: 
	SendPos (564) 
Return 
; <cm_CRCcheck>: >> checksum verification {{{2 
<cm_CRCcheck>: 
	SendPos (565) 
return 
; <cm_SetAttrib>: >> change the properties {{{2 
<cm_SetAttrib>: 
	SendPos (502) 
return 
; configuration ========================= ================ 
Return 
; <cm_Config>: >> configuration: layout 2 {{{ 
<cm_Config>: 
	SendPos (490) 
Return 
; <cm_DisplayConfig>: >> configuration: display {{{2 
<cm_DisplayConfig>: 
	SendPos (486) 
Return 
; <cm_IconConfig>: >> configuration: 2 icon {{{ 
<cm_IconConfig>: 
	SendPos (477) 
Return 
; <cm_FontConfig>: >> configuration: font {{{2 
<cm_FontConfig>: 
	SendPos (492) 
Return 
; <cm_ColorConfig>: >> configuration: color {{{2 
<cm_ColorConfig>: 
	SendPos (494) 
Return 
; <cm_ConfTabChange>: >> configuration: tab {{{2 
<cm_ConfTabChange >: 
	SendPos (497) 
Return 
; <cm_DirTabsConfig>: >> configuration: folders tab {{{2 
<cm_DirTabsConfig>: 
	SendPos (488) 
Return 
; <cm_CustomColumnConfig>: >> configuration: customize columns {{{2 
<cm_CustomColumnConfig >: 
	SendPos (483) 
Return 
; <cm_CustomColumnDlg>: >> change the current customize columns {{{2 
<cm_CustomColumnDlg>: 
	SendPos (2920) 
Return 
; <cm_LanguageConfig>: >> configuration: language {{{2 
<cm_LanguageConfig>: 
	SendPos (499) 
Return 
; <cm_Config2>: >>: operating mode {{{2 
<cm_Config2>: 
	SendPos (516) 
Return 
; <cm_EditConfig>: >> configuration: edit / View {{{2 
<cm_EditConfig>: 
	SendPos (496) 
Return 
; <cm_CopyConfig>: >> configuration: copy / delete {{{2 
<cm_CopyConfig>: 
	SendPos (487) 
Return 
; <cm_RefreshConfig>: >> configuration: refresh {{{2 
<cm_RefreshConfig>: 
	SendPos (478 ) 
Return 
; <cm_QuickSearchConfig>: >> configuration: Quick Search {{{2 
<cm_QuickSearchConfig>: 
	SendPos (479) 
Return 
; <cm_FtpConfig>: >> configuration: FTP {{{2 
<cm_FtpConfig>: 
	SendPos (489) 
Return 
; <cm_PluginsConfig>: >> configuration: plug-in {{{2 
<cm_PluginsConfig>: 
	SendPos (484) 
Return 
; <cm_ThumbnailsConfig>: >> configuration: thumbnail {{{2 
<cm_ThumbnailsConfig>: 
	SendPos (482) 
Return 
; <cm_LogConfig> : >> configuration: log file {{{2 
<cm_LogConfig>: 
	SendPos (481) 
Return 
; <cm_IgnoreConfig>: >> configuration: hidden files {{{2 
<cm_IgnoreConfig>: 
	SendPos (480) 
Return 
; <cm_PackerConfig>:> > configuration: compressor {{{2 
<cm_PackerConfig>: 
	SendPos (491) 
Return 
; <cm_ZipPackerConfig>: >> configuration: ZIP compression program {{{2 
<cm_ZipPackerConfig>: 
	SendPos (485) 
Return 
; <cm_Confirmation>: >> configuration: other / confirm {{{2 
<cm_Confirmation>: 
	SendPos (495) 
Return 
; <cm_ConfigSavePos>: >> save location {{{2 
<cm_ConfigSavePos>: 
	SendPos (493) 
Return 
; <cm_ButtonConfig>: >> change toolbar {{{2 
<cm_ButtonConfig>: 
	SendPos (498) 
Return 
; <cm_ConfigSaveSettings>: >> save settings {{{2 
<cm_ConfigSaveSettings>: 
	SendPos (580) 
Return 
; <cm_ConfigChangeIniFiles>: >> directly modify the configuration file {{{2 
<cm_ConfigChangeIniFiles>: 
	SendPos (581) 
Return 
; <cm_ConfigSaveDirHistory>: >> save folder history {{{2 
<cm_ConfigSaveDirHistory>: 
	SendPos (582) 
Return 
; <cm_ChangeStartMenu>: >> change the start menu {{{2 
<cm_ChangeStartMenu >: 
	SendPos (700) 
Return 
; network ========================================= 
return 
; <cm_NetConnect>: >> map network drive {{{2 
<cm_NetConnect>: 
	SendPos (512) 
return 
; <cm_NetDisconnect>: >> disconnect network drive {{{2 
<cm_NetDisconnect>: 
	SendPos (513) 
return 
; < cm_NetShareDir>: >> share current folder {{{2 
<cm_NetShareDir>: 
	SendPos (514) 
Return 
; <cm_NetUnshareDir>: >> cancel folder sharing {{{2 
<cm_NetUnshareDir>: 
	SendPos (515) 
Return 
; <cm_AdministerServer> : >> display system shared folder {{{2 
<cm_AdministerServer>: 
	SendPos (2204) 
Return 
; <cm_ShowFileUser>: >> displays the remote user's local file {{{2 
<cm_ShowFileUser>: 
	SendPos (2203) 
Return 
; other = ======================================== 
Return 
; <cm_GetFileSpace>: >> computing occupancy space {{{2 
<cm_GetFileSpace>: 
	SendPos (503) 
Return 
; <cm_VolumeId>: >> set label {{{2 
<cm_VolumeId>: 
	SendPos (505) 
Return 
; <cm_VersionInfo>: >> version information {{{2 
<cm_VersionInfo>: 
	SendPos (510) 
Return 
; <cm_ExecuteDOS>: >> open a command prompt window {{{2 
<cm_ExecuteDOS>: 
	SendPos (511) 
Return 
; <cm_CompareDirs>: >> Compare folders {{{2 
<cm_CompareDirs >: 
	SendPos (533) 
Return 
; <cm_CompareDirsWithSubdirs>: >> compare folders (and subfolders another window does not mark folder) {{{2 
<cm_CompareDirsWithSubdirs>: 
	SendPos (536) 
Return 
; <cm_ContextMenu>: >> display a shortcut menu {{{2 
<cm_ContextMenu>: 
	SendPos (2500) 
Return 
; <cm_ContextMenuInternal>: >> display a shortcut menu (inter-related) {{{2 
<cm_ContextMenuInternal>: 
	SendPos (2927) 
Return 
; <cm_ContextMenuInternalCursor>: >> displays the internal cursor files associated shortcut menu {{{2 
<cm_ContextMenuInternalCursor>: 
	SendPos (2928) 
Return 
; <cm_ShowRemoteMenu>: >> media Center remote control play / pause key shortcut menu {{{2 
<cm_ShowRemoteMenu>: 
	SendPos (2930 ) 
Return 
; <cm_SyncChangeDir>: >> changes on both sides of the window to synchronize the folder {{{2 
<cm_SyncChangeDir>: 
	SendPos (2600) 
Return 
; <cm_EditComment>: >> edit the file {{{Note 2 
<cm_EditComment>: 
	SendPos (2700) 
return 
; <cm_FocusLeft>: >> focus on the left window {{{2 
<cm_FocusLeft>: 
	SendPos (4001) 
return 
; <cm_FocusRight>: >> focus placed in the right window {{{2 
<cm_FocusRight>: 
	SendPos (4002) 
return 
; <cm_FocusCmdLine>: >> focus on the command line {{{2 
<cm_FocusCmdLine>: 
	SendPos (4003) 
return 
; <cm_FocusButtonBar>: >> focus on the toolbar {{{2 
<cm_FocusButtonBar>: 
	SendPos (4004) 
return 
; <cm_CountDirContent>: >> calculate all the space occupied folders {{{2 
<cm_CountDirContent>: 
	SendPos (2014) 
return 
; <cm_UnloadPlugins>: >> uninstall all plug-ins {{{2 
<cm_UnloadPlugins>: 
	SendPos (2913) 
return 
; <cm_DirMatch>: >> mark new files, hidden by the same {{{2 
<cm_DirMatch>: 
	SendPos (534) 
return 
; <cm_Exchange>: >> exchange about window {{{2 
<cm_Exchange>: 
	SendPos (531 ) 
Return 
; <cm_MatchSrc>: >> target = source {{{2 
<cm_MatchSrc>: 
	SendPos (532) 
Return 
; <cm_ReloadSelThumbs>: >> refresh thumbnail of the selected file {{{2 
<cm_ReloadSelThumbs>: 
	SendPos (2918) 
return 
; parallel ========================================= 
return 
; <cm_DirectCableConnect>: >> direct cable connection {{{2 
<cm_DirectCableConnect>: 
	SendPos (2300) 
Return 
; <cm_NTinstallDriver>: >> load NT parallel port driver {{{2 
<cm_NTinstallDriver>: 
	SendPos (2301) 
Return 
; <cm_NTremoveDriver>: >> uninstall NT parallel port driver {{{2 
<cm_NTremoveDriver>: 
	SendPos (2302) 
Return 
; print ============================== =========== 
Return 
; <cm_PrintDir>: >> Print file list {{{2 
<cm_PrintDir>: 
	SendPos (2027) 
Return 
; <cm_PrintDirSub>: >> print a list of files (including subfolders ) {{{2 
<cm_PrintDirSub>: 
	SendPos (2028) 
Return 
; <cm_PrintFile>: >> Print the file content {{{2 
<cm_PrintFile>: 
	SendPos (504) 
Return 
; select =========== ============================== 
Return 
; <cm_SpreadSelection>: >> select a group of files {{{2 
<cm_SpreadSelection>: 
	SendPos (521) 
Return 
; <cm_SelectBoth>: >> select a group: files and folders {{{2 
<cm_SelectBoth>: 
	SendPos (3311) 
Return 
; <cm_SelectFiles>: >> select a group: only file {{{2 
<cm_SelectFiles>: 
	SendPos (3312) 
Return 
; <cm_SelectFolders>: >> select a group: only folders {{{2 
<cm_SelectFolders>: 
	SendPos (3313) 
Return 
; <cm_ShrinkSelection>: >> do not choose a group of files {{ {2 
<cm_ShrinkSelection>: 
	SendPos (522) 
Return 
; <cm_ClearFiles>: >> do not choose a group: only file {{{2 
<cm_ClearFiles>: 
	SendPos (3314) 
Return 
; <cm_ClearFolders>: >> do not choose a group: only the folder {{{2 
<cm_ClearFolders>: 
	SendPos (3315) 
Return 
; <cm_ClearSelCfg>: >> do not choose a group: files and / or folders (depending on configuration) {{{2 
<cm_ClearSelCfg>: 
	SendPos ( 3316) 
Return 
; <cm_SelectAll>: >> Select all: files and / or folders (depending on configuration) {{{2 
<cm_SelectAll>: 
	SendPos (523) 
Return 
; <cm_SelectAllBoth>: >> Select all: file and folder {{{2 
<cm_SelectAllBoth>: 
	SendPos (3301) 
Return 
; <cm_SelectAllFiles>: >> select all: only the files {{{2 
<cm_SelectAllFiles>: 
	SendPos (3302) 
Return 
; <cm_SelectAllFolders>: >> Select all: only the folder {{{2 
<cm_SelectAllFolders>: 
	SendPos (3303) 
Return 
; <cm_ClearAll>: >> cancel all: files and folders {{{2 
<cm_ClearAll>: 
	SendPos (524) 
Return 
; <cm_ClearAllFiles>: >> cancel all: only the files {{{2 
<cm_ClearAllFiles>: 
	SendPos (3304) 
Return 
; <cm_ClearAllFolders>: >> cancel all: only the folder {{{2 
<cm_ClearAllFolders>: 
	SendPos (3305) 
Return 
; <cm_ClearAllCfg>:> > cancel all: the files and / or folders (depending on configuration) {{{2 
<cm_ClearAllCfg>: 
	SendPos (3306) 
Return 
; <cm_ExchangeSelection>: >> Invert {{{2 
<cm_ExchangeSelection>: 
	SendPos (525 ) 
Return 
; <cm_ExchangeSelBoth>: >> Invert selection: files and folders {{{2 
<cm_ExchangeSelBoth>: 
	SendPos (3321) 
Return 
; <cm_ExchangeSelFiles>: >> Invert selection: only file {{{2 
<cm_ExchangeSelFiles> : 
	SendPos (3322) 
Return 
; <cm_ExchangeSelFolders>: >> Invert selection: only the folder {{{2 
<cm_ExchangeSelFolders>: 
	SendPos (3323) 
Return 
; <cm_SelectCurrentExtension>: >> choose the same file extension {{{2 
<cm_SelectCurrentExtension>: 
	SendPos (527) 
Return 
; <cm_UnselectCurrentExtension>: >> do not choose the same file extension {{{2 
<cm_UnselectCurrentExtension>: 
	SendPos (528) 
Return 
; <cm_SelectCurrentName>: >> Select the file with the same name in the paper { {{2 
<cm_SelectCurrentName>: 
	SendPos (541) 
Return 
; <cm_UnselectCurrentName>: >> do not choose the file with the same filename {{{2 
<cm_UnselectCurrentName>: 
	SendPos (542) 
Return 
; <cm_SelectCurrentNameExt>: >> Select the file name and extension the same filename {{{2 
<cm_SelectCurrentNameExt>: 
	SendPos (543) 
Return 
; <cm_UnselectCurrentNameExt>: >> Uncheck the file name and the same file name extension {{{2 
<cm_UnselectCurrentNameExt>: 
	SendPos (544) 
Return 
; <cm_SelectCurrentPath> : >> Select the file under the same path (+ expand the folder to search for files) {{{2 
<cm_SelectCurrentPath>: 
	SendPos (537) 
Return 
; <cm_UnselectCurrentPath>: >> do not choose the same path of the file (folder + expand Search file) {{{2 
<cm_UnselectCurrentPath>: 
	SendPos (538) 
Return 
; <cm_RestoreSelection>: >> resume selection list {{{2 
<cm_RestoreSelection>: 
	SendPos (529) 
Return 
; <cm_SaveSelection>: >> save selection list {{ {2 
<cm_SaveSelection>: 
	SendPos (530) 
Return 
; <cm_SaveSelectionToFile>: >> export selection list {{{2 
<cm_SaveSelectionToFile>: 
	SendPos (2031) 
Return 
; <cm_SaveSelectionToFileA>: >> export selection list (ANSI) {{{ 2 
<cm_SaveSelectionToFileA>: 
	SendPos (2041) 
Return 
; <cm_SaveSelectionToFileW>: >> export selection list (Unicode) {{{2 
<cm_SaveSelectionToFileW>: 
	SendPos (2042) 
Return 
; <cm_SaveDetailsToFile>: >> export the details {{{2 
<cm_SaveDetailsToFile>: 
	SendPos (2039) 
Return 
; <cm_SaveDetailsToFileA>: >> export the details (ANSI) {{{2 
<cm_SaveDetailsToFileA>: 
	SendPos (2043) 
Return 
; <cm_SaveDetailsToFileW>: >> export the details (Unicode) {{ {2 
<cm_SaveDetailsToFileW>: 
	SendPos (2044) 
Return 
; <cm_LoadSelectionFromFile>: >> import selection list (from a file) {{{2 
<cm_LoadSelectionFromFile>: 
	SendPos (2032) 
Return 
; <cm_LoadSelectionFromClip>: >> import selection list (from clipboard) {{{2 
<cm_LoadSelectionFromClip>: 
	SendPos (2033) 
Return 
; security ================================ ========= 
Return 
; <cm_EditPermissionInfo>: >> set permissions (NTFS) {{{2 
<cm_EditPermissionInfo>: 
	SendPos (2200) 
Return 
; <cm_EditAuditInfo>: >> audit file (NTFS) {{{ 2 
<cm_EditAuditInfo>: 
	SendPos (2201) 
Return 
; <cm_EditOwnerInfo>: >> take ownership (NTFS) {{{2 
<cm_EditOwnerInfo>: 
	SendPos (2202) 
Return 
; clipboard ============ ============================= 
Return 
; <cm_CutToClipboard>: >> cut the selected file to the clipboard {{{2 
< cm_CutToClipboard>: 
	SendPos (2007) 
Return 
; <cm_CopyToClipboard>: >> copy the selected file to the clipboard {{{2 
<cm_CopyToClipboard>: 
	SendPos (2008) 
Return 
; <cm_PasteFromClipboard>: >> paste from the clipboard to the current folder {{{2 
<cm_PasteFromClipboard>: 
	SendPos (2009) 
Return 
; <cm_CopyNamesToClip>: >> copy the file name {{{2 
<cm_CopyNamesToClip>: 
	SendPos (2017) 
Return 
; <cm_CopyFullNamesToClip>: >> copy the full path and file name { {{2 
<cm_CopyFullNamesToClip>: 
	SendPos (2018) 
Return 
; <cm_CopyNetNamesToClip>: >> copy the file name and network path {{{2 
<cm_CopyNetNamesToClip>: 
	SendPos (2021) 
Return 
; <cm_CopySrcPathToClip>: >> copy source path {{ {2 
<cm_CopySrcPathToClip>: 
	SendPos (2029) 
Return 
; <cm_CopyTrgPathToClip>: >> copy destination path {{{2 
<cm_CopyTrgPathToClip>: 
	SendPos (2030) 
Return 
; <cm_CopyFileDetailsToClip>: >> copy file details {{{2 
< cm_CopyFileDetailsToClip>: 
	SendPos (2036) 
Return 
; <cm_CopyFpFileDetailsToClip>: >> copy the full path and file details {{{2 
<cm_CopyFpFileDetailsToClip>:
	SendPos (2037) 
Return 
; <cm_CopyNetFileDetailsToClip>: >> Copy file details and network paths {{{2 
<cm_CopyNetFileDetailsToClip>: 
	SendPos (2038) 
Return 
; FTP ================ ========================= 
Return 
; <cm_FtpConnect>: FTP connection >> {{{2 
<cm_FtpConnect>: 
	SendPos (550) 
Return 
; < cm_FtpNew>: >> New FTP connection {{{2 
<cm_FtpNew>: 
	SendPos (551) 
Return 
; <cm_FtpDisconnect>: >> disconnect FTP connection {{{2 
<cm_FtpDisconnect>: 
	SendPos (552) 
Return 
; <cm_FtpHiddenFiles>: >> show hidden files {{{2 
<cm_FtpHiddenFiles>: 
	SendPos (553) 
Return 
; <cm_FtpAbort>: >> abort the current FTP command {{{2 
<cm_FtpAbort>: 
	SendPos (554) 
Return 
; <cm_FtpResumeDownload>: continued >> Biography {{{2 
<cm_FtpResumeDownload>: 
	SendPos (555) 
Return 
; <cm_FtpSelectTransferMode>: >> Select transfer mode {{{2 
<cm_FtpSelectTransferMode>: 
	SendPos (556) 
Return 
; <cm_FtpAddToList>: >> Add to download list {{ {2 
<cm_FtpAddToList>: 
	SendPos (557) 
Return 
; <cm_FtpDownloadList>: >> download by list {{{2 
<cm_FtpDownloadList>: 
	SendPos (558) 
Return 
; navigation ============== =========================== 
Return 
; <cm_GotoPreviousDir>: >> Back {{{2 
<cm_GotoPreviousDir>: 
	SendPos (570) 
Return 
; <cm_GotoNextDir>: >> forward {{{2 
<cm_GotoNextDir>: 
	SendPos (571) 
Return 
; <cm_DirectoryHistory>: >> folder history {{{2 
<cm_DirectoryHistory>: 
	Vim_HotkeyCount: = 0 
	SendPos (572) 
Return 
; < cm_GotoPreviousLocalDir>: >> Back (non-FTP) {{{2 
<cm_GotoPreviousLocalDir>: 
	SendPos (573) 
Return 
; <cm_GotoNextLocalDir>: >> forward (non-FTP) {{{2 
<cm_GotoNextLocalDir>: 
	SendPos (574) 
Return 
; < cm_DirectoryHotlist>: >> frequently used folders {{{2 
<cm_DirectoryHotlist>: 
	Vim_HotkeyCount: = 0 
	SendPos (526) 
Return 
; <cm_GoToRoot>: >> Go to the root folder {{{2 
<cm_GoToRoot>: 
	SendPos (2001) 
Return 
; <cm_GoToParent>: >> Go to the parent folder {{{2 
<cm_GoToParent>: 
	SendPos (2002) 
Return 
; <cm_GoToDir>: >> open cursor folder or archive {{{2 
<cm_GoToDir>: 
	SendPos (2003) 
Return 
; <cm_OpenDesktop>: Desktop >> {{{2 
<cm_OpenDesktop>: 
	SendPos (2121) 
Return 
; <cm_OpenDrives>: >> my computer {{{2 
<cm_OpenDrives>: 
	SendPos (2122) 
Return 
; < cm_OpenControls>: >> control panel {{{2 
<cm_OpenControls>: 
	SendPos (2123) 
Return 
; <cm_OpenFonts>: >> font {{{2 
<cm_OpenFonts>: 
	SendPos (2124) 
Return 
; <cm_OpenNetwork>: >> Network Places {{{2 
<cm_OpenNetwork>: 
	SendPos (2125) 
Return 
; <cm_OpenPrinters>: >> printer {{{2 
<cm_OpenPrinters>: 
	SendPos (2126) 
Return 
; <cm_OpenRecycled>: >> trash {{{2 
<cm_OpenRecycled> :
	SendPos (2127) 
Return 
; <cm_CDtree>: >> Change the folder {{{2 
<cm_CDtree>: 
	SendPos (500) 
Return 
; <cm_TransferLeft>: >> Open at the cursor in the left window folder or archive {{{ 2 
<cm_TransferLeft>: 
	SendPos (2024) 
Return 
; <cm_TransferRight>: >> open cursor in the right window folder or archive {{{2 
<cm_TransferRight>: 
	SendPos (2025) 
Return 
; <cm_EditPath>: >> edit source path window {{{2 
<cm_EditPath>: 
	SendPos (2912) 
Return 
; <cm_GoToFirstFile>: >> move the cursor to the first file in the list {{{2 
<cm_GoToFirstFile>: 
	SendPos (2050) 
Return 
; <cm_GotoNextDrive >: >> Go to the next drive {{{2 
<cm_GotoNextDrive>: 
	SendPos (2051) 
Return 
; <cm_GotoPreviousDrive>: >> Go on a drive {{{2 
<cm_GotoPreviousDrive>: 
	SendPos (1033) 
Return 
; <cm_GotoNextSelected >: >> Go to the next selected file {{{2 
<cm_GotoNextSelected>: 
	SendPos (2053) 
Return 
; <cm_GotoPrevSelected>: >> Go on a selected file {{{2 
<cm_GotoPrevSelected>: 
	SendPos (2054) 
return 
; <cm_GotoDriveA>: >> Go drive A {{{2 
<cm_GotoDriveA>: 
	SendPos (2061) 
return 
; <cm_GotoDriveC>: >> Go to drive C {{{2 
<cm_GotoDriveC>: 
	SendPos (2063) 
return 
; <cm_GotoDriveD>: >> Go drive D {{{2 
<cm_GotoDriveD>: 
	SendPos (2064) 
Return 
; <cm_GotoDriveE>: >> Go drive E {{{2 
<cm_GotoDriveE>: 
	SendPos (2065) 
Return 
; <cm_GotoDriveF >: >> can customize other drives {{{2 
<cm_GotoDriveF>: 
	SendPos (2066) 
Return 
; <cm_GotoDriveZ>: >> Up to 26 {{{2 
<cm_GotoDriveZ>: 
	SendPos (2086) 
Return 
; help === ====================================== 
Return 
; <cm_HelpIndex>: >> help index {{ {2 
<cm_HelpIndex>: 
	SendPos (610) 
Return 
; <cm_Keyboard>: >> shortcut list {{{2 
<cm_Keyboard>: 
	SendPos (620) 
Return 
; <cm_Register>: >> registration information {{{2 
<cm_Register> : 
	SendPos (630) 
Return 
; <cm_VisitHomepage>: >> visit Totalcmd site {{{2 
<cm_VisitHomepage>: 
	SendPos (640) 
Return 
; <cm_About>: >> About Total Commander {{{2 
<cm_About>: 
	SendPos (690 ) 
Return 
; window ========================================= 
Return 
; <cm_Exit> : exit Total Commander >> {{{2 
<cm_Exit>: 
	SendPos (24340) 
Return 
; <cm_Minimize>: >> minimize Total Commander {{{2 
<cm_Minimize>: 
	SendPos (2000) 
Return 
; <cm_Maximize>: >> maximize Total Commander {{{2 
<cm_Maximize>: 
	SendPos (2015) 
Return 
; <cm_Restore>: >> resume normal size {{{2 
<cm_Restore>: 
	SendPos (2016) 
Return 
; command line ======= ================================== 
Return 
; <cm_ClearCmdLine>: >> clear the command line {{{2 
< cm_ClearCmdLine>: 
	SendPos (2004) 
Return 
; <cm_NextCommand>: >> next command {{{2 
<cm_NextCommand>: 
	SendPos (2005) 
Return 
; <cm_PrevCommand>: >> previous command {{{2 
<cm_PrevCommand>: 
	SendPos (2006) 
Return 
; <cm_AddPathToCmdline>: >> copy path to the command line {{{2 
<cm_AddPathToCmdline>: 
	SendPos (2019) 
Return 
; tool ================== ======================= 
Return 
; <cm_MultiRenameFiles>: >> batch rename {{{2 
<cm_MultiRenameFiles>: 
	SendPos (2400) 
Return 
; <cm_SysInfo >: >> system information {{{2 
<cm_SysInfo>: 
	SendPos (506) 
Return 
; <cm_OpenTransferManager>: >> background transfer Manager {{{2 
<cm_OpenTransferManager>: 
	SendPos (559) 
Return 
; <cm_SearchFor>: >> Search file {{{2 
<cm_SearchFor>: 
	SendPos (501) 
Return 
; <cm_FileSync>: >> synchronize folders {{{2 
<cm_FileSync>: 
	SendPos (2020) 
Return 
; <cm_Associate>: >> file association {{{ 2 
<cm_Associate>: 
	SendPos (507) 
Return 
; <cm_InternalAssociate>: >> definition of internal association {{{2 
<cm_InternalAssociate>: 
	SendPos (519) 
Return 
; <cm_CompareFilesByContent>: >> compare file contents {{{2 
<cm_CompareFilesByContent> : 
	SendPos (2022) 
Return 
; <cm_IntCompareFilesByContent>: >> using internal comparison program {{{2 
<cm_IntCompareFilesByContent>: 
	SendPos (2040) 
Return 
; <cm_CommandBrowser>: >> View command inside {{{2 
<cm_CommandBrowser>: 
	SendPos ( 2924) 
Return 
; view ========================================= 
Return 
; <cm_VisButtonbar >: >> show / Hide: The toolbar {{{2 
<cm_VisButtonbar>: 
	SendPos (2901) 
Return 
; <cm_VisDriveButtons>: >> show / Hide: drive button {{{2 
<cm_VisDriveButtons>: 
	SendPos (2902) 
Return 
; <cm_VisTwoDriveButtons>: >> show / Hide: two drives button bar {{{2 
<cm_VisTwoDriveButtons>: 
	SendPos (2903) 
Return 
; <cm_VisFlatDriveButtons>: >> switching: flat / stereo drive button {{{2 
<cm_VisFlatDriveButtons>: 
	SendPos (2904) 
Return 
; <cm_VisFlatInterface>: >> switching: flat / three-dimensional user interface {{{2 
<cm_VisFlatInterface>: 
	SendPos (2905) 
Return 
; <cm_VisDriveCombo>: >> show / Hide: drives list {{{2 
< cm_VisDriveCombo>: 
	SendPos (2906) 
Return 
; <cm_VisCurDir>: >> show / Hide: The current folder {{{2 
<cm_VisCurDir>: 
	SendPos (2907) 
Return 
; <cm_VisBreadCrumbs>: >> show / Hide: route navigation bar { {{2 
<cm_VisBreadCrumbs>: 
	SendPos (2926) 
Return 
; <cm_VisTabHeader>: >> show / Hide: Sort tabs {{{2 
<cm_VisTabHeader>: 
	SendPos (2908) 
Return 
; <cm_VisStatusbar>: >> show / Hide : status bar {{{2 
<cm_VisStatusbar>: 
	SendPos (2909) 
Return 
; <cm_VisCmdLine>: >> show / Hide: command line {{{2 
<cm_VisCmdLine>: 
	SendPos (2910) 
Return 
; <cm_VisKeyButtons>: >> display / hide: function key buttons {{{2 
<cm_VisKeyButtons>: 
	SendPos (2911) 
Return 
; <cm_ShowHint>: >> display file prompt {{{2 
<cm_ShowHint>: 
	SendPos (2914) 
Return 
; <cm_ShowQuickSearch>: >> display Quick Search window {{{2 
<cm_ShowQuickSearch>: 
	SendPos (2915) 
Return 
; <cm_SwitchLongNames>: >> On / Off: long file name display {{{2 
<cm_SwitchLongNames>: 
	SendPos (2010) 
Return 
; <cm_RereadSource>:> > refresh sources window {{{2 
<cm_RereadSource>: 
	SendPos (540) 
Return 
; <cm_ShowOnlySelected>: >> display only the selected file {{{2 
<cm_ShowOnlySelected>: 
	SendPos (2023) 
Return 
; <cm_SwitchHidSys>: >> open / Close: hidden or system files show {{{2 
<cm_SwitchHidSys>: 
	SendPos (2011) 
Return 
; <cm_Switch83Names>: >> On / Off: 8.3 filenames lowercase type {{{2 
<cm_Switch83Names>: 
	SendPos (2013) 
return 
; <cm_SwitchDirSort>: >> On / Off: folder Sort by name {{{2 
<cm_SwitchDirSort>: 
	SendPos (2012) 
return 
; <cm_DirBranch>: >> expand All folders {{{2 
<cm_DirBranch>: 
	SendPos (2026) 
Return 
; <cm_DirBranchSel>: >> expand only the selected folder {{{2 
<cm_DirBranchSel>: 
	SendPos (2046) 
Return 
; <cm_50Percent>: >> window divider bar located 50% {{{2 
<cm_50Percent> : 
	SendPos (909) 
Return 
; <cm_100Percent>: >> window divider bar located 100% {{{2 
<cm_100Percent>: 
	SendPos (910) 
Return 
; <cm_VisDirTabs>: >> show / Hide: folders tab {{{2 
<cm_VisDirTabs>: 
	SendPos (2916) 
Return 
; <cm_VisXPThemeBackground>: >> show / Hide: XP Themes {{{2 
<cm_VisXPThemeBackground>: 
	SendPos (2923) 
Return 
; <cm_SwitchOverlayIcons>: >> On / Off: stacked icon display {{{2 
<cm_SwitchOverlayIcons>: 
	SendPos (2917) 
Return 
; <cm_VisHistHotButtons>: >> show / Hide: folder history and frequently used folders button {{{2 
<cm_VisHistHotButtons>: 
	SendPos (2919) 
Return 
; <cm_SwitchWatchDirs >: >> enable / disable: The folder automatically refresh {{{2 
<cm_SwitchWatchDirs>: 
	SendPos (2921) 
Return 
; <cm_SwitchIgnoreList>: >> enable / disable: custom hide file {{{2 
<cm_SwitchIgnoreList>: 
	SendPos ( 2922) 
Return 
; <cm_SwitchX64Redirection>: >> On / Off: 32 system32 folder redirection (Windows 64) {{{2 
<cm_SwitchX64Redirection>: 
	SendPos (2925) 
Return 
; <cm_SeparateTreeOff>: >> Close independence folder tree panel {{{2 
<cm_SeparateTreeOff>: 
	SendPos (3200) 
Return 
; <cm_SeparateTree1>: >> a separate folder tree panel {{{2 
<cm_SeparateTree1>: 
	SendPos (3201) 
Return 
; <cm_SeparateTree2>: >> two independent folder tree panel {{{2 
<cm_SeparateTree2>: 
	SendPos (3202) 
Return 
; <cm_SwitchSeparateTree>: >> folder tree panel switch independent state {{{2 
<cm_SwitchSeparateTree>: 
	SendPos (3203) 
Return 
; <cm_ToggleSeparateTree1>:> > On / Off: a separate folder tree panel {{{2 
<cm_ToggleSeparateTree1>: 
	SendPos (3204) 
Return 
; <cm_ToggleSeparateTree2>: >> On / Off: two separate folder tree panel {{{2 
<cm_ToggleSeparateTree2>: 
	SendPos (3205) 
Return 
; user ========================================= 
Return 
; <cm_UserMenu1>: >> user menu 1 {{{2 
<cm_UserMenu1>: 
	SendPos (701) 
Return 
; <cm_UserMenu2>: >> user menu 2 {{{2 
<cm_UserMenu2>: 
	SendPos (702) 
Return 
; <cm_UserMenu3>: >> user menu 3 {{{2 
<cm_UserMenu3>: 
	SendPos (703) 
Return 
; <cm_UserMenu4>: >> ... {{{2 
<cm_UserMenu4>: 
	SendPos (704) 
Return 
; <cm_UserMenu5>: >> 5 { {{2 
<cm_UserMenu5>: 
	SendPos (70) 
Return 
; <cm_UserMenu6>: >> 6 {{{2 
<cm_UserMenu6>: 
	SendPos (70) 
Return 
; <cm_UserMenu7>: >> 7 {{{2 
<cm_UserMenu7>: 
	SendPos (70) 
Return 
; <cm_UserMenu8>: >> 8 {{{2 
<cm_UserMenu8>: 
	SendPos (70) 
Return 
; <cm_UserMenu9>: >> 9 {{{2 
<cm_UserMenu9>: 
	SendPos (70) 
Return 
; <cm_UserMenu10> : >> other user-definable menu {{{2 
<cm_UserMenu10>: 
	SendPos (710) 
Return 
; tag =========================== ============== 
Return 
; <cm_OpenNewTab>: >> New tag {{{2 
<cm_OpenNewTab>: 
	SendPos (3001) 
Return 
; <cm_OpenNewTabBg>: >> New label (in the background) {{{2 
<cm_OpenNewTabBg>: 
	SendPos (3002) 
Return 
; <cm_OpenDirInNewTab>: >> New label (and open the cursor folder) {{{2 
<cm_OpenDirInNewTab>: 
	SendPos (3003) 
Return 
; <cm_OpenDirInNewTabOther>:> > New tab (open the folder in another window) {{{2 
<cm_OpenDirInNewTabOther>: 
	SendPos (3004) 
Return 
; <cm_SwitchToNextTab>: >> next tab (Ctrl + tab) {{{2 
<cm_SwitchToNextTab>: 
	SendPos ( 3005) 
Return 
; <cm_SwitchToPreviousTab>: >> a label (Ctrl + Shift + tab) {{{2 
<cm_SwitchToPreviousTab>: 
	SendPos (3006) 
Return 
; <cm_CloseCurrentTab>: >> Close current tab {{{2 
<cm_CloseCurrentTab> : 
	SendPos (3007) 
Return 
; <cm_CloseAllTabs>: Close all tabs >> {{{2 
<cm_CloseAllTabs>: 
	SendPos (3008) 
Return 
; <cm_DirTabsShowMenu>: >> display tab {{{2 
<cm_DirTabsShowMenu>: 
	SendPos (3009 ) 
Return 
; <cm_ToggleLockCurrentTab>: >> lock / unlock the current label {{{2 
<cm_ToggleLockCurrentTab>: 
	SendPos (3010) 
Return 
; <cm_ToggleLockDcaCurrentTab>: >> lock / unlock the current tab (to change the folder) {{{2 
< cm_ToggleLockDcaCurrentTab>: 
	SendPos (3012) 
Return 
; <cm_ExchangeWithTabs>: >> exchange around window and {{{2 tag 
<cm_ExchangeWithTabs>: 
	SendPos (535) 
Return 
; <cm_GoToLockedDir>: >> Go to the root folder of the locking tab { {{2 
<cm_GoToLockedDir>: 
	SendPos (3011) 
Return 
; <cm_SrcActivateTab1>: >> source window: activate tab 1 {{{2 
<cm_SrcActivateTab1>: 
	SendPos (5001) 
Return 
; <cm_SrcActivateTab2>: >> source window: active tab 2 {{{2 
<cm_SrcActivateTab2>: 
	SendPos (5002) 
Return 
; <cm_SrcActivateTab3>: >> ... {{{2 
<cm_SrcActivateTab3>: 
	SendPos (5003) 
Return 
; <cm_SrcActivateTab4>: >> Up to 99 {{{ 2 
<cm_SrcActivateTab4>: 
	SendPos (5004) 
Return 
; <cm_SrcActivateTab5>: >> 5 {{{2 
<cm_SrcActivateTab5>: 
	SendPos (5005) 
Return 
; <cm_SrcActivateTab6>: >> 6 {{{2 
<cm_SrcActivateTab6>: 
	SendPos (5006 ) 
Return 
; <cm_SrcActivateTab7>: >> 7 {{{2 
<cm_SrcActivateTab7>: 
	SendPos (5007) 
Return 
; <cm_SrcActivateTab8>: >> 8 {{{2 
<cm_SrcActivateTab8>: 
	SendPos (5008) 
Return 
; <cm_SrcActivateTab9>:> > 9 {{{2 
<cm_SrcActivateTab9>: 
	SendPos (5009) 
Return 
; <cm_SrcActivateTab10>: >> {{{2 0 
<cm_SrcActivateTab10>: 
	SendPos (5010) 
Return 
; <cm_TrgActivateTab1>: >> target window: activate tab 1 { {{2 
<cm_TrgActivateTab1>: 
	SendPos (5101) 
Return 
; <cm_TrgActivateTab2>: >> target window: activate tab 2 {{{2 
<cm_TrgActivateTab2>: 
	SendPos (5102) 
Return 
; <cm_TrgActivateTab3>: >> ... {{ {2 
<cm_TrgActivateTab3>: 
	SendPos (5103) 
Return 
; <cm_TrgActivateTab4>: >> Up to 99 {{{2 
<cm_TrgActivateTab4>: 
	SendPos (5104) 
Return 
; <cm_TrgActivateTab5>: >> 5 {{{2 
<cm_TrgActivateTab5>: 
	SendPos (5105) 
Return 
; <cm_TrgActivateTab6>: >> 6 {{{2 
<cm_TrgActivateTab6>: 
	SendPos (5106) 
Return 
; <cm_TrgActivateTab7>: >> 7 {{{2 
<cm_TrgActivateTab7>: 
	SendPos (5107) 
Return 
; <cm_TrgActivateTab8 >: >> 8 {{{2 
<cm_TrgActivateTab8>: 
	SendPos (5108) 
Return 
; <cm_TrgActivateTab9>: >> 9 {{{2 
<cm_TrgActivateTab9>: 
	SendPos (5109) 
Return 
; <cm_TrgActivateTab10>: >> 0 {{{ 2 
<cm_TrgActivateTab10>: 
	SendPos (5110) 
Return 
; <cm_LeftActivateTab1>: >> left window: activate tab 1 {{{2 
<cm_LeftActivateTab1>: 
	SendPos (5201) 
Return 
; <cm_LeftActivateTab2>: >> left window: activate tab 2 { {{2 
<cm_LeftActivateTab2>: 
	SendPos (5202) 
Return 
; <cm_LeftActivateTab3>: >> ... {{{2 
<cm_LeftActivateTab3>: 
	SendPos (5203) 
Return 
; <cm_LeftActivateTab4>: >> Up to 99 {{{2 
< cm_LeftActivateTab4>: 
	SendPos (5204) 
Return 
; <cm_LeftActivateTab5>: >> 5 {{{2 
<cm_LeftActivateTab5>: 
	SendPos (5205) 
Return 
; <cm_LeftActivateTab6>: >> 6 {{{2 
<cm_LeftActivateTab6>: 
	SendPos (5206) 
Return 
; <cm_LeftActivateTab7>: >> 7 {{{2 
<cm_LeftActivateTab7>: 
	SendPos (5207) 
Return 
; <cm_LeftActivateTab8>: >> 8 {{{2 
<cm_LeftActivateTab8>: 
	SendPos (5208) 
Return 
; <cm_LeftActivateTab9>: >> 9 {{{2 
<cm_LeftActivateTab9>: 
	SendPos (5209) 
Return 
; <cm_LeftActivateTab10>: >> {{{2 0 
<cm_LeftActivateTab10>: 
	SendPos (5210) 
Return 
; <cm_RightActivateTab1>: >> Right window: activate tab 1 {{{ 2 
<cm_RightActivateTab1>: 
	SendPos (5301) 
Return 
; <cm_RightActivateTab2>: >> Right window: activate tab 2 {{{2 
<cm_RightActivateTab2>: 
	SendPos (5302) 
Return 
; <cm_RightActivateTab3>: >> ... {{{2 
<cm_RightActivateTab3>: 
	SendPos (5303) 
Return 
; <cm_RightActivateTab4>: >> Up to 99 {{{2 
<cm_RightActivateTab4>: 
	SendPos (5304) 
Return 
; <cm_RightActivateTab5>: >> 5 {{{2 
<cm_RightActivateTab5>: 
	SendPos ( 5305) 
Return 
; <cm_RightActivateTab6>: >> 6 {{{2 
<cm_RightActivateTab6>: 
	SendPos (5306) 
Return 
; <cm_RightActivateTab7>: >> 7 {{{2 
<cm_RightActivateTab7>: 
	SendPos (5307) 
Return 
; <cm_RightActivateTab8>: >> 8 {{{2 
<cm_RightActivateTab8>: 
	SendPos (5308) 
Return 
; <cm_RightActivateTab9>: >> 9 {{{2 
<cm_RightActivateTab9>: 
	SendPos (5309) 
Return 
; <cm_RightActivateTab10>: >> {{{2 0 
< cm_RightActivateTab10>: 
	SendPos (5310) 
Return 
; sort ======================================== = 
Return 
; <cm_SrcSortByCol1>: >> source window: the first one by sorting {{{2 
<cm_SrcSortByCol1>: 
	SendPos (6001) 
Return 
; <cm_SrcSortByCol2>: >> source window: sort by section 2 {{{2 
< cm_SrcSortByCol2>: 
	SendPos (6002) 
Return 
; <cm_SrcSortByCol3>: >> ... {{{2 
<cm_SrcSortByCol3>: 
	SendPos (6003) 
Return 
; <cm_SrcSortByCol4>: >> Up to 99 {{{2 
<cm_SrcSortByCol4>: 
	SendPos (6004) 
Return 
; <cm_SrcSortByCol5>: >> 5 {{{2 
<cm_SrcSortByCol5>: 
	SendPos (6005) 
Return 
; <cm_SrcSortByCol6>: >> 6 {{{2 
<cm_SrcSortByCol6>: 
	SendPos (6006) 
Return 
; <cm_SrcSortByCol7> : >> 7 {{{2 
<cm_SrcSortByCol7>: 
	SendPos (6007) 
Return 
; <cm_SrcSortByCol8>: >> 8 {{{2 
<cm_SrcSortByCol8>: 
	SendPos (6008) 
Return 
; <cm_SrcSortByCol9>: >> 9 {{{2 
<cm_SrcSortByCol9>: 
	SendPos (6009) 
Return 
; <cm_SrcSortByCol10>: >> {{{2 0 
<cm_SrcSortByCol10>: 
	SendPos (6010) 
Return 
; <cm_SrcSortByCol99>: >> 9 {{{2 
<cm_SrcSortByCol99>: 
	SendPos (6099) 
return 
; <cm_TrgSortByCol1>: >> target window: press the first one sort {{{2 
<cm_TrgSortByCol1>: 
	SendPos (6101) 
return 
; <cm_TrgSortByCol2>: >> target window: in section 2 Sort {{{2 
<cm_TrgSortByCol2 >: 
	SendPos (6102) 
Return 
; <cm_TrgSortByCol3>: >> ... {{{2 
<cm_TrgSortByCol3>: 
	SendPos (6103) 
Return 
; <cm_TrgSortByCol4>: >> Up to 99 {{{2 
<cm_TrgSortByCol4>: 
	SendPos ( 6104) 
Return 
; <cm_TrgSortByCol5>: >> 5 {{{2 
<cm_TrgSortByCol5>: 
	SendPos (6105) 
Return 
; <cm_TrgSortByCol6>: >> 6 {{{2 
<cm_TrgSortByCol6>: 
	SendPos (6106) 
Return 
; <cm_TrgSortByCol7>: >> 7 {{{2 
<cm_TrgSortByCol7>: 
	SendPos (6107) 
Return 
; <cm_TrgSortByCol8>: >> 8 {{{2 
<cm_TrgSortByCol8>: 
	SendPos (6108) 
Return 
; <cm_TrgSortByCol9>: >> 9 {{{2 
< cm_TrgSortByCol9>: 
	SendPos (6109) 
Return 
; <cm_TrgSortByCol10>: >> {{{2 0 
<cm_TrgSortByCol10>: 
	SendPos (6110) 
Return 
; <cm_TrgSortByCol99>: >> 9 {{{2 
<cm_TrgSortByCol99>: 
	SendPos (6199) 
Return 
; <cm_LeftSortByCol1>: >> left window: the first one by sorting {{{2 
<cm_LeftSortByCol1>: 
	SendPos (6201) 
Return 
; <cm_LeftSortByCol2>: >> left window: sort by section 2 {{{2 
<cm_LeftSortByCol2> : 
	SendPos (6202) 
Return 
; <cm_LeftSortByCol3>: >> ... {{{2 
<cm_LeftSortByCol3>: 
	SendPos (6203) 
Return 
; <cm_LeftSortByCol4>: >> Up to 99 {{{2 
<cm_LeftSortByCol4>: 
	SendPos (6204 ) 
Return 
; <cm_LeftSortByCol5>: >> 5 {{{2 
<cm_LeftSortByCol5>: 
	SendPos (6205) 
Return 
; <cm_LeftSortByCol6>: >> 6 {{{2 
<cm_LeftSortByCol6>: 
	SendPos (6206) 
Return 
; <cm_LeftSortByCol7>:> > 7 {{{2 
<cm_LeftSortByCol7>: 
	SendPos (6207) 
Return 
; <cm_LeftSortByCol8>: >> 8 {{{2 
<cm_LeftSortByCol8>: 
	SendPos (6208) 
Return 
; <cm_LeftSortByCol9>: >> 9 {{{2 
<cm_LeftSortByCol9 >: 
	SendPos (6209) 
Return 
; <cm_LeftSortByCol10>: >> {{{2 0 
<cm_LeftSortByCol10>: 
	SendPos (6210) 
Return 
; <cm_LeftSortByCol99>: >> 9 {{{2 
<cm_LeftSortByCol99>: 
	SendPos (6299) 
Return 
; <cm_RightSortByCol1>: >> right window: press the first one sort {{{2 
<cm_RightSortByCol1>: 
	SendPos (6301) 
Return 
; <cm_RightSortByCol2>: >> Right window: Sort by section 2 {{{2 
<cm_RightSortByCol2>: 
	SendPos (6302) 
Return 
; <cm_RightSortByCol3>: >> ... {{{2 
<cm_RightSortByCol3>: 
	SendPos (6303) 
Return 
; <cm_RightSortByCol4>: >> Up to 99 {{{2 
<cm_RightSortByCol4>: 
	SendPos (6304) 
return 
; <cm_RightSortByCol5>: >> 5 {{{2 
<cm_RightSortByCol5>: 
	SendPos (6305) 
return 
; <cm_RightSortByCol6>: >> 6 {{{2 
<cm_RightSortByCol6>: 
	SendPos (6306) 
return 
; <cm_RightSortByCol7>: >> 7 {{{2 
<cm_RightSortByCol7>: 
	SendPos (6307) 
Return 
; <cm_RightSortByCol8>: >> 8 {{{2 
<cm_RightSortByCol8>: 
	SendPos (6308) 
Return 
; <cm_RightSortByCol9>: >> 9 {{{2 
<cm_RightSortByCol9> : 
	SendPos (6309) 
Return 
; <cm_RightSortByCol10>: >> {{{2 0 
<cm_RightSortByCol10>: 
	SendPos (6310) 
Return 
; <cm_RightSortByCol99>: >> 9 {{{2 
<cm_RightSortByCol99>: 
	SendPos (6399) 
Return 
; self Customize columns view ========================================= 
Return 
; <cm_SrcCustomView1>: >> source window: custom column view 1 {{{2 
<cm_SrcCustomView1>: 
	SendPos (271) 
Return 
; <cm_SrcCustomView2>: >> source window: custom column view 2 {{{2 
<cm_SrcCustomView2>: 
	SendPos (272) 
return 
; <cm_SrcCustomView3>: >> ... {{{2 
<cm_SrcCustomView3>: 
	SendPos (273) 
return 
; <cm_SrcCustomView4>: >> Up to 29 {{{2 
<cm_SrcCustomView4>: 
	SendPos (274) 
return 
; <cm_SrcCustomView5 >: >> 5 {{{2 
<cm_SrcCustomView5>: 
	SendPos (275) 
Return 
; <cm_SrcCustomView6>: >> 6 {{{2 
<cm_SrcCustomView6>: 
	SendPos (276) 
Return 
; <cm_SrcCustomView7>: >> 7 {{{ 2 
<cm_SrcCustomView7>: 
	SendPos (277) 
Return 
; <cm_SrcCustomView8>: >> 8 {{{2 
<cm_SrcCustomView8>: 
	SendPos (278) 
Return 
; <cm_SrcCustomView9>: >> 9 {{{2 
<cm_SrcCustomView9>: 
	SendPos (279 ) 
Return 
; <cm_LeftCustomView1>: >> left window: custom column view 1 {{{2 
<cm_LeftCustomView1>: 
	SendPos (710) 
Return 
; <cm_LeftCustomView2>: >> left window: custom column view 2 {{{2 
< cm_LeftCustomView2>: 
	SendPos (72) 
Return 
; <cm_LeftCustomView3>: >> ... {{{2 
<cm_LeftCustomView3>: 
	SendPos (73) 
Return 
; <cm_LeftCustomView4>: >> Up to 29 {{{2 
<cm_LeftCustomView4>: 
	SendPos (74) 
Return 
; <cm_LeftCustomView5>: >> 5 {{{2 
<cm_LeftCustomView5>: 
	SendPos (75) 
Return 
; <cm_LeftCustomView6>: >> 6 {{{2 
<cm_LeftCustomView6>: 
	SendPos (76) 
Return 
; <cm_LeftCustomView7> : >> 7 {{{2 
<cm_LeftCustomView7>: 
	SendPos (77) 
Return 
; <cm_LeftCustomView8>: >> 8 {{{2 
<cm_LeftCustomView8>: 
	SendPos (78) 
Return 
; <cm_LeftCustomView9>: >> 9 {{{2 
<cm_LeftCustomView9>: 
	SendPos (79) 
Return 
; <cm_RightCustomView1>: >> Right window: custom column view 1 {{{2 
<cm_RightCustomView1>: 
	SendPos (171) 
Return 
; <cm_RightCustomView2>: >> Right window: custom columns view 2 {{{2 
<cm_RightCustomView2>: 
	SendPos (172) 
Return 
; <cm_RightCustomView3>: >> ... {{{2 
<cm_RightCustomView3>:
	SendPos(173)
Return
;<cm_RightCustomView4>: >>最多 29 个{{{2
<cm_RightCustomView4>:
	SendPos(174)
Return
;<cm_RightCustomView5>: >>5{{{2
<cm_RightCustomView5>:
	SendPos(175)
Return
;<cm_RightCustomView6>: >>6{{{2
<cm_RightCustomView6>:
	SendPos(176)
Return
;<cm_RightCustomView7>: >>7{{{2
<cm_RightCustomView7>:
	SendPos(177)
Return
;<cm_RightCustomView8>: >>8{{{2
<cm_RightCustomView8>:
	SendPos(178)
Return
;<cm_RightCustomView9>: >>9{{{2
<cm_RightCustomView9>:
	SendPos(179)
Return
;<cm_SrcNextCustomView>: >>来源窗口: 下一个自定义视图{{{2
<cm_SrcNextCustomView>:
	SendPos(5501)
Return
;<cm_SrcPrevCustomView>: >>来源窗口: 上一个自定义视图{{{2
<cm_SrcPrevCustomView>:
	SendPos(5502)
Return
;<cm_TrgNextCustomView>: >>目标窗口: 下一个自定义视图{{{2
<cm_TrgNextCustomView>:
	SendPos(5503)
Return
;<cm_TrgPrevCustomView>: >>目标窗口: 上一个自定义视图{{{2
<cm_TrgPrevCustomView>:
	SendPos(5504)
Return
;<cm_LeftNextCustomView>: >>左窗口: 下一个自定义视图{{{2
<cm_LeftNextCustomView>:
	SendPos(5505)
Return
;<cm_LeftPrevCustomView>: >>左窗口: 上一个自定义视图{{{2
<cm_LeftPrevCustomView>:
	SendPos(5506)
Return
;<cm_RightNextCustomView>: >>右窗口: 下一个自定义视图{{{2
<cm_RightNextCustomView>:
	SendPos(5507)
Return
;<cm_RightPrevCustomView>: >>右窗口: 上一个自定义视图{{{2
<cm_RightPrevCustomView>:
	SendPos(5508)
Return
;<cm_LoadAllOnDemandFields>: >>所有文件都按需加载备注{{{2
<cm_LoadAllOnDemandFields>:
	SendPos(5512)
Return
;<cm_LoadSelOnDemandFields>: >>仅选中的文件按需加载备注{{{2
<cm_LoadSelOnDemandFields>:
	SendPos(5513)
Return
;<cm_ContentStopLoadFields>: >>停止后台加载备注{{{2
<cm_ContentStopLoadFields>:
	SendPos(5514)
Return
