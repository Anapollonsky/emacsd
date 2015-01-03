;; Work Proxy
;; (setq url-proxy-services '(("no_proxy" . "work\\.com")
;;                            ("http" . "global.proxy.lucent.com:8000")))

;; Package repositories
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")))

;; Single package to auto-install package if not present. Only used to bootstrap use-package.

(setq package-enable-at-startup nil)
(package-initialize)


;; Automatically install use-package
(or (package-installed-p 'use-package) (package-install 'use-package))
(require 'use-package)

;; Proceed with rest of initialization
 (org-babel-load-file "~/.emacs.d/initialization.org")
