(defun htmlize-region-snippet (beg end)
  "Htmlize region and put into <pre> tag style that is left in <body> tag
plus add font-size: 8pt"
  (interactive "r")
  (let* ((buffer-faces (htmlize-faces-in-buffer))
         (face-map (htmlize-make-face-map (adjoin 'default buffer-faces)))
         (pre-tag (format
                   "<pre style=\"%s\">"
                   (mapconcat #'identity (htmlize-css-specs
                                          (gethash 'default face-map)) " ")))
         (htmlized-reg (htmlize-region-for-paste beg end)))
    (switch-to-buffer-other-window "*htmlized output*")
    ; clear buffer
    (kill-region (point-min) (point-max))
    ; set mode to have syntax highlighting
    (nxml-mode)
    (save-excursion
      (insert htmlized-reg))
    (while (re-search-forward "<pre>" nil t)
      (replace-match pre-tag nil nil))
    (goto-char (point-min))))

(global-set-key [(f5)] (lambda (beg end)
                         (interactive "r") (my-htmlize-region beg end)))

(provide 'my-htmlize)
