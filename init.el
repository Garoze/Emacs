(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

(setq gc-cons-threshold 80000000)
(setq read-process-output-max (* 1024 1024))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-keybinding nil)
  (setq evil-search-module 'evil-search)
  (setq evil-split-window-below t)
  (setq evil-vsplit-window-right t)
  (unless (display-graphic-p)
    (setq evil-want-C-i-jump nil))
  :config
  (evil-mode 1))

;; (with-eval-after-load 'evil-maps (define-key evil-motion-state-map (kbd "TAB") nil))

(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "SPC") nil)
  (define-key evil-motion-state-map (kbd "RET") nil)
  (define-key evil-motion-state-map (kbd "TAB") nil))

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-quickscope
  :after evil
  :config
  :hook
  ((prog-mode  . turn-on-evil-quickscope-mode)
   (LaTeX-mode . turn-on-evil-quickscope-mode)
   (org-mode   . turn-on-evil-quickscope-mode)))

(use-package evil-lion
  :config
  (evil-lion-mode))

(define-key evil-normal-state-map (kbd "g l") 'evil-lion-left)
(define-key evil-normal-state-map (kbd "g L") 'evil-lion-right)
(define-key evil-visual-state-map (kbd "g l") 'evil-lion-left)
(define-key evil-visual-state-map (kbd "g L") 'evil-lion-right)

(use-package evil-collection
  :after evil
  :config
  (setq evil-collection-mode-list '(calendar dashboard dired ediff info magit ibuffer org compile))
  (evil-collection-init))

(use-package evil-org
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda () (evil-org-set-key-theme))))


(use-package vertico
  :custom
  (vertico-scroll-margin 0)
  (vertico-count 20)
  (vertico-resize t)
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package savehist
  :init
  (savehist-mode))

(use-package orderless
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package marginalia
  :config
  (marginalia-mode))

(tool-bar-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode 0)

(setq inhibit-startup-message t
      initial-scratch-message ""
      initial-major-mode 'org-mode
      inhibit-splash-screen t)

(defun setup-scratch-buffer ()
  "Set up the scratch buffer in org-mode with a title and move to the next line."
  (with-current-buffer "*scratch*"
    (goto-char (point-max))
    (insert "#+TITLE: Scratch\n\n")))

(add-hook 'emacs-startup-hook 'setup-scratch-buffer)

(setq-default visible-bell t)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

(use-package all-the-icons
  :if
  (display-graphic-p))

(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-one t)

  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

(use-package doom-modeline
  :init
  (doom-modeline-mode 1))

(set-face-attribute 'default nil
                    :font "JetBrains Mono"
                    :height 110
                    :weight 'medium)

(set-face-attribute 'variable-pitch nil
                    :font "Ubuntu"
                    :height 120
                    :weight 'medium)

(set-face-attribute 'fixed-pitch nil
                    :font "JetBrains Mono"
                    :height 110
                    :weight 'medium)

(set-face-attribute 'font-lock-comment-face nil
                    :slant 'italic)

(set-face-attribute 'font-lock-keyword-face nil
                    :slant 'italic)

(add-to-list 'default-frame-alist '(font . "JetBrains Mono-12"))
(setq-default line-spacing 0.12)

(global-prettify-symbols-mode 1)

(use-package ligature
  :config
  (ligature-set-ligatures 'prog-mode '("--" "---" "==" "===" "!=" "!==" "=!="
                                       "=:=" "=/=" "<=" ">=" "&&" "&&&" "&=" "++" "+++" "***" ";;" "!!"
                                       "??" "???" "?:" "?." "?=" "<:" ":<" ":>" ">:" "<:<" "<>" "<<<" ">>>"
                                       "<<" ">>" "||" "-|" "_|_" "|-" "||-" "|=" "||=" "##" "###" "####"
                                       "#{" "#[" "]#" "#(" "#?" "#_" "#_(" "#:" "#!" "#=" "^=" "<$>" "<$"
                                       "$>" "<+>" "<+" "+>" "<*>" "<*" "*>" "</" "</>" "/>" "<!--" "<#--"
                                       "-->" "->" "->>" "<<-" "<-" "<=<" "=<<" "<<=" "<==" "<=>" "<==>"
                                       "==>" "=>" "=>>" ">=>" ">>=" ">>-" ">-" "-<" "-<<" ">->" "<-<" "<-|"
                                       "<=|" "|=>" "|->" "<->" "<~~" "<~" "<~>" "~~" "~~>" "~>" "~-" "-~"
                                       "~@" "[||]" "|]" "[|" "|}" "{|" "[<" ">]" "|>" "<|" "||>" "<||"
                                       "|||>" "<|||" "<|>" "..." ".." ".=" "..<" ".?" "::" ":::" ":=" "::="
                                       ":?" ":?>" "//" "///" "/*" "*/" "/=" "//=" "/==" "@_" "__" "???"
                                       "<:<" ";;;"))
  (global-ligature-mode t))

(setq  x-meta-keysym 'super
       x-super-keysym 'meta)

(use-package general
  :config
  (general-evil-setup)

  (general-create-definer nl/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "M-SPC")

  (nl/leader-keys
    "SPC" '(execute-extended-command :wk "M-x")
    "." '(find-file :wk "Find file")
    "f c" '((lambda () (interactive) (find-file "~/.emacs.d/init.el")) :wk "Edit emacs config")
    "c" '(comment-line :wk "Comment lines"))

  (nl/leader-keys
    "b" '(:ignore t :wk "buffer")
    "b b" '(switch-to-buffer :wk "Switch buffer")
    "b i" '(ibuffer :wk "Ibuffer")
    "b k" '(kill-this-buffer :wk "Kill this buffer")
    "b n" '(next-buffer :wk "Next buffer")
    "b p" '(previous-buffer :wk "Previous buffer")
    "b r" '(revert-buffer :wk "Reload buffer"))

  (nl/leader-keys
    "e" '(:ignore t :wk "Evaluate")
    "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
    "e d" '(eval-defun :wk "Evaluate defun containing or after point")
    "e e" '(eval-expression :wk "Evaluate and elisp expression")
    "e l" '(eval-last-sexp :wk "Evaluate elisp expression before point")
    "e r" '(eval-region :wk "Evaluate elisp in region"))

  (nl/leader-keys
    "g" '(:ignore t :wk "Git")
    "g g" '(magit-status :wk "Magit Status"))

  (nl/leader-keys
    "h" '(:ignore t :wk "Help")
    "h f" '(describe-function :wk "Describe function")
    "h v" '(describe-variable :wk "Describe variable")
    "h k" '(describe-key :wk "Describe keybind")
    "h r r" '(reload-init-file :wk "Reload emacs  onfig"))

  (nl/leader-keys
    "i" '(:ignore t :wk "Indent")
    "i r" '(indent-region :wk "Indent Region"))

  (nl/leader-keys
    "l" '(:ignore t :wk "Literate-calc")
    "l m" '(literate-calc-minor-mode :wk "Literate-calc mode")
    "l l" '(literate-calc-eval-line :wk "Literate-calc eval line"))

  (nl/leader-keys
    "t" '(:ignore t :wk "Toggle")
    "t l" '(display-line-numbers-mode :wk "Toggle line numbers")
    "t t" '(visual-line-mode :wk "Toggle truncated lines"))

  (nl/leader-keys
    "w" '(:ignore t :wk "Windows")
    ;; Window splits
    "w c" '(evil-window-delete :wk "Close window")
    "w n" '(evil-window-new :wk "New window")
    "w s" '(evil-window-split :wk "Horizontal split window")
    "w v" '(evil-window-vsplit :wk "Vertical split window")
    ;; Window motions
    "w h" '(evil-window-left :wk "Window left")
    "w j" '(evil-window-down :wk "Window down")
    "w k" '(evil-window-up :wk "Window up")
    "w l" '(evil-window-right :wk "Window right")
    "w w" '(evil-window-next :wk "Goto next window")
    ;; Move Windows
    "w H" '(buf-move-left :wk "Buffer move left")
    "w J" '(buf-move-down :wk "Buffer move down")
    "w K" '(buf-move-up :wk "Buffer move up")
    "w L" '(buf-move-right :wk "Buffer move right"))
  )

(defun reload-init-file ()
  (interactive)
  (load-file user-init-file))

(use-package org-bullets)
(add-hook 'org-mode-hook
          (lambda () (org-bullets-mode 1)))

(use-package toc-org
  :commands toc-org-enable
  :init
  (add-hook 'org-mode-hook 'toc-org-enable))

(add-hook 'org-mode-hook 'org-indent-mode)

(require 'org-tempo)

(use-package org-auto-tangle
  :hook
  (org-mode . org-auto-tangle-mode))

(electric-pair-mode 1)
(electric-indent-mode t)

(add-hook 'org-mode-hook (lambda ()
                           (setq-local electric-pair-inhibit-predicate
                                       `(lambda (c)
                                          (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))

(global-set-key [escape] 'keyboard-escape-quit)

(setq org-return-follows-link t)
(setq org-confirm-babel-evaluate nil)

(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :height 1.5))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.4))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.3))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.3))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.2))))
 '(org-level-6 ((t (:inherit outline-5 :height 1.1))))
 '(org-level-7 ((t (:inherit outline-5 :height 1.1)))))

(use-package winum
  :config
  (global-set-key (kbd "M-1") 'winum-select-window-1)
  (global-set-key (kbd "M-2") 'winum-select-window-2)
  (global-set-key (kbd "M-3") 'winum-select-window-3)
  (global-set-key (kbd "M-4") 'winum-select-window-4)
  (setq window-numbering-scope            'global
        winum-reverse-frame-list          nil
        winum-auto-assign-0-to-minibuffer t
        winum-auto-setup-mode-line        t
        winum-format                      " %s "
        winum-mode-line-position          1
        winum-ignored-buffers             '(" *which-key*")
        winum-ignored-buffers-regexp      '(" \\*Treemacs-.*"))
  (winum-mode))

(use-package breadcrumb
  :config
  (setq which-func-functions #'(breadcrumb-imenu-crumbs))
  (breadcrumb-mode))

(use-package which-key
  :init
  (which-key-mode 1)
  :diminish
  :config
  (setq which-key-side-window-location 'bottom
        which-key-sort-order #'which-key-key-order-alpha
        which-key-allow-imprecise-window-fit nil
        which-key-sort-uppercase-first nil
        which-key-add-column-padding 1
        which-key-max-display-columns nil
        which-key-min-display-lines 6
        which-key-side-window-slot -10
        which-key-side-window-max-height 0.25
        which-key-idle-delay 0.8
        which-key-max-description-length 25
        which-key-allow-imprecise-window-fit nil
        which-key-separator " ? " ))

(use-package magit)
(define-key transient-base-map (kbd "<escape>") 'transient-quit-one)

(use-package company
  :config
  ;; Remove the M-n option to select since i'm using winum
  (company-keymap--unbind-quick-access company-active-map)
  ;; (company-tng-configure-default)
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay .1)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  (global-company-mode t))

(use-package company-box
  :after company
  :hook
  (company-mode . company-box-mode))

(defun delete-carrage-returns ()
  (interactive)
  (save-excursion
    (goto-char 0)
    (while (search-forward "\r" nil :noerror)
      (replace-match ""))))

(use-package literate-calc-mode
  :config
  (setq literate-calc-mode-inhibit-in-src-blocks t)
  (setq literate-calc-mode-inhibit-in-latex t))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

(setq make-lockfiles nil
      make-backup-files nil
      auto-save-default nil)

(setq compilation-scroll-output t)

(require 'ansi-color)
(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)
