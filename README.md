# dot-emacs
 My **.emacs** file and other personal Emacs goodies

# Overview

Personal [GNU Emacs](https://www.gnu.org/s/emacs/) configuration file
to use the same *.emacs* file among several machines.

# Description

It uses [use-package](https://github.com/jwiegley/use-package) to load 
packages from the following package repositories:

* MELPA - [Milkypostman’s Emacs Lisp Package Archive](http://melpa.org/)
* ELPA - [GNU Emacs Lisp Package Archive](https://elpa.gnu.org/)
* MARMALADE - [Marmalade repo](http://marmalade-repo.org/)

# Install

Put *.emacs* in any of the default init file paths:

- `~/.emacs` 
- `~/.emacs.el`
- `~/.emacs.d/init.el`

# Cheatsheet

## Main key bindings and custom behaviour

### Move between windows

- Go directly to a window from a list of candidates: 
  - `M-p` **ace-window**
- Traverse the window list:
  - `C-x o` **other-window**
- Go directly to a speific word in any window
  - `C-.` **ace-jump-mode**

# Conventions

Conventions followed when adding a package

* add package summary
* add source code URL
* add relevant notes

Example:

~~~ lisp
;; ace-jump-mode a quick cursor jump mode for emacs
;; https://github.com/winterTTr/ace-jump-mode
;; Other relevant notes
;; (..)
(use-package ace-jump-mode
  :bind
  (("C-." . ace-jump-mode)
   ("C-c SPC" . ace-jump-mode-pop-mark)))
~~~

# .emacs file layout

~~~ lisp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; bootstrap package managers ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
...

;;;;;;;;;;;;;;;;
;; global-map ;;
;;;;;;;;;;;;;;;;

;;; C-

;; replace default buffer-menu
(bind-key "C-x C-b" #'ibuffer) 
...

;;;;;;;;;;;;;;;;;;;
;; Load packages ;;
;;;;;;;;;;;;;;;;;;;

(use-package ace-jump-mode)
...

;;;;;;;;;;;;
;; Themes ;;
;;;;;;;;;;;;

..

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Customizing default packages ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(show-paren-mode t)
...
~~~

# License

The MIT License (MIT)

Copyright (c) Marcelo Canina 

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
