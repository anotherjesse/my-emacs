(provide 'flymake_config)

(require 'flymake)
(defun flymake-erlang-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
         'flymake-create-temp-inplace))
   (local-file (file-relative-name temp-file
    (file-name-directory buffer-file-name))))
    (list "~/.emacs.d/eflymake" (list local-file))))

(add-to-list 'flymake-allowed-file-name-masks '("\\.erl\\'" flymake-erlang-init))

