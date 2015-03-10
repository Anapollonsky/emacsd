
;; Function to check whether emacs can connect to websites to verify internet connection.
;; Hangs on needproxy + GUI, so don't run it if graphical, only update if non-gui.

;; Package repositories
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;; (condition-case nil
;;     (progn 
;;       (shell-copy-environment-variable "http_proxy")
;;       (setq url-proxy-services '(("no_proxy" . "work\\.com")
;;                               ("http" . (getenv "http_proxy"))))
;;       (package-refresh-contents))
;;   (error nil))

(setq url-proxy-services '(("no_proxy" . "work\\.com")
			   ("http" . "global.proxy.lucent.com:8000")))

(package-refresh-contents)
(setq package-enable-at-startup nil)
(package-initialize)


;; Bootstrap use-package and dependencies.
(or (package-installed-p 'diminish) (package-install 'diminish))
(or (package-installed-p 'bind-key) (package-install 'bind-key))
(or (package-installed-p 'use-package) (package-install 'use-package))         
(require 'use-package)

;; Proceed with rest of initialization
 (org-babel-load-file "~/.emacs.d/initialization.org")
