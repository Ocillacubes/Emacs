(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(setq use-package-always-ensure t)

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(use-package general
  :config
  (general-evil-setup t))

(nvmap :prefix "SPC" ;; very original yes
  "SPC"    '(counsel-M-x :which-key "M-x") ;; Broken
  "f f"    '(find-file :which-key "Find File")
  "o t"    '(org-babel-tangle :which-key "Tangle Org File")
  "s"      '(swiper :which-key "Search in File")
  "r r"    '((lambda () (interactive) (load-file "~/.emacs.d/init.el")) :which-key "Reload emacs config")
  "h h"    '(mark-whole-buffer :which-key "Select the entire file")
  "\\"     '(indent-region :which-key "Auto indent everything")

  "w c"    '(evil-window-delete :which-key "Close Window")
  "w n"    '(evil-window-new :which-key "New Window")
  "w s"    '(evil-window-split :which-key "Horizontal Split")
  "w v"    '(evil-window-vsplit :which-key "Vertical Split")
  "w h"    '(evil-window-left :which-key "Left Window")
  "w j"    '(evil-window-down :which-key "Down Window")
  "w k"    '(evil-window-up :which-key "Up Window")
  "w l"    '(evil-window-right :which-key "Right Window")
  "w w"    '(evil-window-next :which-key "Next Window")

  "t t"      '(vterm :which-key "Open terminal emulator")
  "t e"      '(eshell :which-key "Open eshell")
  )

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-message t) 
(tooltip-mode -1)

(global-display-line-numbers-mode 1)

(global-visual-line-mode t)

(use-package gruvbox-theme)
(load-theme 'gruvbox-dark-medium t)
;;(load-theme 'adwaita)

(global-prettify-symbols-mode t)

(use-package dashboard
  :ensure t
  :preface
  (defun create-scratch-buffer ()
    "Create a scratch buffer"
    (interactive)
    (switch-to-buffer (get-buffer-create "*scratch*"))
    (lisp-interaction-mode))
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title "An Emacs Distro for the Devilish User") 
  (setq dashboard-startup-banner "~/.emacs.d/logo.png") 
  (setq dashboard-center-content t) 
  (setq dashboard-show-shortcuts nil) 
  (setq dashboard-set-init-info t) 
  (setq dashboard-init-info (format "%d youkai entered Gensokyou in %s"
				    (length package-activated-list) (emacs-init-time))) 
  (setq dashboard-set-navigator t) 
  (setq dashboard-items '((recents . 3)
			  (agenda . 5)))
  (setq dashboard-navigator-buttons
	`(;; line1
	  ((,nil
	    "Config"
	    "Edit Emacs Config File init.el"
	    (lambda (&rest _) (find-file "~/.emacs.d/init.org"))
	    'default)
	   (nil
	    "Scratchpad"
	    "Open a scratch buffer"
	    (lambda (&rest _) (create-scratch-buffer))
	    'default)
	   (nil
	    "Todo"
	    "Open the TODO list file"
	    (lambda (&rest _) (find-file "~/docs/org/TODO.org"))
	    'default))
	  ((,nil ;;line 2
	    "Githhub"
	    "Visit the github repo"
	    (lambda (&rest _) (browse-url "https://github.com/Ocillacubes/Emacs"))
	    'default))))
  (setq dashboard-footer-messages '("What, you don't have any manga or anything?"
				    "Fairies are completely useless."
				    "You know, watermelons look more like slices of meat than grapes."
				    "I rather dislike the sun..."))) 
(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))) ;; Allow emacs to load dashboard when running as a daemon

(setq scroll-conservatively 101) ;; value greater than 100 gets rid of half page jumping

(use-package all-the-icons)

(use-package which-key)
(which-key-mode)

(use-package counsel
  :config (counsel-mode))
(use-package ivy
  :diminish
  :bind (
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

(setq x-select-enable-clipboard t)

(use-package undo-tree
  :ensure t
  :diminish)
(global-undo-tree-mode)
(define-key evil-normal-state-map "u" 'undo-tree-undo)
(define-key evil-normal-state-map (kbd "C-r") 'undo-tree-redo)

(setq make-backup-files nil)
(setq auto-save-default nil)

(setq electric-pair-pairs '(
			    (?\{ . ?\})
			    (?\( . ?\))
			    (?\[ . ?\])
			    (?\" . ?\")
			    ))
(electric-pair-mode t)
(show-paren-mode 1)

(use-package org-tempo
  :ensure nil)

(setq org-src-fontify-natively t
      org-src-tab-acts-natively t
      org-confirm-babel-evaluate nil
      org-edit-src-content-indentation 0)

(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(add-hook 'org-mode-hook 'org-indent-mode)

(setq org-directory "~/docs/org")

(use-package projectile
  :config
  (projectile-global-mode 1))

(use-package swiper)

(setq shell-file-name "/bin/zsh"
      vterm-max-scrollback 1000)

(use-package eshell-syntax-highlighting
  :after esh-mode
  :config
  (eshell-syntax-highlighting-global-mode +1))
(setq eshell-aliases-file "~/.emacs.d/eshell_alias"
      eshell-history-size 1000)

(use-package vterm)
