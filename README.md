vimdows-ng - vim normal mode anywhere in Windows
------------------------------------------------

###Info
Vimdows-ng allows you to use Vim (or vim-like) normal mode anywhere in Windows.

Use the provided executable or the .ahk script with [Autohotkey](http://www.autohotkey.com). It does not require any special permissions and will run in your system notification area until activated, when it'll show an icon on your taskbar and a small tooltip overlay in the top-left corner of the screen.

This is based on previous work of [achalddave](https://github.com/achalddave/Vimdows-Navigation) who himself modified the
[original script](http://www.autohotkey.com/community/viewtopic.php?t=44762)
by Rich Alesi, and most of the credit for this script goes to him.

###Activate normal mode
- with <tt>Shift-Esc</tt>
- with <tt>Esc</tt> for selected programs:
	* Matlab
	* Thunderbird Text Composition

###Basic VIM navigation and text manipulation
If you are not familiar with VIM yet, you might want to try a [vim tutorial](http://www.openvim.com/).
Or you might want to try [Vim Adventures](http://vim-adventures.com/) :)

A good in-depth book is [Practical VIM](https://pragprog.com/book/dnvim2/practical-vim-second-edition).

	Keys                                   Function
	====                                   ========
	h, j, k, l, w, b, $, ^                 navigation
	dd, d<w, b, $, ^>                      deletion
	o, O                                   insert lines and exit normal mode
	p, P                                   paste lines
	v                                      yank mode; not perfect
		                                           hit y after you're done selecting to copy
	<#[cmd]>                               Run 'cmd' # times. E.g. 3dd, 4w, 10l, etc
	u, <Shift> r                           Undo, redo
	/, n                                   Find, next found result (Uses Ctrl + F and F3)

###Some more advanced mappings in normal mode provided by vimdows-ng
	Keys									Function
	====									========
	a, A 									append at cursor / end of line
	0 									    go to first character in line
	C, D 									change / delete rest of line
	J									    move next line to end of this line
	gg, G 								    go to beginning/end of document
	5G 										go to a specific line
	gt, gT 									go to next/previous tab
	y2w, yb, yy, y$, ... 					yank 2 words, yank back, yank line, yank rest of line
	yi(w)									yank inner word
	d2w, c5w, cb, ... 						change and delete mode
	di(w)									delete inner word
	x, X  								    delete single characters
	Y  										yank rest of line
	I 										go to beginning of line and enter insertion mode
	e 										go to end of word
	<Ctrl> u, <Ctrl> d 						go page up/down
	<Ctrl> b, <Ctrl> f 						go page up/down
	~, 3~,v3w~,... 							Toggle case of next char(s) or visual selection.

###More modifications in vimdows-ng
- Change-mode, change-inner, delete-inner, yank-inner modes.
- show tooltip "Vimdows" when active (useful when hiding task bar)
- correction of indent and undo
- provide another script to remap caps to esc.
- limit of 50 to not blindly execute a repeated command too often (e.g. 500w -> 50w)

###Application-specific modifications:
####Matlab:
- Proper indent using editor indenting.

###Todo:
- f _char_ should move to next occurence of _char_
- jump between block beginning/end (in vim, % jumps between { and }, for instance)?

###You like this? You'll love these:
####AHK_L Alternative
- [vim.ahk](https://github.com/mihaifm/vim.ahk) (better code structure, but very slow)

####AHK Application-specific
- [Vim Keybindings for Onenote](https://github.com/idvorkin/Vim-Keybindings-For-Onenote)

####Browsers
- Firefox: [Vimperator](https://addons.mozilla.org/de/firefox/addon/vimperator/) and [Pentadactyl](http://5digits.org/pentadactyl/)
- Chrome: [Vimium](https://vimium.github.io/)

####Office
- LibreOffice: [VibreOffice](https://github.com/seanyeh/vibreoffice)
- Thunderbird: [Muttator](https://addons.mozilla.org/de/thunderbird/addon/muttator/)

####Code
- JetBrains IDEs: [IdeaVim](https://plugins.jetbrains.com/plugin/164?pr=idea)
- for most IDEs, it's better to find a specific plugin if available.

####Editors
- Atom: [Vim-mode plus](https://atom.io/packages/vim-mode-plus)
