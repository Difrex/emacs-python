;;; python-config.el --- Configure python mode
;;; Commentary:
;; Configure python completion
;;; Code:

;; Python mode hook
(defun my-python-mode-hook ()
    "Define hook."

    (use-package flymake-python-pyflakes
        :config
        (setq flymake-python-pyflakes-executable "flake8")
        (setq flymake-python-pyflakes-extra-arguments '("--max-line-length=99"))
        (flymake-python-pyflakes-load))

    (use-package py-autopep8
        :config
        (setq py-autopep8-options '("--max-line-length=99"))
        (py-autopep8-enable-on-save))

    ;; Enable rainbow
    (rainbow-delimiters-mode-enable)

    (setq-default py-shell-name "ipython")
    (setq-default py-which-bufname "IPython")
    ;; Fill column indicator
    (use-package fill-column-indicator
        :init
        :config
        (setq-default fill-column 99)
        (setq fci-rule-width 1)
        (setq fci-rule-color "#696969"))

    (fci-mode)

    (anaconda-mode +1)
    (company-mode)
    (anaconda-eldoc-mode)
    (highlight-symbol-mode +1))

(defun configure-python-packages ()
    "Install and configure python packages."
    ;; We use company for completion
    (use-package company)
    (use-package anaconda-mode)
    (use-package company-anaconda
        :config
        (add-to-list 'company-backends '(company-anaconda :with company-capf)))

    ;; Colorize braces
    (use-package rainbow-delimiters)
    (use-package highlight-symbol)

    (use-package jedi
        :init
        (jedi:install-server)
        :config
        (setq jedi:complete-on-dot t))

    (use-package python
        :mode ("\\.py\\'" . python-mode)
        :interpreter ("python" . python-mode)
        :init
        (add-hook 'python-mode-hook 'my-python-mode-hook))

    (use-package anaconda-mode
        :bind (("M-," . anaconda-mode-go-back)))

    (use-package pythonic
        :config
        (progn
            (define-key python-mode-map (kbd "C-c M-i")
                'company-complete)
            (define-key python-mode-map (kbd "C-j")
                'indent-new-comment-line)
            (define-key python-mode-map (kbd "M-j")
                'electric-newline-and-maybe-indent)
            (define-key python-mode-map (kbd "M-,")
                'anaconda-mode-go-back))))

(provide 'python-config)

;;; python-config.el ends here
