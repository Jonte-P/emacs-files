;; -*- lexical-binding: t; -*-

;;; ============================
;;; User options (Customize)
;;; ============================

(defgroup jp nil
  "Personal starter config options."
  :group 'convenience)

(defcustom jp/use-devil-mode t
  "Enable devil-mode as the main keybinding layer."
  :type 'boolean
  :group 'jp)

(defcustom jp/disable-gui-bars t
  "Disable tool bar, menu bar, and scroll bar."
  :type 'boolean
  :group 'jp)

(defcustom jp/use-vertico t
  "Enable Vertico completion UI."
  :type 'boolean
  :group 'jp)

(defcustom jp/vertico-count 13
  "Number of completion candidates Vertico should show."
  :type 'integer
  :group 'jp)

(defcustom jp/use-marginalia t
  "Enable Marginalia minibuffer annotations."
  :type 'boolean
  :group 'jp)

(defcustom jp/use-flycheck t
  "Enable Flycheck globally."
  :type 'boolean
  :group 'jp)

(defcustom jp/use-yasnippet t
  "Enable yasnippet globally."
  :type 'boolean
  :group 'jp)

(defcustom jp/use-eglot t
  "Enable Eglot (LSP) for Go and C."
  :type 'boolean
  :group 'jp)

(defcustom jp/auto-gofmt t
  "Automatically run gofmt before saving Go files."
  :type 'boolean
  :group 'jp)

(defcustom jp/auto-restart-after-first-setup t
  "If non-nil, automatically restart Emacs once after installing
missing packages from `my-packages`."
  :type 'boolean
  :group 'jp)

;;; ============================
;;; Package setup
;;; ============================

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

;; Refresh archive contents once if needed (first run on a fresh install)
(unless package-archive-contents
  (package-refresh-contents))

;; Track whether we installed any packages this session
(defvar jp/installed-new-packages nil
  "Non-nil if any of `my-packages` were installed during this session.")

(defvar my-packages
  '(consult
    consult-eglot
    corfu
    corfu-candidate-overlay
    devil
    flycheck
    flycheck-eglot
    go-mode
    kanagawa-themes
    marginalia
    quickrun
    vertico
    yasnippet
    restart-emacs)
  "Packages that should be installed on startup.")

(dolist (pkg my-packages)
  (unless (package-installed-p pkg)
    (setq jp/installed-new-packages t)
    (package-install pkg))
  (require pkg nil 'noerror))

;; If we installed new packages and the user allows it, restart once
(when (and jp/installed-new-packages
           jp/auto-restart-after-first-setup)
  (add-hook
   'emacs-startup-hook
   (lambda ()
     (when (featurep 'restart-emacs)
       (message "Packages installed. Restarting Emacs once to finish setup…")
       (restart-emacs)))))

;;; ============================
;;; UI tweaks
;;; ============================

(when jp/disable-gui-bars
  (menu-bar-mode -1)
  (when (window-system)
    (scroll-bar-mode -1))
  (tool-bar-mode -1))

;;; ============================
;;; Devil (modal-ish key layer)
;;; ============================

(when jp/use-devil-mode
  (global-devil-mode 1))

;; Toggle devil-mode quickly
(global-set-key (kbd "C-,") #'global-devil-mode)

;;; ============================
;;; Completion / minibuffer
;;; ============================

;; Vertico
(when jp/use-vertico
  (vertico-mode 1)
  (setq vertico-count jp/vertico-count
        vertico-cycle nil)

  ;; Vertico keybindings
  (keymap-set vertico-map "?"     #'minibuffer-completion-help)
  (keymap-set vertico-map "M-RET" #'minibuffer-force-complete-and-exit)
  (keymap-set vertico-map "M-TAB" #'minibuffer-complete))

;; Marginalia
(when jp/use-marginalia
  (marginalia-mode 1))

;;; ============================
;;; Eglot / languages
;;; ============================

(when jp/use-eglot
  ;; Only require Eglot if we actually want it
  (require 'eglot)

  ;; Go
  (autoload 'go-mode "go-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

  ;; C
  (add-to-list 'auto-mode-alist '("\\.c\\'" . c-mode))

  ;; Start Eglot automatically in Go and C buffers
  (add-hook 'go-mode-hook #'eglot-ensure)
  (add-hook 'c-mode-hook  #'eglot-ensure)

  ;; Format Go buffers before save, but only in Go buffers
  (when jp/auto-gofmt
    (add-hook 'go-mode-hook
              (lambda ()
                (add-hook 'before-save-hook #'gofmt-before-save nil t)))))

;;; ============================
;;; Flycheck
;;; ============================

(when jp/use-flycheck
  (global-flycheck-mode +1)
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

;;; ============================
;;; Consult keybindings
;;; ============================

(with-eval-after-load 'consult
  ;; Convenient Consult bindings (replace some built-ins)
  (define-key mode-specific-map (kbd "C-c M-x") #'consult-mode-command)
  (define-key mode-specific-map (kbd "C-c h")   #'consult-history)

  (global-set-key (kbd "C-x b")   #'consult-buffer)
  (global-set-key (kbd "C-x 4 b") #'consult-buffer-other-window)
  (global-set-key (kbd "C-x 5 b") #'consult-buffer-other-frame)
  (global-set-key (kbd "C-x r b") #'consult-bookmark)
  (global-set-key (kbd "M-y")     #'consult-yank-pop)
  (global-set-key (kbd "M-s g")   #'consult-grep)
  (global-set-key (kbd "M-s r")   #'consult-ripgrep)
  (global-set-key (kbd "M-s L")   #'consult-line-multi)

  (define-key global-map (kbd "M-g e") #'consult-compile-error)
  (define-key global-map (kbd "M-g g") #'consult-goto-line)
  (define-key global-map (kbd "M-g i") #'consult-imenu))

;;; ============================
;;; Snippets
;;; ============================

(when jp/use-yasnippet
  (yas-global-mode 1))

;;; ============================
;;; Custom (managed by Emacs)
;;; ============================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(kanagawa-dragon))
 '(custom-safe-themes
   '("d2ab3d4f005a9ad4fb789a8f65606c72f30ce9d281a9e42da55f7f4b9ef5bfc6"
     default))
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

