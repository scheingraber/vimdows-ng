Vimdows-keys
------------

Vimdows-keys tries to allow you to use Vim (or vim-like) commands outside of vim. 
The [original script](http://www.autohotkey.com/community/viewtopic.php?t=44762)
was written by Rich Alesi, and most of the credit for this script goes to him. I
modified a variety of things, but I would have had no idea how to even
begin this if it weren't for Alesi's code. 

It isn't perfect, of course, but I've found it useful. You can run the .exe, or 
download [Autohotkey](http://www.autohotkey.com). Either way, this'll run in your
system notification area until activated, when it'll show an icon on your taskbar. 

###Activation

**Vim "mode"**: Toggle with <tt>Shift</tt>+<tt>Esc</tt>; <tt>i</tt> will also exit 
the mode


**Quick Vim keys**:  <tt>CapsLock</tt> + <tt>cmd</tt>

Note that because of the way Quick Vim functions, you will have to use 
<tt>Ctrl</tt>+<tt>CapsLock</tt> to toggle <tt>CapsLock</tt>. 

	Keys                                   Function
	====                                   ========
	h, j, k, l, w, b, $, ^                 navigation
	dd, d<w, b, $, ^>                      deletion
	o, O                                   insert lines
	p, P                                   paste lines
	y                                      yank mode; not perfect
   	                                           hit y after you're done selecting to copy
	Y                                      similar to 'y', except copies lines
	<#[cmd]>                               Run 'cmd' # times. E.g. 3dd. May not be perfect
	/, n                                   Find, next found result (Uses Ctrl + F and F3)
	