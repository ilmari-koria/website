<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="2.0">

  <xsl:output method="text"
              encoding="UTF-8"
              indent="no"
              omit-xml-declaration="yes"/>

  <xsl:param name="org-path"/>

  <!-- TODO sort out el load path -->
  <xsl:template match="/">
    (load "/home/ilmari/my-files/blog/website/emacs/emacs/share/emacs/site-lisp/dash.el")
    (load "/home/ilmari/my-files/blog/website/emacs/emacs/share/emacs/site-lisp/s.el")
    (load "/home/ilmari/my-files/blog/website/emacs/emacs/share/emacs/site-lisp/org-ml-macs.el")
    (load "/home/ilmari/my-files/blog/website/emacs/emacs/share/emacs/site-lisp/org-ml.el")
    (load "/home/ilmari/my-files/blog/website/emacs/emacs/share/emacs/site-lisp/om-to-xml.el")
    (require 'dash)
    (require 's)
    (require 'org-ml)
    (require 'om-to-xml)
    (setq org-export-with-sub-superscripts t)
    (defun convert-blog-posts-to-xml ()
    (let ((directory "<xsl:value-of select="$org-path"/>"))
    (when (file-directory-p directory)
    (dolist (file (directory-files directory t "\\.org$"))
    (when (file-regular-p file)
    (with-current-buffer (find-file-noselect file)
    (om-to-xml)
    (save-buffer)
    (kill-buffer)))))))
  </xsl:template>
</xsl:stylesheet>
