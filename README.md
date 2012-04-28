Vim Everywhere
--------------

Vim Everywhere tries to allow you to use Vim (or vim-like) commands outside of vim. 
The original script (http://www.autohotkey.com/community/viewtopic.php?t=44762)
was written by Rich Alesi, and most of the credit for this script goes to him. I
(Achal Dave) modified a variety of things, but I would have had no idea how to even
begin this if it weren't for Alesi's code. 

It isn't perfect, of course, but I've found it useful.

Activation:
	Hit <Shift><Esc>
	Hit <CapsLock> + <cmd>
		You can use <ctrl>+<CapsLock> to toggle caps lock

	Keys							Function
	----							--------
	h, j, k, l, w, b, $, ^ 			navigation
	dd, d<w, b, $, ^>				deletion
	o, O							insert lines
	p, P							paste lines
	y								yank mode; not perfect
										hit y after you're done selecting to copy
	Y								similar to 'y', except copies lines
	<#[cmd]>						Run 'cmd' # times. E.g. 3dd. May not be perfect
	/, n							Find, next found result (Uses Ctrl + F and F3)
	