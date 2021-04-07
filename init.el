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

(global-prettify-symbols-mode t) ;; Make words show as their symbols ie lambda will show up as it's symbol

;; Numbers
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'text-mode-hook 'display-line-numbers-mode)



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

;; Auto update packages because I've accepted the emacs bloat train
;; (use-package auto-package-update
  ;; :defer nil
  ;; :ensure t
  ;; :config
  ;; (setq auto-package-update-delete-old-versions t)
  ;; (setq auto-package-update-hide-results t)
  ;; (auto-package-update-maybe))



;; === KEYBINDS === 

;; Evil Mode (Vim keybinds)
(use-package evil
  :ensure t
  :defer nil
  :init
  :config
  (evil-mode 1))

;; Escape quits prompts WHY IS THIS NOT DEFAULT
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Tabbing


;; === FILE MANAGEMENT ===

;; Swiper - Search document for text, C-n / C-p to navigate or use arrow keys
(use-package swiper 
  :ensure t)

;; Treemacs
(use-package treemacs
  :ensure t
  :defer t
  :init
  :config
  (progn
    (setq ;; treemacs-show-hidden-files     t ;; Show hidden files by default
	  treemacs-width                 30)
    (treemacs-resize-icons 11)
    )
  :bind
  (:map global-map
	("M-0"       . treemacs-select-window) ;; Meta 0 open treemacs window, whether or not its open
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("M-f"       . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))
(use-package treemacs-evil
  :after treemacs evil
    :ensure t)
  (use-package treemacs-icons-dired
    :after treemacs dired
    :ensure t
    :config (treemacs-icons-dired-mode))



;; === AUTOCOMPLETION ===
;; Taken from some tutorial on yt
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
(show-paren-mode 1) ;; Highlight other parenthesis

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
  :preface
  (defun create-scratch-buffer ()
    "Create a scratch buffer"
    (interactive)
    (switch-to-buffer (get-buffer-create "*scratch*"))
    (lisp-interaction-mode))
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title "An Emacs Distro for the Devilish User") ;; Welcome message
  (setq dashboard-startup-banner "~/.emacs.d/logo.png") ;; Remilia picture from PaperJoey on DeviantArt, original by Shingo
  (setq dashboard-center-content t) ;; Center content of homepage
  (setq dashboard-show-shortcuts nil) ;; Remove shortcut hints
  ;; (setq dashboard-set-footer nil) ;; Disables messages at the bottom
  (setq dashboard-set-init-info t) 
  (setq dashboard-init-info (format "%d youkai entered Gensokyou in %s"
				    (length package-activated-list) (emacs-init-time))) ;; Show # of packages loaded, and boot time
  (setq dashboard-set-navigator t) 
  (setq dashboard-items '((recents . 3)
			  (agenda . 5)))
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
	   (nil
	    "Scratchpad"
	    "Open a scratch buffer"
	    (lambda (&rest _) (create-scratch-buffer))
	    'default)
	   )))
  (setq dashboard-footer-messages '("What, you don't have any manga or anything?"
				    "Fairies are completely useless."
				    "You know, watermelons look more like slices of meat than grapes."
				    "I rather dislike the sun..."))) 



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



;; === RECENT FILES ===
(recentf-mode 1)
(setq recentf-max-menu-items 20)
(setq recentf-max-saved-items 50)
;; (define-key evil-normal-state-map "\C-t" 'recentf-open-files)



;; === ESHELL ===
;; currently just copy pasted from witchmacs till I figure stuff out
;; wow eshell is funky
(setq eshell-prompt-regexp "^[^αλ\n]*[αλ] ")
(setq eshell-prompt-function
      (lambda nil
        (concat
         (if (string= (eshell/pwd) (getenv "HOME"))
             (propertize "~" 'face `(:foreground "#99CCFF"))
           (replace-regexp-in-string
            (getenv "HOME")
            (propertize "~" 'face `(:foreground "#99CCFF"))
            (propertize (eshell/pwd) 'face `(:foreground "#99CCFF"))))
         (if (= (user-uid) 0)
             (propertize " α " 'face `(:foreground "#FF6666"))
         (propertize " λ " 'face `(:foreground "#A6E22E"))))))

(setq eshell-highlight-prompt nil)
(defun eshell-other-window ()
  "Create or visit an eshell buffer."
  (interactive)
  (if (not (get-buffer "*eshell*"))
      (progn
        (split-window-sensibly (selected-window))
        (other-window 1)
        (eshell))
    (switch-to-buffer-other-window "*eshell*")))

(global-set-key (kbd "<s-C-return>") 'eshell-other-window)



;; === MUSIC PLAYER ===
;; Base copied from DOOM Emacs
(use-package emms
  :defer t
  :init
  (setq emms-directory (concat user-emacs-directory "emms"))
  :config
  (emms-all)
  (emms-default-players))



;; === OTHER ===
(setq x-select-enable-clipboard t) ;; Copy paste support
(setq use-package-always-defer t) ;; Try to speed boot



;; === AUTOGEN STUFF ===
;; Don't edit this stuff by hand

;; Keep 1 of this
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Only have this once, carefule not to screw it up
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("7661b762556018a44a29477b84757994d8386d6edee909409fabe0631952dad9" default))
 '(initial-frame-alist '((fullscreen . maximized)))
 '(package-selected-packages
   '(emms treemacs-icons-dired treemacs-evil treemacs gruvbox-theme magit undo-tree swiper which-key spaceline powerline nix-mode ivy evil use-package)))
