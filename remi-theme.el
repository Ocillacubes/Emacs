(require 'autothemer)

(autothemer-deftheme
remi "For those who fear the sun"
((((class color) (min-colors #xFFFFFF))) ;; Make scheme work only with gui emacs
(remi-bg            "#303044")
(remi-text-default  "#c6a2e0")
(remi-comment       "#dbcedd")
(remi-cursor        "#b187df")
(remi-string        "#AFD9FE")
(remi-keyword       "#fd4251")
(remi-func_name     "#fe717d")
(remi-var_name      "#ffbec3")
(remi-button        "#d9fff8")
(remi-builtin       "#9c80f7")
)

((default                       (:foreground remi-text-default :background remi-bg))
 (cursor                        (:background remi-cursor))
 (font-lock-comment-face        (:foreground remi-comment))
 (font-lock-string-face         (:foreground remi-string))
 (font-lock-keyword-face        (:foreground remi-keyword))
 (font-lock-function-name-face  (:foreground remi-func_name))
 (font-lock-variable-name-face  (:foreground remi-var_name))
 (font-lock-builtin-face        (:foreground remi-builtin))
 (button                        (:foreground remi-button))
 ))

(provide-theme 'remi)
