vimdows-ng navigation
---------------------

###Info
Vimdows-ng allows you to use Vim (or vim-like) normal mode outside anywhere in Windows.

Use the provided executable or the .ahk script with [Autohotkey](http://www.autohotkey.com). It does not require any special permissions and will run in your system notification area until activated, when it'll show an icon on your taskbar and a small tooltip overlay in the top-left corner of the screen.

This is forked from [achalddave](https://github.com/achalddave/Vimdows-Navigation) who himself modified the
[original script](http://www.autohotkey.com/community/viewtopic.php?t=44762)
by Rich Alesi, and most of the credit for this script goes to him.

###Activate normal mode
- with _shift-esc_
- with _esc_ for selected programs:
	* Matlab
	* Thunderbird Text Composition

###Additional mappings in normal mode provided by this fork
- _a_ and _A_ to append at cursor / end of line.
- _0_ goes to first character in line.
- _C_ and _D_ to change / delete rest of line.
- _gg_ and _G_ to go to beginning/end of document.
- _gt_ and _gT_ to go to next/previous tab.
- _x_ and _X_ (delete).
- _Y_ to yank line.
- _I_ go to first char and exit normal mode.
- _e_ goes to end of word.
- _Ctrl-u_ and _Ctrl-d_ to go page up/down.
- _Ctrl-r_ to redo, not shift-u.

###Some modifications in this fork:
- show tooltip "Vimdows" when active (useful when hiding task bar)
- correction of indent and undo
- "inner-word" mode, not perfect: only "di" works which emulates "diw".
- WIP change-mode.
- provide another script to remap caps to esc.

###Application-specific modifications:
####Matlab:
- Proper indent using editor indenting.

####Onenote:
- Need to merge.

###Todo:
- proper change-mode.
- jump between block beginning/end (in vim, % jumps between { and }, for instance)?
- unify with [Vim-Keybindings for Onenote](https://github.com/ChrisPara/Vim-Keybindings-For-Onenote).

###You like this? You'll love these:
####Browsers
- Firefox: [Vimperator](https://addons.mozilla.org/de/firefox/addon/vimperator/) and [Pentadactyl](http://5digits.org/pentadactyl/)
- Chrome: [Vimium](https://vimium.github.io/)

####Office
- LibreOffice: [VibreOffice](https://github.com/seanyeh/vibreoffice)
- Thunderbird: [Muttator](https://addons.mozilla.org/de/thunderbird/addon/muttator/)

####Code
- JetBrains IDEs: [IDEA](https://plugins.jetbrains.com/plugin/164?pr=idea)
- for most IDEs, it's better to find a specific plugin if available.

####Editors
- Atom: [Vim-mode plus](https://atom.io/packages/vim-mode-plus)


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
