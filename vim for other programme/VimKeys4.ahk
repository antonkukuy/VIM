
Process, Priority, , AboveNormal    ; Эта запись сообщает операционной системе уделить больше внимания к исполнению данных команд



; Auto-execute section {{{
;GroupAdd VimGroup, ahk_exe cmd.exe ; cmd
;GroupAdd VimGroup, ahk_exe MathcadPrime.exe
;GroupAdd VimGroup, ahk_class Photo_Lightweight_Viewer ; Photo_Viewer_windows

GroupAdd VimGroup
;GroupAdd VimGroup, ahk_exe acad.exe
;GroupAdd VimGroup, ahk_exe chrome.exe
;GroupAdd VimGroup, ahk_exe sublime_text.exe
;GroupAdd AllWindons

vim_verbose=1


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

^!+sc1E::
  VimCheckMode(3,VimMode)
  Return
; }}}

; Enter vim normal mode {{{
#IfWInActive, ahk_group VimGroup && (VimMode == "Insert")
+sc14:: ; Just send Esc at converting, long press for normal Esc.
  KeyWait, sc14, T0.5   ; sc14 key - t
  if (ErrorLevel){ ; long press
    Send,{Esc}
    Return
  }
  

  else {
    VimSetMode("Normal")
  }
  Return

+F2::ExitApp
Return

^sc39::Suspend   ; CapsLock
Return

/*
^[:: ; Go to Normal mode (for vim) with IME off even at converting.
  KeyWait, [, T0.5
  if (ErrorLevel){ ; long press to Esc
    Send,{Esc}
    Return
  }
*/


; }}}

; {{ Toogle mode

#If WInActive("ahk_group VimGroup")  && (VimMode =="Insert")

~sc10::VimSetMode("Numpad")  ;q
;sc14::VimSetMode("Normal")  ;t
~sc14::VimSetMode("Normal")  ;t
Return

#If WInActive("ahk_group VimGroup") && (VimMode=="Normal")

~sc14::VimSetMode("Insert")  ;t
~sc10::VimSetMode("Numpad")  ;q
Return

#If WInActive("ahk_group VimGroup") && (VimMode=="Numpad")

~sc10::VimSetMode("Insert")  ; q
~sc14::VimSetMode("Normal")  ; t
Return

;}}

; 4keys {{{{
; Insert mode {{{

;3::VimSetMode("Insert")

#If WInActive("ahk_group VimGroup") && (VimMode == "Insert")

~sc1E::  ; a
Input, UserInput, I T0.55 V *,,as,ad,af,фы,фв,фа
SetKeyDelay, -1

if UserInput = as
    Send, {backspace 3}n
else if UserInput = фы
    Send, {backspace 3}т
else if UserInput = ad
    Send, {backspace 3}p
else if UserInput = фв
    Send, {backspace 3}з
else if UserInput = af
    Send, {backspace 3}j
else if UserInput = фа
    Send, {backspace 3}о
return

~sc1E & sc1F ::send {backspace}{sc26} ; as to l
~sc1E & sc20::send {backspace}{sc17} ; ad to i
~sc1E & sc21::send {backspace}{sc11}  ; af to w

~sc1F::   ;s
Input, UserInput, I T0.55 V *,,ss,sa,sd,sf,ыы,ыф,ыв,ыа
SetKeyDelay, -1
if UserInput = ss
    Send, {backspace 3}a
else if UserInput = ыы
    Send, {backspace 3}ф
else if UserInput = sa
    Send, {backspace 3}m
else if UserInput = ыф
    Send, {backspace 3}ь
else if UserInput = sd
    Send, {backspace 3}f
else if UserInput = ыв
    Send, {backspace 3}а
else if UserInput = sf
    Send, {backspace 3}g
else if UserInput = ыа
    Send, {backspace 3}п
return

~sc1F & sc1E::send {backspace}щ  ; sa to o
~sc1F & sc20::send {backspace}р  ; sd to h
~sc1F & sc21::send {backspace}с  ; sf to c

~sc20::  ; d
Input, UserInput, I T0.55 V *,,dd,da,ds,df,вв,вф,вы,ва
SetKeyDelay, -1 ; Большинство редакторов допускают максимальную скорость.
if UserInput = dd
    Send, {backspace 3}e
else if UserInput = вв
    Send, {backspace 3}у
else if UserInput = da
    Send, {backspace 3}r
else if UserInput = вф
    Send, {backspace 3}к
else if UserInput = ds
    Send, {backspace 3}s
else if UserInput = вы
    Send, {backspace 3}ы
else if UserInput = df
    Send, {backspace 3}x
else if UserInput = ва
    Send, {backspace 3}ч
return

~sc20 & sc1E::send {backspace}{sc15}  ; da to y
~sc20 & sc1F::send {backspace}{sc14}  ; ds to t
~sc20 & sc21::send {backspace}{sc2F}  ; df to v

~sc21::  ; f
;KeyWait, f
Input, UserInput, I T0.55 V *,,fa,fs,fd,аф,аы,ав
SetKeyDelay, -1 ; Большинство редакторов допускают максимальную скорость.
if UserInput = fa
    Send, {backspace 3}b
else if UserInput = аф
    Send, {backspace 3}л  ; fa to b
else if UserInput = fs
    Send, {backspace 3}k
else if UserInput = аы
    Send, {backspace 3}л  ; fs to k
else if UserInput = fd
    Send, {backspace 3}z
else if UserInput = ав
    Send, {backspace 3}я  ; fd to z
return

~sc21 & sc1E::send {backspace}{sc16}  ; fa to u
~sc21 & sc1F::send {backspace}{sc20}  ; fs to d
~sc21 & sc20::send {backspace}{sc10}  ; fd to q



#If WInActive("ahk_group VimGroup") && (VimMode == "Insert")

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
e::Send, ^{BackSpace}

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

/*#If WInActive("ahk_group VimGroup")
+i::send {Up}
+,::send {Down}
+j::send {Left}
+l::send {Right}
Msgbox It's work
Return*/

#If WInActive("ahk_group VimGroup")
/*
;vk14::Suspend, Toogle  ; CapsLock
+^sc39::Suspend   ; CapsLock
Return

*/