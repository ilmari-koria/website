;;; esh-groups.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "em-alias" "em-alias.el" "a9c92e4ece52f5887c98d16873f9d46d")
;;; Generated autoloads from em-alias.el

(defgroup eshell-alias nil "\
Command aliases allow for easy definition of alternate commands." :tag "Command aliases" :group 'eshell-module)

;;;***

;;;### (autoloads nil "em-banner" "em-banner.el" "ea1a93a909c7fbfc26a897da2b1cc8c4")
;;; Generated autoloads from em-banner.el

(defgroup eshell-banner nil "\
This sample module displays a welcome banner at login.
It exists so that others wishing to create their own Eshell extension
modules may have a simple template to begin with." :tag "Login banner" :group 'eshell-module)

;;;***

;;;### (autoloads nil "em-basic" "em-basic.el" "16045ad4ae7945a08a13ddc72f43891d")
;;; Generated autoloads from em-basic.el

(defgroup eshell-basic nil "\
The \"basic\" code provides a set of convenience functions which
are traditionally considered shell builtins.  Since all of the
functionality provided by them is accessible through Lisp, they are
not really builtins at all, but offer a command-oriented way to do the
same thing." :tag "Basic shell commands" :group 'eshell-module)

;;;***

;;;### (autoloads nil "em-cmpl" "em-cmpl.el" "8185e51c56e5aa4b8f498fdcfccced13")
;;; Generated autoloads from em-cmpl.el

(defgroup eshell-cmpl nil "\
This module provides a programmable completion function bound to
the TAB key, which allows for completing command names, file names,
variable names, arguments, etc." :tag "Argument completion" :group 'eshell-module)

;;;***

;;;### (autoloads nil "em-dirs" "em-dirs.el" "d15eb1f93a9727049ada22b5acb2e32f")
;;; Generated autoloads from em-dirs.el

(defgroup eshell-dirs nil "\
Directory navigation involves changing directories, examining the
current directory, maintaining a directory stack, and also keeping
track of a history of the last directory locations the user was in.
Emacs does provide standard Lisp definitions of `pwd' and `cd', but
they lack somewhat in feel from the typical shell equivalents." :tag "Directory navigation" :group 'eshell-module)

;;;***

;;;### (autoloads nil "em-glob" "em-glob.el" "50e0e1f8293f0330c13b099da448c57c")
;;; Generated autoloads from em-glob.el

(defgroup eshell-glob nil "\
This module provides extended globbing syntax, similar what is used
by zsh for filename generation." :tag "Extended filename globbing" :group 'eshell-module)

;;;***

;;;### (autoloads nil "em-hist" "em-hist.el" "fb21a83a809337b199f473bc0155b003")
;;; Generated autoloads from em-hist.el

(defgroup eshell-hist nil "\
This module provides command history management." :tag "History list management" :group 'eshell-module)

;;;***

;;;### (autoloads nil "em-ls" "em-ls.el" "880ddae8f15a7d785a6ff78303987d7e")
;;; Generated autoloads from em-ls.el

(defgroup eshell-ls nil "\
This module implements the \"ls\" utility fully in Lisp.  If it is
passed any unrecognized command switches, it will revert to the
operating system's version.  This version of \"ls\" uses text
properties to colorize its output based on the setting of
`eshell-ls-use-colors'." :tag "Implementation of `ls' in Lisp" :group 'eshell-module)

;;;***

;;;### (autoloads nil "em-pred" "em-pred.el" "d509f18c05ca165c87341030fc60e20b")
;;; Generated autoloads from em-pred.el

(defgroup eshell-pred nil "\
This module allows for predicates to be applied to globbing
patterns (similar to zsh), in addition to string modifiers which can
be applied either to globbing results, variable references, or just
ordinary strings." :tag "Value modifiers and predicates" :group 'eshell-module)

;;;***

;;;### (autoloads nil "em-prompt" "em-prompt.el" "47e6e989f9edbb488c954df0475e82c5")
;;; Generated autoloads from em-prompt.el

(defgroup eshell-prompt nil "\
This module provides command prompts, and navigation between them,
as is common with most shells." :tag "Command prompts" :group 'eshell-module)

;;;***

;;;### (autoloads nil "em-rebind" "em-rebind.el" "cacca6cc8cc42ec593fdf725214b5714")
;;; Generated autoloads from em-rebind.el

(defgroup eshell-rebind nil "\
This module allows for special keybindings that only take effect
while the point is in a region of input text.  By default, it binds
C-a to move to the beginning of the input text (rather than just the
beginning of the line), and C-p and C-n to move through the input
history, C-u kills the current input text, etc.  It also, if
`eshell-confine-point-to-input' is non-nil, does not allow certain
commands to cause the point to leave the input area, such as
`backward-word', `previous-line', etc.  This module intends to mimic
the behavior of normal shells while the user editing new input text." :tag "Rebind keys at input" :group 'eshell-module)

;;;***

;;;### (autoloads nil "em-script" "em-script.el" "e86a06f546d09de73acc492ea22b2127")
;;; Generated autoloads from em-script.el

(defgroup eshell-script nil "\
This module allows for the execution of files containing Eshell
commands, as a script file." :tag "Running script files." :group 'eshell-module)

;;;***

;;;### (autoloads nil "em-smart" "em-smart.el" "7cf786e1cb24f3a0d6f077d7381feae8")
;;; Generated autoloads from em-smart.el

(defgroup eshell-smart nil "\
This module combines the facility of normal, modern shells with
some of the edit/review concepts inherent in the design of Plan 9's
9term.  See the docs for more details.

Most likely you will have to turn this option on and play around with
it to get a real sense of how it works." :tag "Smart display of output" :group 'eshell-module)

;;;***

;;;### (autoloads nil "em-term" "em-term.el" "e929a121c54be983ea46be80a3cd3d33")
;;; Generated autoloads from em-term.el

(defgroup eshell-term nil "\
This module causes visual commands (e.g., `vi') to be executed by
the `term' package, which comes with Emacs.  This package handles most
of the ANSI control codes, allowing curses-based applications to run
within an Emacs window.  The variable `eshell-visual-commands' defines
which commands are considered visual in nature." :tag "Running visual commands" :group 'eshell-module)

;;;***

;;;### (autoloads nil "em-tramp" "em-tramp.el" "6430aca2660e9c43e035a5ed096bb2a2")
;;; Generated autoloads from em-tramp.el

(defgroup eshell-tramp nil "\
This module defines commands that use TRAMP in a way that is
  not transparent to the user.  So far, this includes only the
  built-in su and sudo commands, which are not compatible with
  the full, external su and sudo commands, and require the user
  to understand how to use the TRAMP sudo method." :tag "TRAMP Eshell features" :group 'eshell-module)

;;;***

;;;### (autoloads nil "em-unix" "em-unix.el" "9e6dca6fb3088f69c758a2b9fd763e15")
;;; Generated autoloads from em-unix.el

(defgroup eshell-unix nil "\
This module defines many of the more common UNIX utilities as
aliases implemented in Lisp.  These include mv, ln, cp, rm, etc.  If
the user passes arguments which are too complex, or are unrecognized
by the Lisp variant, the external version will be called (if
available).  The only reason not to use them would be because they are
usually much slower.  But in several cases their tight integration
with Eshell makes them more versatile than their traditional cousins
\(such as being able to use `kill' to kill Eshell background processes
by name)." :tag "UNIX commands in Lisp" :group 'eshell-module)

;;;***

;;;### (autoloads nil "em-xtra" "em-xtra.el" "19700e81e07e6c9aba5c6fece7eeb8ff")
;;; Generated autoloads from em-xtra.el

(defgroup eshell-xtra nil "\
This module defines some extra alias functions which are entirely
optional.  They can be viewed as samples for how to write Eshell alias
functions, or as aliases which make some of Emacs's behavior more
naturally accessible within Emacs." :tag "Extra alias functions" :group 'eshell-module)

;;;***

(provide 'esh-groups)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; esh-groups.el ends here
