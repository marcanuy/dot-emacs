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
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/") t)
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

;; ace-jump-mode a quick cursor jump mode for emacs
;; https://github.com/winterTTr/ace-jump-mode
(use-package ace-jump-mode
  :bind  (("C-." . ace-jump-mode)
	  ("C-c SPC" . ace-jump-mode-pop-mark)))
(use-package ac-php)
(use-package ac-php-core)
;; ace-window
;; https://github.com/abo-abo/ace-window
(use-package ace-window
  :bind ("M-p" . ace-window)
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

;; Code navigation, documentation lookup and completion for Python
;; https://github.com/proofit404/anaconda-mode
(use-package anaconda-mode
  :config
  (add-hook 'python-mode-hook 'anaconda-mode))
;; auto-complete -  Emacs auto-complete package
;; https://github.com/auto-complete/auto-complete
(use-package auto-complete)
;; Auto activate python virtualenvs
;; http://github.com/marcwebbie/auto-virtualenv
(use-package auto-virtualenv)
;; emacs-async - Simple library for asynchronous processing in Emacs
;; https://github.com/jwiegley/emacs-async
(use-package async)
;; A simple way to manage personal keybindings
(use-package bind-key)
;; Interact with Bundler from Emacs
;; http://github.com/endofunky/bundler.el
(use-package bundler)
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
(use-package command-log-mode)
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
  (add-to-list 'company-backends '(company-anaconda :with company-capf))
  (add-to-list 'company-backends 'company-emoji)
  (add-to-list 'company-backends 'company-ghc)
  (add-to-list 'company-backends 'company-ghci)
  (add-to-list 'company-backends 'company-go)
  (add-to-list 'company-backends 'company-ac-php-backend) ;; provided by company-php
  (add-to-list 'company-backends 'company-robe)
  (add-to-list 'company-backends 'company-jedi)
  (add-to-list 'company-backends 'company-restclient)
  (add-to-list 'company-backends '(company-shell company-fish-shell))
  (add-to-list 'company-backends 'company-web-html))

;; company-anaconda - Anaconda backend for company-mode.
;; https://github.com/proofit404/company-anaconda
(use-package company-anaconda
  :config
  (add-hook 'python-mode-hook 'anaconda-mode))
(use-package company-emoji)
;; company-mode completion backend for ghc-mod
;; https://github.com/iquiw/company-ghc
(use-package company-ghc)
;; company backend which uses the current ghci process.
(use-package company-ghci)
;; company-mode backend for Go (using gocode)
(use-package company-go)
;; Completion back-end for Python JEDI.
(use-package company-jedi)
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

