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
change = cc
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

; 0 is used for num and to go to first char dep. on context
0::
if (num = "") {
	handle_nav_mode("{home}")
	} else {
		num = %num%0
	}
return


; ~ toggle case
; TODO

; Navigation
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

; get next line to end of this line
+j::
if modal =
	Send, {Down}{Home}{Home}{Backspace}
return

; Delete end of line
+D::
if modal =
	Send, {SHIFT DOWN}{END}{SHIFT UP}{DEL}
return

; change end of line
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


; todo: implement true ci and di -modal types here
; change modal to changer-inner and delete-inner and wait for next key
; change context to change-inner and delete inner
i::
if (modal = "") {
	; exit normal mode, go to insertion mode
	unvimize()
    vimModeOn := false
} else if (modal = delete) {
	; for now, di emulates diw
	GetWordSelection()
	Run_Mode()
} else if (modal = change) {
	; for now, ci emulates ciw
	GetWordSelection()
	Send, {BACKSPACE}
	unvimize()
	vimModeOn := false
	context =
	modal =
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

;; Modal
d::
if (modal = "") {
   context = Delete Mode
   modal = %delete%
} else if ( modal = delete) {
   GetLineSelection()
   Run_Mode()
}
return

c::
if (modal = "") {
    context = Change Mode
    modal = %change%
} else if (modal = yanklines or modal = yank) {
    ;change text from visual mode
	modal = %delete%
	Run_Mode()
	unvimize()
	vimModeOn := false
} else if ( modal = change) {
	if islastkey("c") {
		GetLineSelection()
		Send, {BACKSPACE}
		unvimize()
		vimModeOn := false
		Send, {Enter}{Up}
		context =
		modal =
	}
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

;y yanks in visual, yy yanks line
y::
if (modal = yanklines) {
	modal = %yank%
} else if (modal = "") {
	if IsLastKey("y") {
	    GetLineSelection()
	    modal = %yank%
	    Run_Mode()
	}
}
Run_Mode()
return

;Y yanks rest of line
+y::
if (modal = "") {
    Send, {Shift Down}{End}{Shift Up}
    modal = %yank%
    Run_Mode()
}
return

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
	    } else if ( modal = change ) {
			Send, {BACKSPACE}
			unvimize()
			vimModeOn := false
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
   global
   Send, {Shift Up}{Home}{Shift Down}{End}{DOWN %num%}{Home}{Shift Up}
}

GetWordSelection() {
	global
	Send, {Shift Up}^{Left}{Shift Down}^{Right %num%}{Shift Up}
}

Run_Mode() {
   global modal
   Send, ^%modal%
   Send {Left}{RIGHT}
   num =
   modal =
}
