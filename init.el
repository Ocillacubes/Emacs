(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
						 ("org" . "https://orgmode.org/elpa/")
						 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; (use-package auto-package-update
;; :defer nil
;; :ensure t
;; :config
;; (setq auto-package-update-delete-old-versions t)
;; (setq auto-package-update-hide-results t)
;; (auto-package-update-maybe))

(scroll-bar-mode -1) 
(tool-bar-mode -1) 
(tooltip-mode -1) 
(menu-bar-mode -1) 
(setq inhibit-startup-message t)

(use-package gruvbox-theme
  :ensure t)
(load-theme 'gruvbox-dark-medium t)

(setq visible-bell t) ;; Flash when backspace on empty line

(global-prettify-symbols-mode t)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(add-hook 'text-mode-hook 'display-line-numbers-mode)

(use-package evil
  :ensure t
  :defer nil
  :init
  :config
  (evil-mode 1))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(setq x-select-enable-clipboard t)

(use-package swiper 
  :ensure t)

;; Treemacs
(use-package treemacs
  :ensure t
  :defer t
  :init
  :config
  (progn
	(setq ;; treemacs-show-hidden-files     t
	 treemacs-width                 30)
	(treemacs-resize-icons 11)
	)
  :bind
  (:map global-map
		("M-0"       . treemacs-select-window) 
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

(use-package ivy ;; this section taken from YT tutorial
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

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :init
  (which-key-mode))

(setq electric-pair-pairs '(
							(?\{ . ?\})
							(?\( . ?\))
							(?\[ . ?\])
							(?\" . ?\")
							))
(electric-pair-mode t)
(show-paren-mode 1)

(use-package flycheck)
(global-flycheck-mode)

(use-package flycheck-haskell)
(add-hook 'haskell-mode-hook #'flycheck-haskell-setup)

(add-hook 'python-mode-hook #'flycheck-python-setup)

(use-package diminish  ;; Keep the line from getting cluttered with modes
  :ensure t)
(use-package spaceline
  :ensure t)
(use-package powerline
  :ensure t
  :init
  (spaceline-spacemacs-theme)
  :hook
  ('after-init-hook) . 'powerline-reset)

(use-package nix-mode
  :mode "\\.nix\\'")

(use-package haskell-mode
  :mode "\\.hs\\'")

(use-package rainbow-mode
  :ensure t
  :diminish rainbow-mode
  :init
  (rainbow-mode))

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
  ;; (setq dashboard-set-footer nil) ;; Disables messages at the bottom
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

(use-package magit
  :ensure t)

(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode)
(global-undo-tree-mode)
(define-key evil-normal-state-map "u" 'undo-tree-undo)
(define-key evil-normal-state-map (kbd "C-r") 'undo-tree-redo)

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

(use-package emms
  :ensure t
  :bind
  ("s-m p" . emms)
  ("s-m b" . emms-smart-browse)
  (:map emms-playlist-mode-map
		("d" . emms-play-directory)
		("p" . emms-start)
		("k" . emms-previous)
		("j" . emms-next)
		("x" . emms-shuffle)
		("s" . emms-stop))
  :config
  (require 'emms-setup)
  (emms-all)
  (setq emms-player-list '(emms-player-mpd))
  (setq emms-info-functions '(emms-info-mpd))
  (require 'emms-player-mpd))
(setq mpc-host "localhost:6600")
(defun mpd/update-database ()
  "Updates the MPD Database"
  (interactive)
  (call-process "mpc" nil nil nil "update")
  (message "Updated MPD database"))
(global-set-key (kbd "s-m u") 'mpd/update-database)
(defun mpd/start-music-daemon ()
  "Start MPD, connect to it, and sync"
  (interactive)
  (shell-command "mpd")
  (mpd/update-database)
  (emms-player-mpd-connect)
  (emms-cache-set-from-mpd-all)
  (message "Initialized MPD"))
(global-set-key (kbd "s-m c") 'mpd/start-music-daemon)
(defun mpd/kill-music-daemon ()
  "Stops music and yeets MPD"
  (interactive)
  (emms-stop)
  (call-process "killall" nil nil nil "mpd")
  (message "Killed MPD"))
(global-set-key (kbd "s-m k") 'mpd/kill-music-daemon)

(setq make-backup-files nil)
(setq auto-save-default nil)

(setq use-package-always-defer t) ;; Try to speed boot by not loading some packages
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
 '(tab-width 4)
 '(package-selected-packages
   '(emms treemacs-icons-dired treemacs-evil treemacs gruvbox-theme magit undo-tree swiper which-key spaceline powerline nix-mode ivy evil use-package)))
