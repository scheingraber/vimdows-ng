; Auto-Execute
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
delete = x
yank = c
yanklines = cl

SetTimer, vim, 100
Return

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
  vimModeOn := true
}

unvimize()
{
  Gui 11:Destroy
  vimModeOn := false
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
; 0:: num = %num%0

; ~ toggle case

; Navigation

0::handle_nav_mode("{home}")
+4::handle_nav_mode("{end}")
+6::handle_nav_mode("{home}")

; navigation keys

h::handle_nav_mode("{left " . num . "}")

j::handle_nav_mode("{down " . num . "}")

k::handle_nav_mode("{up " . num . "}")

l::handle_nav_mode("{right " . num . "}")

w::handle_nav_mode("^{right " . num . "}")

b::handle_nav_mode("^{left " . num . "}")

; Insert lines
o::
if modal = 
	Send, {END}{ENTER}
	unvimize()
	vimModeOn := false
return

+o::
if modal =
	Send, {HOME}{ENTER}{UP}
	unvimize()
	vimModeOn := false
return

; Go out of whatever mode you're in
Esc::
	modal = 
	num = 
	context = 
	Send {Left}{Right}
return

i::
	unvimize()
	vimModeOn := false
return

a::
if modal = 
	Send, {Right}
	unvimize()
	vimModeOn := false
return

+a::
if modal = 
	Send, {END}
	unvimize()
	vimModeOn := false
return

; Searching

/::
  send, ^f ;; search
  unvimize()
  vimModeOn := false
  return
^/::
  send, ^h ;; search
  unvimize()
  vimModeOn := false
  return
n::Send {F3}

; Pasting

p::
IfInString, clipboard, `n
{
   Send, {END}{ENTER}^v
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
+,::Send, {End}{Home}{Home}{Del}{Del}{Del}{Del}
+.::Send, {Home}`t
u::Send, ^z
+u:: Send, ^y

; replace
+r::Send, {Ins}

; Modal
d::
if (modal = "") {
   context = Delete Mode 
   modal = %delete%
} else if ( modal = delete) {
   GetLineSelection()
   Run_Mode()
}
return

v::
if (modal = "") {
   context = Yank Mode
   modal = %yank%
}
return

+v::
if (modal = "") {
	GetLineSelection()
	context = Line Yank Mode
	modal = %yanklines%
}
return

y::
if (modal = yanklines) {
	modal = %yank%
}
Run_Mode()
return

c::
if (modal = yanklines or modal = yank) {
	modal = %delete%
	Run_Mode()
	unvimize()
	vimModeOn := false
} else {
	Send, c
}
return

^+!r::Reload

#IfWinExist

; ===== SubRoutines =====

handle_nav_mode(nav)
{
	global
	num =
	if (modal =  "") {
		Send, %nav%
	} else {
		Send, +%nav%
		if (modal = delete) {
			Run_Mode()
		} else if (modal = yanklines) {
			if (nav = "down") {
				Send +{End}
			} else if (nav = "up") {
				Send +{Home}
			}
		}
	}
	return
}

GetLineSelection() {
   Send, {ShiftUp}{Home}{Shift Down}{End}{DOWN %num%}{Home}{Shift Up}
}

Run_Mode() {
   global modal
   Send, ^%modal%
   Send {Left}{RIGHT}
   num =
   modal =
}
