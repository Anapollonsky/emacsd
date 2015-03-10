;; Function to check whether emacs can connect to websites to verify internet connection.
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
(package-refresh-contents)

;; Bootstrap use-package and dependencies.
(or (package-installed-p 'diminish) (package-install 'diminish))
(or (package-installed-p 'bind-key) (package-install 'bind-key))
(or (package-installed-p 'use-package) (package-install 'use-package))
         
(require 'use-package)

;; Proceed with rest of initialization
 (org-babel-load-file "~/.emacs.d/initialization.org")
