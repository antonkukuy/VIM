Process, Priority, , High     ; Эта запись сообщает операционной системе уделить больше внимания к исполнению данных команд
#UseHook On ; Make it a bit slow, but can avoid infinitude loop
            ; Same as "$" for each hotkey
#InstallKeybdHook ; For checking key history
                  ; Use ~500kB memory?

#HotkeyInterval 2000 ; Hotkey inteval (default 2000 milliseconds).
#MaxHotkeysPerInterval 70 ; Max hotkeys perinterval (default 50).

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
Input, UserInput, I T0.5 V *,,s,d,f,as,ad,af

;KeyWait, a
SetKeyDelay, -1
if UserInput = s
    Send, {backspace 2}l
else if UserInput = d
    Send, {backspace 2}i
else if UserInput = f
    Send, {backspace 2}w
else if UserInput = as
    Send, {backspace 3}n
else if UserInput = ad
    Send, {backspace 3}p
else if UserInput = af
    Send, {backspace 3}j
return
~s::
Input, UserInput, I T0.5 V *,,a,d,f,sa,sd,sf
;KeyWait, s
SetKeyDelay, -1
if UserInput = a
    Send, {backspace 2}o
else if UserInput = d
    Send, {backspace 2}h
else if UserInput = f
    Send, {backspace 2}c
else if UserInput = sa
    Send, {backspace 3}m
else if UserInput = sd
    Send, {backspace 3}f
else if UserInput = sf
    Send, {backspace 3}g
return
~d::
Input, UserInput, I T0.5 V *,,a,s,f,da,ds,df
;KeyWait, d
SetKeyDelay, -1 ; Большинство редакторов допускают максимальную скорость.
if UserInput = a
    Send, {backspace 2}y
else if UserInput = s
    Send, {backspace 2}t
else if UserInput = f
    Send, {backspace 2}v
else if UserInput = da
    Send, {backspace 3}r
else if UserInput = ds
    Send, {backspace 3}s
else if UserInput = df
    Send, {backspace 3}x
return
~f::
;KeyWait, f
Input, UserInput, I T0.5 V *,,a,s,d,fa,fs,fd
SetKeyDelay, -1 ; Большинство редакторов допускают максимальную скорость.
if UserInput = a
    Send, {backspace 2}u
else if UserInput = s
    Send, {backspace 2}d
else if UserInput = d
    Send, {backspace 2}q
else if UserInput = fa
    Send, {backspace 3}b
else if UserInput = fs
    Send, {backspace 3}k
else if UserInput = fd
    Send, {backspace 3}z
return


/*
#Hotstring EndChars z

;:ZO?*0:as::n
:ZO?*0:sa::m
:ZO?*0:da::r
:ZO?*0:fa::b
:ZO?*0:ad::p
:ZO?*0:sd::f
:ZO?*0:fd::z
:ZO?*0:af::j
:ZO?*0:sf::g
:ZO?*0:df::x
:ZO?*0:ds::s
:ZO?*0:fs::k
*/

/*
~a::
Input, UserInput, I T0.5 V *,,ad,af

;KeyWait, a
SetKeyDelay, -1
if UserInput = add
    Send, {backspace 3}i
else if UserInput = af
    Send, {backspace 3}w
return
~s::
Input, UserInput, I T0.5 V *,,sa,sd,sf
;KeyWait, s
SetKeyDelay, -1
if UserInput = sa
    Send, {backspace 3}o
else if UserInput = sd
    Send, {backspace 3}h
else if UserInput = sf
    Send, {backspace 3}d
return
~d::
Input, UserInput, I T0.5 V *,,da,ds,df
;KeyWait, d
SetKeyDelay, -1 ; Большинство редакторов допускают максимальную скорость.
if UserInput = da
    Send, {backspace 3}y
else if UserInput = ds
    Send, {backspace 3}t
else if UserInput = df
    Send, {backspace 3}v
return
~f::
;KeyWait, f
Input, UserInput, I T0.5 V *,,fa,fd
SetKeyDelay, -1 ; Большинство редакторов допускают максимальную скорость.
if UserInput = fa
    Send, {backspace 3}u
else if UserInput = fd
    Send, {backspace 3}q
return
*/




