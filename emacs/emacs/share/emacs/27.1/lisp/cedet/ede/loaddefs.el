;;; loaddefs.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "ede/cpp-root" "cpp-root.el" "408bcfc6f90bd629817f644d6474649c")
;;; Generated autoloads from cpp-root.el

(eieio-defclass-autoload 'ede-cpp-root-project '(ede-project eieio-instance-tracker) "ede/cpp-root" "EDE cpp-root project class.\nEach directory needs a project file to control it.")

;;;***

;;;### (autoloads nil "ede/custom" "custom.el" "7c610711f4ef31987a0c2773d30d8c40")
;;; Generated autoloads from custom.el

(autoload 'ede-customize-project "ede/custom" "\
Edit fields of the current project through EIEIO & Custom." t nil)

(defalias 'customize-project 'ede-customize-project)

(autoload 'ede-customize-current-target "ede/custom" "\
Edit fields of the current target through EIEIO & Custom." t nil)

(defalias 'customize-target 'ede-customize-current-target)

(autoload 'ede-project-sort-targets "ede/custom" "\
Create a custom-like buffer for sorting targets of current project." t nil)

;;;***

;;;### (autoloads nil "ede/dired" "dired.el" "27f9912a4dcc6cb87e0fe0399a3ffd39")
;;; Generated autoloads from dired.el

(autoload 'ede-dired-minor-mode "ede/dired" "\
A minor mode that should only be activated in DIRED buffers.

If called interactively, enable Ede-Dired minor mode if ARG is
positive, and disable it if ARG is zero or negative.  If called from
Lisp, also enable the mode if ARG is omitted or nil, and toggle it if
ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil "ede/emacs" "emacs.el" "3add6a792ca315815e8e6a23251108a4")
;;; Generated autoloads from emacs.el

(ede-add-project-autoload (make-instance 'ede-project-autoload :name "EMACS ROOT" :file 'ede/emacs :proj-file "src/emacs.c" :load-type 'ede-emacs-load :class-sym 'ede-emacs-project :new-p nil :safe-p t) 'unique)

;;;***

;;;### (autoloads nil "ede/files" "files.el" "8aa12227618e8ec5d9d039d185b8a28a")
;;; Generated autoloads from files.el

(autoload 'ede-find-file "ede/files" "\
Find FILE in project.  FILE can be specified without a directory.
There is no completion at the prompt.  FILE is searched for within
the current EDE project.

\(fn FILE)" t nil)

;;;***

;;;### (autoloads nil "ede/generic" "generic.el" "06cd4fde13f12580f0c8c8047406d464")
;;; Generated autoloads from generic.el

(autoload 'ede-enable-generic-projects "ede/generic" "\
Enable generic project loaders." t nil)

;;;***

;;;### (autoloads nil "ede/linux" "linux.el" "6463d83ebef4232b415467c4e00009e5")
;;; Generated autoloads from linux.el

(autoload 'ede-linux-load "ede/linux" "\
Return a Linux Project object if there is a match.
Return nil if there isn't one.
Argument DIR is the directory it is created for.
ROOTPROJ is nil, since there is only one project.

\(fn DIR &optional ROOTPROJ)" nil nil)

(ede-add-project-autoload (make-instance 'ede-project-autoload :name "LINUX ROOT" :file 'ede/linux :proj-file "scripts/ver_linux" :load-type 'ede-linux-load :class-sym 'ede-linux-project :new-p nil :safe-p t) 'unique)

;;;***

;;;### (autoloads nil "ede/locate" "locate.el" "216112ceeee7d873418303b88ec9cef2")
;;; Generated autoloads from locate.el

(autoload 'ede-enable-locate-on-project "ede/locate" "\
Enable an EDE locate feature on PROJECT.
Attempt to guess which project locate style to use
based on `ede-locate-setup-options'.

\(fn &optional PROJECT)" t nil)

;;;***

;;;### (autoloads nil "ede/make" "make.el" "89d599b4f3b77e3daeaa9d9fb6398f06")
;;; Generated autoloads from make.el

(autoload 'ede-make-check-version "ede/make" "\
Check the version of GNU Make installed.
The check passes if the MAKE version is no high enough, or if it
is not GNU make.
If NOERROR is non-nil, return t for success, nil for failure.
If NOERROR is nil, then throw an error on failure.  Return t otherwise.

\(fn &optional NOERROR)" t nil)

;;;***

;;;### (autoloads nil "ede/speedbar" "speedbar.el" "ddaa1a2f5496ab1b445d120735fd0190")
;;; Generated autoloads from speedbar.el

(autoload 'ede-speedbar-file-setup "ede/speedbar" "\
Setup some keybindings in the Speedbar File display." nil nil)

;;;***

;;;### (autoloads nil "ede/system" "system.el" "29041b75645278cedb6ffb28d96b1691")
;;; Generated autoloads from system.el

(autoload 'ede-web-browse-home "ede/system" "\
Browse the home page of the current project." t nil)

(autoload 'ede-edit-web-page "ede/system" "\
Edit the web site for this project." t nil)

(autoload 'ede-upload-distribution "ede/system" "\
Upload the current distribution to the correct location.
Use /user@ftp.site.com: file names for FTP sites.
Download tramp, and use /r:machine: for names on remote sites w/out FTP access." t nil)

(autoload 'ede-upload-html-documentation "ede/system" "\
Upload the current distributions documentation as HTML.
Use /user@ftp.site.com: file names for FTP sites.
Download tramp, and use /r:machine: for names on remote sites w/out FTP access." t nil)

(autoload 'ede-vc-project-directory "ede/system" "\
Run `vc-dir' on the current project." t nil)

;;;***

;;;### (autoloads nil "ede/util" "util.el" "815ae7a1d1c9467a14193e361824bbd5")
;;; Generated autoloads from util.el

(autoload 'ede-update-version "ede/util" "\
Update the current projects main version number.
Argument NEWVERSION is the version number to use in the current project.

\(fn NEWVERSION)" t nil)

;;;***

(provide 'loaddefs)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; loaddefs.el ends here