(use-package company-restclient)
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
;; Diminished modes are minor modes with no modeline display
;; https://github.com/myrjola/diminish.el
(use-package diminish)
;;https://github.com/thamer/diredful
;;(use-package diredful)
;; dracula-theme - A dark theme for Atom, Alfred, Emacs,...
;; https://github.com/dracula/dracula-theme
;; https://draculatheme.com/emacs/
(use-package dracula-theme
  :init
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
  :config
  (load-theme 'dracula t))
;; A RPC stack for the Emacs Lisp
;; https://github.com/kiwanami/emacs-epc
(use-package epc)
;; Emacs Package Library
;; http://github.com/cask/epl
(use-package epl)
;; Manipulate sqlite file from Emacs
;; https://github.com/mhayashi1120/Emacs-esqlite
(use-package esqlite)
;; Modern API for working with files and directories
;; http://github.com/rejeep/f.el
(use-package f)
(use-package flymake-easy)
(use-package flymake-php)
(use-package flymake-yaml)
;; https://github.com/syohex/emacs-fontawesome
(use-package fontawesome)

;; Print a fortune in your Emacs scratch buffer
;; https://github.com/andschwa/fortune-cookie
;; $sudo apt-get install fortunes fortunes-it fortunes-es
(use-package fortune-cookie
  :config
  (setq fortune-cookie-cowsay-args  "-f tux -s")
  (fortune-cookie-mode))

(use-package ggtags)
(use-package gh)

;; Render markdown using the Github API.
;; https://github.com/emacs-pe/gh-md.el
;; After install gh-md.el you can use the functions gh-md-render-region and
;; gh-md-render-buffer to generate a preview of the markdown content of a
;; buffer.
(use-package gh-md)
(use-package gist)
(use-package git-commit)
(use-package google)
;;(use-package grandshell-theme)
;;(use-package gruvbox-theme)

;; helm
(use-package helm
  :bind (("M-x" . helm-M-x)
	 ("C-x b" . helm-buffers-list)
	 ("C-x C-f" . helm-find-files)
	 ("C-x r b" . helm-bookmarks)))
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
;;  Helm UI for Projectile 
;; https://github.com/bbatsov/helm-projectile
(use-package helm-projectile)
;;(use-package helm-core)
(use-package helm-google)
(use-package helm-gtags)
;; http://www.emacswiki.org/help-fns+.el
(use-package help-fns+)
(use-package hi-lock
  :bind (("M-o l" . highlight-lines-matching-regexp)
         ("M-o r" . highlight-regexp)
         ("M-o w" . highlight-phrase)))
(use-package highlight-blocks
  :config
  (highlight-blocks-mode t))
(use-package ht)
;; An Emacs mode to manage Jekyll blogs
;; https://github.com/nibrahim/Hyde
(use-package hyde)
;;(autoload 'ibuffer "ibuffer" "List buffers." t)
(use-package ibuffer-projectile)
(use-package inf-php)
(use-package inf-ruby)
(use-package inflections)
(use-package interaction-log)
(use-package jedi)
(use-package jedi-core)
(use-package js2-mode)
(use-package json-mode)
(use-package json-reformat)
(use-package json-snatcher)
(use-package logito)
;; Manage Git inside Emacs
;; https://github.com/magit/magit
(use-package magit)
(use-package magit-popup)
(use-package markdown-mode)
(use-package markdown-preview-eww)
(use-package markdown-toc)
(use-package marshal)
(use-package mkdown)
(use-package mmm-mode)
(use-package mmt)
(use-package moccur-edit)
;;(use-package moe-theme)
;;(use-package monokai-theme)
(use-package multiple-cursors)
(use-package neotree)
(use-package pcache)
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

(use-package php-auto-yasnippets)
(use-package php-mode)
(use-package phpunit
  :bind (:map php-mode-map
	      ("C-x t" . phpunit-current-test)
	      ("C-x c" . phpunit-current-class)
	      ("C-x p" . phpunit-current-project)))
(use-package pkg-info)
(use-package polymode)
(use-package popup)
(use-package pos-tip)
;; Project Interaction Library
;; https://github.com/bbatsov/projectile
(use-package projectile
  :config
  (projectile-global-mode t))

;; Projectile Rails - minor mode for working with Ruby on Rails applications
;; https://github.com/asok/projectile-rails
(use-package projectile-rails
  :config
  (add-hook 'projectile-mode-hook 'projectile-rails-on))
(use-package python-environment)
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
(use-package rake)
;; https://github.com/pashky/restclient.el
;; This is a tool to manually explore and test HTTP REST webservices.
;; Runs queries from a plain-text query sheet, displays results as a
;; pretty-printed XML, JSON and even images.
(use-package restclient)
;; Robe - Code navigation, documentation lookup and completion for Ruby
;; https://github.com/dgutov/robe
(use-package robe
  :init
  (add-hook 'ruby-mode-hook 'robe-mode))

;; S - The long lost Emacs string manipulation library.
;; https://github.com/magnars/s.el
(use-package s)

;; scss-mode Emacs mode for SCSS files (http://sass-lang.com)
;; https://github.com/antonj/scss-mode
(use-package scss-mode)

;; smartparens - Minor mode for Emacs that deals with parens
;; pairs and tries to be smart about it.
;; https://github.com/Fuco1/smartparens
(use-package smartparens
  :config
  (require 'smartparens-config)
  (smartparens-global-mode t))

(use-package speed-type)
(use-package sublimity)
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
(use-package virtualenvwrapper)
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
;; Writeroom-mode: distraction-free writing for Emacs. 
;; https://github.com/joostkremers/writeroom-mode
;; can be activated in a buffer by calling M-x writeroom-mode RET
(use-package writeroom-mode)
(use-package xcscope)
;; https://github.com/yoshiki/yaml-mode
(use-package yaml-mode)

;; A template system for Emacs
;; https://github.com/joaotavora/yasnippet
;; snippets repository https://github.com/AndreaCrotti/yasnippet-snippets
;; cloned in yasnippet/snippets
(use-package yasnippet
  :config
  (yas-global-mode t))

;;;;;;;;;;;;
;; Themes ;;
;;;;;;;;;;;;

;;(use-package zenburn-theme)
;;;;;;;;;;; black-themes ;;;;;;;;;;;;
;;(load-theme 'wheatgrass)
;;(load-theme 'alect-black)
;;(load-theme 'cyberpunk)
;;;;;;;(load-theme 'gruvbox t)
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

;; lisp/menu-bar
;;;; Toggle display of a menu bar on each frame (Menu Bar mode).
;;;; (menu-bar-mode -1)
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
