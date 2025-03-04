;;; erc-loaddefs.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "erc-autoaway" "erc-autoaway.el" "ca668ea42f4deac871bfc9c2f92cab11")
;;; Generated autoloads from erc-autoaway.el
(autoload 'erc-autoaway-mode "erc-autoaway")

;;;***

;;;### (autoloads nil "erc-button" "erc-button.el" "cdc986f12666c6240d8e541f30dc8b4d")
;;; Generated autoloads from erc-button.el
(autoload 'erc-button-mode "erc-button" nil t)

;;;***

;;;### (autoloads nil "erc-capab" "erc-capab.el" "e1016ca6627c94c6f16d8e21e7b2c900")
;;; Generated autoloads from erc-capab.el
(autoload 'erc-capab-identify-mode "erc-capab" nil t)

;;;***

;;;### (autoloads nil "erc-compat" "erc-compat.el" "aab018d738484d60354572e400001ac2")
;;; Generated autoloads from erc-compat.el
(autoload 'erc-define-minor-mode "erc-compat")

;;;***

;;;### (autoloads nil "erc-dcc" "erc-dcc.el" "11bfbaa7dcbaa5f9185803d62c4742f9")
;;; Generated autoloads from erc-dcc.el
(autoload 'erc-dcc-mode "erc-dcc")

(autoload 'erc-cmd-DCC "erc-dcc" "\
Parser for /dcc command.
This figures out the dcc subcommand and calls the appropriate routine to
handle it.  The function dispatched should be named \"erc-dcc-do-FOO-command\",
where FOO is one of CLOSE, GET, SEND, LIST, CHAT, etc.

\(fn CMD &rest ARGS)" nil nil)

(autoload 'pcomplete/erc-mode/DCC "erc-dcc" "\
Provide completion for the /DCC command." nil nil)

(defvar erc-ctcp-query-DCC-hook '(erc-ctcp-query-DCC) "\
Hook variable for CTCP DCC queries.")

(autoload 'erc-ctcp-query-DCC "erc-dcc" "\
The function called when a CTCP DCC request is detected by the client.
It examines the DCC subcommand, and calls the appropriate routine for
that subcommand.

\(fn PROC NICK LOGIN HOST TO QUERY)" nil nil)

;;;***

;;;### (autoloads nil "erc-desktop-notifications" "erc-desktop-notifications.el"
;;;;;;  "2576908e6624c2c6c00707c91269148e")
;;; Generated autoloads from erc-desktop-notifications.el
(autoload 'erc-notifications-mode "erc-desktop-notifications" "" t)

;;;***

;;;### (autoloads nil "erc-ezbounce" "erc-ezbounce.el" "34f21e38aa5c98666c71a97b1d31e2d6")
;;; Generated autoloads from erc-ezbounce.el

(autoload 'erc-cmd-ezb "erc-ezbounce" "\
Send EZB commands to the EZBouncer verbatim.

\(fn LINE &optional FORCE)" nil nil)

(autoload 'erc-ezb-get-login "erc-ezbounce" "\
Return an appropriate EZBounce login for SERVER and PORT.
Look up entries in `erc-ezb-login-alist'.  If the username or password
in the alist is nil, prompt for the appropriate values.

\(fn SERVER PORT)" nil nil)

(autoload 'erc-ezb-lookup-action "erc-ezbounce" "\


\(fn MESSAGE)" nil nil)

(autoload 'erc-ezb-notice-autodetect "erc-ezbounce" "\
React on an EZBounce NOTICE request.

\(fn PROC PARSED)" nil nil)

(autoload 'erc-ezb-identify "erc-ezbounce" "\
Identify to the EZBouncer server.

\(fn MESSAGE)" nil nil)

(autoload 'erc-ezb-init-session-list "erc-ezbounce" "\
Reset the EZBounce session list to nil.

\(fn MESSAGE)" nil nil)

(autoload 'erc-ezb-end-of-session-list "erc-ezbounce" "\
Indicate the end of the EZBounce session listing.

\(fn MESSAGE)" nil nil)

(autoload 'erc-ezb-add-session "erc-ezbounce" "\
Add an EZBounce session to the session list.

\(fn MESSAGE)" nil nil)

(autoload 'erc-ezb-select "erc-ezbounce" "\
Select an IRC server to use by EZBounce, in ERC style.

\(fn MESSAGE)" nil nil)

(autoload 'erc-ezb-select-session "erc-ezbounce" "\
Select a detached EZBounce session." nil nil)

(autoload 'erc-ezb-initialize "erc-ezbounce" "\
Add EZBouncer convenience functions to ERC." nil nil)

;;;***

;;;### (autoloads nil "erc-fill" "erc-fill.el" "731a19ef9a3b13b9ff98c756e5881d04")
;;; Generated autoloads from erc-fill.el
(autoload 'erc-fill-mode "erc-fill" nil t)

(autoload 'erc-fill "erc-fill" "\
Fill a region using the function referenced in `erc-fill-function'.
You can put this on `erc-insert-modify-hook' and/or `erc-send-modify-hook'." nil nil)

;;;***

;;;### (autoloads nil "erc-identd" "erc-identd.el" "ab7b9860d67ffa89d3ab0544f7ccc805")
;;; Generated autoloads from erc-identd.el
(autoload 'erc-identd-mode "erc-identd")

(autoload 'erc-identd-start "erc-identd" "\
Start an identd server listening to port 8113.
Port 113 (auth) will need to be redirected to port 8113 on your
machine -- using iptables, or a program like redir which can be
run from inetd.  The idea is to provide a simple identd server
when you need one, without having to install one globally on your
system.

\(fn &optional PORT)" t nil)

(autoload 'erc-identd-stop "erc-identd" "\


\(fn &rest IGNORE)" t nil)

;;;***

;;;### (autoloads nil "erc-imenu" "erc-imenu.el" "f5c4224eb343e9204935f5e36dd2cd8d")
;;; Generated autoloads from erc-imenu.el

(autoload 'erc-create-imenu-index "erc-imenu" nil nil nil)

;;;***

;;;### (autoloads nil "erc-join" "erc-join.el" "f7e4b71821e96b2bb5cedde311576280")
;;; Generated autoloads from erc-join.el
(autoload 'erc-autojoin-mode "erc-join" nil t)

;;;***

;;;### (autoloads nil "erc-list" "erc-list.el" "029e85ef7b385dd8ae26c8495dada2b7")
;;; Generated autoloads from erc-list.el
(autoload 'erc-list-mode "erc-list")

;;;***

;;;### (autoloads nil "erc-log" "erc-log.el" "a7aff2dc724e69ccd0b5470695b478ba")
;;; Generated autoloads from erc-log.el
(autoload 'erc-log-mode "erc-log" nil t)

(autoload 'erc-logging-enabled "erc-log" "\
Return non-nil if logging is enabled for BUFFER.
If BUFFER is nil, the value of `current-buffer' is used.
Logging is enabled if `erc-log-channels-directory' is non-nil, the directory
is writable (it will be created as necessary) and
`erc-enable-logging' returns a non-nil value.

\(fn &optional BUFFER)" nil nil)

(autoload 'erc-save-buffer-in-logs "erc-log" "\
Append BUFFER contents to the log file, if logging is enabled.
If BUFFER is not provided, current buffer is used.
Logging is enabled if `erc-logging-enabled' returns non-nil.

This is normally done on exit, to save the unsaved portion of the
buffer, since only the text that runs off the buffer limit is logged
automatically.

You can save every individual message by putting this function on
`erc-insert-post-hook'.

\(fn &optional BUFFER)" t nil)

;;;***

;;;### (autoloads nil "erc-match" "erc-match.el" "94b1f11acd5a99478d58d017536b0bb7")
;;; Generated autoloads from erc-match.el
(autoload 'erc-match-mode "erc-match")

(autoload 'erc-add-pal "erc-match" "\
Add pal interactively to `erc-pals'." t nil)

(autoload 'erc-delete-pal "erc-match" "\
Delete pal interactively to `erc-pals'." t nil)

(autoload 'erc-add-fool "erc-match" "\
Add fool interactively to `erc-fools'." t nil)

(autoload 'erc-delete-fool "erc-match" "\
Delete fool interactively to `erc-fools'." t nil)

(autoload 'erc-add-keyword "erc-match" "\
Add keyword interactively to `erc-keywords'." t nil)

(autoload 'erc-delete-keyword "erc-match" "\
Delete keyword interactively to `erc-keywords'." t nil)

(autoload 'erc-add-dangerous-host "erc-match" "\
Add dangerous-host interactively to `erc-dangerous-hosts'." t nil)

(autoload 'erc-delete-dangerous-host "erc-match" "\
Delete dangerous-host interactively to `erc-dangerous-hosts'." t nil)

;;;***

;;;### (autoloads nil "erc-menu" "erc-menu.el" "38c3a0663348cdfc93f035042eb6d1f3")
;;; Generated autoloads from erc-menu.el
(autoload 'erc-menu-mode "erc-menu" nil t)

;;;***

;;;### (autoloads nil "erc-netsplit" "erc-netsplit.el" "91f7cfa5e118765b3baeb5a69d0af861")
;;; Generated autoloads from erc-netsplit.el
(autoload 'erc-netsplit-mode "erc-netsplit")

(autoload 'erc-cmd-WHOLEFT "erc-netsplit" "\
Show who's gone." nil nil)

;;;***

;;;### (autoloads nil "erc-notify" "erc-notify.el" "87dd5d737dbdbb6536ff859993f9d41a")
;;; Generated autoloads from erc-notify.el
(autoload 'erc-notify-mode "erc-notify" nil t)

(autoload 'erc-cmd-NOTIFY "erc-notify" "\
Change `erc-notify-list' or list current notify-list members online.
Without args, list the current list of notified people online,
with args, toggle notify status of people.

\(fn &rest ARGS)" nil nil)

(autoload 'pcomplete/erc-mode/NOTIFY "erc-notify" nil nil nil)

;;;***

;;;### (autoloads nil "erc-page" "erc-page.el" "e610077a6d3425be885698de53e8616b")
;;; Generated autoloads from erc-page.el
(autoload 'erc-page-mode "erc-page")

;;;***

;;;### (autoloads nil "erc-pcomplete" "erc-pcomplete.el" "62ee5e21e5161a0b280efc32f264e5fe")
;;; Generated autoloads from erc-pcomplete.el
(autoload 'erc-completion-mode "erc-pcomplete" nil t)

;;;***

;;;### (autoloads nil "erc-replace" "erc-replace.el" "531f61bc0e3d9be12a68c7ca493975a8")
;;; Generated autoloads from erc-replace.el
(autoload 'erc-replace-mode "erc-replace")

;;;***

;;;### (autoloads nil "erc-ring" "erc-ring.el" "67a9a5d171237b0cbf376181acdca72e")
;;; Generated autoloads from erc-ring.el
(autoload 'erc-ring-mode "erc-ring" nil t)

;;;***

;;;### (autoloads nil "erc-services" "erc-services.el" "9dec03d381ea5a151a203478402275f7")
;;; Generated autoloads from erc-services.el
(autoload 'erc-services-mode "erc-services" nil t)

(autoload 'erc-nickserv-identify-mode "erc-services" "\
Set up hooks according to which MODE the user has chosen.

\(fn MODE)" t nil)

(autoload 'erc-nickserv-identify "erc-services" "\
Send an \"identify <PASSWORD>\" message to NickServ.
When called interactively, read the password using `read-passwd'.

\(fn PASSWORD)" t nil)

;;;***

;;;### (autoloads nil "erc-sound" "erc-sound.el" "d583b70db2faa6da6259f3d8ab1960e0")
;;; Generated autoloads from erc-sound.el
(autoload 'erc-sound-mode "erc-sound")

;;;***

;;;### (autoloads nil "erc-speedbar" "erc-speedbar.el" "fbe37562633113346fdaf0b1b040c424")
;;; Generated autoloads from erc-speedbar.el

(autoload 'erc-speedbar-browser "erc-speedbar" "\
Initialize speedbar to display an ERC browser.
This will add a speedbar major display mode." t nil)

;;;***

;;;### (autoloads nil "erc-spelling" "erc-spelling.el" "cbc826eb1503bc61f9262efd419530db")
;;; Generated autoloads from erc-spelling.el
(autoload 'erc-spelling-mode "erc-spelling" nil t)

;;;***

;;;### (autoloads nil "erc-stamp" "erc-stamp.el" "8a33d68476c0ba5649a2390a709caa22")
;;; Generated autoloads from erc-stamp.el
(autoload 'erc-timestamp-mode "erc-stamp" nil t)

;;;***

;;;### (autoloads nil "erc-track" "erc-track.el" "58ab098accc3f1015ad487cfba57506d")
;;; Generated autoloads from erc-track.el

(defvar erc-track-minor-mode nil "\
Non-nil if Erc-Track minor mode is enabled.
See the `erc-track-minor-mode' command
for a description of this minor mode.")

(custom-autoload 'erc-track-minor-mode "erc-track" nil)

(autoload 'erc-track-minor-mode "erc-track" "\
Toggle mode line display of ERC activity (ERC Track minor mode).

If called interactively, enable Erc-Track minor mode if ARG is
positive, and disable it if ARG is zero or negative.  If called from
Lisp, also enable the mode if ARG is omitted or nil, and toggle it if
ARG is `toggle'; disable the mode otherwise.

ERC Track minor mode is a global minor mode.  It exists for the
sole purpose of providing the C-c C-SPC and C-c C-@ keybindings.
Make sure that you have enabled the track module, otherwise the
keybindings will not do anything useful.

\(fn &optional ARG)" t nil)
(autoload 'erc-track-mode "erc-track" nil t)

;;;***

;;;### (autoloads nil "erc-truncate" "erc-truncate.el" "b5827787102055435ead19aefa224250")
;;; Generated autoloads from erc-truncate.el
(autoload 'erc-truncate-mode "erc-truncate" nil t)

(autoload 'erc-truncate-buffer-to-size "erc-truncate" "\
Truncates the buffer to the size SIZE.
If BUFFER is not provided, the current buffer is assumed.  The deleted
region is logged if `erc-logging-enabled' returns non-nil.

\(fn SIZE &optional BUFFER)" nil nil)

(autoload 'erc-truncate-buffer "erc-truncate" "\
Truncates the current buffer to `erc-max-buffer-size'.
Meant to be used in hooks, like `erc-insert-post-hook'." t nil)

;;;***

;;;### (autoloads nil "erc-xdcc" "erc-xdcc.el" "a561a16a265fef197cc8209360591ed2")
;;; Generated autoloads from erc-xdcc.el
(autoload 'erc-xdcc-mode "erc-xdcc")

(autoload 'erc-xdcc-add-file "erc-xdcc" "\
Add a file to `erc-xdcc-files'.

\(fn FILE)" t nil)

;;;***

(provide 'erc-loaddefs)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; erc-loaddefs.el ends here
