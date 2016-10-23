# dot-emacs
 My .emacs file and other personal Emacs goodies

# Overview

Personal [GNU Emacs](https://www.gnu.org/s/emacs/) configuration file
to use the same *.emacs* file among several machines.

# Description

It uses [use-package](https://github.com/jwiegley/use-package) to load 
packages from the following package repositories:

* MELPA - [Milkypostman’s Emacs Lisp Package Archive](http://melpa.org/)
* ELPA - [GNU Emacs Lisp Package Archive](https://elpa.gnu.org/)
* MARMALADE - [Marmalade repo](http://marmalade-repo.org/)

## Conventions

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
