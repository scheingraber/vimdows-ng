; Auto-Execute
; Modal_Vim.ahk
; Initial Build: Rich Alesi
; Friday, May 29, 2009
; Original available at http://www.autohotkey.com/community/viewtopic.php?t=44762

; Some modifications: Achal Dave
; Friday, April 27, 2012

; More modifications: Chris Scheingraber
; Friday, September 30, 2016

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

; vim/normal mode
vimModeOn := false

; enter normal mode for some programs with ESC
#IfWinActive MATLAB
Esc::
	vimModeOn := !vimModeOn
return
#IfWinActive
; Thunderbird
#IfWinActive Verfassen
Esc::
	vimModeOn := !vimModeOn
return
#IfWinActive


; can always enter normal mode with shift-ESC
+Esc::
	vimModeOn := !vimModeOn
return


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
      Tooltip, vimdows, 60, 10
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
  Tooltip
  Gui 11:Destroy
  vimModeOn := false
}

; function to get last key
IsLastKey(key)
{
    return (A_PriorHotkey == key and A_TimeSincePriorHotkey < 400)
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
;todo: check num and handle navigation / num case correctly
; 0:: num = %num%0

; ~ toggle case

; Navigation

0::handle_nav_mode("{home}")
+4::handle_nav_mode("{end}")
+6::handle_nav_mode("{home}")

; move back(up) and forward(down) one page
^b::handle_nav_mode("{PgUp}")
^f::handle_nav_mode("{PgDn}")

; TODO: this should actually move half a page
^u::handle_nav_mode("{PgUp}")
; d goes page down - not in Matlab since thats used to open a under caret
; TODO: this should actually move half a page
SetTitleMatchMode 2 ;- Mode 2 is window title substring.
^d::
IfWinNotActive, MATLAB
	{
	handle_nav_mode("{PgDn}")
	} else
	{
		SendInput, ^d
	}
return

; navigation keys

h::handle_nav_mode("{left " . num . "}")

j::handle_nav_mode("{down " . num . "}")

k::handle_nav_mode("{up " . num . "}")

l::handle_nav_mode("{right " . num . "}")

w::handle_nav_mode("^{right " . num . "}")

e::handle_nav_mode("^{right " . num . "}{left}")

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

+i::
	Send, {HOME}{HOME}
	unvimize()
	vimModeOn := false
return

; Delete end of line
+D::
if modal =
	Send, {SHIFT DOWN}{END}{SHIFT UP}{DEL}
return

; delete and change end of line
+C::
if modal =
	Send, {SHIFT DOWN}{END}{SHIFT UP}{DEL}
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
if modal =
{
	unvimize()
    vimModeOn := false
; this is not correct vim behaviour yet - do not want di, but diw
; also need a "change" mode / context
} else {
   GetWordSelection()
   Run_Mode()
}
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


; gg
g::
if modal =
{
	if IsLastKey("g")
	{
	    ;gg - Go to start of document
	    Send, ^{Home}
	}
}
return

; G and 20G (go to 20th line)
+g::
if modal =
{
	if num =
	{
	; G to go to last line
		Send, {Ctrl Down}{END}{Ctrl Up}
	} else
	{
	; go to n-th line
	; Matlab
	IfWinActive, MATLAB
		{
			SendInput, {Ctrl Down}g{Ctrl Up}
			SendRaw, %num%
			SendInput, {Enter}
		    num =
		} else {
		; general n-th line
		num -= 1
		Send, {Ctrl Down}{HOME}{Ctrl Up}{Down %num%)}
	    num =
		}
	}
}
return

; gt and gT
t::
if modal =
{
	if IsLastKey("g")
	{
	    ;gt - next tab
	    Send, {Ctrl Down}{PgDn %num%}{Ctrl Up}
	    num =
	}
}
return
+t::
if modal =
{
	if IsLastKey("g")
	{
	    ;gT - prev tab
	    Send, {Ctrl Down}{PgUp %num%}{Ctrl Up}
	    num =
	}
}
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

; Decrease Indent
+,::
IfWinActive, MATLAB
{
	Send, ^[
} else {
	; General indent
	Send, {End}{Home}{Home}{Del}{Del}{Del}{Del}
}
return


; Increase Indent
+.::
IfWinActive, MATLAB
{
	Send, ^]
} else {
	; General indent
	Send, {Home}`t
}
return


; undo and redo
u::Send, ^z
^r:: Send, ^y

; replace
+r::Send, {Ins}

; delete
x::Send, {Del}
+x::Send, {Backspace}

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

+y::
if (modal = "") {
    GetLineSelection()
    modal = %yank%
    Run_Mode()
}
return

;change text from visual mode
c::
if (modal = yanklines or modal = yank) {
	modal = %delete%
	Run_Mode()
	unvimize()
	vimModeOn := false

;cc
} else if modal =
	{
	if IsLastKey("c") {
		GetLineSelection()
		Send, {BACKSPACE}
		unvimize()
		vimModeOn := false
		Send, {Enter}{Up}
	}
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
			} else if (nav = "PgDn") {
				Send +{PgDn}
			} else if (nav = "PgUp") {
				Send +{PgUp}
			}
		}
	}
	return
}

GetLineSelection() {
   Send, {Shift Up}{Home}{Shift Down}{End}{DOWN %num%}{Home}{Shift Up}
}

GetWordSelection() {
	Send, {Shift Up}^{Left}{Shift Down}^{Right %num%}{Shift Up}
}

Run_Mode() {
   global modal
   Send, ^%modal%
   Send {Left}{RIGHT}
   num =
   modal =
}
