Vimdows Navigation
------------------

Vimdows Navigation tries to allow you to use Vim (or vim-like) commands outside of vim anywhere in Windows.
This is forked from [achalddave](https://github.com/achalddave/Vimdows-Navigation) who himself modified the
[original script](http://www.autohotkey.com/community/viewtopic.php?t=44762)
by Rich Alesi, and most of the credit for this script goes to him.

Use it with [Autohotkey](http://www.autohotkey.com). It will run in your
system notification area until activated, when it'll show an icon on your taskbar. 



###Additional mappings in normal mode provided by this fork
- "a" and "A"
- 0 goes to first character in line
- "C" and "D"
- "g" and "G" to go to beginning / end of document.
- "x" and "X" (delete).
- "Y" to yank line.

###Some modifications:
- show tooltip "Vimdows" when active (useful when hiding task bar)
- correction of indent and undo


###Activation

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
	
