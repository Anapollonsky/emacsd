;;; apples-gray.el --- A gray color theme for Emacs.

;; Theme based on Kelvin Smith's Monokai theme.
;; Version: 0.2

(unless (>= emacs-major-version 24)
  (error "The apples-gray theme requires Emacs 24 or later!"))

(deftheme apples-gray "The Apples-gray colour theme")

(defgroup apples-gray nil
  "Apples theme options.
The theme has to be reloaded after changing anything in this group."
  :group 'faces)

(defcustom apples-distinct-fringe-background nil
  "Make the fringe background different from the normal background color.
Also affects 'linum-mode' background."
  :type 'boolean
  :group 'apples-gray)

(defcustom apples-use-variable-pitch t
  "Use variable pitch face for some headings and titles."
  :type 'boolean
  :group 'apples-gray)

(defcustom apples-high-contrast-mode-line nil
  "Make the active/inactive mode line stand out more."
  :type 'boolean
  :group 'apples-gray)

(defcustom apples-height-minus-1 0.8
  "Font size -1."
  :type 'number
  :group 'apples-gray)

(defcustom apples-height-plus-1 1.1
  "Font size +1."
  :type 'number
  :group 'apples-gray)

(defcustom apples-height-plus-2 1.15
  "Font size +2."
  :type 'number
  :group 'apples-gray)

(defcustom apples-height-plus-3 1.2
  "Font size +3."
  :type 'number
  :group 'apples-gray)

(defcustom apples-height-plus-4 1.3
  "Font size +4."
  :type 'number
  :group 'apples-gray)

(defun in-terminal ()
  "Return true if in a terminal."
  (not (display-graphic-p)))

(defun create-apples-gray-theme (&optional frame)
  "Create the apples theme.
Takes and optional `FRAME' as reference."
  (let* ((class '((class color) (min-colors 89)))
         ;; Accented colors
         (yellow           (if (in-terminal) "#CDC673" "#E6DB74"))
         (orange           (if (in-terminal) "#FF8C00" "#FD971F"))
         (red              (if (in-terminal) "#FF3333" "#FF9999"))
         (magenta          (if (in-terminal) "#D700D7" "#FD5FF0"))
         (violet           (if (in-terminal) "#AF87FF" "#AE81FF"))
         (blue             (if (in-terminal) "#5FD7FF" "#66D9EF"))
         (cyan             (if (in-terminal) "#5FFFFF" "#A1EFE4"))
         (green            (if (in-terminal) "#87D700" "#A6E22E"))
         (gray             (if (in-terminal) "#444444" "#474747"))

         ;; Darker and lighter accented colors
         ;;
         ;; TODO: find terminal equivalents for all window colors (on the right)
         ;;
         (yellow-d         (if (in-terminal) "#968B26" "#968B26"))
         (yellow-l         (if (in-terminal) "#FFF68F" "#F3EA98"))
         (orange-d         (if (in-terminal) "#A0522D" "#A45E0A"))
         (orange-l         (if (in-terminal) "#FFA54F" "#FEB257"))
         (red-d            (if (in-terminal) "#5F0000" "#A20000"))
         (red-l            (if (in-terminal) "#EE0000" "#FF6666"))
         (magenta-d        (if (in-terminal) "#A41F99" "#A41F99"))
         (magenta-l        (if (in-terminal) "#FE87F4" "#FE87F4"))
         (violet-d         (if (in-terminal) "#562AA6" "#562AA6"))
         (violet-l         (if (in-terminal) "#C2A1FF" "#C2A1FF"))
         (blue-d           (if (in-terminal) "#21889B" "#21889B"))
         (blue-l           (if (in-terminal) "#8DE6F7" "#8DE6F7"))
         (cyan-d           (if (in-terminal) "#349B8D" "#349B8D"))
         (cyan-l           (if (in-terminal) "#AFEEEE" "#BBF7EF"))
         (green-d          (if (in-terminal) "#6B8E23" "#67930F"))
         (green-l          (if (in-terminal) "#B3EE3A" "#C1F161"))
         (gray-d           (if (in-terminal) "#3a3a3a" "#333333"))
         (gray-l           (if (in-terminal) "#6c6c6c" "#6b6b6b"))

         ;; Adaptive colors
         (apples-fg       (if (in-terminal) "#F5F5FF" "#F0F0FF"))
         (apples-bg       (if (in-terminal) "#1A1A22" "#1A1A22"))
         (apples-hl-line  (if (in-terminal) "#303038" "#303038"))
         (apples-hl       (if (in-terminal) "#606068" "#606068"))
         (apples-emph     (if (in-terminal) "#F8F8F8" "#F8F8F8"))
         (apples-comments (if (in-terminal) "#9595B5" "#9595B5"))

         ;; Adaptive higher/lower contrast accented colors
         (apples-fg-hc    (if (in-terminal) "171A0B" "#141414"))
         (apples-fg-lc    (if (in-terminal) "#141414" "#171A0B"))

         (yellow-hc        (if (in-terminal) yellow-d yellow-l))
         (yellow-lc        (if (in-terminal) yellow-l yellow-d))
         (orange-hc        (if (in-terminal) orange-d orange-l))
         (orange-lc        (if (in-terminal) orange-l orange-d))
         (red-hc           (if (in-terminal) red-d red-l))
         (red-lc           (if (in-terminal) red-l red-d))
         (magenta-hc       (if (in-terminal) magenta-d magenta-l))
         (magenta-lc       (if (in-terminal) magenta-l magenta-d))
         (violet-hc        (if (in-terminal) violet-d violet-l))
         (violet-lc        (if (in-terminal) violet-l violet-d))
         (blue-hc          (if (in-terminal) blue-d blue-l))
         (blue-lc          (if (in-terminal) blue-l blue-d))
         (cyan-hc          (if (in-terminal) cyan-d cyan-l))
         (cyan-lc          (if (in-terminal) cyan-l cyan-d))
         (green-hc         (if (in-terminal) green-d green-l))
         (green-lc         (if (in-terminal) green-l green-d))

         ;; customize based face properties
         (s-variable-pitch (if apples-use-variable-pitch
                               'variable-pitch 'default))
         (s-fringe-bg (if apples-distinct-fringe-background
                          apples-hl apples-bg))

         (s-mode-line-fg (if apples-high-contrast-mode-line
                             apples-bg apples-fg))
         (s-mode-line-bg (if apples-high-contrast-mode-line
                             apples-fg apples-hl-line))
         (s-mode-line-buffer-id-fg (if apples-high-contrast-mode-line
                                       'unspecified green))
         (s-mode-line-inactive-fg (if apples-high-contrast-mode-line
                                      apples-fg apples-comments))
         (s-mode-line-inactive-bg (if apples-high-contrast-mode-line
                                      apples-hl-line apples-bg))
         (s-mode-line-inactive-bc (if apples-high-contrast-mode-line
                                      apples-fg apples-hl-line)))
    (custom-theme-set-faces
     'apples-gray
     '(button ((t (:underline t))))

     ;; basic coloring
     `(default
        ((,class (:foreground ,apples-fg
                              :background ,apples-bg))))

     `(shadow
       ((,class (:foreground ,apples-comments))))

     `(match
       ((,class (:background ,apples-hl
                             :foreground ,apples-emph
                             :weight bold))))
 
     `(cursor
       ((,class (:foreground ,apples-bg
                             :background "#FF0000"
                             :inverse-video t))))

     `(mouse
       ((,class (:foreground ,apples-bg
                             :background ,apples-fg
                             :inverse-video t))))

     `(escape-glyph-face
       ((,class (:foreground ,red))))

     `(fringe
       ((,class (:foreground ,apples-fg
                             :background ,s-fringe-bg))))

     `(highlight
       ((,class (:background ,apples-hl))))

     `(link
       ((,class (:foreground ,blue
                             :underline t
                             :weight bold))))

     `(link-visited
       ((,class (:foreground ,blue
                             :underline t
                             :weight normal))))

     `(success
       ((,class (:foreground ,green ))))

     `(warning
       ((,class (:foreground ,yellow ))))

     `(error
       ((,class (:foreground ,orange))))

     `(lazy-highlight
       ((,class (:foreground ,apples-bg
                             :background ,yellow
                             :weight normal))))

     `(escape-glyph
       ((,class (:foreground ,violet))))

     ;; compilation
     `(compilation-column-face
       ((,class (:foreground ,cyan
                             :underline nil))))

     `(compilation-column-number
       ((,class (:inherit font-lock-doc-face
                          :foreground ,cyan
                          :underline nil))))

     `(compilation-enter-directory-face
       ((,class (:foreground ,green
                             :underline nil))))

     `(compilation-error
       ((,class (:inherit error
                          :underline nil))))

     `(compilation-error-face
       ((,class (:foreground ,red
                             :underline nil))))

     `(compilation-face
       ((,class (:foreground ,apples-fg
                             :underline nil))))

     `(compilation-info
       ((,class (:foreground ,apples-comments
                             :underline nil
                             :bold nil))))

     `(compilation-info-face
       ((,class (:foreground ,blue
                             :underline nil))))

     `(compilation-leave-directory-face
       ((,class (:foreground ,green
                             :underline nil))))

     `(compilation-line-face
       ((,class (:foreground ,green
                             :underline nil))))

     `(compilation-line-number
       ((,class (:foreground ,green
                             :underline nil))))

     `(compilation-warning
       ((,class (:inherit warning
                          :underline nil))))

     `(compilation-warning-face
       ((,class (:foreground ,yellow
                             :weight normal
                             :underline nil))))

     `(compilation-mode-line-exit
       ((,class (:inherit compilation-info
                          :foreground ,green
                          :weight bold))))

     `(compilation-mode-line-fail
       ((,class (:inherit compilation-error
                          :foreground ,red
                          :weight bold))))

     `(compilation-mode-line-run
       ((,class (:foreground ,orange
                             :weight bold))))

     ;; cua
     `(cua-global-mark
       ((,class (:background ,yellow
                             :foreground ,apples-bg))))

     `(cua-rectangle
       ((,class (:inherit region
                          :background ,magenta
                          :foreground ,apples-bg))))

     `(cua-rectangle-noselect
       ((,class (:inherit region
                          :background ,apples-hl
                          :foreground ,apples-comments))))

     ;; diary
     `(diary
       ((,class (:foreground ,yellow))))

     ;; dired
     `(dired-directory
       ((,class (:foreground ,blue
                             :weight normal))))

     `(dired-flagged
       ((,class (:foreground ,red))))

     `(dired-header
       ((,class (:foreground ,apples-bg
                             :background ,blue))))

     `(dired-ignored
       ((,class (:inherit shadow))))

     `(dired-mark
       ((,class (:foreground ,yellow
                             :weight bold))))

     `(dired-marked
       ((,class (:foreground ,magenta
                             :weight bold))))

     `(dired-perm-write
       ((,class (:foreground ,apples-fg
                             :underline t))))

     `(dired-symlink
       ((,class (:foreground ,cyan
                             :weight normal
                             :slant italic))))

     `(dired-warning
       ((,class (:foreground ,orange
                             :underline t))))

     ;; dropdown
     `(dropdown-list-face
       ((,class (:background ,apples-hl
                             :foreground ,cyan))))

     `(dropdown-list-selection-face
       ((,class (:background ,cyan-lc
                             :foreground ,cyan-hc))))

     ;; grep
     `(grep-context-face
       ((,class (:foreground ,apples-fg))))

     `(grep-error-face
       ((,class (:foreground ,red
                             :weight bold
                             :underline t))))

     `(grep-hit-face
       ((,class (:foreground ,blue))))

     `(grep-match-face
       ((,class (:foreground ,orange
                             :weight bold))))

     ;; faces used by isearch
     `(isearch
       ((,class (:foreground ,apples-bg
                             :background ,magenta
                             :weight normal))))

     `(isearch-fail
       ((,class (:foreground ,red
                             :background ,apples-bg
                             :bold t))))

     ;; man
     `(Man-overstrike
       ((,class (:foreground ,blue
                             :weight bold))))

     `(Man-reverse
       ((,class (:foreground ,orange))))

     `(Man-underline
       ((,class (:foreground ,green :underline t))))

     ;; misc faces
     `(menu
       ((,class (:foreground ,apples-fg
                             :background ,apples-bg))))

     `(minibuffer-prompt
       ((,class (:foreground ,blue))))

     `(mode-line
       ((,class (:inverse-video unspecified
                                :underline unspecified
                                :foreground ,s-mode-line-fg
                                :background ,s-mode-line-bg
                                :box (:line-width 1
                                                  :color ,s-mode-line-bg
                                                  :style unspecified)))))

     `(mode-line-buffer-id
       ((,class (:foreground ,s-mode-line-buffer-id-fg
                             :weight bold))))

     `(mode-line-inactive
       ((,class (:inverse-video unspecified
                                :underline unspecified
                                :foreground ,s-mode-line-inactive-fg
                                :background ,s-mode-line-inactive-bg
                                :box (:line-width 1
                                                  :color ,s-mode-line-inactive-bc
                                                  :style unspecified)))))

     `(header-line
       ((,class (:inverse-video unspecified
                                :underline unspecified
                                :foreground ,apples-emph
                                :background ,apples-hl
                                :box (:line-width 1
                                                  :color ,apples-hl
                                                  :style unspecified)))))

     `(region
       ((,class (:background ,apples-hl
                             :inherit t))))

     `(secondary-selection
       ((,class (:background ,apples-hl
                             :inherit t))))


     `(trailing-whitespace
       ((,class (:background ,red))))

     `(vertical-border
       ((,class (:foreground ,apples-hl))))

     ;; font lock
     `(font-lock-builtin-face
       ((,class (:foreground ,red
                             :weight normal))))

     `(font-lock-comment-delimiter-face
       ((,class (:foreground ,apples-comments))))

     `(font-lock-comment-face
       ((,class (:foreground ,apples-comments))))

     `(font-lock-constant-face
       ((,class (:foreground ,violet))))

     `(font-lock-doc-face
       ((,class (:foreground ,apples-comments))))

     `(font-lock-function-name-face
       ((,class (:foreground ,green))))

     `(font-lock-keyword-face
       ((,class (:foreground ,red
                             :weight normal))))

     `(font-lock-negation-char-face
       ((,class (:foreground ,yellow
                             :weight bold))))

     `(font-lock-preprocessor-face
       ((,class (:foreground ,red))))

     `(font-lock-regexp-grouping-construct
       ((,class (:foreground ,yellow
                             :weight normal))))

     `(font-lock-regexp-grouping-backslash
       ((,class (:foreground ,violet
                             :weight normal))))

     `(font-lock-string-face
       ((,class (:foreground ,yellow))))

     `(font-lock-type-face
       ((,class (:foreground ,blue
                             :italic t))))

     `(font-lock-variable-name-face
       ((,class (:foreground ,orange))))

     `(font-lock-warning-face
       ((,class (:foreground ,orange
                             :weight bold
                             :italic t
                             :underline t))))

     `(c-annotation-face
       ((,class (:inherit font-lock-constant-face))))


     ;;; external

     ;; ace-jump-mode
     `(ace-jump-face-background
       ((,class (:foreground ,apples-comments
                             :background ,apples-bg
                             :inverse-video nil))))

     `(ace-jump-face-foreground
       ((,class (:foreground ,red :background ,apples-bg
                             :inverse-video nil
                             :weight bold))))

     ;; auctex
     `(font-latex-bold-face
       ((,class (:inherit bold
                          :foreground ,apples-emph))))

     `(font-latex-doctex-documentation-face
       ((,class (:background unspecified))))

     `(font-latex-doctex-preprocessor-face
       ((,class
         (:inherit (font-latex-doctex-documentation-face
                    font-lock-builtin-face
                    font-lock-preprocessor-face)))))

     `(font-latex-italic-face
       ((,class (:inherit italic :foreground ,apples-emph))))

     `(font-latex-math-face
       ((,class (:foreground ,violet))))

     `(font-latex-sectioning-0-face
       ((,class (:inherit font-latex-sectioning-1-face
                          :height ,apples-height-plus-1))))

     `(font-latex-sectioning-1-face
       ((,class (:inherit font-latex-sectioning-2-face
                          :height ,apples-height-plus-1))))

     `(font-latex-sectioning-2-face
       ((,class (:inherit font-latex-sectioning-3-face
                          :height ,apples-height-plus-1))))

     `(font-latex-sectioning-3-face
       ((,class (:inherit font-latex-sectioning-4-face
                          :height ,apples-height-plus-1))))

     `(font-latex-sectioning-4-face
       ((,class (:inherit font-latex-sectioning-5-face
                          :height ,apples-height-plus-1))))

     `(font-latex-sectioning-5-face
       ((,class (:inherit ,s-variable-pitch :foreground ,yellow
                          :weight bold))))

     `(font-latex-sedate-face
       ((,class (:foreground ,apples-emph))))

     `(font-latex-slide-title-face
       ((,class (:inherit (,s-variable-pitch font-lock-type-face)
                          :weight bold
                          :height ,apples-height-plus-3))))

     `(font-latex-string-face
       ((,class (:foreground ,cyan))))

     `(font-latex-subscript-face
       ((,class (:height ,apples-height-minus-1))))

     `(font-latex-superscript-face
       ((,class (:height ,apples-height-minus-1))))

     `(font-latex-verbatim-face
       ((,class (:inherit fixed-pitch
                          :foreground ,apples-fg
                          :slant italic))))

     `(font-latex-warning-face
       ((,class (:inherit bold
                          :foreground ,orange))))

     ;; auto-complete
     `(ac-candidate-face
       ((,class (:background ,apples-hl
                             :foreground ,cyan))))

     `(ac-selection-face
       ((,class (:background ,cyan-lc
                             :foreground ,cyan-hc))))

     `(ac-candidate-mouse-face
       ((,class (:background ,cyan-hc
                             :foreground ,cyan-lc))))

     `(ac-completion-face
       ((,class (:foreground ,apples-emph
                             :underline t))))

     `(ac-gtags-candidate-face
       ((,class (:background ,apples-hl
                             :foreground ,blue))))

     `(ac-gtags-selection-face
       ((,class (:background ,blue-lc
                             :foreground ,blue-hc))))

     `(ac-yasnippet-candidate-face
       ((,class (:background ,apples-hl
                             :foreground ,yellow))))

     `(ac-yasnippet-selection-face
       ((,class (:background ,yellow-lc
                             :foreground ,yellow-hc))))

     ;; calfw
     `(cfw:face-day-title
       ((,class (:background ,apples-hl))))

     `(cfw:face-annotation
       ((,class (:inherit cfw:face-day-title
                          :foreground ,yellow))))

     `(cfw:face-default-content
       ((,class (:foreground ,green))))

     `(cfw:face-default-day
       ((,class (:inherit cfw:face-day-title
                          :weight bold))))

     `(cfw:face-disable
       ((,class (:inherit cfw:face-day-title
                          :foreground ,apples-comments))))

     `(cfw:face-grid
       ((,class (:foreground ,apples-comments))))

     `(cfw:face-header
       ((,class (:foreground ,blue-hc
                             :background ,blue-lc
                             :weight bold))))

     `(cfw:face-holiday
       ((,class (:background nil
                             :foreground ,red
                             :weight bold))))

     `(cfw:face-periods
       ((,class (:foreground ,magenta))))

     `(cfw:face-select
       ((,class (:background ,magenta-lc
                             :foreground ,magenta-hc))))

     `(cfw:face-saturday
       ((,class (:foreground ,cyan-hc
                             :background ,cyan-lc))))

     `(cfw:face-sunday
       ((,class (:foreground ,red-hc
                             :background ,red-lc :weight bold))))

     `(cfw:face-title
       ((,class (:inherit ,s-variable-pitch
                          :foreground ,yellow
                          :weight bold :height ,apples-height-plus-4))))

     `(cfw:face-today
       ((,class (:weight bold
                         :background ,apples-hl
                         :foreground nil))))

     `(cfw:face-today-title
       ((,class (:background ,yellow-lc
                             :foreground ,yellow-hc
                             :weight bold))))

     `(cfw:face-toolbar
       ((,class (:background ,apples-hl
                             :foreground ,apples-fg))))

     `(cfw:face-toolbar-button-off
       ((,class (:background ,yellow-lc
                             :foreground ,yellow-hc
                             :weight bold))))

     `(cfw:face-toolbar-button-on
       ((,class (:background ,yellow-hc
                             :foreground ,yellow-lc
                             :weight bold))))


     ;; company-mode
     `(company-tooltip
       ((,class (:background ,apples-hl
                             :foreground ,cyan))))

     `(company-tooltip-selection
       ((,class (:background ,cyan-lc
                             :foreground ,cyan-hc))))

     `(company-tooltip-mouse
       ((,class (:background ,cyan-hc
                             :foreground ,cyan-lc))))

     `(company-tooltip-common
       ((,class (:foreground ,apples-emph
                             :underline t))))

     `(company-tooltip-common-selection
       ((,class (:foreground ,apples-emph
                             :underline t))))

     `(company-preview
       ((,class (:background ,apples-hl
                             :foreground ,cyan))))

     `(company-preview-common
       ((,class (:foreground ,apples-emph
                             :underline t))))

     `(company-scrollbar-bg
       ((,class (:background ,gray-l))))

     `(company-scrollbar-fg
       ((,class (:background ,yellow-d))))

     ;; cscope
     `(cscope-file-face
       ((,class (:foreground ,green
                             :weight bold))))

     `(cscope-function-face
       ((,class (:foreground ,blue))))

     `(cscope-line-number-face
       ((,class (:foreground ,yellow))))

     `(cscope-line-face
       ((,class (:foreground ,apples-fg))))

     `(cscope-mouse-face
       ((,class (:background ,blue
                             :foreground ,apples-fg)))
                             :underline t)

     ;; custom
     `(custom-face-tag
       ((,class (:inherit ,s-variable-pitch
                          :height ,apples-height-plus-3
                          :foreground ,violet
                          :weight bold))))

     `(custom-variable-tag
       ((,class (:inherit ,s-variable-pitch
                          :foreground ,cyan
                          :height ,apples-height-plus-3))))

     `(custom-comment-tag
       ((,class (:foreground ,apples-comments))))

     `(custom-group-tag
       ((,class (:inherit ,s-variable-pitch
                          :foreground ,blue
                          :height ,apples-height-plus-3))))

     `(custom-group-tag-1
       ((,class (:inherit ,s-variable-pitch
                          :foreground ,red
                          :height ,apples-height-plus-3))))

     `(custom-state
       ((,class (:foreground ,green))))

     ;; diff
     `(diff-added
       ((,class (:foreground ,green
                             :background ,apples-bg))))

     `(diff-changed
       ((,class (:foreground ,blue
                             :background ,apples-bg))))

     `(diff-removed
       ((,class (:foreground ,red
                             :background ,apples-bg))))

     `(diff-header
       ((,class (:background ,apples-bg))))

     `(diff-file-header
       ((,class (:background ,apples-bg
                             :foreground ,apples-fg
                             :weight bold))))

     `(diff-refine-added
       ((,class :foreground ,apples-bg
                :background ,green)))

     `(diff-refine-change
       ((,class :foreground ,apples-bg
                :background ,blue)))

     `(diff-refine-removed
       ((,class (:foreground ,apples-bg
                             :background ,red))))

     ;; ediff
     `(ediff-fine-diff-A
       ((,class (:background ,orange-lc))))

     `(ediff-fine-diff-B
       ((,class (:background ,green-lc))))

     `(ediff-fine-diff-C
       ((,class (:background ,yellow-lc))))

     `(ediff-current-diff-C
       ((,class (:background ,blue-lc))))

     `(ediff-even-diff-A
       ((,class (:background ,apples-comments
                             :foreground ,apples-fg-lc ))))

     `(ediff-odd-diff-A
       ((,class (:background ,apples-comments
                             :foreground ,apples-fg-hc ))))

     `(ediff-even-diff-B
       ((,class (:background ,apples-comments
                             :foreground ,apples-fg-hc ))))

     `(ediff-odd-diff-B
       ((,class (:background ,apples-comments
                             :foreground ,apples-fg-lc ))))

     `(ediff-even-diff-C
       ((,class (:background ,apples-comments
                             :foreground ,apples-fg ))))

     `(ediff-odd-diff-C
       ((,class (:background ,apples-comments
                             :foreground ,apples-bg ))))

     ;; diff-hl
     `(diff-hl-change
       ((,class (:background ,blue-lc
                             :foreground ,blue-hc))))

     `(diff-hl-delete
       ((,class (:background ,red-lc
                             :foreground ,red-hc))))

     `(diff-hl-insert
       ((,class (:background ,green-lc
                             :foreground ,green-hc))))

     `(diff-hl-unknown
       ((,class (:background ,cyan-lc
                             :foreground ,cyan-hc))))


     ;; elfeed
     `(elfeed-search-date-face
       ((,class (:foreground ,apples-comments))))

     `(elfeed-search-feed-face
       ((,class (:foreground ,apples-comments))))

     `(elfeed-search-tag-face
       ((,class (:foreground ,apples-fg))))

     `(elfeed-search-title-face
       ((,class (:foreground ,cyan))))

     ;; epc
     `(epc:face-title
       ((,class (:foreground ,blue
                             :background ,apples-bg
                             :weight normal
                             :underline nil))))

     ;; erc
     `(erc-action-face
       ((,class (:inherit erc-default-face))))

     `(erc-bold-face
       ((,class (:weight bold))))

     `(erc-current-nick-face
       ((,class (:foreground ,blue :weight bold))))

     `(erc-dangerous-host-face
       ((,class (:inherit font-lock-warning-face))))

     `(erc-default-face
       ((,class (:foreground ,apples-fg))))

     `(erc-highlight-face
       ((,class (:inherit erc-default-face
                          :background ,apples-hl))))

     `(erc-direct-msg-face
       ((,class (:inherit erc-default-face))))

     `(erc-error-face
       ((,class (:inherit font-lock-warning-face))))

     `(erc-fool-face
       ((,class (:inherit erc-default-face))))

     `(erc-input-face
       ((,class (:foreground ,yellow))))

     `(erc-keyword-face
       ((,class (:foreground ,blue
                             :weight bold))))

     `(erc-nick-default-face
       ((,class (:foreground ,yellow
                             :weight bold))))

     `(erc-my-nick-face
       ((,class (:foreground ,red
                             :weight bold))))

     `(erc-nick-msg-face
       ((,class (:inherit erc-default-face))))

     `(erc-notice-face
       ((,class (:foreground ,green))))

     `(erc-pal-face
       ((,class (:foreground ,orange
                             :weight bold))))

     `(erc-prompt-face
       ((,class (:foreground ,orange
                             :background ,apples-bg
                             :weight bold))))

     `(erc-timestamp-face
       ((,class (:foreground ,green))))

     `(erc-underline-face ((t (:underline t))))

     ;; eshell
     `(eshell-prompt
       ((,class (:foreground ,yellow
                             :weight bold))))

     `(eshell-ls-archive
       ((,class (:foreground ,red
                             :weight bold))))

     `(eshell-ls-backup
       ((,class (:inherit font-lock-comment-face))))

     `(eshell-ls-clutter
       ((,class (:inherit font-lock-comment-face))))

     `(eshell-ls-directory
       ((,class (:foreground ,blue
                             :weight bold))))

     `(eshell-ls-executable
       ((,class (:foreground ,red
                             :weight bold))))

     `(eshell-ls-unreadable
       ((,class (:foreground ,apples-fg))))

     `(eshell-ls-missing
       ((,class (:inherit font-lock-warning-face))))

     `(eshell-ls-product
       ((,class (:inherit font-lock-doc-face))))

     `(eshell-ls-special
       ((,class (:foreground ,yellow
                             :weight bold))))

     `(eshell-ls-symlink
       ((,class (:foreground ,cyan
                             :weight bold))))

     ;; flymake
     `(flymake-errline
       ((,(append '((supports :underline (:style wave))) class)
         (:underline (:style wave :color ,red)
                     :inherit unspecified
                     :foreground unspecified
                     :background unspecified))
        (,class (:foreground ,red-hc
                             :background ,red-lc
                             :weight bold
                             :underline t))))

     `(flymake-infoline
       ((,(append '((supports :underline (:style wave))) class)
         (:underline (:style wave :color ,green)
                     :inherit unspecified
                     :foreground unspecified
                     :background unspecified))
        (,class (:foreground ,green-hc
                             :background ,green-lc))))

     `(flymake-warnline
       ((,(append '((supports :underline (:style wave))) class)
         (:underline (:style wave :color ,yellow)
                     :inherit unspecified
                     :foreground unspecified
                     :background unspecified))
        (,class (:foreground ,yellow-hc
                             :background ,yellow-lc
                             :weight bold
                             :underline t))))

     ;; flycheck
     `(flycheck-error
       ((,(append '((supports :underline (:style wave))) class)
         (:underline (:style wave :color ,red)
                     :inherit unspecified))
        (,class (:foreground ,red-hc
                             :background ,red-lc
                             :weight bold
                             :underline t))))

     `(flycheck-warning
       ((,(append '((supports :underline (:style wave))) class)
         (:underline (:style wave :color ,yellow)
                     :inherit unspecified))
        (,class (:foreground ,yellow-hc
                             :background ,yellow-lc
                             :weight bold
                             :underline t))))

     `(flycheck-info
       ((,(append '((supports :underline (:style wave))) class)
         (:underline (:style wave :color ,blue)
                     :inherit unspecified))
        (,class (:foreground ,blue-hc
                             :background ,blue-lc
                             :weight bold
                             :underline t))))

     `(flycheck-fringe-error
       ((,class (:foreground ,red-hc
                             :background ,red-lc
                             :weight bold))))

     `(flycheck-fringe-warning
       ((,class (:foreground ,yellow-hc
                             :background ,yellow-lc
                             :weight bold))))

     `(flycheck-fringe-info
       ((,class (:foreground ,blue-hc
                             :background ,blue-lc
                             :weight bold))))

     ;; flyspell
     `(flyspell-duplicate
       ((,(append '((supports :underline (:style wave))) class)
         (:underline (:style wave :color ,yellow)
                     :inherit unspecified))
        (,class (:foreground ,yellow
                             :weight bold
                             :underline t))))

     `(flyspell-incorrect
       ((,(append '((supports :underline (:style wave))) class)
         (:underline (:style wave :color ,red)
                     :inherit unspecified))
        (,class (:foreground ,red
                             :weight bold
                             :underline t))))


     ;; git-gutter
     `(git-gutter:added
       ((,class (:background ,green
                             :foreground ,apples-bg
                             :weight bold))))

     `(git-gutter:deleted
       ((,class (:background ,red
                             :foreground ,apples-bg
                             :weight bold))))

     `(git-gutter:modified
       ((,class (:background ,blue
                             :foreground ,apples-bg
                             :weight bold))))

     `(git-gutter:unchanged
       ((,class (:background ,apples-hl
                             :foreground ,apples-bg
                             :weight bold))))

     ;; git-gutter-fr
     `(git-gutter-fr:added
       ((,class (:foreground ,green
                             :weight bold))))

     `(git-gutter-fr:deleted
       ((,class (:foreground ,red
                             :weight bold))))

     `(git-gutter-fr:modified
       ((,class (:foreground ,blue
                             :weight bold))))
     ;; git-gutter+ and git-gutter+-fr
     `(git-gutter+-added
       ((,class (:background ,green
                             :foreground ,apples-bg
                             :weight bold))))
     `(git-gutter+-deleted
       ((,class (:background ,red
                             :foreground ,apples-bg
                             :weight bold))))
     `(git-gutter+-modified
       ((,class (:background ,blue
                             :foreground ,apples-bg
                             :weight bold))))
     `(git-gutter+-unchanged
       ((,class (:background ,apples-hl
                             :foreground ,apples-bg
                             :weight bold))))
     `(git-gutter-fr+-added
       ((,class (:foreground ,green
                             :weight bold))))
     `(git-gutter-fr+-deleted
       ((,class (:foreground ,red
                             :weight bold))))
     `(git-gutter-fr+-modified
       ((,class (:foreground ,blue
                             :weight bold))))

     ;; guide-key
     `(guide-key/highlight-command-face
       ((,class (:foreground ,blue))))

     `(guide-key/key-face
       ((,class (:foreground ,apples-comments))))

     `(guide-key/prefix-command-face
       ((,class (:foreground ,green))))

     ;; gnus
     `(gnus-group-mail-1
       ((,class (:weight bold
                         :inherit gnus-group-mail-1-empty))))

     `(gnus-group-mail-1-empty
       ((,class (:inherit gnus-group-news-1-empty))))

     `(gnus-group-mail-2
       ((,class (:weight bold
                         :inherit gnus-group-mail-2-empty))))

     `(gnus-group-mail-2-empty
       ((,class (:inherit gnus-group-news-2-empty))))

     `(gnus-group-mail-3
       ((,class (:weight bold
                         :inherit gnus-group-mail-3-empty))))

     `(gnus-group-mail-3-empty
       ((,class (:inherit gnus-group-news-3-empty))))

     `(gnus-group-mail-low
       ((,class (:weight bold
                         :inherit gnus-group-mail-low-empty))))

     `(gnus-group-mail-low-empty
       ((,class (:inherit gnus-group-news-low-empty))))

     `(gnus-group-news-1
       ((,class (:weight bold
                         :inherit gnus-group-news-1-empty))))

     `(gnus-group-news-2
       ((,class (:weight bold
                         :inherit gnus-group-news-2-empty))))

     `(gnus-group-news-3
       ((,class (:weight bold
                         :inherit gnus-group-news-3-empty))))

     `(gnus-group-news-4
       ((,class (:weight bold
                         :inherit gnus-group-news-4-empty))))

     `(gnus-group-news-5
       ((,class (:weight bold
                         :inherit gnus-group-news-5-empty))))

     `(gnus-group-news-6
       ((,class (:weight bold
                         :inherit gnus-group-news-6-empty))))

     `(gnus-group-news-low
       ((,class (:weight bold
                         :inherit gnus-group-news-low-empty))))

     `(gnus-header-content
       ((,class (:inherit message-header-other))))

     `(gnus-header-from
       ((,class (:inherit message-header-other))))

     `(gnus-header-name
       ((,class (:inherit message-header-name))))

     `(gnus-header-newsgroups
       ((,class (:inherit message-header-other))))

     `(gnus-header-subject
       ((,class (:inherit message-header-subject))))

     `(gnus-summary-cancelled
       ((,class (:foreground ,orange))))

     `(gnus-summary-high-ancient
       ((,class (:foreground ,blue
                             :weight bold))))

     `(gnus-summary-high-read
       ((,class (:foreground ,green
                             :weight bold))))

     `(gnus-summary-high-ticked
       ((,class (:foreground ,orange
                             :weight bold))))

     `(gnus-summary-high-unread
       ((,class (:foreground ,apples-fg
                             :weight bold))))

     `(gnus-summary-low-ancient
       ((,class (:foreground ,blue))))

     `(gnus-summary-low-read
       ((t (:foreground ,green))))

     `(gnus-summary-low-ticked
       ((,class (:foreground ,orange))))

     `(gnus-summary-low-unread
       ((,class (:foreground ,apples-fg))))

     `(gnus-summary-normal-ancient
       ((,class (:foreground ,blue))))

     `(gnus-summary-normal-read
       ((,class (:foreground ,green))))

     `(gnus-summary-normal-ticked
       ((,class (:foreground ,orange))))

     `(gnus-summary-normal-unread
       ((,class (:foreground ,apples-fg))))

     `(gnus-summary-selected
       ((,class (:foreground ,yellow
                             :weight bold))))

     `(gnus-cite-1
       ((,class (:foreground ,blue))))

     `(gnus-cite-2
       ((,class (:foreground ,blue))))

     `(gnus-cite-3
       ((,class (:foreground ,blue))))

     `(gnus-cite-4
       ((,class (:foreground ,green))))

     `(gnus-cite-5
       ((,class (:foreground ,green))))

     `(gnus-cite-6
       ((,class (:foreground ,green))))

     `(gnus-cite-7
       ((,class (:foreground ,red))))
 
     `(gnus-cite-8
       ((,class (:foreground ,red))))

     `(gnus-cite-9
       ((,class (:foreground ,red))))

     `(gnus-cite-10
       ((,class (:foreground ,yellow))))

     `(gnus-cite-11
       ((,class (:foreground ,yellow))))

     `(gnus-group-news-1-empty
       ((,class (:foreground ,yellow))))

     `(gnus-group-news-2-empty
       ((,class (:foreground ,green))))

     `(gnus-group-news-3-empty
       ((,class (:foreground ,green))))

     `(gnus-group-news-4-empty
       ((,class (:foreground ,blue))))

     `(gnus-group-news-5-empty
       ((,class (:foreground ,blue))))

     `(gnus-group-news-6-empty
       ((,class (:foreground ,blue-lc))))

     `(gnus-group-news-low-empty
       ((,class (:foreground ,apples-comments))))

     `(gnus-signature
       ((,class (:foreground ,yellow))))

     `(gnus-x-face
       ((,class (:background ,apples-fg
                             :foreground ,apples-bg))))


     ;; helm (these probably needs tweaking)
     `(helm-apt-deinstalled
       ((,class (:foreground ,apples-comments))))

     `(helm-apt-installed
       ((,class (:foreground ,green))))

     `(helm-bookmark-directory
       ((,class (:inherit helm-ff-directory))))

     `(helm-bookmark-file
       ((,class (:foreground ,apples-fg))))

     `(helm-bookmark-gnus
       ((,class (:foreground ,cyan))))

     `(helm-bookmark-info
       ((,class (:foreground ,green))))

     `(helm-bookmark-man
       ((,class (:foreground ,violet))))

     `(helm-bookmark-w3m
       ((,class (:foreground ,yellow))))

     `(helm-bookmarks-su
       ((,class (:foreground ,orange))))

     `(helm-buffer-not-saved
       ((,class (:foreground ,orange))))

     `(helm-buffer-saved-out
       ((,class (:foreground ,red
                             :background ,apples-bg
                             :inverse-video t))))

     `(helm-buffer-size
       ((,class (:foreground ,apples-comments))))

     `(helm-candidate-number
       ((,class (:background ,apples-hl
                             :foreground ,apples-emph
                             :bold t))))

     `(helm-ff-directory
       ((,class (:background ,apples-bg
                             :foreground ,blue))))

     `(helm-ff-executable
       ((,class (:foreground ,green))))

     `(helm-ff-file
       ((,class (:background ,apples-bg
                             :foreground ,apples-fg))))

     `(helm-ff-invalid-symlink
       ((,class (:background ,apples-bg
                             :foreground ,orange
                             :slant italic))))

     `(helm-ff-prefix
       ((,class (:background ,yellow
                             :foreground ,apples-bg))))

     `(helm-ff-symlink
       ((,class (:foreground ,cyan))))

     `(helm-grep-file
       ((,class (:foreground ,cyan
                             :underline t))))

     `(helm-grep-finish
       ((,class (:foreground ,green))))

     `(helm-grep-lineno
       ((,class (:foreground ,orange))))

     `(helm-grep-match
       ((,class (:inherit match))))

     `(helm-grep-running
       ((,class (:foreground ,red))))

     `(helm-header
       ((,class (:inherit header-line))))

     `(helm-lisp-completion-info
       ((,class (:foreground ,apples-fg))))

     `(helm-lisp-show-completion
       ((,class (:foreground ,yellow
                             :background ,apples-hl
                             :bold t))))

     `(helm-M-x-key
       ((,class (:foreground ,orange
                             :underline t))))

     `(helm-moccur-buffer
       ((,class (:foreground ,cyan
                             :underline t))))

     `(helm-match
       ((,class (:inherit match))))

     `(helm-selection
       ((,class (:background ,apples-hl
                             :underline t))))

     `(helm-selection-line
       ((,class (:background ,apples-hl
                             :foreground ,apples-emph
                             :underline nil))))

     `(helm-separator
       ((,class (:foreground ,red))))

     `(helm-source-header
       ((,class (:background ,blue-lc
                             :foreground ,apples-bg
                             :underline nil))))

     `(helm-swoop-target-line-face
       ((,class (:background ,apples-hl))))

     `(helm-swoop-target-line-block-face
       ((,class (:background ,apples-hl))))

     `(helm-swoop-target-word-face
       ((,class (:foreground ,magenta
                             :background unspecified))))

     `(helm-time-zone-current
       ((,class (:foreground ,green))))

     `(helm-time-zone-home
       ((,class (:foreground ,red))))

     `(helm-visible-mark
       ((,class (:background ,apples-bg
                             :foreground ,magenta :bold t))))

     ;; helm-ls-git
     `(helm-ls-git-modified-not-staged-face
       ((,class :foreground ,blue)))

     `(helm-ls-git-modified-and-staged-face
       ((,class :foreground ,blue-l)))

     `(helm-ls-git-renamed-modified-face
       ((,class :foreground ,blue-l)))

     `(helm-ls-git-untracked-face
       ((,class :foreground ,orange)))

     `(helm-ls-git-added-copied-face
       ((,class :foreground ,green)))

     `(helm-ls-git-added-modified-face
       ((,class :foreground ,green-l)))

     `(helm-ls-git-deleted-not-staged-face
       ((,class :foreground ,red)))

     `(helm-ls-git-deleted-and-staged-face
       ((,class :foreground ,red-l)))

     `(helm-ls-git-conflict-face
       ((,class :foreground ,yellow)))

     ;; hi-lock-mode
     `(hi-yellow
       ((,class (:foreground ,yellow-lc
                             :background ,yellow-hc))))

     `(hi-pink
       ((,class (:foreground ,magenta-lc
                             :background ,magenta-hc))))

     `(hi-green
       ((,class (:foreground ,green-lc
                             :background ,green-hc))))

     `(hi-blue
       ((,class (:foreground ,blue-lc
                             :background ,blue-hc))))

     `(hi-black-b
       ((,class (:foreground ,apples-emph
                             :background ,apples-bg
                             :weight bold))))

     `(hi-blue-b
       ((,class (:foreground ,blue-lc
                             :weight bold))))

     `(hi-green-b
       ((,class (:foreground ,green-lc
                             :weight bold))))

     `(hi-red-b
       ((,class (:foreground ,red
                             :weight bold))))

     `(hi-black-hb
       ((,class (:foreground ,apples-emph
                             :background ,apples-bg
                             :weight bold))))

     ;; highlight-changes
     `(highlight-changes
       ((,class (:foreground ,orange))))

     `(highlight-changes-delete
       ((,class (:foreground ,red
                             :underline t))))

     ;; highlight-indentation
     `(highlight-indentation-face
       ((,class (:background ,apples-hl))))

     `(highlight-indentation-current-column-face
       ((,class (:background ,apples-hl))))

     ;; hl-line-mode
     `(hl-line
       ((,class (:background ,apples-hl-line
                             :inherit t))))

     `(hl-line-face
       ((,class (:background ,apples-hl-line
                             :inherit t))))

     ;; js2-mode colors
     `(js2-error
       ((,class (:foreground ,red))))

     `(js2-external-variable
       ((,class (:foreground ,orange))))

     `(js2-function-param
       ((,class (:foreground ,green))))

     `(js2-instance-member
       ((,class (:foreground ,magenta))))

     `(js2-jsdoc-html-tag-delimiter
       ((,class (:foreground ,cyan))))

     `(js2-jsdoc-html-tag-name
       ((,class (:foreground ,orange))))

     `(js2-jsdoc-tag
       ((,class (:foreground ,cyan))))

     `(js2-jsdoc-type
       ((,class (:foreground ,blue))))

     `(js2-jsdoc-value
       ((,class (:foreground ,violet))))

     `(js2-magic-paren
       ((,class (:underline t))))

     `(js2-private-function-call
       ((,class (:foreground ,yellow))))

     `(js2-private-member
       ((,class (:foreground ,blue))))

     `(js2-warning
       ((,class (:underline ,orange))))

     ;; jedi
     `(jedi:highlight-function-argument
       ((,class (:inherit bold))))

     ;; linum-mode
     `(linum
       ((,class (:foreground ,apples-comments
                             :background ,s-fringe-bg))))

     ;; magit
     `(magit-section-title
       ((,class (:foreground ,yellow
                             :weight bold))))

     `(magit-branch
       ((,class (:foreground ,orange
                             :weight bold))))

     `(magit-item-highlight
       ((,class (:background ,apples-hl
                             :weight unspecified))))

     `(magit-log-author
       ((,class (:foreground ,cyan))))

     `(magit-log-graph
       ((,class (:foreground ,apples-comments))))

     `(magit-log-head-label-bisect-bad
       ((,class (:background ,red-hc
                             :foreground ,red-lc
                             :box 1))))

     `(magit-log-head-label-bisect-good
       ((,class (:background ,green-hc
                             :foreground ,green-lc
                             :box 1))))

     `(magit-log-head-label-default
       ((,class (:background ,apples-hl :box 1))))

     `(magit-log-head-label-local
       ((,class (:background ,blue-lc
                             :foreground ,blue-hc
                             :box 1))))

     `(magit-log-head-label-patches
       ((,class (:background ,red-lc
                             :foreground ,red-hc
                             :box 1))))

     `(magit-log-head-label-remote
       ((,class (:background ,green-lc
                             :foreground ,green-hc
                             :box 1))))

     `(magit-log-head-label-tags
       ((,class (:background ,yellow-lc
                             :foreground ,yellow-hc
                             :box 1))))

     `(magit-log-sha1
       ((,class (:foreground ,yellow))))

     ;; message-mode
     `(message-cited-text
       ((,class (:foreground ,apples-comments))))

     `(message-header-name
       ((,class (:foreground ,apples-comments))))

     `(message-header-other
       ((,class (:foreground ,apples-fg
                             :weight normal))))

     `(message-header-to
       ((,class (:foreground ,apples-fg
                             :weight normal))))

     `(message-header-cc
       ((,class (:foreground ,apples-fg
                             :weight normal))))

     `(message-header-newsgroups
       ((,class (:foreground ,yellow
                             :weight bold))))

     `(message-header-subject
       ((,class (:foreground ,cyan
                             :weight normal))))

     `(message-header-xheader
       ((,class (:foreground ,cyan))))

     `(message-mml
       ((,class (:foreground ,yellow
                             :weight bold))))

     `(message-separator
       ((,class (:foreground ,apples-comments
                             :slant italic))))

     ;; org-mode
     `(org-agenda-structure
       ((,class (:foreground ,apples-emph
                             :background ,apples-hl
                             :weight bold
                             :slant normal
                             :inverse-video nil
                             :height ,apples-height-plus-1
                             :underline nil
                             :box (:line-width 2 :color ,apples-bg)))))

     `(org-agenda-calendar-event
       ((,class (:foreground ,apples-emph))))

     `(org-agenda-calendar-sexp
       ((,class (:foreground ,apples-fg
                             :slant italic))))

     `(org-agenda-date
       ((,class (:foreground ,apples-comments
                             :background ,apples-bg
                             :weight normal
                             :inverse-video nil
                             :overline nil
                             :slant normal
                             :height 1.0
                             :box (:line-width 2 :color ,apples-bg)))) t)

     `(org-agenda-date-weekend
       ((,class (:inherit org-agenda-date
                          :inverse-video nil
                          :background unspecified
                          :foreground ,apples-comments
                          :weight unspecified
                          :underline t
                          :overline nil
                          :box unspecified))) t)

     `(org-agenda-date-today
       ((,class (:inherit org-agenda-date
                          :inverse-video t
                          :weight bold
                          :underline unspecified
                          :overline nil
                          :box unspecified
                          :foreground ,blue
                          :background ,apples-bg))) t)

     `(org-agenda-done
       ((,class (:foreground ,apples-comments
                             :slant italic))) t)

     `(org-archived
       ((,class (:foreground ,apples-comments
                             :weight normal))))

     `(org-block
       ((,class (:foreground ,apples-comments))))

     `(org-block-begin-line
       ((,class (:foreground ,apples-comments
                             :slant italic))))

     `(org-checkbox
       ((,class (:background ,apples-bg
                             :foreground ,apples-fg
                             :box (:line-width 1 :style released-button)))))

     `(org-code
       ((,class (:foreground ,apples-comments))))

     `(org-date
       ((,class (:foreground ,blue :underline t))))

     `(org-done
       ((,class (:weight bold :foreground ,green))))

     `(org-ellipsis
       ((,class (:foreground ,apples-comments))))

     `(org-formula
       ((,class (:foreground ,yellow))))

     `(org-headline-done
       ((,class (:foreground ,green))))

     `(org-hide
       ((,class (:foreground ,apples-bg))))

     `(org-level-1
       ((,class (:inherit ,s-variable-pitch
                          :height ,apples-height-plus-4
                          :foreground ,orange))))

     `(org-level-2
       ((,class (:inherit ,s-variable-pitch
                          :height ,apples-height-plus-3
                          :foreground ,green))))

     `(org-level-3
       ((,class (:inherit ,s-variable-pitch
                          :height ,apples-height-plus-2
                          :foreground ,blue))))

     `(org-level-4
       ((,class (:inherit ,s-variable-pitch
                          :height ,apples-height-plus-1
                          :foreground ,yellow))))

     `(org-level-5
       ((,class (:inherit ,s-variable-pitch
                          :foreground ,cyan))))

     `(org-level-6
       ((,class (:inherit ,s-variable-pitch
                          :foreground ,green))))

     `(org-level-7
       ((,class (:inherit ,s-variable-pitch
                          :foreground ,red))))

     `(org-level-8
       ((,class (:inherit ,s-variable-pitch
                          :foreground ,blue))))

     `(org-link
       ((,class (:foreground ,yellow
                             :underline t))))

     `(org-sexp-date
       ((,class (:foreground ,violet))))

     `(org-scheduled
       ((,class (:foreground ,green))))

     `(org-scheduled-previously
       ((,class (:foreground ,cyan))))

     `(org-scheduled-today
       ((,class (:foreground ,blue
                             :weight normal))))

     `(org-special-keyword
       ((,class (:foreground ,apples-comments
                             :weight bold))))

     `(org-table
       ((,class (:foreground ,green))))

     `(org-tag
       ((,class (:weight bold))))

     `(org-time-grid
       ((,class (:foreground ,apples-comments))))

     `(org-todo
       ((,class (:foreground ,red
                             :weight bold))))

     `(org-upcoming-deadline
       ((,class (:foreground ,yellow
                             :weight normal
                             :underline nil))))

     `(org-warning
       ((,class (:foreground ,orange
                             :weight normal
                             :underline nil))))

     ;; org-habit (clear=blue, ready=green, alert=yellow, overdue=red. future=lower contrast)
     `(org-habit-clear-face
       ((,class (:background ,blue-lc
                             :foreground ,blue-hc))))

     `(org-habit-clear-future-face
       ((,class (:background ,blue-lc))))

     `(org-habit-ready-face
       ((,class (:background ,green-lc
                             :foreground ,green))))

     `(org-habit-ready-future-face
       ((,class (:background ,green-lc))))

     `(org-habit-alert-face
       ((,class (:background ,yellow
                             :foreground ,yellow-lc))))

     `(org-habit-alert-future-face
       ((,class (:background ,yellow-lc))))

     `(org-habit-overdue-face
       ((,class (:background ,red
                             :foreground ,red-lc))))

     `(org-habit-overdue-future-face
       ((,class (:background ,red-lc))))

     ;; latest additions
     `(org-agenda-dimmed-todo-face
       ((,class (:foreground ,apples-comments))))

     `(org-agenda-restriction-lock
       ((,class (:background ,yellow))))

     `(org-clock-overlay
       ((,class (:background ,yellow))))

     `(org-column
       ((,class (:background ,apples-hl
                             :strike-through nil
                             :underline nil
                             :slant normal
                             :weight normal
                             :inherit default))))

     `(org-column-title
       ((,class (:background ,apples-hl
                             :underline t
                             :weight bold))))

     `(org-date-selected
       ((,class (:foreground ,red
                             :inverse-video t))))

     `(org-document-info
       ((,class (:foreground ,apples-fg))))

     `(org-document-title
       ((,class (:foreground ,apples-emph
                             :weight bold
                             :height ,apples-height-plus-4))))

     `(org-drawer
       ((,class (:foreground ,cyan))))

     `(org-footnote
       ((,class (:foreground ,magenta
                             :underline t))))

     `(org-latex-and-export-specials
       ((,class (:foreground ,orange))))

     `(org-mode-line-clock-overrun
       ((,class (:inherit mode-line
                          :background ,red))))

     ;; outline
     `(outline-1
       ((,class (:inherit org-level-1))))

     `(outline-2
       ((,class (:inherit org-level-2))))

     `(outline-3
       ((,class (:inherit org-level-3))))

     `(outline-4
       ((,class (:inherit org-level-4))))

     `(outline-5
       ((,class (:inherit org-level-5))))

     `(outline-6
       ((,class (:inherit org-level-6))))

     `(outline-7
       ((,class (:inherit org-level-7))))

     `(outline-8
       ((,class (:inherit org-level-8))))

     ;; parenfaceu
     `(paren-face
       ((,class (:foreground ,apples-comments))))

     ;; pretty-mode
     `(pretty-mode-symbol-face
       ((,class (:foreground ,yellow
                             :weight normal))))

     ;; popup
     `(popup-face
       ((,class (:background ,apples-hl
                             :foreground ,apples-fg))))

     `(popup-isearch-match
       ((,class (:background ,yellow
                             :foreground ,apples-bg))))

     `(popup-menu-face
       ((,class (:background ,apples-hl
                             :foreground ,apples-fg))))

     `(popup-menu-mouse-face
       ((,class (:background ,blue
                             :foreground ,apples-fg))))

     `(popup-menu-selection-face
       ((,class (:background ,magenta
                             :foreground ,apples-bg))))

     `(popup-scroll-bar-background-face
       ((,class (:background ,apples-comments))))

     `(popup-scroll-bar-foreground-face
       ((,class (:background ,apples-emph))))

     `(popup-tip-face
       ((,class (:background ,apples-hl
                             :foreground ,apples-fg))))

     ;; powerline
     `(powerline-active1
       ((,class (:background ,gray))))

     `(powerline-active2
       ((,class (:background ,gray-l))))

     `(powerline-inactive1
       ((,class (:background ,gray-d))))

     `(powerline-inactive2
       ((,class (:background ,gray))))

     ;; rainbow-delimiters
     `(rainbow-delimiters-depth-1-face
       ((,class (:foreground ,cyan))))

     `(rainbow-delimiters-depth-2-face
       ((,class (:foreground ,yellow))))

     `(rainbow-delimiters-depth-3-face
       ((,class (:foreground ,blue))))

     `(rainbow-delimiters-depth-4-face
       ((,class (:foreground ,orange))))

     `(rainbow-delimiters-depth-5-face
       ((,class (:foreground ,green))))

     `(rainbow-delimiters-depth-6-face
       ((,class (:foreground ,yellow))))

     `(rainbow-delimiters-depth-7-face
       ((,class (:foreground ,blue))))

     `(rainbow-delimiters-depth-8-face
       ((,class (:foreground ,orange))))

     `(rainbow-delimiters-depth-9-face
       ((,class (:foreground ,green))))

     `(rainbow-delimiters-depth-10-face
       ((,class (:foreground ,yellow))))

     `(rainbow-delimiters-depth-11-face
       ((,class (:foreground ,blue))))

     `(rainbow-delimiters-depth-12-face
       ((,class (:foreground ,orange))))

     `(rainbow-delimiters-unmatched-face
       ((,class (:foreground ,apples-fg
                             :background ,apples-bg
                             :inverse-video t))))

     ;; smartparens
     `(sp-pair-overlay-face
       ((,class (:background ,apples-hl))))

     `(sp-wrap-overlay-face
       ((,class (:background ,apples-hl))))

     `(sp-wrap-tag-overlay-face
       ((,class (:background ,apples-hl))))

     `(sp-show-pair-enclosing
       ((,class (:inherit highlight))))

     `(sp-show-pair-match-face

       ((,class (:foreground ,cyan
                             :background ,apples-bg
                             :weight normal
                             :inverse-video t))))

     `(sp-show-pair-mismatch-face
       ((,class (:foreground ,red
                             :background ,apples-bg
                             :weight normal
                             :inverse-video t))))

     ;; show-paren
     `(show-paren-match
       ((,class (:foreground ,cyan
                             :background ,apples-bg
                             :weight normal
                             :inverse-video t))))

     `(show-paren-mismatch
       ((,class (:foreground ,red
                             :background ,apples-bg
                             :weight normal
                             :inverse-video t))))

     ;; mic-paren
     `(paren-face-match

       ((,class (:foreground ,cyan
                             :background ,apples-bg
                             :weight normal
                             :inverse-video t))))

     `(paren-face-mismatch
       ((,class (:foreground ,red
                             :background ,apples-bg
                             :weight normal
                             :inverse-video t))))

     `(paren-face-no-match
       ((,class (:foreground ,red
                             :background ,apples-bg
                             :weight normal
                             :inverse-video t))))

     ;; SLIME
     `(slime-repl-inputed-output-face
       ((,class (:foreground ,red))))

     ;; speedbar
     `(speedbar-button-face
       ((,class (:inherit ,s-variable-pitch
                          :foreground ,apples-comments))))

     `(speedbar-directory-face
       ((,class (:inherit ,s-variable-pitch
                          :foreground ,blue))))

     `(speedbar-file-face
       ((,class (:inherit ,s-variable-pitch
                          :foreground ,apples-fg))))

     `(speedbar-highlight-face
       ((,class (:inherit ,s-variable-pitch
                          :background ,apples-hl))))

     `(speedbar-selected-face
       ((,class (:inherit ,s-variable-pitch
                          :foreground ,yellow
                          :underline t))))

     `(speedbar-separator-face
       ((,class (:inherit ,s-variable-pitch
                          :background ,blue
                          :foreground ,apples-bg
                          :overline ,cyan-lc))))

     `(speedbar-tag-face
       ((,class (:inherit ,s-variable-pitch
                          :foreground ,green
                          :weight normal))))

     ;; table
     `(table-cell
       ((,class (:foreground ,apples-fg
                             :background ,apples-hl))))

     ;; term
     `(term-color-black
       ((t (:foreground ,apples-bg
                        :background ,apples-hl))))

     `(term-color-red
       ((t (:foreground ,red
                        :background ,red-d))))

     `(term-color-green
       ((t (:foreground ,green
                        :background ,green-d))))

     `(term-color-yellow
       ((t (:foreground ,yellow
                        :background ,yellow-d))))

     `(term-color-blue
       ((t (:foreground ,blue
                        :background ,blue-d))))

     `(term-color-magenta
       ((t (:foreground ,magenta
                        :background ,magenta-d))))

     `(term-color-cyan
       ((t (:foreground ,cyan
                        :background ,cyan-d))))

     `(term-color-white
       ((t (:foreground ,apples-emph
                        :background ,apples-fg))))

     '(term-default-fg-color
       ((t (:inherit term-color-white))))

     '(term-default-bg-color
       ((t (:inherit term-color-black))))

     ;; tooltip. (NOTE: This setting has no effect on the os widgets for me
     ;; zencoding uses this)
     `(tooltip
       ((,class (:background ,yellow-lc
                             :foreground ,yellow-hc
                             :inherit ,s-variable-pitch))))

     ;; undo-tree
     `(undo-tree-visualizer-default-face
       ((,class (:foreground ,apples-comments
                             :background ,apples-bg))))

     `(undo-tree-visualizer-unmodified-face
       ((,class (:foreground ,green))))

     `(undo-tree-visualizer-current-face
       ((,class (:foreground ,blue
                             :inverse-video t))))

     `(undo-tree-visualizer-active-branch-face
       ((,class (:foreground ,apples-emph
                             :background ,apples-bg
                             :weight bold))))

     `(undo-tree-visualizer-register-face
       ((,class (:foreground ,yellow))))

     ;; volatile highlights
     `(vhl/default-face
       ((,class (:background ,green-lc
                             :foreground ,green-hc))))

     ;; whitespace-mode
     `(whitespace-space
       ((,class (:background ,apples-bg
                             :foreground "gray15"
                             :inverse-video unspecified
                             :slant italic))))

     `(whitespace-hspace
       ((,class (:background unspecified
                             :foreground ,apples-emph
                             :inverse-video unspecified))))

     `(whitespace-tab
       ((,class (:background unspecified
                             :foreground ,red
                             :inverse-video unspecified
                             :weight bold))))

     `(whitespace-newline
       ((,class(:background unspecified
                            :foreground ,apples-comments
                            :inverse-video unspecified))))

     `(whitespace-trailing
       ((,class (:background unspecified
                             :foreground ,orange-lc
                             :inverse-video t))))

     `(whitespace-line
       ((,class (:background unspecified
                             :foreground ,magenta
                             :inverse-video unspecified))))

     `(whitespace-space-before-tab
       ((,class (:background ,red-lc
                             :foreground unspecified
                             :inverse-video unspecified))))

     `(whitespace-indentation
       ((,class (:background unspecified
                             :foreground "gray18"
                             :inverse-video unspecified :weight bold))))

     `(whitespace-empty
       ((,class (:background unspecified
                             :foreground ,red-lc
                             :inverse-video t))))

     `(whitespace-space-after-tab
       ((,class (:background unspecified
                             :foreground ,orange
                             :inverse-video t
                             :weight bold))))

     ;; which-func-mode
     `(which-func
       ((,class (:foreground ,green))))

     ;; window-number-mode
     `(window-number-face
       ((,class (:foreground ,green))))

     ;; yascroll
     `(yascroll:thumb-text-area
       ((,class (:foreground ,apples-comments
                             :background ,apples-comments))))

     `(yascroll:thumb-fringe
       ((,class (:foreground ,apples-comments
                             :background ,apples-comments))))

     ;; zencoding
     `(zencoding-preview-input
       ((,class (:background ,apples-hl
                             :box ,apples-emph)))))

    (custom-theme-set-variables
     'apples-gray
     `(ansi-color-names-vector [,apples-bg ,red ,green ,yellow
                                            ,blue ,magenta ,cyan ,apples-fg])

     ;; compilation
     `(compilation-message-face 'default)

     ;; fill-column-indicator
     `(fci-rule-color ,apples-hl)

     ;; magit
     `(magit-diff-use-overlays nil)

     ;; highlight-changes
     `(highlight-changes-colors '(,magenta ,violet))

     ;; highlight-tail
     `(highlight-tail-colors
       '((,apples-hl . 0)(,green-lc . 20)(,cyan-lc . 30)(,blue-lc . 50)
         (,yellow-lc . 60)(,orange-lc . 70)(,magenta-lc . 85)(,apples-hl . 100)))

     ;; vc
     `(vc-annotate-color-map
       '((20 . ,red)
         (40 . "#CF4F1F")
         (60 . "#C26C0F")
         (80 . ,yellow)
         (100 . "#AB8C00")
         (120 . "#A18F00")
         (140 . "#989200")
         (160 . "#8E9500")
         (180 . ,green)
         (200 . "#729A1E")
         (220 . "#609C3C")
         (240 . "#4E9D5B")
         (260 . "#3C9F79")
         (280 . ,cyan)
         (300 . "#299BA6")
         (320 . "#2896B5")
         (340 . "#2790C3")
         (360 . ,blue)))
     `(vc-annotate-very-old-color nil)
     `(vc-annotate-background nil))))

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(create-apples-gray-theme)

(add-hook 'server-visit-hook 'create-apples-gray-theme )

(provide-theme 'apples-gray)

;; Local Variables:
;; no-byte-compile: t
;; eval: (when (fboundp 'rainbow-mode) (rainbow-mode 1))
;; fill-column: 95
;; End:

;;; apples-gray-theme.el ends here
