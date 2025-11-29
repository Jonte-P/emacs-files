# emacs-files
A simple emacs rice using devil-mode and eglot

## Installation
Installation is as simple as:
```bash
git clone https://github.com/Jonte-P/emacs-files ~/.emacs.d
```


## Good to know:
Code completion (along with snippets) works well, but you have to hit M-TAB. Meta and the arrow keys (in this case actually meta, it doesn't work with devil mode) can be used to select a candidate, that is then confirmed with M-RETURN.
The different autocomplete options can be selected via META and the arrow keys, and chosen or "confirmed" with meta and return.
Code can be compiled via ```M-x quick-run-compile-only```, and executed with
```M-x quick-run```.
This config uses devil mode, so the comma key can be used as a substitute for ctrl, and ,m can be used as meta. Comma can be typed by hitting comma twice, or comma and space. Ctrl space is triggered via ,z followed by space.
