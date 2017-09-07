(add-to-list 'load-path "~/dotfiles/emacs.d/lisp")

;; VISUALS ;;
(transient-mark-mode 1) ; makes the region visible
(column-number-mode 1)  ; makes the column number show up

(require 'linum)
(global-linum-mode 1)   ; show line numbers
(show-paren-mode 1)
(menu-bar-mode 0)
(setq linum-format "%d \u2502 ") ; seperate line numbers with bar
(setq mac-option-key-is-meta nil)
;;(setq mac-command-key-is-meta 1)
;;(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

;; NAVIGATION ;;
;; (add-to-list 'load-path "~/.emacs.d/lisp")
;; (require 'no-easy-keys)
;; (no-easy-keys 1)
(setq scroll-conservatively 10000)

;; LUA ;;
(add-to-list 'load-path "~/lua-mode")
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;; BACKUPS ;;
;; Default and per-save backups go here:
(setq backup-directory-alist '(("" . "~/.emacs.d/backup/per-save")))

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
