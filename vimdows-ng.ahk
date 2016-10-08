; Auto-Execute
; Modal_Vim.ahk
; Initial Build: Rich Alesi
; Friday, May 29, 2009
; Original available at http://www.autohotkey.com/community/viewtopic.php?t=44762

; Some modifications: Achal Dave
; Friday, April 27, 2012

; More modifications: Chris Scheingraber
; Thursday, October 6, 2016

#Persistent
#SingleInstance, Force
SetKeyDelay, -1
CoordMode, Tooltip, Screen
modal =
context =
num =
delete = x
visual = c
yank = cy
change = cc
visuallines = cl

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
	if (modal = "") {
		vimModeOn := true
	} else {
		vimModeOn := !vimModeOn
	}
return
#IfWinActive
; Thunderbird
#IfWinActive Verfassen
Esc::
	if (modal = "") {
		vimModeOn := true
	} else {
		vimModeOn := !vimModeOn
	}
return
#IfWinActive


; can always enter normal mode with shift-ESC
+Esc::
	if (modal = "") {
		vimModeOn := true
	} else {
		vimModeOn := !vimModeOn
	}
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
; limit to not blindly run sth too often
1::
	num = %num%1
	numlimit(500)
return

2::
	num = %num%2
	numlimit(500)
return

3::
	num = %num%3
	numlimit(500)
return

4::
	num = %num%4
	numlimit(500)
return

5::
	num = %num%5
	numlimit(500)
return

6::
	num = %num%6
	numlimit(500)
return

7::
	num = %num%7
	numlimit(500)
return

8::
	num = %num%8
	numlimit(500)
return

9::
	num = %num%9
	numlimit(500)
return

; 0 is used for num and to go to first char dep. on context
0::
if (num = "") {
	handle_nav_mode("{home}")
	} else {
		num = %num%0
		numlimit(500)
	}
return

; soft limit for num to not blindly execute too often
numlimit(limit) {
	global num
	if (num > limit) {
		num := limit
	}
}

; swap case of current letter
~::
	if (modal = visuallines or modal = visual) {
		Convert_Inv()
	} else {
		GetCharSelection()
		Convert_Inv()
		num =
	}
	; return to prev position
	Send, {Left}
return

; credit: this is taken from https://autohotkey.com/board/topic/24431-convert-text-uppercase-lowercase-capitalized-or-inverted/
Convert_Inv()
{
 Clip_Save:= ClipboardAll                                            ; save original contents of clipboard
 Clipboard:= ""                                                      ; empty clipboard
 Send ^c{delete}                                                     ; copy highlighted text to clipboard

 Inv_Char_Out:= ""                                                   ; clear variable that will hold output string
 Loop % Strlen(Clipboard) {                                          ; loop for each character in the clipboard
    Inv_Char:= Substr(Clipboard, A_Index, 1)                         ; isolate the character
    if Inv_Char is upper                                             ; if upper case
       Inv_Char_Out:= Inv_Char_Out Chr(Asc(Inv_Char) + 32)           ; convert to lower case
    else if Inv_Char is lower                                        ; if lower case
       Inv_Char_Out:= Inv_Char_Out Chr(Asc(Inv_Char) - 32)           ; convert to upper case
    else
       Inv_Char_Out:= Inv_Char_Out Inv_Char                          ; copy character to output var unchanged
 }
 Send %Inv_Char_Out%                                                 ; send desired text
 Len:= Strlen(Inv_Char_Out)
 Send +{left %Len%}                                                  ; highlight desired text
 Clipboard:= Clip_Save                                               ; restore original clipboard
}

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
	; select end of line
	GetEndOfLineSelection()
	; set modal to cut
	modal = x
	Run_Mode()
return

; change end of line
+C::
if modal =
	; select end of line
	GetEndOfLineSelection()
	; set modal to cut
	modal = x
	Run_Mode()
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
; change modal to changer-inner and delete-inner and wait for next movement key
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
} else if (modal = yank) {
	; for now, yi emulates yiw
	GetWordSelection()
	modal = %visual%
	Run_Mode()
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
; need to turn this into a new mode to get <2j, ...
+,::
if IsLastKey("+,") {
	IfWinActive, MATLAB
	{
		Send, ^[
	} else {
		; General indent
		Send, {End}{Home}{Home}{Del}{Del}{Del}{Del}
	}
}
return


; need to turn this into a new mode to get <2j, ...
; Increase Indent
+.::
if IsLastKey("+.") {
	IfWinActive, MATLAB
	{
		Send, ^]
	} else {
		; General indent
		Send, {Home}`t
	}
}
return


; undo and redo
u::Send, ^z
^r:: Send, ^y

; replace
+r::Send, {Ins}

r::
if (modal = "") {
	Send, +{Right}
	unvimize()
	vimModeOn := false
	}
return

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
} else if ( modal = visuallines or modal = visual ) {
    ;delete text from visual mode
	modal = %delete%
	Run_Mode()
}
return

y::
if (modal = "") {
   context = Yank Mode
   modal = %yank%
} else if (modal = yank) {
   GetLineSelection()
   modal = %visual%
   Run_Mode()
} else if ( modal = visuallines or modal = visual ) {
    ;yank text from visual mode
	modal = %visual%
	Run_Mode()
}
return

c::
if (modal = "") {
    context = Change Mode
    modal = %change%
} else if (modal = visuallines or modal = visual) {
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
   context = Visual Mode
   modal = %visual%
}
return

+v::
if (modal = "") {
	GetLineSelection()
	context = Visual Line Mode
	modal = %visuallines%
}
return

;Y yanks rest of line
+y::
if (modal = "") {
	; select end of line
	GetEndOfLineSelection()
	; set modal to copy
    modal = c
    Run_Mode()
}
return

#IfWinExist

; ===== SubRoutines =====

; handle navigation keys hjkl, w, e, b
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
		} else if ( modal = yank ) {
			modal = %visual%
			Run_Mode()
	    } else if ( modal = change ) {
			Send, {BACKSPACE}
			unvimize()
			vimModeOn := false
		} else if (modal = visuallines) {
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

; text block/object selection modes

; select line (e.g. yy)
GetLineSelection() {
   global
   Send, {Shift Up}{Home}{Shift Down}{End}{DOWN %num%}{Home}{Shift Up}
}

; select end of line (e.g. y$, C)
GetEndOfLineSelection() {
	; select end of line
	Send, {SHIFT DOWN}{END}{SHIFT UP}
}

; select inner word (e.g. yw)
; todo: correctly split select inner word and select word!
GetWordSelection() {
	global
	Send, {Shift Up}^{Left}{Shift Down}^{Right %num%}{Shift Up}
}

; select next character (e.g. for ~, or for r)
GetCharSelection() {
	global
	Send, {Shift Down}{Right %num%}{Shift Up}
}

; run command - yank, delete, change
Run_Mode() {
   global modal
   Send, ^%modal%
   Send {Left}{RIGHT}
   num =
   modal =
}
