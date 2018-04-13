(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

; LOAD f90-mode BY DEFAULT FOR FILE *.F90
(setq auto-mode-alist (cons '(".F90$" . f90-mode) auto-mode-alist))
(setq auto-mode-alist (cons '(".F90.bpp$" . f90-mode) auto-mode-alist))

(setq auto-mode-alist (cons '("\\.f90$" . f90-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.f$" . f90-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.F90$" . f90-mode) auto-mode-alist))

(setq f90-type-indent 2)
(setq f90-program-indent 2)
(setq f90-do-indent 2)
(setq f90-if-indent 2)
(setq f90-continuation-indent 4)
(setq f90-comment-indent-style nil)
(setq f90-directive-comment-re "![A-Z]*$.*")
(setq f90-continuation-char 38)

(require 'color-theme)
(color-theme-initialize)
(color-theme-arjen)

(setq show-paren-delay 0)
(show-paren-mode 1)

;; show line number
(add-hook 'prog-mode-hook 'linum-mode)

(add-to-list 'load-path "~/.emacs.d/site-lisp/php-mode")
(require 'php-mode)

;; Don't use TAB
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Python Hook
(add-hook 'python-mode-hook '(lambda () 
  (setq python-indent 4)))

;; Rust mdoe
(add-to-list 'load-path "/home/frozar/.emacs.d/rust-mode/")
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
