;; #### Melpa Package Support ####

(require 'package)

;; Adds the Melpa archive to the list of available repositories
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)


;; Initializes the package infrastructure
(package-initialize)


;; If there are no archived package contents, refresh them
(when (not package-archive-contents)
  (package-refresh-contents))

;; MyPackages contains a list of package names
(defvar myPackages
  '(better-defaults                 ;; Set up some better Emacs defaults
    material-theme                  ;; Theme
    nordic-night-theme
    eglot
    )
  )


;; Scans the list in myPackages
;; If the package listed is not already installed, install it
(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)


;; User Customizations:


;; VISUALS ;;
(load-theme 'nordic-night t)       ; Load theme
(transient-mark-mode 1)            ; makes the region visible
(column-number-mode 1)             ; makes the column number show up
(show-paren-mode 1)                ; show parentheses pairs
(delete-selection-mode 1)          ; enable delete selection with delete key
(menu-bar-mode 0)                  ; remove menu bar
(global-display-line-numbers-mode)

;; NAVIGATION ;;
(setq scroll-conservatively 10000) ; fix scroll speed
(setq mac-option-key-is-meta nil)  ; use esc as meta key
(setq mac-option-modifier nil)

;; PYTHON LINTING ;;
(add-hook 'python-mode-hook 'eglot-ensure)
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(python-mode . ("ruff" "server")))
  (add-hook 'after-save-hook 'eglot-format))

;; JS CONFIG ;;
(setq js-indent-level 2)


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
(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(nordic-night-theme ruff-format material-theme eglot better-defaults)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
