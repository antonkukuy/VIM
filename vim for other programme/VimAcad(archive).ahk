
Process, Priority, , High     ; Эта запись сообщает операционной системе уделить больше внимания к исполнению данных команд

; Auto-execute section {{{
;GroupAdd VimGroup, ahk_exe cmd.exe ; cmd
;GroupAdd VimGroup, ahk_exe MathcadPrime.exe
;GroupAdd VimGroup, ahk_class Photo_Lightweight_Viewer ; Photo_Viewer_windows

;GroupAdd VimGroup, ahk_class AfxMDIFrame110u
GroupAdd VimGroup, ahk_exe acad.exe
;GroupAdd VimGroup, ahk_class ApplicationFrameWindow
;GroupAdd VimGroup, ahk_class Notepad

vim_verbose=1


VimMode=Keyboard
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
#IfWInActive, ahk_group VimGroup && (VimMode == "Keyboard")
+t:: ; Just send Esc at converting, long press for normal Esc.
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
    VimSetMode("Normal")
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

  VimSetMode("Normal")
  Return
; }}}

; {{ Toogle mode
#If WInActive("ahk_group VimGroup") && (VimMode == "Right")
+3::VimSetMode("Keyboard")

#If WInActive("ahk_group VimGroup") && (VimMode == "Keyboard")
;+3::VimSetMode("Insert")
+q::VimSetMode("Numpad")
+t::VimSetMode("Normal")
+3::VimSetMode("Right")
+4::VimSetMode("Insert")

#If WInActive("ahk_group VimGroup") and (VimMode="Normal")

+3::VimSetMode("Keyboard")

#If WInActive("ahk_group VimGroup") and (VimMode="Insert")

+3::VimSetMode("Keyboard")


#If WInActive("ahk_group VimGroup") and (VimMode="Numpad")

+3::VimSetMode("Keyboard")
;}}

