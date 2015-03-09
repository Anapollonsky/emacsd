(require 'cl-lib)
(defun can-retrieve-packages ()
  (cl-loop for url in '("http://melpa.milkbox.net/packages/"
                        "http://elpa.gnu.org/packages/")
           do (condition-case e
                  (kill-buffer (url-retrieve-synchronously url))
                (error (cl-return)))
           finally (cl-return t)))


;; Work Proxy
(when (not (can-retrieve-packages))
(setq url-proxy-services '(("no_proxy" . "work\\.com")
                           ("http" . "global.proxy.lucent.com:8000"))) )

;; Package repositories
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")))

(setq package-enable-at-startup nil)
(package-initialize)

;; Single package to auto-install package if not present. Only used to bootstrap use-package.
(or (package-installed-p 'use-package) (package-install 'use-package))
(require 'use-package)

;; Proceed with rest of initialization
 (org-babel-load-file "~/.emacs.d/initialization.org")
