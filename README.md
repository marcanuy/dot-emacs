# dot-emacs
 My **.emacs** file and other personal Emacs goodies

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-generate-toc again -->
**Table of Contents**

- [dot-emacs](#dot-emacs)
- [Overview](#overview)
- [Description](#description)
- [Install](#install)
- [Cheatsheet](#cheatsheet)
    - [Custom behaviour notes](#custom-behaviour-notes)
        - [Move between windows](#move-between-windows)
    - [Personal keybindings](#personal-keybindings)
    - [php-mode-map](#php-mode-map)
- [Conventions](#conventions)
- [.emacs file layout](#emacs-file-layout)
- [License](#license)

<!-- markdown-toc end -->

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

After that, first run will take a while installing all the missing packages
specified in the file.

# Cheatsheet

## Custom behaviour notes

### Move between windows

- Go directly to a window from a list of candidates: 
  - `M-p` **ace-window**
- Traverse the window list:
  - `C-x o` **other-window**

## Personal keybindings

The list resulting after executing `M-x describe-personal-keybindings`.

~~~
Key name          Command                                 Comments
----------------- --------------------------------------- ---------------------
44              `langtool-show-message-at-point'
4W              `langtool-check-done'
4c              `langtool-correct-buffer'               was `clone-indirect-buffer-other-window'
4l              `langtool-switch-default-language'
4w              `langtool-check'
<f12>             `pomidor'

C-:               `avy-goto-char'
C-?               `company-complete'

C-c '             `avy-goto-char-2'
C-c t             `term'

C-x b             `helm-buffers-list'
C-x r b           `helm-bookmarks'

C-x C-b           `ibuffer'                               was `list-buffers'
C-x C-d           `helm-browse-project'                   was `list-directory'
C-x C-f           `helm-find-files'
C-x C-l           `helm-locate'

C-x M-s o         `helm-occur'

M-p               `ace-window'
M-x               `helm-M-x'

M-o l             `highlight-lines-matching-regexp'       was `facemenu-set-bold-italic'
M-o r             `highlight-regexp'
M-o w             `highlight-phrase'

c-x c-l           `helm-locate'                           [now: `1']


php-mode-map: C-x c
-------------------------------------------------------------------------------

C-x c             `phpunit-current-class'
C-x p             `phpunit-current-project'
C-x t             `phpunit-current-test'
~~~

The full list of keybindings can be found with: `M-x describe-bindings`.

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

# File layout

~~~ lisp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; bootstrap package managers ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

...

;;;;;;;;;;;;;;;;
;; global-map ;;
;;;;;;;;;;;;;;;;

...

;;;;;;;;;;;;;;;;;;;
;; Load packages ;;
;;;;;;;;;;;;;;;;;;;

...

;;;;;;;;;;;;
;; Themes ;;
;;;;;;;;;;;;

...

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Core packages customization ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; file path
;;;; comment

...
~~~

# Notes

Make sure you customize the `user-mail-address` with your email.

~~~ lisp
;; lisp/startup
(setq user-mail-address "me@marcanuy.com")
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
