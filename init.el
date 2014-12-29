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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("756597b162f1be60a12dbd52bab71d40d6a2845a3e3c2584c6573ee9c332a66e" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" default)))
 '(magit-use-overlays nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
