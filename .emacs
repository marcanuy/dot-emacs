;; Personal init file for Emacs
;; Copyright (C) 2013-2019 Marcelo Canina

;;;;;;;;;;;;;;
;; SECTIONS ;;
;;;;;;;;;;;;;;
;;
;; - bootstrap package managers
;;   - load use-package
;; - global-map
;;   - redefine global mappings
;; - Load packages
;;   - load new packages
;; - Core packages customization
;;   - change preinstalled packages behaviour
;; - Custom functions
;;   - new functions defitions
;;
;;

;; http://stackoverflow.com/questions/1217180/how-do-i-byte-compile-everything-in-my-emacs-d-directory
;;(byte-recompile-directory (expand-file-name "~/.emacs.d") 0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; bootstrap package managers ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("gnu" . "http://elpa.gnu.org/packages/") t)
(package-initialize)

;; bootstrap use-package
;; https://github.com/jwiegley/use-package/
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

;; The :ensure keyword causes the package(s) to be installed
;; automatically if not already present on your system
;; use-package-always-ensure if you wish this behavior to be global
;; for all packages
(setq use-package-always-ensure t)

;;;;;;;;;;;;;;;;
;; global-map ;;
;;;;;;;;;;;;;;;;

;;; C-

;; replace default buffer-menu
(bind-key "C-x C-b" #'ibuffer) 

;;;;;;;;;;;;;;;;;;;
;; Load packages ;;
;;;;;;;;;;;;;;;;;;;

;; ace-window
;; https://github.com/abo-abo/ace-window
(use-package ace-window
  :bind ("M-p" . ace-window)
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

;; Code navigation, documentation lookup and completion for Python
;; https://github.com/proofit404/anaconda-mode
;; (use-package anaconda-mode
;;   :config
;;   (add-hook 'python-mode-hook 'anaconda-mode))

;; auto-complete -  Emacs auto-complete package
;; https://github.com/auto-complete/auto-complete
(use-package auto-complete)

;; emacs-async - Simple library for asynchronous processing in Emacs
;; https://github.com/jwiegley/emacs-async
(use-package async)
;; jumping to visible text using a char-based decision tree
;; https://github.com/abo-abo/avy
(use-package avy
  :bind  (("C-:" . avy-goto-char) ;; Input one char, jump to it with a tree. eg. C-: b
	  ("C-c '" . avy-goto-char-2))) ;; Input two chars e.g.: C-' bu
;; A simple way to manage personal keybindings
(use-package bind-key)

(use-package chess)
;; color-moccur 
;; (use-package color-moccur
;;   :commands (isearch-moccur isearch-all)
;;   :bind (("M-s O" . moccur)
;;          :map isearch-mode-map
;;          ("M-o" . isearch-moccur)
;;          ("M-O" . isearch-moccur-all))
;;   :init
;;   (setq isearch-lazy-highlight t)
;;   :config
;;   (use-package moccur-edit))

;; Company autocomplete
;; http://company-mode.github.io/
;; Completion will start automatically after you type a few letters.
;; Use M-n and M-p to select, <return> to complete or <tab> to complete
;; the common part. Search through the completions with C-s, C-r and C-o.
;; Press M-(digit) to quickly complete with one of the first 10 candidates.
;; Type M-x company-complete to initiate completion manually
;; Third party packages
;; https://github.com/company-mode/company-mode/wiki/Third-Party-Packages
(use-package company
  :bind (("C-?" . company-complete))
  :config
  (global-company-mode t)
  ;(add-to-list 'company-backends '(company-anaconda :with company-capf))
  (add-to-list 'company-backends 'company-emoji)
  (add-to-list 'company-backends 'company-ghc)
  (add-to-list 'company-backends 'company-ghci)
  (add-to-list 'company-backends 'company-go)
  (add-to-list 'company-backends 'company-ac-php-backend) ;; provided by company-php
  (add-to-list 'company-backends '(company-shell company-fish-shell))
  (add-to-list 'company-backends 'company-web-html))

;; company-anaconda - Anaconda backend for company-mode.
;; https://github.com/proofit404/company-anaconda
;; (use-package company-anaconda
;;   :config
;;   (add-hook 'python-mode-hook 'anaconda-mode))

(use-package company-emoji)
;; company-mode completion backend for ghc-mod
;; https://github.com/iquiw/company-ghc
(use-package company-ghc)
;; company backend which uses the current ghci process.
(use-package company-ghci)
;; company-mode backend for Go (using gocode)
(use-package company-go)
;; https://github.com/xcwen/ac-php
(use-package company-php)
;; Documentation popup for Company - https://github.com/expez/company-quickhelp
;; You can adjust the time it takes for the documentation to pop up by changing company-quickhelp-delay.
;; If you don't want the help popup to appear automatically, but prefer it to the popup help buffer provided by company, you can set company-quickhelp-delay to nil and manually trigger the popup with M-h.
;; Customizing
;; If you hit M-x customize-group <RET> company-quickhelp <RET> you'll find a few variables you can diddle.
;; You might also want to put this in your init.el:
;; (eval-after-load 'company
;;   '(define-key company-active-map (kbd "M-h") #'company-quickhelp-manual-begin))
;; This gives you a key to manually trigger the help popup, but only when company is doing its thing.
(use-package company-quickhelp
  :config
  (company-quickhelp-mode 1))


;; https://github.com/Alexander-Miller/company-shell
(use-package company-shell)
;; Plugin for autocompletion in html-mode, web-mode, jade-mode, slim-mode
;; and use data of ac-html.
;; https://github.com/osv/company-web
(use-package company-web
  :config
  (require 'company-web-html)
  (require 'company-web-jade) ; load company mode jade backend
  (require 'company-web-slim) ; load company mode slim backend
  )
;; Concurrent utility functions for emacs lisp
;; https://github.com/kiwanami/emacs-deferred/blob/master/README-concurrent.markdown
(use-package concurrent)
;; http://elpa.gnu.org/packages/csv-mode.html
(use-package csv-mode
  :commands csv-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.[Cc][Ss][Vv]\\'" . csv-mode)))
;; https://github.com/jacksonrayhamilton/context-coloring
;;(use-package context-coloring)
(use-package ctable)
;;(use-package cyberpunk-theme)
;; A modern list library for Emacs
;; https://github.com/magnars/dash.el
(use-package dash)
;; Simple asynchronous functions for emacs lisp
;; https://github.com/kiwanami/emacs-deferred
(use-package deferred)
;;https://github.com/thamer/diredful
;;(use-package diredful)
;; dracula-theme - A dark theme for Atom, Alfred, Emacs,...
;; https://github.com/dracula/dracula-theme
;; https://draculatheme.com/emacs/
(use-package dracula-theme
  ;;   :config
  ;;   (load-theme 'dracula t)
  )
;; A RPC stack for the Emacs Lisp
;; https://github.com/kiwanami/emacs-epc
(use-package epc)
;; Emacs Package Library
;; http://github.com/cask/epl
(use-package epl)
;; Modern API for working with files and directories
;; http://github.com/rejeep/f.el
(use-package f)
(use-package flymake-easy)

;; A modern on-the-fly syntax checking extension for GNU Emacs,
;; intended as replacement for the older Flymake extension which is
;; part of GNU Emacs.  http://www.flycheck.org/en/latest/
;; (for python it needs: pip install pylint)
;; check whether your Flycheck setup is complete in the desired buffer: C-c ! v
;; jump through errors:  C-c ! n and C-c ! p
;; list all errors: C-c ! l 
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode)
  (setq flycheck-python-pylint-executable "pylint3")
  (setq flycheck-python-flake8-executable "python -m flake8"))

;; flyspell-mode
;; flyspell-auto-correct-previous-word C-;

;; https://github.com/syohex/emacs-fontawesome
(use-package fontawesome)

;; Print a fortune in your Emacs scratch buffer
;; https://github.com/andschwa/fortune-cookie
;; $sudo apt-get install fortunes fortunes-it fortunes-es cowsay*
(use-package fortune-cookie
  :custom
  (fortune-cookie-fortune-string
   "History repeats itself: the first time as tragedy, the second time as farce.")
  (fortune-cookie-cowsay-enable (executable-find "cowsay"))
  (fortune-cookie-cowsay-args '("-f" "tux"))
  :config (fortune-cookie-mode))

(use-package ggtags)
(use-package gh)

(use-package gist)
(use-package git-commit)

;;(use-package grandshell-theme)
;;(use-package gruvbox-theme)

;; helm
(use-package helm
  :bind (("M-x" . helm-M-x)
	 ("C-x b" . helm-buffers-list)
	 ("C-x r b" . helm-bookmarks)
	 ("C-x C-f" . helm-find-files)
	 ("C-x C-l" . helm-locate)
	 ("C-x M-s o" . helm-occur)
	 )
  :config
  (helm-adaptive-mode t))
;; replace basic M-x with helm
;; vanilla way of setting up helm without use-package
;;(global-set-key (kbd "M-x") 'helm-M-x)
;;(global-set-key (kbd "C-x b") 'helm-buffers-list)
;;(global-set-key (kbd "C-x C-f") 'helm-find-files)
;;(global-set-key (kbd "C-x r b") 'helm-bookmarks)
;;(helm-autoresize-mode 1)

;; Select company-complete candidates by helm. It is useful to narrow
;; company candidates.
(use-package helm-company)
;; Helm frontend for describe-bindings (C-h b) making the currently active key
;; bindings interactively searchable with helm.
;; https://github.com/emacs-helm/helm-descbinds
(use-package helm-descbinds
  :config
  (helm-descbinds-mode))
;; Helm interface to Emacs’s describe-mode (C-h m)
;; https://github.com/emacs-helm/helm-describe-modes
(use-package helm-describe-modes
  :config
  (global-set-key [remap describe-mode] #'helm-describe-modes))
;; Yet another helm to list git file. 
;; https://github.com/emacs-helm/helm-ls-git
;; 
(use-package helm-ls-git
  :bind (("C-x C-d" . helm-browse-project)))
;;  Helm UI for Projectile (use helm-ls-git better)
;; https://github.com/bbatsov/helm-projectile
;;;;(use-package helm-projectile)
;;(use-package helm-core)
(use-package helm-google)
(use-package helm-gtags)
;; http://www.emacswiki.org/help-fns+.el
;;(use-package help-fns+)
(use-package hi-lock
  :bind (("M-o l" . highlight-lines-matching-regexp)
         ("M-o r" . highlight-regexp)
         ("M-o w" . highlight-phrase)))

(use-package ht)
;;(autoload 'ibuffer "ibuffer" "List buffers." t)
(use-package ibuffer-projectile)
;;(use-package inf-php)
;; inf-ruby - a REPL buffer connected to a Ruby subprocess
;; https://github.com/nonsequitur/inf-ruby
(use-package inf-ruby)
;; https://github.com/eschulte/jump.el
(use-package interaction-log)
(use-package js2-mode)
(use-package json-mode)
(use-package json-reformat)
(use-package json-snatcher)

;; https://github.com/mhayashi1120/Emacs-langtool
(use-package langtool
  :bind (("\C-x4w" . langtool-check)
	 ("\C-x4W" . langtool-check-done)
	 ("\C-x4l" . langtool-switch-default-language)
	 ("\C-x44" . langtool-show-message-at-point)
	 ("\C-x4c" . langtool-correct-buffer))
  :config
  (setq langtool-language-tool-jar "/opt/LanguageTool-3.7/languagetool-commandline.jar")
  (setq langtool-default-language "en-US")
  )

(use-package logito)
;; Manage Git inside Emacs
;; https://github.com/magit/magit
(use-package magit)
(use-package magit-popup)
;; Load markdown package with kramdown as its parser
;; Needs to have the 'kramdown' command locally
(use-package markdown-mode
  ;; :config
  ;; (setq markdown-command "kramdown")
  )
(use-package markdown-preview-eww)
(use-package markdown-toc)
(use-package marshal)
;; https://github.com/cpaulik/emacs-material-theme
(use-package material-theme
  :config
  (load-theme 'material t))
(use-package mmm-mode)
(use-package mmt)
;;(use-package moe-theme)
;; http://www.monokai.nl/blog/2006/07/15/textmate-color-theme/
;;(use-package monokai-theme)
(use-package multiple-cursors)
(use-package neotree)
(use-package pcache)
;; pcsv provides parser of csv based on rfc4180
;; https://github.com/mhayashi1120/Emacs-pcsv
(use-package pcsv)

;; Projectile integration for perspective.el
;; https://github.com/bbatsov/persp-projectile
;; You're ready to go! Try the interactive command projectile-persp-switch-project,
;; or you may also bind it to some handy keybinding.
;; (define-key projectile-mode-map (kbd "s-s") 'projectile-persp-switch-project)
;;(use-package persp-projectile)
(use-package perspective
  :config
  (persp-mode))

(use-package php-mode)
(use-package phpunit
  :bind (:map php-mode-map
	      ("C-x t" . phpunit-current-test)
	      ("C-x c" . phpunit-current-class)
	      ("C-x p" . phpunit-current-project)))
(use-package pkg-info)
(use-package plantuml-mode
  :init
  (setq plantuml-jar-path "/usr/share/plantuml/plantuml.jar"))
(use-package po-mode)
(use-package polymode)

;; https://github.com/TatriX/pomidor
;; 
(use-package pomidor
  :bind (("<f12>" . pomidor))
  :init
  (setq pomidor-sound-tick nil
        pomidor-sound-tack nil
	;;pomidor-sound-overwork nil
	))

(use-package popup)
(use-package pos-tip)
;; Project Interaction Library
;; https://github.com/bbatsov/projectile
;; ;; (use-package projectile
;; ;;   :config
;; ;;   (projectile-global-mode t))

(use-package pyvenv)

;; "rainbow parentheses"-like mode which highlights delimiters
;; such as parentheses, brackets or braces according to their depth. 
;; https://github.com/Fanael/rainbow-delimiters
(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; rainbow-mode is a minor mode for Emacs which displays strings
;; representing colors with the color they represent as background.
;; https://julien.danjou.info/projects/emacs-packages
;; Type M-x rainbow-mode. Rbow should be added to the mode-line,
;; indicating that Rainbow mode is in effect.
(use-package rainbow-mode)
;; https://github.com/pashky/restclient.el
;; This is a tool to manually explore and test HTTP REST webservices.
;; Runs queries from a plain-text query sheet, displays results as a
;; pretty-printed XML, JSON and even images.
(use-package restclient)

;; S - The long lost Emacs string manipulation library.
;; https://github.com/magnars/s.el
(use-package s)

;; scss-mode Emacs mode for SCSS files (http://sass-lang.com)
;; https://github.com/antonj/scss-mode
(use-package scss-mode)

;; https://github.com/bbatsov/solarized-emacs
(use-package solarized-theme)

;; smartparens - Minor mode for Emacs that deals with parens
;; pairs and tries to be smart about it.
;; https://github.com/Fuco1/smartparens
(use-package smartparens
  :config
  (require 'smartparens-config)
  (smartparens-global-mode t))

(use-package speed-type)
;; Smooth-scrolling, minimap and distraction free mode like sublime
;; editor
;; https://github.com/zk-phi/sublimity
(use-package sublimity
  :config
  (require 'sublimity-scroll)
  ;;(require 'sublimity-map)
  (sublimity-mode 1)
  ;;(require 'sublimity-attractive)
  )

;; Stack Exchange for Emacs
;; https://github.com/vermiculus/sx.el
;; (use-package sx
;;   :config
;;   (bind-keys :prefix "C-c s"
;;              :prefix-map my-sx-map
;;              :prefix-docstring "Global keymap for SX."
;;              ("q" . sx-tab-all-questions)
;;              ("i" . sx-inbox)
;;              ("o" . sx-open-link)
;;              ("u" . sx-tab-unanswered-my-tags)
;;              ("a" . sx-ask)
;;              ("s" . sx-search)))

(use-package term
  :bind (("C-c t" . term)
         :map term-mode-map
         ("M-p" . term-send-up)
         ("M-n" . term-send-down)
         :map term-raw-map
         ("M-o" . other-window)
         ("M-p" . term-send-up)
         ("M-n" . term-send-down)))
(use-package trr)
(use-package typit)
(use-package visual-fill-column)
(use-package web-completion-data)
;; web-mode is an autonomous emacs major-mode for editing web templates.
;; https://github.com/fxbois/web-mode
;; http://web-mode.org/
;; HTML documents can embed parts (CSS / JavaScript) and blocks
;; (client / server side).
(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  ;; Using web-mode for editing plain HTML files can be done this way
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  ;; You can also edit plain js, jsx, css, scss, xml files.
  )
;; Use the Emacsclient as the $EDITOR of child processes
;; https://github.com/magit/with-editor
(use-package with-editor)
(use-package xcscope)
;; https://github.com/yoshiki/yaml-mode
(use-package yaml-mode)

;; A template system for Emacs
;; https://github.com/joaotavora/yasnippet
(use-package yasnippet
  :config
  (yas-global-mode t))
;; snippets repository https://github.com/AndreaCrotti/yasnippet-snippets
(use-package yasnippet-snippets)

;; https://github.com/bbatsov/zenburn-emacs
;;(use-package zenburn-theme)

;;;;;;;;;;;;
;; Themes ;;
;;;;;;;;;;;;
;;;;;;;;;;; black-themes ;;;;;;;;;;;;
;;(load-theme 'wheatgrass)
;;(load-theme 'alect-black)
;;(load-theme 'cyberpunk)
;;(load-theme 'gruvbox t)
;;(load-theme 'dracula t)
;;(load-theme 'monokai)
;;(load-theme 'zenburn)
;;;;;;;;;;;;; white-themes ;;;;;;;;;;;
;;(load-theme 'whiteboard)
;;(load-theme 'leuven)
;;;;;;;;;;; general themes ;;;;;;;;;;;
;;(use-package alect-themes)
;;(use-package apropospriate-theme)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Core packages customization ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Emacs 24.5.1 Base Packages
;; /usr/share/emacs/24.5/lisp/

;; maximize Emacs frame on start-up
;; https://emacs.stackexchange.com/a/3008/8563
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; lisp/menu-bar
;;;; Toggle display of a menu bar on each frame (Menu Bar mode).
(menu-bar-mode -1)
;; lisp/paren
(show-paren-mode t)
;; lisp/progmodes/python
;;;; working with Python with company
;;;; http://emacs.stackexchange.com/questions/10167/how-to-automatically-run-inferior-process-when-loading-major-mode-for-the-first
(add-hook 'python-mode 'run-python)
;; lisp/simple
;;;; Toggle column number display in the mode line
(column-number-mode t)
;; lisp/startup
(setq user-mail-address "me@marcanuy.com")
;;;; hide default startup screen
(setq inhibit-startup-message t)
;; lisp/textmodes
;; lisp/textmodes/text-mode
;;;;  Automatic line breaking in Text mode and related modes
(add-hook 'text-mode-hook 'auto-fill-mode)
;; lisp/textmodes/ispell
;;;; change ispell dictionary to use also with flymake-mode
;;;; can be changed with command: ispell-change-dictionary
(setq ispell-dictionary "english")    ;set the default dictionary
(put 'downcase-region 'disabled nil)
;; tool-bar
(tool-bar-mode -1)
;; windmove
;;;; Move between windows with Shift-ArrowKeys
(windmove-default-keybindings)

;;;;;;;;;;;;;;;;;;;;;;
;; Custom functions ;;
;;;;;;;;;;;;;;;;;;;;;;

;; edit contrab in emacs
;; http://emacs.stackexchange.com/a/10080/8563
(defun crontab-e ()
    (interactive)
    (with-editor-async-shell-command "crontab -e"))


;;;;;;;;;;;;;
;; Writing ;;
;;;;;;;;;;;;;

;; activate flyspell-mode when editing text (markdown, text, etc)
(dolist (hook '(markdown-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
;; Ran langtool checker every time a markdown file is saved
;; https://stackoverflow.com/a/6141681/1165509
;; (add-hook 'markdown-mode-hook
;;           (lambda () 
;;              (add-hook 'after-save-hook 'langtool-check nil 'make-it-local)))
;; Use flyspell-mode in comments and string of python-mode
(add-hook 'python-mode-hook
    (lambda ()
    (flyspell-prog-mode)
    ))
