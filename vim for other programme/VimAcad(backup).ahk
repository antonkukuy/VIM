
Process, Priority, , High     ; Эта запись сообщает операционной системе уделить больше внимания к исполнению данных команд

; Auto-execute section {{{
;GroupAdd VimGroup, ahk_exe cmd.exe ; cmd
;GroupAdd VimGroup, ahk_exe MathcadPrime.exe
;GroupAdd VimGroup, ahk_class Photo_Lightweight_Viewer ; Photo_Viewer_windows

GroupAdd VimGroup, ahk_class AfxMDIFrame110u
GroupAdd VimGroup, ahk_exe acad.exe
GroupAdd VimGroup, ahk_class ApplicationFrameWindow
GroupAdd VimGroup, ahk_class Notepad

vim_verbose=2


VimMode=Insert
Vim_g=0
Vim_n=0
VimLineCopy=0

Return
; }}}

; Basic Settings, HotKeys, Functions {{{
; Settings

#UseHook On ; Make it a bit slow, but can avoid infinitude loop
            ; Same as "$" for each hotkey
#InstallKeybdHook ; For checking key history
                  ; Use ~500kB memory?

#HotkeyInterval 2000 ; Hotkey inteval (default 2000 milliseconds).
#MaxHotkeysPerInterval 70 ; Max hotkeys perinterval (default 50).


/*    pages 168 and 189

; Ref for IME: http://www6.atwiki.jp/eamat/pages/17.html
; Get IME Status. 0: Off, 1: On
VIM_IME_GET(WinTitle="A")  {
  ControlGet,hwnd,HWND,,,%WinTitle%
  if (WinActive(WinTitle)) {
    ptrSize := !A_PtrSize ? 4 : A_PtrSize
    VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
    NumPut(cbSize, stGTI,  0, "UInt")   ;   DWORD   cbSize;
    hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
        ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
  }

  Return DllCall("SendMessage"
      , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwnd)
      , UInt, 0x0283  ;Message : WM_IME_CONTROL
      ,  Int, 0x0005  ;wParam  : IMC_GETOPENSTATUS
      ,  Int, 0)      ;lParam  : 0
}
; Get input status. 1: Converting, 2: Have converting window, 0: Others
VIM_IME_GetConverting(WinTitle="A",ConvCls="",CandCls="") {
  ; Input windows, candidate windows (Add new IME with "|")
  ConvCls .= (ConvCls ? "|" : "")                 ;--- Input Window ---
    .  "ATOK\d+CompStr"                           ; ATOK
    .  "|imejpstcnv\d+"                           ; MS-IME
    .  "|WXGIMEConv"                              ; WXG
    .  "|SKKIME\d+\.*\d+UCompStr"                 ; SKKIME Unicode
    .  "|MSCTFIME Composition"                    ; Google IME
  CandCls .= (CandCls ? "|" : "")                 ;--- Candidate Window ---
    .  "ATOK\d+Cand"                              ; ATOK
    .  "|imejpstCandList\d+|imejpstcand\d+"       ; MS-IME 2002(8.1)XP
    .  "|mscandui\d+\.candidate"                  ; MS Office IME-2007
    .  "|WXGIMECand"                              ; WXG
    .  "|SKKIME\d+\.*\d+UCand"                    ; SKKIME Unicode
 CandGCls := "GoogleJapaneseInputCandidateWindow" ; Google IME

  ControlGet,hwnd,HWND,,,%WinTitle%
  if (WinActive(WinTitle)) {
    ptrSize := !A_PtrSize ? 4 : A_PtrSize
    VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
    NumPut(cbSize, stGTI,  0, "UInt")   ;   DWORD   cbSize;
    hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
      ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
  }

  WinGet, pid, PID,% "ahk_id " hwnd
  tmm:=A_TitleMatchMode
  SetTitleMatchMode, RegEx
  ret := WinExist("ahk_class " . CandCls . " ahk_pid " pid) ? 2
      :  WinExist("ahk_class " . CandGCls                 ) ? 2
      :  WinExist("ahk_class " . ConvCls . " ahk_pid " pid) ? 1
      :  0
  SetTitleMatchMode, %tmm%
  Return ret
}
; Set IME, SetSts=0: Off, 1: On, return 0 for success, others for non-success
VIM_IME_SET(SetSts=0, WinTitle="A")    {
  ControlGet,hwnd,HWND,,,%WinTitle%
  if(WinActive(WinTitle)){
    ptrSize := !A_PtrSize ? 4 : A_PtrSize
    VarSetCapacity(stGTI, cbSize:=4+4+(PtrSize*6)+16, 0)
    NumPut(cbSize, stGTI,  0, "UInt")   ;   DWORD   cbSize;
    hwnd := DllCall("GetGUIThreadInfo", Uint,0, Uint,&stGTI)
        ? NumGet(stGTI,8+PtrSize,"UInt") : hwnd
  }

  Return DllCall("SendMessage"
    , UInt, DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hwnd)
    , UInt, 0x0283  ;Message : WM_IME_CONTROL
    ,  Int, 0x006   ;wParam  : IMC_SETOPENSTATUS
    ,  Int, SetSts) ;lParam  : 0 or 1
}
*/
; }}}

