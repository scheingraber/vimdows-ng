; Modal_Vim.ahk
; Initial Build: Rich Alesi
; Friday, May 29, 2009
; Original available at http://www.autohotkey.com/community/viewtopic.php?t=44762

; Some modifications: Achal Dave
; Friday, April 27, 2012

#Persistent
#SingleInstance, Force
SetKeyDelay, -1
CoordMode, Tooltip, Screen
modal =
context =
num =

SetTimer, vim, 100

;Disable CAPSLOCK
$CAPSLOCK::
return

vimModeOn := false

+Esc::
	vimModeOn := !vimModeOn
return

;Esc::
;	if (vimModeOn = true)
;		vimModeOn = false
;	else
;		Send {Escape}
;return

vim:
while (vimModeOn = true or (!GetKeyState("Ctrl","P") and GetKeyState("CAPSLOCK", "P"))) 
; make it not run if ctrl+capslock is pressed (so ctrl+capslock toggles capslock
{
	vimize()
    if modal !=
      Tooltip, %context%: %num%, 60, 10
   else if num !=
      Tooltip, %num%, 60, 10
   else
      Tooltip
   SetTimer, vim, off
}

modal =
num =
unvimize()
SetTimer, vim, on
Tooltip
Return

vimize()
{
  Gui 11:Show, Minimize, vimOn ; Hide,
  vimModeOn = true
}

unvimize()
{
  Gui 11:Destroy
  vimModeOn = false
}

#IFWinExist vimOn

; Multiples
1:: num = %num%1
2:: num = %num%2
3:: num = %num%3
4:: num = %num%4
5:: num = %num%5
6:: num = %num%6
7:: num = %num%7
8:: num = %num%8
9:: num = %num%9
0:: num = %num%0

; ~ toggle case

; Navigation

; A: The original script used 'a' to move to the
; front of the line, and 'e' to move to the back.
; Changed it to use '$' and '^' instead.

+4::
if modal = 
	send, {end}
else
	Send, +{end}
	GoSub, Run_Mode
return

+6::
if modal =
	send, {Home}
else
	Send, +{Home}
	GoSub, Run_Mode
return

; navigation keys

h::
if modal = 
	Send, {Left}
else
	Send, +{Left}
return

j::
if modal = 
	Send, {Down}
else if modal = cl
	Send, {ShiftDown}{Down}{End}{ShiftUp}
else
	Send, +{Down}
return

k::
if modal =
	Send, {Up}
else if modal = cl
	Send, {ShiftDown}{Up}{Home}{ShiftUp}
else
	Send, +{Up}
return

l::
if modal = 
	Send, {Right}
else
	Send, +{Right}
return

o::Send, {END}{ENTER}
+o::Send, {HOME}{ENTER}{UP}

Esc::
	modal = 
return

i::
	unvimize()
	vimModeOn=false
return

w::
if modal =
   send, ^{RIGHT %num%}
else
   Send, +^{RIGHT %num%}
return

b::

if modal =
   Send, ^{LEFT %num%}
else
   Send, +^{LEFT %num%}
return

; Searching

/::
  send, ^f ;; search
  unvimize()
  vimModeOn = false
  return
^/::
  send, ^h ;; search
  unvimize()
  vimModeOn = false
  return
n::Send {F3}

; Pasting

p::
IfInString, clipboard, `n
{
   Send, {END}{ENTER}^v{DEL}
}
Else
{
   Send, ^v
}
return

+p::
IfInString, clipboard, `n
{
   Send, {Home}^v
}
Else
{
   Send, ^v
}
return

; Indent and Undo
+,::Send, {Home}{HOME}{Del}
+.::Send, {Home}`t
u::Send, ^z
+u:: Send, ^y

; replace
+r::Send, {Ins}

; Modal
d::
if modal =
{
   context = Delete Mode
   modal = x
   ;GoSub, Modal_Input
}
else if modal = x
{
   GoSub, GetLineSelection
   GoSub, Run_Mode
}
return

y::
if modal =
{
   context = Yank Mode
   modal = c
   ;GoSub, Modal_Input
}
else if modal = c
{
   GoSub, Run_Mode
}
return

+y::
if modal = 
{
	context = Yank Mode
	Send, {End}{Shift Down}{Home}{Shift Up}
	modal = cl
} 
else if modal = cl
{
	modal = c
	GoSub, Run_Mode
}
return

r::Reload

#IfWinExist

; ===== SubRoutines =====

GetLineSelection:
   Send, {Home}{Shift Down}{End}{DOWN %num%}{Home}{Shift Up}
Return

Run_Mode:
   Send, ^%modal%
   Send {Left}{RIGHT}
   num =
   modal =
return