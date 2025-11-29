;; -*- lexical-binding: t; -*-
;; Initialize melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
;; Custom variables added by Custom
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(kanagawa-dragon))
 '(custom-safe-themes
   '("d2ab3d4f005a9ad4fb789a8f65606c72f30ce9d281a9e42da55f7f4b9ef5bfc6"
     default))
 '(package-selected-packages
   '(consult consult-eglot corfu-candidate-overlay devil flycheck-eglot
	     go-mode kanagawa-themes marginalia quickrun vertico
	     yasnippet)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; Installing quickrun and other things
(when (not (package-installed-p 'go-mode))
  (package-install 'go-mode))
(when (not (package-installed-p 'consult))
(package-install 'consult))
(when (not (package-installed-p 'corfu-candidate-overlay))
  (package-install 'corfu-candidate-overlay))
(when (not (package-installed-p 'flycheck-eglot))
  (package-install 'flycheck-eglot))
(when (not (package-installed-p 'kanagawa-themes))
  (package-install 'kanagawa-themes))
(load-theme 'kanagawa-dragon)
(when (not (package-installed-p 'quickrun))
  (package-install 'quickrun))
;; Devil
(when (not (package-installed-p 'devil))
	   (package-install 'devil))
(require 'devil)
(global-devil-mode)
(global-set-key (kbd "C-,") 'global-devil-mode)

;; Remove ugly bars
(menu-bar-mode -1)
(if (window-system)
    (scroll-bar-mode -1))
(tool-bar-mode -1)


;; Eglot and go-mode section, as well as vertico
;; Ensure go-mode is loaded when opening .go files
(require 'eglot)
(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
(add-to-list 'auto-mode-alist '("\\.c\\'" . c-mode))

;; Add a hook to start Eglot automatically in go-mode buffers
(add-hook 'go-mode-hook #'eglot-ensure)
(add-hook 'c-mode-hook #'eglot-ensure)

;; Optional: automatically format Go code using 'gofmt' before saving
(add-hook 'before-save-hook #'gofmt-before-save)
;; Vertico
(when (not (package-installed-p 'vertico))
  (package-install 'vertico))
(require 'vertico)
(vertico-mode)
(setq vertico-count 13)
(setq vertico-cycle nil)
;; Vertico bindings
(keymap-set vertico-map "?" #'minibuffer-completion-help)
(keymap-set vertico-map "M-RET" #'minibuffer-force-complete-and-exit)
(keymap-set vertico-map "M-TAB" #'minibuffer-complete)
(when (not (package-installed-p 'marginalia))
  (package-install 'marginalia))
(require 'marginalia)
(marginalia-mode)
;; Flycheck
(when (not (package-installed-p 'flycheck))
  (package-install 'flycheck))
(require 'flycheck)
(global-flycheck-mode +1)
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
;; Consult
;; Load the consult package after it's installed
(when (not (package-installed-p 'consult))
  (package-install 'consult))
(require 'consult)

;; Configuration for Consult
(with-eval-after-load 'consult

  ;; Recommended: Bind Consult commands to convenient keymaps.
  ;; Note that Consult commands often replace built-in commands.
  (define-key mode-specific-map (kbd "C-c M-x") #'consult-mode-command)
  (define-key mode-specific-map (kbd "C-c h") #'consult-history)

  ;; Remap standard Emacs commands to Consult versions
  (global-set-key (kbd "C-x b") #'consult-buffer)
  (global-set-key (kbd "C-x 4 b") #'consult-buffer-other-window)
  (global-set-key (kbd "C-x 5 b") #'consult-buffer-other-frame)
  (global-set-key (kbd "C-x r b") #'consult-bookmark) ;; orig. bookmark-jump
  (global-set-key (kbd "M-y") #'consult-yank-pop)     ;; orig. yank-pop
  (global-set-key (kbd "M-s g") #'consult-grep)
  (global-set-key (kbd "M-s r") #'consult-ripgrep)
  (global-set-key (kbd "M-s L") #'consult-line-multi)

  ;; Use Consult for navigation commands
  (define-key global-map (kbd "M-g e") #'consult-compile-error)
  (define-key global-map (kbd "M-g g") #'consult-goto-line)
  (define-key global-map (kbd "M-g i") #'consult-imenu)
  
  ;; You might need to disable built-in completion previews if you use Consult's
  ;; This is part of setting up a complete completion *system* (like Vertico/Marginalia/Consult)
  ;; (setq completion-style 'emporium ; or 'prescient or 'orderless
  ;;       completion-category-defaults nil
  ;;       completion-category-overrides '((file (styles partial-by-ext))))
  )

;; Yasnippet
(when (not (package-installed-p 'yasnippet))
  (package-install 'yasnippet))
(require 'yasnippet)
(yas-global-mode 1)
