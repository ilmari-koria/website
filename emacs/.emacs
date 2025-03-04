;; nts emacs compiled for nox
;; ./autogen.sh
;; ./configure --prefix=/home/ilmari/my-files/blog/website/emacs/emacs --bindir=/home/ilmari/my-files/blog/website/emacs/bin --with-x-toolkit=no --with-xpm=no --with-jpeg=no --with-png=no --with-gif=no --with-tiff=no
;; make
;; make install

;; for the sigsegv issue in debian use the updated code in emacs 30:
;;
;;  #if defined HAVE_STACK_OVERFLOW_HANDLING && !defined WINDOWSNT
;;  
;;  /* Alternate stack used by SIGSEGV handler below.  */
;;  
;;  /* Storage for the alternate signal stack.
;;     64 KiB is not too large for Emacs, and is large enough
;;     for all known platforms.  Smaller sizes may run into trouble.
;;     For example, libsigsegv 2.6 through 2.8 have a bug where some
;;     architectures use more than the Linux default of an 8 KiB alternate
;;     stack when deciding if a fault was caused by stack overflow.  */
;;  static max_align_t sigsegv_stack[(64 * 1024
;;  				  + sizeof (max_align_t) - 1)
;;  				 / sizeof (max_align_t)];


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
