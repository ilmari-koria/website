<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="2.0">

  <xsl:output method="text"
              encoding="UTF-8"
              indent="no"
              omit-xml-declaration="yes"/>

  <xsl:param name="org-path"/>

  <xsl:template match="/">
    (require 'package)
    (package-initialize)
    (unless (package-installed-p 'dash)
    (package-refresh-contents)
    (package-install 'dash))
    (unless (package-installed-p 's)
    (package-refresh-contents)
    (package-install 's))
    (add-to-list 'load-path ".")
    (require 'org-ml)
    (require 'om-to-xml)
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
