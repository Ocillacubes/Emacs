;; === THEME ===

;; Clean up
(scroll-bar-mode -1) ;; Turn off scroll bar on the side
(tool-bar-mode -1) ;; Hide toolbar
(tooltip-mode -1) ;; Hide tooltips
(menu-bar-mode -1) ;; Hide menubar
(setq inhibit-startup-message t) ;; Hide welcome message

(use-package gruvbox-theme
  :ensure t)
(load-theme 'gruvbox-dark-medium t) ;; Actually load the theme

(setq visible-bell t) ;; Flash when backspace on empty line

;; Start emacs fullscreen
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("7661b762556018a44a29477b84757994d8386d6edee909409fabe0631952dad9" default))
 '(initial-frame-alist '((fullscreen . maximized)))
 '(package-selected-packages
   '(gruvbox-theme magit undo-tree swiper which-key spaceline powerline nix-mode ivy evil use-package)))


;; === PACKAGE STUFF ===

;; Initialize package sources
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
      ("org" . "https://orgmode.org/elpa/")
      ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; Refresh packages if theyre not there
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)



;; === KEYBINDS === 

;; Evil Mode (Vim keybinds)
(use-package evil
  :ensure t
  :defer nil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scoll t) ;; Doesn't want to work this is so sad
  :config
  (evil-mode 1))

;; Escape quits prompts WHY IS THIS NOT DEFAULT
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Tabbing


;; === FILE MANAGEMENT ===

;; Swiper - Search document for text, C-n / C-p to navigate or use arrow keys
(use-package swiper 
  :ensure t)




;; === AUTOCOMPLETION ===
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-l" . ivy-alt-done)
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . Ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

;; Autosuggestions
(use-package which-key
  :ensure t
  :diminish which-key-mode
  :init
  (which-key-mode))

;; Bracket Pairs - Truly amazing
(setq electric-pair-pairs '(
							(?\{ . ?\})
							(?\( . ?\))
							(?\[ . ?\])
							(?\" . ?\")
							))
(electric-pair-mode t)

;; TODO -- setup company package w/ irony



;; === MODELINE ===
(use-package diminish ;; Keep trash out
  :ensure t)
(use-package spaceline
  :ensure t)
(use-package powerline
  :ensure t
  :init
  (spaceline-spacemacs-theme)
  :hook
  ('after-init-hook) . 'powerline-reset)



;; === SYNTAX HIGHLIGHTING ===
(use-package nix-mode ;; .nix
  :mode "\\.nix\\'")



;; === MAIL ===



;; === HOMEPAGE ===
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title "An Emacs Distro for the Devilish User") ;; Welcome message
  (setq dashboard-startup-banner "~/.emacs.d/logo.png") ;; Remilia picture from PaperJoey on DeviantArt, original by Shingo
  (setq dashboard-center-content t) ;; Center content of homepage
  (setq dashboard-show-shortcuts nil) ;; Remove shortcut hints
  (setq dashboard-set-footer nil) ;; Disables messages at the bottom
  (setq dashboard-set-init-info t) 
  (setq dashboard-init-info (format "%d youkai entered Gensokyou in %s"
				    (length package-activated-list) (emacs-init-time))) ;; Show # of packages loaded, and boot time
  (setq dashboard-set-navigator t) 
  (setq dashboard-items '((recents . 5)))
  (setq dashboard-navigator-buttons
	`(;; line1
	  ((,nil
	    "Config"
	    "Edit Emacs Config File init.el"
	    (lambda (&rest _) (find-file "~/.emacs.d/init.el"))
	    'default)
	   (nil
	    "Github"
	    "Visit our github"
	    (lambda (&rest _) (browse-url "https://github.com/Ocillacubes/Emacs"))
	    'default)
	   ))))



;; === MAGIT ===
(use-package magit
  :ensure t)



;; === UNDO/REDO ===
(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode)
(global-undo-tree-mode)
(define-key evil-normal-state-map "u" 'undo-tree-undo)
(define-key evil-normal-state-map (kbd "C-r") 'undo-tree-redo)



;; === Recent files ===
(recentf-mode 1)
(setq recentf-max-menu-items 20)
(setq recentf-max-saved-items 50)
(define-key evil-normal-state-map "\C-t" 'recentf-open-files)



;; === OTHER ===
(setq x-select-enable-clipboard t) ;; Copy paste support
(setq use-package-always-defer t) ;; Try to speed boot



;; === AUTOGEN STUFF ===
;; Don't edit this stuff by hand

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