; 4keys {{{{
; Insert mode {{{

;3::VimSetMode("Insert")

#If WInActive("ahk_group VimGroup") && (VimMode == "Insert")

;#Hotstring EndChars z

;SetKeyDelay, -1 ; Большинство редакторов допускают максимальную скорость.
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
;SetKeyDelay, -1

/*
;:Z?*:aa::{Space}
;:ZB?*:ss::a
;KeyWait, s , T2
Return
;:ZB?*:dd::e
;KeyWait, d , T2
Return
;:CZ?*:ff:: mode
:ZB?*:as::l
;KeyWait, s , T2
Return
:ZB?*:sa::o
;KeyWait, a , T2
Return
:ZB?*:ad::i
;KeyWait, d , T2
Return
:ZB?*:da::y
;KeyWait, a , T2
Return
:ZB?*:af::w
;KeyWait, f , T2
Return
:ZB?*:fa::u
;KeyWait, a , T2
Return
:ZB?*:sd::h
;KeyWait, d , T2
Return
:ZB?*:ds::t
;KeyWait, s , T2
Return
:ZB?*:sf::c
;KeyWait, f , T2
Return
:ZB?*:fs::d
;KeyWait, s , T2
Return
:ZB?*:df::v
;KeyWait, f , T2
Return
:ZB?*:fd::q
;KeyWait, d , T2
Return

*/



/*
~a::
KeyWait, a , T2
send {BackSpace}{n} ; :?*:asa::n
Return
;$a::send {a}
~s::
KeyWait, s , T2
send {BackSpace}{m}  ; :?*:sas::m
Return

*/

/*
~s:: 
KeyWait, s , T2
send {BackSpace}{a} ; :?*:asa::n
Return
;$a::send {a}
~d::
KeyWait, d , T2
send {BackSpace}{e}  ; :?*:sas::m
Return
*/

:ZB?*:w::a
:ZB?*:as::l
;~a & s:: 
;KeyWait, a
;send {BackSpace}{l} ; :?*:asa::n
Return
;$a::send {a}
~s & a::
;KeyWait, s
send {BackSpace}{o}  ; :?*:sas::m
Return
;$s::send {s}
~a & d::
#MaxThreadsPerHotkey 1
;KeyWait, a
send {BackSpace}{i}  ;:?*:ada::p
Return
;$a::send {a}
~d & a::
;KeyWait, d
send {BackSpace}{y}  ;:?*:dad::r
Return
;$d:send {d}
~a & f::
;KeyWait, a
send {BackSpace}{w}  ;:?*:afa::j
Return
;$a:send {a}
~f & a::
;KeyWait, f
send {BackSpace}{u}  ;:?*:faf::r
Return
;$f::send {f}
~s & d::
;KeyWait, s
send {BackSpace}{h}  ;:?*:sds::f
Return
;$s::send {s}
~d & s::
;KeyWait, d
send {BackSpace}{t}  ;:?*:dsd::s
Return
;$d::send {d}
~s & f::
;KeyWait, s
send {BackSpace}{c}  ;:?*:sfs::g
Return
~f & s::
;KeyWait, f
send {BackSpace}{d}  ;:?*:fsf::k
Return
~f & d::
;KeyWait, f
send {BackSpace}{q}  ; :?*:fdf::z
Return
;$f::send {f}
~d & f::
;KeyWait, d
send {BackSpace}{v}  ; :?*:dfd::x
Return
;$d::send {d}

/*
:Z?*:aas::n
:Z?*:ssa::m
:Z?*:aad::p
:Z?*:dda::r
:Z?*:aaf::j
:Z?*:ffa::b
:Z?*:ssd::f
:Z?*:dds::s
:Z?*:ssf::g
:Z?*:ffs::k
:Z?*:ddf::x
:Z?*:ffd::z
*/

HotKeys , a , ass
aas:
send n
Return

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
/*
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

*/




#If WInActive("ahk_group VimGroup") && (VimMode == "Insert")

;SetKeyDelay, -1
/*
~a::
KeyWait, a , T2
send {BackSpace}{n} ; :?*:asa::n
Return
;$a::send {a}
~s::
KeyWait, s , T2
send {BackSpace}{m}  ; :?*:sas::m
Return
*/
/*
~a & s:: 
;KeyWait, a
send {BackSpace}{n} ; :?*:asa::n
Return
;$a::send {a}
~s & a::
;KeyWait, s
send {BackSpace}{m}  ; :?*:sas::m
Return
;$s::send {s}
~a & d::
#MaxThreadsPerHotkey 1
;KeyWait, a
send {BackSpace}{p}  ;:?*:ada::p
Return
;$a::send {a}
~d & a::
;KeyWait, d
send {BackSpace}{r}  ;:?*:dad::r
Return
;$d:send {d}
~a & f::
;KeyWait, a
send {BackSpace}{j}  ;:?*:afa::j
Return
;$a:send {a}
~f & a::
;KeyWait, f
send {BackSpace}{r}  ;:?*:faf::r
Return
;$f::send {f}
~s & d::
;KeyWait, s
send {BackSpace}{f}  ;:?*:sds::f
Return
;$s::send {s}
~d & s::
;KeyWait, d
send {BackSpace}{s}  ;:?*:dsd::s
Return
;$d::send {d}
~s & f::
;KeyWait, s
send {BackSpace}{g}  ;:?*:sfs::g
Return
~f & s::
;KeyWait, f
send {BackSpace}{k}  ;:?*:fsf::k
Return
~f & d::
;KeyWait, f
send {BackSpace}{z}  ; :?*:fdf::z
Return
;$f::send {f}
~d & f::
;KeyWait, d
send {BackSpace}{x}  ; :?*:dfd::x
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

1::send, {&}
2::send, {*}
3::send, {(}
4::send, {)}
5::send, {_}
6::send, {-}

z::send {F7}
x::send {F8}
c::send {F9}
v::send {F10}
b::send {F11}
g::Send, {BackSpace}
r::Send, {Del}

Return

; Normal mode {{{

#If WInActive("ahk_group VimGroup") && (VimMode == "Normal")

f::
  Send,{Down}
  Return
d::
  Send,{Up}
  Return
e::
  Send,+{Left}
  Return
w::
  Send,{Home}
  Return
c::
  Send,+{Right}
  Return
x::
  Send,{End}
  Return
v::
  Send,+^{Left}
  Return
r::
  Send,+^{Right}
  Return
s::
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

; Right mode {{



#If WInActive("ahk_group VimGroup") && (VimMode == "Right")

g::
  Send,{h}
  Return
f::
  Send,{j}
  Return
d::
  Send,{k}
  Return
s::
  Send, {l}
  Return
a::
  Send,{BackSpace}
  Return
t::
  Send, {y}
  Return
r::
  Send,{u}
  Return
e::
  Send, {i}
  Return
w::
  Send, {o}
  Return
q::
  Send, {p}
  Return
b::
  Send, {n}
  Return
v::
  Send,{m}
  Return
c::
  Send,{,}
  Return
x::
  Send,{.}
  Return
z::
  Send,{/}
  Return

; }}} Right mode


; Keyboard mode {{



#If WInActive("ahk_group VimGroup") && (VimMode == "Keyboard")
;SetKeyDelay, -1
~g::
~f::
~d::
~s::
~a::
~t::
~r::
~e::
~w::
~q::
~b::
~v::
~c::
~x::
~z::


~1::
~2::
~3::
~4::
~5::
~6::
~`::

#Hotstring EndChars ``




:Z?*:qq::p
:Z?*:ww::o
:Z?*:ee::i
:Z?*:rr::u
:Z?*:tt::y
:Z?*:aa::;
:Z?*:ss::l
:Z?*:dd::k
:Z?*:ff::j
:Z?*:gg::h
:Z?*:zz::/
:Z?*:xx::.
:Z?*:cc::,
:Z?*:vv::m
:Z?*:bb::n


:ZO?*0:11::7
:ZO?*0:22::8
:ZO?*0:33::9
:ZO?*0:44::0
:ZO?*0:55::_
:ZO?*0:66::=
:ZO?*0:``::'

F3::send {Left}{backspace}{right}
;+F3::send {~F3::}
+f::send {backspace}
Return
; }}} Right mode




; Vim comamnd mode {{{


#If WInActive("ahk_group VimGroup") and (VimMode="Numpad")

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
b::send {.}      ; NumpadDel

4::send {/}      ; NumpadDiv
5::send {*}      ; NumpadMult
6::send {-}      ; NumpadSub
g::send {+}      ; NumpadAdd
z::send {0}       ; Numpad0
1::send {=}
a::send {BackSpace}       ; BackSpace
;1::send {F12}      ;NumLock
;q::send {vk14}      ;NumpadClear(CapsLock)
2::Run, calc.exe
;2::send {vkB7}      ;Calculator

;}} Numpad



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

/*
a::
Send {Left down} ; Нажать клавишу "стрелка влево".
KeyWait a ; Подождать, пока пользователь отпустит клавишу.
Send {Left up} ; Отпустить клавишу "стрелка влево".
return

*/


#If WInActive("ahk_group VimGroup")
vk14::Suspend   ; CapsLock
Return
