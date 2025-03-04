;; nts emacs compiled with just prefx and bindir set:
;;   ./autogen.sh 
;;   ./configure --prefix=/home/ilmari/my-files/blog/website/emacs/emacs --bindir=/home/ilmari/my-files/blog/website/emacs/bin
;;   make
;;   make install

;; this stuff is just here as an example
(load "/home/ilmari/my-files/blog/website/emacs/el/dash.el")
(load "/home/ilmari/my-files/blog/website/emacs/el/s.el")
;; note the load order
(load "/home/ilmari/my-files/blog/website/emacs/el/org-ml-macs.el")
(load "/home/ilmari/my-files/blog/website/emacs/el/org-ml.el")
(load "/home/ilmari/my-files/blog/website/emacs/el/om-to-xml.el")

(require 'dash)
(require 's)
(require 'org-ml)
(require 'om-to-xml)
