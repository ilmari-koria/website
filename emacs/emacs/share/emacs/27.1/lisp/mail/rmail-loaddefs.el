;;; rmail-loaddefs.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "rmailedit" "rmailedit.el" "e0680dfbae04878ac59f00c1ab1015bb")
;;; Generated autoloads from rmailedit.el

(autoload 'rmail-edit-current-message "rmailedit" "\
Edit the contents of this message." t nil)

;;;***

;;;### (autoloads nil "rmailkwd" "rmailkwd.el" "2cb4183566349c4277ed8fa515341ca6")
;;; Generated autoloads from rmailkwd.el

(autoload 'rmail-add-label "rmailkwd" "\
Add LABEL to labels associated with current RMAIL message.
Completes (see `rmail-read-label') over known labels when reading.
LABEL may be a symbol or string.  Only one label is allowed.

\(fn LABEL)" t nil)

(autoload 'rmail-kill-label "rmailkwd" "\
Remove LABEL from labels associated with current RMAIL message.
Completes (see `rmail-read-label') over known labels when reading.
LABEL may be a symbol or string.  Only one label is allowed.

\(fn LABEL)" t nil)

(autoload 'rmail-read-label "rmailkwd" "\
Read a label with completion, prompting with PROMPT.
Completions are chosen from `rmail-label-obarray'.  The default
is `rmail-last-label', if that is non-nil.  Updates `rmail-last-label'
according to the choice made, and returns a symbol.

\(fn PROMPT)" nil nil)

(autoload 'rmail-previous-labeled-message "rmailkwd" "\
Show previous message with one of the labels LABELS.
LABELS should be a comma-separated list of label names.
If LABELS is empty, the last set of labels specified is used.
With prefix argument N moves backward N messages with these labels.

\(fn N LABELS)" t nil)

(autoload 'rmail-next-labeled-message "rmailkwd" "\
Show next message with one of the labels LABELS.
LABELS should be a comma-separated list of label names.
If LABELS is empty, the last set of labels specified is used.
With prefix argument N moves forward N messages with these labels.

\(fn N LABELS)" t nil)

;;;***

;;;### (autoloads nil "rmailmm" "rmailmm.el" "3d7bfa781e1b12bbc6356c47a8992a1a")
;;; Generated autoloads from rmailmm.el

(autoload 'rmail-mime "rmailmm" "\
Toggle the display of a MIME message.

The actual behavior depends on the value of `rmail-enable-mime'.

If `rmail-enable-mime' is non-nil (the default), this command toggles
the display of a MIME message between decoded presentation form and
raw data.  With optional prefix argument ARG, it toggles the display only
of the MIME entity at point, if there is one.  The optional argument
STATE forces a particular display state, rather than toggling.
`raw' forces raw mode, any other non-nil value forces decoded mode.

If `rmail-enable-mime' is nil, this creates a temporary \"*RMAIL*\"
buffer holding a decoded copy of the message.  Inline content-types
are handled according to `rmail-mime-media-type-handlers-alist'.
By default, this displays text and multipart messages, and offers to
download attachments as specified by `rmail-mime-attachment-dirs-alist'.
The arguments ARG and STATE have no effect in this case.

\(fn &optional ARG STATE)" t nil)

;;;***

;;;### (autoloads nil "rmailmsc" "rmailmsc.el" "2e38e13aa604e172c9c0a2edc2762ba0")
;;; Generated autoloads from rmailmsc.el

(autoload 'set-rmail-inbox-list "rmailmsc" "\
Set the inbox list of the current RMAIL file to FILE-NAME.
You can specify one file name, or several names separated by commas.
If FILE-NAME is empty, remove any existing inbox list.

This applies only to the current session.

\(fn FILE-NAME)" t nil)

;;;***

;;;### (autoloads nil "rmailsort" "rmailsort.el" "635e6401db61e1ab41ca6ea7e9e9893d")
;;; Generated autoloads from rmailsort.el

(autoload 'rmail-sort-by-date "rmailsort" "\
Sort messages of current Rmail buffer by \"Date\" header.
If prefix argument REVERSE is non-nil, sorts in reverse order.

\(fn REVERSE)" t nil)

(autoload 'rmail-sort-by-subject "rmailsort" "\
Sort messages of current Rmail buffer by \"Subject\" header.
Ignores any \"Re: \" prefix.  If prefix argument REVERSE is
non-nil, sorts in reverse order.

\(fn REVERSE)" t nil)

(autoload 'rmail-sort-by-author "rmailsort" "\
Sort messages of current Rmail buffer by author.
This uses either the \"From\" or \"Sender\" header, downcased.
If prefix argument REVERSE is non-nil, sorts in reverse order.

\(fn REVERSE)" t nil)

(autoload 'rmail-sort-by-recipient "rmailsort" "\
Sort messages of current Rmail buffer by recipient.
This uses either the \"To\" or \"Apparently-To\" header, downcased.
If prefix argument REVERSE is non-nil, sorts in reverse order.

\(fn REVERSE)" t nil)

(autoload 'rmail-sort-by-correspondent "rmailsort" "\
Sort messages of current Rmail buffer by other correspondent.
This uses either the \"From\", \"Sender\", \"To\", or
\"Apparently-To\" header, downcased.  Uses the first header not
excluded by `mail-dont-reply-to-names'.  If prefix argument
REVERSE is non-nil, sorts in reverse order.

\(fn REVERSE)" t nil)

(autoload 'rmail-sort-by-lines "rmailsort" "\
Sort messages of current Rmail buffer by the number of lines.
If prefix argument REVERSE is non-nil, sorts in reverse order.

\(fn REVERSE)" t nil)

(autoload 'rmail-sort-by-labels "rmailsort" "\
Sort messages of current Rmail buffer by labels.
LABELS is a comma-separated list of labels.  The order of these
labels specifies the order of messages: messages with the first
label come first, messages with the second label come second, and
so on.  Messages that have none of these labels come last.
If prefix argument REVERSE is non-nil, sorts in reverse order.

\(fn REVERSE LABELS)" t nil)

;;;***

;;;### (autoloads nil "rmailsum" "rmailsum.el" "782164f774074065f94fc726d70d3dfd")
;;; Generated autoloads from rmailsum.el

(autoload 'rmail-summary "rmailsum" "\
Display a summary of all messages, one line per message." t nil)

(autoload 'rmail-summary-by-labels "rmailsum" "\
Display a summary of all messages with one or more LABELS.
LABELS should be a string containing the desired labels, separated by commas.

\(fn LABELS)" t nil)

(autoload 'rmail-summary-by-recipients "rmailsum" "\
Display a summary of all messages with the given RECIPIENTS.
Normally checks the To, From and Cc fields of headers;
but if PRIMARY-ONLY is non-nil (prefix arg given),
 only look in the To and From fields.
RECIPIENTS is a regular expression.

\(fn RECIPIENTS &optional PRIMARY-ONLY)" t nil)

(autoload 'rmail-summary-by-regexp "rmailsum" "\
Display a summary of all messages according to regexp REGEXP.
If the regular expression is found in the header of the message
\(including in the date and other lines, as well as the subject line),
Emacs will list the message in the summary.

\(fn REGEXP)" t nil)

(autoload 'rmail-summary-by-topic "rmailsum" "\
Display a summary of all messages with the given SUBJECT.
Normally checks just the Subject field of headers; but with prefix
argument WHOLE-MESSAGE is non-nil, looks in the whole message.
SUBJECT is a regular expression.

\(fn SUBJECT &optional WHOLE-MESSAGE)" t nil)

(autoload 'rmail-summary-by-senders "rmailsum" "\
Display a summary of all messages whose \"From\" field matches SENDERS.
SENDERS is a regular expression.  The default for SENDERS matches the
sender of the current message.

\(fn SENDERS)" t nil)

;;;***

;;;### (autoloads nil "undigest" "undigest.el" "ff7e4b2d7f1e02f2288d2a405ab40b6f")
;;; Generated autoloads from undigest.el

(autoload 'undigestify-rmail-message "undigest" "\
Break up a digest message into its constituent messages.
Leaves original message, deleted, before the undigestified messages." t nil)

(autoload 'unforward-rmail-message "undigest" "\
Extract a forwarded message from the containing message.
This puts the forwarded message into a separate rmail message following
the containing message.  This command is only useful when messages are
forwarded with `rmail-enable-mime-composing' set to nil." t nil)

;;;***

(provide 'rmail-loaddefs)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; rmail-loaddefs.el ends here
