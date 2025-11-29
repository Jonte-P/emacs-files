# emacs-files
A simple emacs rice using devil-mode and eglot

## Installation
Installation is as simple as:
```bash
git clone https://github.com/Jonte-P/emacs-files ~/.emacs.d
```


## Good to know:
Code completion (along with snippets) works well, but you have to hit M-TAB (That's meta, i.e. hold down alt, or hit escape once, and then tab) for it to work.
C- in this guide means the ctrl key (and it being held down)
The different autocomplete options can be selected via META and the arrow keys, and chosen or "confirmed" with meta and return.
Code can be compiled via M-x quick-run-compile-only (That is, hold down meta and press x, and then type quick-run-compile-only), and executed with
M-x quick-run.
This config uses devil mode, so the comma key can be used as a substitute for ctrl, and ,m can be used as meta. Note, that generally, it's enough to hit comma once, and then you can generally perform the emacs commands without having to hold down the comma key. This is true until a comma is typed again, a bit of time has passed since comma was pressed, or ctrl g (not comma g) is pressed to cancel all operations. Ctrl-g is useful for when emacs is not responding, or you accidentally pressed a button, etc. Things can be undone via C-x, C-u.
Files can be saved with C-x C-s, and opened with C-x, C-f