/*
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
*/
/*
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

/*
~sc1E::
Input, UserInput, I T0.55 V *,,as,ad,af,фы,фв,фа

;KeyWait, a
SetKeyDelay, -1

if UserInput = as
    Send, {backspace 3}n   ;{vk53}  ;n
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

~s::
Input, UserInput, I T0.55 V *,,sa,sd,sf
;KeyWait, s
SetKeyDelay, -1
if UserInput = sa
    Send, {backspace 3}m
else if UserInput = sd
    Send, {backspace 3}f
else if UserInput = sf
    Send, {backspace 3}g
return

~s & a::send {backspace}o
~s & d::send {backspace}h
~s & f::send {backspace}c

~d::
Input, UserInput, I T0.55 V *,,da,ds,df
;KeyWait, d
SetKeyDelay, -1 ; Большинство редакторов допускают максимальную скорость.
if UserInput = da
    Send, {backspace 3}r
else if UserInput = ds
    Send, {backspace 3}s
else if UserInput = df
    Send, {backspace 3}x
return

~d & a::send {backspace}y
~d & s::send {backspace}t
~d & f::send {backspace}v

~f::
;KeyWait, f
Input, UserInput, I T0.55 V *,,fa,fs,fd
SetKeyDelay, -1 ; Большинство редакторов допускают максимальную скорость.
if UserInput = fa
    Send, {backspace 3}b
else if UserInput = fs
    Send, {backspace 3}k
else if UserInput = fd
    Send, {backspace 3}z
return

~f & a::send {backspace}u
~f & s::send {backspace}d
~f & d::send {backspace}q

*/







/*
~sc1E::  ; a
Input, UserInput, I C T0.7 V *,,ф,as,ad,af,фы,фв,фа

if UserInput = ф         ; RU
    Send, {backspace 2}о
else if UserInput = as
    Send, {backspace 3}n
else if UserInput = фы
    Send, {backspace 3}с
else if UserInput = ad
    Send, {backspace 3}p
else if UserInput = фв
    Send, {backspace 3}з
else if UserInput = af
    Send, {backspace 3}j
else if UserInput = фа
    Send, {backspace 3}ж
return


~+sc1E::  ; a
Input, UserInput, I C T0.7 V *,,Ф,AS,AD,AF,ФЫ,ФВ,ФА
SetKeyDelay, -1

if UserInput = Ф   ; RU
    Send, {backspace 2}О
else if UserInput = AS
    Send, {backspace 3}N
else if UserInput = ФЫ
    Send, {backspace 3}С
else if UserInput = AD
    Send, {backspace 3}P
else if UserInput = ФВ
    Send, {backspace 3}З
else if UserInput = AF
    Send, {backspace 3}J
else if UserInput = ФА
    Send, {backspace 3}Ж
return
*/
/*
~sc1E::  ; a
~+sc1E::  ; a
Input, UserInput, I C T0.7 V *,,а,as,ad,af,фы,фв,фа,А,AS,AD,AF,ФЫ,ФВ,ФА
SetKeyDelay, -1

if UserInput = а         ; RU
    Send, {backspace 3}о
else if UserInput = А    ; RU
    Send, {backspace 3}О
if UserInput = as
    Send, {backspace 3}n
else if UserInput = AS
    Send, {backspace 3}N
if UserInput = фы
    Send, {backspace 3}с
else if UserInput = ФЫ
    Send, {backspace 3}С
else if UserInput = ad
    Send, {backspace 3}p
else if UserInput = AD
    Send, {backspace 3}P
else if UserInput = фв
    Send, {backspace 3}з
else if UserInput = ФВ
    Send, {backspace 3}З
else if UserInput = af
    Send, {backspace 3}j
else if UserInput = AF
    Send, {backspace 3}J
else if UserInput = фа
    Send, {backspace 3}ж
else if UserInput = ФА
    Send, {backspace 3}Ж
return
*/



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

Return