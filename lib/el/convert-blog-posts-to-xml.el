(require 'package)
(package-initialize)
;; (package-refresh-contents)

(unless (package-installed-p 'dash)
  (package-refresh-contents)
  (package-install 'dash))

(unless (package-installed-p 's)
  (package-refresh-contents)
  (package-install 's))

;; TODO is this good practice?
(add-to-list 'load-path ".")

(require 'org-ml)
(require 'om-to-xml)

(defun convert-blog-posts-to-xml ()
  (let ((directory "../../posts/"))
    (when (file-directory-p directory)
      (dolist (file (directory-files directory t "\\.org$"))
        (when (file-regular-p file)
          (with-current-buffer (find-file-noselect file)
            (om-to-xml)
            (save-buffer)
            (kill-buffer)))))))
