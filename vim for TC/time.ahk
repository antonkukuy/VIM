#SingleInstance ignore 
#Persistent 
SetTimer subTimer, 500 
subTimer: 
if WinActive( "ahk_class TTOTAL_CMD" ) 
{ 
FormatTime, time,, dd.MM.yyyy - HH:mm:ss
WinSetTitle Total Commander - %time% %A_DDDD%
} 
Return
