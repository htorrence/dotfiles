(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(add-hook 'after-init-hook #'global-flycheck-mode)

;; VISUALS ;;
(transient-mark-mode 1)            ; makes the region visible
(column-number-mode 1)             ; makes the column number show up
(require 'linum)
(global-linum-mode 1)              ; show line numbers
(show-paren-mode 1)                ; show parentheses pairs
(delete-selection-mode 1)          ; enable delete selection with delete key
(menu-bar-mode 0)                  ; remove menu bar
(setq linum-format "%4d \u2502 ")  ; separate line numbers with bar


;; NAVIGATION ;;
(setq scroll-conservatively 10000) ; fix scroll speed
(setq mac-option-key-is-meta nil)  ; use esc as meta key
(setq mac-option-modifier nil)

;; GROOVY ;;
(require 'groovy-mode)
(add-to-list 'auto-mode-alist '("\\Jenkinsfile\\'" . groovy-mode))

;; JAVASCRIPT ;;
(add-hook 'js-mode-hook #'js-auto-format-mode)

;; BACKUPS ;;
;; Default and per-save backups go here:
(setq backup-directory-alist '(("" . "~/.emacs.d/backup/per-save")))
(setq auto-save-file-name-transforms `((".*" , "~/.emacs.d/backup/auto-save" t)))

(defun force-backup-of-buffer ()
  ;; Make a special "per session" backup at the first save of each
  ;; emacs session.
  (when (not buffer-backed-up)
    ;; Override the default parameters for per-session backups.
    (let ((backup-directory-alist '(("" . "~/.emacs.d/backup/per-session")))
          (kept-new-versions 3))
      (backup-buffer)))
  ;; Make a "per save" backup on each save.  The first save results in
  ;; both a per-session and a per-save backup, to keep the numbering
  ;; of per-save backups consistent.
  (let ((buffer-backed-up nil))
    (backup-buffer)))

(add-hook 'before-save-hook  'force-backup-of-buffer)

;; ALIASES ;;
(defalias 'r 'replace-string)
(defalias '/ 'comment-region)
(defalias '// 'uncomment-region)
(defalias 'i 'indent-code-rigidly)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (flycheck-apertium js-auto-format-mode groovy-mode dash))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