; Vim mode {{{
#IfWInActive, ahk_group VimGroup

; Reset Modes {{{
VimSetMode(Mode="", g=0, n=0, LineCopy=-1) {
  global
  if(Mode!=""){
    VimMode=%Mode%
  }
  if (g != -1){
    Vim_g=%g%
  }
  if (n != -1){
    Vim_n=%n%
  }
  if (LineCopy!=-1) {
    VimLineCopy=%LineCopy%
  }
  VimCheckMode(vim_verbose,Mode,g,n,LineCopy)
  Return
}
VimCheckMode(verbose=0,Mode="", g=0, n=0, LineCopy=-1) {
  global
  if(verbose<1) or ((Mode=="" ) and (g==0) and (n==0) and (LineCopy==-1)) {
    Return
  }else if(verbose=1){
    TrayTip,VimMode,%VimMode%,1,, ; 1 sec is minimum for TrayTip
  }else if(verbose=2){
    TrayTip,VimMode,%VimMode%`r`ng=%Vim_g%`r`nn=%Vim_n%,1,,
  }
  if(verbose=3){
    Msgbox,
    (
    VimMode: %VimMode%
    Vim_g: %Vim_g%
    Vim_n: %Vim_n%
    VimLineCopy: %VimLineCopy%
    )
  }
  Return
}
^!+a::
  VimCheckMode(3,VimMode)
  Return
; }}}

; Enter vim normal mode {{{
#IfWInActive, ahk_group VimGroup
t:: ; Just send Esc at converting, long press for normal Esc.
  KeyWait, t, T0.5
  if (ErrorLevel){ ; long press
    Send,{Esc}
    Return
  }
/*
  if (VIM_IME_GET(A)) {
    if (VIM_IME_GetConverting(A)) {
      Send,{Esc}
    } else {
      VIM_IME_SET()
      VimSetMode("Vim_Normal")
    }
  } 
*/
  else {
    VimSetMode("Vim_Normal")
  }
  Return

^[:: ; Go to Normal mode (for vim) with IME off even at converting.
  KeyWait, [, T0.5
  if (ErrorLevel){ ; long press to Esc
    Send,{Esc}
    Return
  }
/*
  if (VIM_IME_GET(A)) {
    Send,{Esc}
    Sleep 1
    VIM_IME_SET()
  }
 */

  VimSetMode("Vim_Normal")
  Return
; }}}


; 4keys {{{{
; Insert mode {{{

;3::VimSetMode("Insert")

#If WInActive("ahk_group VimGroup") && (VimMode == "Insert")

#Hotstring EndChars z

/*
;1::Space
:*:2::a
:*:3::e
;4::^
:*:12::l
:*:21::o
:*:13::i
:*:31::y
:*:14::w
:*:41::u
:*:23::h
:*:32::t
:*:24::c
:*:42::d
:*:34::v
:*:43::q
:*:121::n
:*:212::m
:*:131::p
:*:313::r
:*:141::j
:*:414::b
:*:232::f
:*:323::s
:*:242::g
:*:424::k
:*:343::x
:*:434::z

*/

;a::
;send, {space}
;s::send, a
;d::send, e
;f::^
;a & s::send {l}
;s::send {s}
;d::send {d}
;f::send {f}


/*
:Z?*:as::l
:ZO?*0:sa::o
:ZO?*0:ad::i
:ZO?*0:da::y
:ZO?*0:af::w
:ZO?*0:fa::u
:ZO?*0:sd::h
:ZO?*0:ds::t
:ZO?*0:sf::c
:ZO?*0:fs::d
:ZO?*0:df::v
:ZO?*0:fd::q
*/
/*

:Z?*:asa::n
:Z?*:sas::m
:Z?*:ada::p
:Z?*:dad::r
:Z?*:afa::j
:Z?*:faf::r
:Z?*:sds::f
:Z?*:dsd::s
:Z?*:sfs::g
:Z?*:fsf::k
:Z?*:fdf::z
:Z?*:dfd::x
*/




/*
Input, SingleKey, L1,
(
{LControl}{RControl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}{AppsKey}
{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}
{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}
{Del}{Ins}{BS}{Capslock}{Numlock}{PrintScreen}{Pause}
)
*/
 ; Пример с горячей клавишей. Т.к. она предваряется тильдой (~),
; её собственное нажатие также будет послано в активное окно
; (за исключением Win9x). Так, если вы напечатаете [btw
; (или любую другую ключевую строку) в любом редакторе,
; скрипт автоматически выполнит заданное действие
; (например, заменит напечатанный текст на другой).

~a::
;KeyWait, a
~s::
;KeyWait, s
~d::
;KeyWait, d
~f::
;KeyWait, f
Input, UserInput, I V *,,sa,ad,da,af,fa,sd,ds,sf,df,fd

if ErrorLevel = Max
{
    MsgBox, Вы ввели "%UserInput%" и достигли максимальной длины текста.
    return
}
if ErrorLevel = Timeout
{
    MsgBox, Вы ввели "%UserInput%" и после этого истёк таймаут.
    return
}
if ErrorLevel = NewInput
    return
IfInString, ErrorLevel, EndKey:
{
    MsgBox, Вы ввели "%UserInput%" и завершили ввод через %ErrorLevel%.
    return
}


; В противном случае произошло совпадение с ключевой строкой.
SetKeyDelay, -1 ; Большинство редакторов допускают максимальную скорость.
if UserInput = sa
    Send, {backspace 2}o
else if UserInput = ad
    Send, {backspace 2}i
else if UserInput = da
    Send, {backspace 2}y
else if UserInput = af
    Send, {backspace 2}w
else if UserInput = fa
    Send, {backspace 2}u
else if UserInput = sd
    Send, {backspace 2}h
else if UserInput = ds
    Send, {backspace 2}t
else if UserInput = sf
    Send, {backspace 2}d
else if UserInput = df
    Send, {backspace 2}v
else if UserInput = fd
    Send, {backspace 2}q
return






#If WInActive("ahk_group VimGroup") && (VimMode == "Insert")
/*
a & s:: send {n} ; :?*:asa::n
KeyWait, a
Return
;$a::send {a}
s & a::send {m}  ; :?*:sas::m
KeyWait, s
Return
*/

/*
;$s::send {s}
a & d::send {BackSpace}{p}  ;:?*:ada::p
KeyWait, a
Return
;$a::send {a}
d & a::send {BackSpace}{r}  ;:?*:dad::r
KeyWait, d
Return
;$d:send {d}
a & f::send {j}  ;:?*:afa::j
KeyWait, a
Return
;$a:send {a}
f & a::send {r}  ;:?*:faf::r
KeyWait, f
Return
;$f::send {f}
s & d::send {f}  ;:?*:sds::f
KeyWait, s
Return
;$s::send {s}
d & s::send {s}  ;:?*:dsd::s
KeyWait, d
Return
;$d::send {d}
s & f::send {g}  ;:?*:sfs::g
KeyWait, s
Return
f & s::send {k}  ;:?*:fsf::k
KeyWait, f
Return
f & d::send {z}  ; :?*:fdf::z
KeyWait, f
Return
;$f::send {f}
d & f::send {x}  ; :?*:dfd::x
KeyWait, d
Return
;$d::send {d}
*/

#If WInActive("ahk_group VimGroup") && (VimMode == "Insert")




;$a::send {a}
;$s::send {s}
;$d::send {d}
;$f::send {f}

/*
:O?*0:as::l
:O?*0:sa::o
:O?*0:ad::i
:O?*0:da::y
:O?*0:af::w
:O?*0:fa::u
:O?*0:sd::h
:O?*0:ds::t
:O?*0:sf::c
:O?*0:fs::d
:O?*0:df::v
:O?*0:fd::q
*/
/*
VimMove(key="", key1=""){
  ;global
  
  if (VimMode == "Insert"){
    ; 1 character
    if (key="$a" && key1="$s"){
      Send,{l}
    }else if (key="$s" && key1="$a"){
      Send,{o}
    ; Home/End
    }else if (key="$a" && key1="$d"){
      Send,{i}
    }else if (key="$d" && key1="$a"){
      Send,{y}
    }
    }
}


#If WInActive("ahk_group VimGroup") && (VimMode == "Insert")

as::VimMove(key="$a", key1="$s")

*/

/*
Space::
    Send {k Down}
    KeyWait, Space
   Send {k Up}
return

*/

/*
^vk47::send, {BackSpace}  ;g

+vk52::send, {Down}  ;r
+vk45::send, {Up}  ;e
$^vk41::send, {Left}  ;a
$^vk44::send, {Right}  ;d
$^vk57::send, {Up}  ;w
$^vk58::send, {Down}  ;x

^q::send, {7}
^w::send, {8}
^e::send, {9}
^r::send, {0}
^t::send, {_}
*/


+z::send {F7}
x::send {F8}
c::send {F9}
v::send {F10}
b::send {F11}
g::Send, {BackSpace}
r::Send, {Del}

Return

; Normal mode {{{

#If WInActive("ahk_group VimGroup") && (VimMode == "Vim_Normal")
;Enter vim insert mode (Exit vim normal mode) {{
3::VimSetMode("Insert")
; }}

f::
  Send,{Down}
  Return
d::
  Send,{Up}
  Return
s::
  Send,{Left}
  Return
w::
  Send,+{Left}
  Return
x::
  Send,{Home}
  Return
e::
  Send,+{Right}
  Return
c::
  Send,{End}
  Return
v::
  Send,+^{Left}
  Return
b::
  Send,+^{Right}
  Return
r::
  Send, {Left}
  Return
g::
  Send, {Right}
  Return
z::
  Send,{Del}
  Return
a::
  Send,{BackSpace}
  Return

; }}} Normal mode



; Vim comamnd mode {{{
#If WInActive("ahk_group VimGroup") ;and (VimMode="Vim_Normal")
q::VimSetMode("Command") ;(q)
#If WInActive("ahk_group VimGroup") and (VimMode="Command")

; Numpad  {{
;Space::send {vkD}  ; NumpadEnter
x::send {1}      ; Numpad1
c::send {2}      ; Numpad2
v::send {3}      ; Numpad3
s::send {4}      ; Numpad4
d::send {5}       ; Numpad5
f::send {6}       ; Numpad6
w::send {7}      ; Numpad7
e::send {8}      ; Numpad8
r::send {9}      ; Numpad9
z::send {vk6E}      ; NumpadDel

4::send {/}      ; NumpadDiv
5::send {*}      ; NumpadMult
6::send {-}      ; NumpadSub
g::send {+}      ; NumpadAdd
b::send {0}       ; Numpad0
1::send {=}
a::send {BackSpace}       ; BackSpace
;1::send {F12}      ;NumLock
;q::send {vk14}      ;NumpadClear(CapsLock)
2::Run, calc.exe
;2::send {vkB7}      ;Calculator

;}} Numpad

t::
  VimSetMode("Normal")
  Return
3::
  VimSetMode("Insert")
  return

; Next modes {{

/*
#If WInActive("ahk_group VimGroup") and (VimMode="Command")
w::VimSetMode("Command_w")
q::VimSetMode("Command_q")
h::
  Send,{F1}
  VimSetMode("Normal")
  Return
#If WInActive("ahk_group VimGroup") and (VimMode="Command_w")
Return::
  Send,^s
  VimSetMode("Normal")
  Return
q::
  Send,^s
  Send,!{F4}
  VimSetMode("Normal")
  Return
Space::
  Send,!fa
  VimSetMode("Normal")
  Return
#If WInActive("ahk_group VimGroup") and (VimMode="Command_q")
Return::
  Send,!{F4}
  VimSetMode("Normal")
  Return
*/
; }} Next modes

; }}} Vim command mode







/*
;Space::send {vkvk2D}  ; Numpad0  Ins
x::send {vk23}      ; Numpad1 End
c::send {vk28}      ; Numpad2 Down
v::send {vk22}      ; Numpad3 PgDn
s::send {vk25}      ; Numpad4 Left
d::send {vkC}       ; Numpad5 
f::send {vk27}       ; Numpad6 Right
w::send {vk24}      ; Numpad7 Home
e::send {vk26}      ; Numpad8  Up
r::send {vk21}      ; Numpad9 PgUp
z::send {vk2E}      ; NumpadDel  Del
*/
;4::send {vk6F}      ; NumpadDiv
;5::send {vk6A}      ; NumpadMult
;g::send {vk6B}      ; NumpadAdd
;b::send {vkD}       ; NumpadEnter
;3::send {=}
;a::send {vk8}       ; BackSpace
;1::send {vk90}      ;NumLock
;q::send {vk14}      ;NumpadClear
;2::send {vkB7}      ;Calculator

;}}}} 4keys

#If WInActive("ahk_group VimGroup")
vk14::Suspend   ; CapsLock
Return