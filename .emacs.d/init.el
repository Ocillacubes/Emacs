; === CLEAN UP DEFAULTS ===

(scroll-bar-mode -1) ;; Turn off scroll bar on the side
(tool-bar-mode -1) ;; Hide toolbar
(tooltip-mode -1) ;; Hide tooltips
(menu-bar-mode -1) ;; Hide menubar

;; (set-fringe-mode 10)  ;; idk what this does
;; (setq inhibit-startup-message t) ;; Hide welcome message



;; === THEME ===

(load-theme 'wombat)

(setq visible-bell t) ;; Flash when backspace on empty line



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
(unless (package-installed-p 'evil)
  (package-install 'evil))
(require 'evil)
(evil-mode 1)

;; Escape quits prompts WHY IS THIS NOT DEFAULT
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)



;; === FILE MANAGEMENT ===
(recentf-mode 1)
(setq recentf-max-menu-items 20)
(setq recentf-max-saved-items 50)
(global-set-key "\C-x" 'recentf-open-files)



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

;; === MODELINE ===



;; === SYNTAX HIGHLIGHTING ===
(use-package nix-mode
  :mode "\\.nix\\'")



;; === AUTOGEN STUFF ===
;; Don't edit this stuff by hand
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(nix-mode ivy evil use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
