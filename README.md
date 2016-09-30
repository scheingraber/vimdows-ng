vimdows-ng navigation
---------------------

Vimdows Navigation tries to allow you to use Vim (or vim-like) commands outside of vim anywhere in Windows.
This is forked from [achalddave](https://github.com/achalddave/Vimdows-Navigation) who himself modified the
[original script](http://www.autohotkey.com/community/viewtopic.php?t=44762)
by Rich Alesi, and most of the credit for this script goes to him.

Use the provided executable or the .ahk script with [Autohotkey](http://www.autohotkey.com). It doesn not require any special permissions and will run in your system notification area until activated, when it'll show an icon on your taskbar and a small tooltip overlay in the top-left corner of the screen.



###Additional mappings in normal mode provided by this fork
- "a" and "A"
- 0 goes to first character in line
- "C" and "D"
- "g" and "G" to go to beginning / end of document.
- "x" and "X" (delete).
- "Y" to yank line.
- "I" go to first char and exit normal mode.
- Ctrl-u and Ctrl-d to go page up/down.
- Ctrl-r to redo, not shift-u.

###Some modifications in this fork:
- show tooltip "Vimdows" when active (useful when hiding task bar)
- correction of indent and undo
- "inner-word" mode, not perfect: only "di" works which emulates "diw".
- WIP change-mode.
- provide another script to remap caps to esc.

###Todo:
- change-mode.
- jump between block beginning/end (in vim, % jumps between { and }, for instance)?
- unify with [Vim-Keybindings for Onenote](https://github.com/ChrisPara/Vim-Keybindings-For-Onenote).


###Original Readme:

**Vim "mode"**: Toggle with <tt>Shift</tt>+<tt>Esc</tt>; <tt>i</tt> will also exit
this mode


**Quick Vim keys**:  <tt>CapsLock</tt> + <tt>cmd</tt>

Note that because of the way Quick Vim functions, you will have to use
<tt>Ctrl</tt>+<tt>CapsLock</tt> to toggle <tt>CapsLock</tt>.

	Keys                                   Function
	====                                   ========
	h, j, k, l, w, b, $, ^                 navigation
	dd, d<w, b, $, ^>                      deletion
	o, O                                   insert lines and exit vim 'mode'
	p, P                                   paste lines
	v                                      yank mode; not perfect
   	                                           hit y after you're done selecting to copy
	<#[cmd]>                               Run 'cmd' # times. E.g. 3dd, 4w, 10l, etc
	u, <shift> u                           Undo, redo
	/, n                                   Find, next found result (Uses Ctrl + F and F3)
