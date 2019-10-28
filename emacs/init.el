;; package install
;; <M-x> package-list-packages
;; helm

;; package.el
;;; http://qiita.com/tadsan/items/6c658cc471be61cbc8f6 を参考にするといい
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;;(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t); httpsで通らないときこちら
(package-initialize)

(helm-mode 1) ;helmを常に有効
;;(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action) ;;tabはアクション選択
(define-key global-map (kbd "M-x") 'helm-M-x) ;;M-xの検索をhelmで行う
(define-key global-map (kbd "C-x r b") #'helm-filtered-bookmarks)
(define-key global-map (kbd "C-x C-f") #'helm-find-files) ;;elscreen-find-fileで置き換え予定
(define-key global-map (kbd "C-x b") 'helm-mini)
(define-key global-map (kbd "C-x C-b") 'helm-buffers-list)
(define-key global-map (kbd "M-y") 'helm-show-kill-ring)
(defvar my-helm-map (make-sparse-keymap) "My original helm keymap binding F7 and C-;.")
(defalias 'my-helm-prefix my-helm-map)
(define-key global-map [f7] 'my-helm-prefix)
(define-key global-map (kbd "C-;") 'my-helm-prefix) ;; ネイティブwindowの時にしかキーが取れない rloginでは C-;を"\030@c;"に割り当てる
(define-key my-helm-map (kbd "h") 'helm-mini)
(define-key my-helm-map (kbd "b") 'helm-mini)
;;(define-key my-helm-map (kbd "r") 'helm-recentf) ;; ielmの起動にした(repl)
(define-key my-helm-map (kbd "i") 'helm-imenu)
(define-key my-helm-map (kbd "k") 'helm-show-kill-ring)
(define-key my-helm-map (kbd "o") 'helm-occur)
(define-key my-helm-map (kbd "x") 'helm-M-x)
(define-key my-helm-map (kbd "f") 'helm-browse-project) ;; git内に関係するファイル全部を絞り込める


;;; org-mode
;;; 最新のorgmodeでditaaが動かないので ubuntu16.04付属のorgを使う
;;; 埋め込みは http://tanehp.ec-net.jp/heppoko-lab/prog/resource/org_mode/org_mode_memo.html が参考になる
;;; #+ の補完をやってくれるようにする
;;(require 'org-mode)
(add-hook 'org-mode-hook #'my-org-mode-hook)
(defun my-org-mode-hook ()
  "My org mode hook."
  (progn
    (add-hook 'completion-at-point-functions 'pcomplete-completions-at-point nil t)))

;; org-modeロード時に評価
(with-eval-after-load 'org
  ;; babel の出力の調整
  (setf (alist-get :exports org-babel-default-header-args) "both") ;; githubではbothにしておかないと表示しない
  (require 'ob-python) ;; これをやっておかないとheade-ags:pythonが見えない
  (setf (alist-get :results org-babel-default-header-args:python) "output") ;; pythonはデフォoutputのほうが使いやすい
  (require 'ob-js) ;; これをやっておかないとheade-ags:pythonが見えない
  (setf (alist-get :results org-babel-default-header-args:js) "output") ;; jsも

  ;; org template expansion に 加える githubのorg-modeが :exports bothにしないと出力しない
  (add-to-list 'org-structure-template-alist '("J" "#+BEGIN_SRC js :exports both\n?\n#+END_SRC"))
  (add-to-list 'org-structure-template-alist '("R" "#+BEGIN_SRC ruby :exports both\n?\n#+END_SRC"))
  (add-to-list 'org-structure-template-alist '("P" "#+BEGIN_SRC python :exports both\n?\n#+END_SRC"))
  (add-to-list 'org-structure-template-alist '("S" "#+BEGIN_SRC sh :exports both\n?\n#+END_SRC"))
  (add-to-list 'org-structure-template-alist '("E" "#+BEGIN_SRC emacs-lisp :exports both :results pp\n?\n#+END_SRC"))

  (define-key org-mode-map (kbd "\C-cp") 'picture-mode) ;; org-modeではC-cpで起動

  (when (eq system-type 'darwin) ;; macのときだけorgの段落キーバインドを変える
    (define-key org-mode-map (kbd "M-{") 'elscreen-previous)
    (define-key org-mode-map (kbd "M-}") 'elscreen-next))
  )

(define-key my-helm-map (kbd "a") 'org-agenda)
(define-key my-helm-map (kbd "c") 'org-capture)

;;(setq org-startup-with-inline-images t) ;;インライン画像を表示 C-cC-xC-vでトグルするので不要
;; http://lioon.net/org-mode-view-style をもう少し研究する

;;https://skalldan.wordpress.com/2011/07/16/%E8%89%B2%E3%80%85-org-capture-%E3%81%99%E3%82%8B-2/ これが参考になる？

(unless (file-exists-p (expand-file-name "~/org")) (make-directory (expand-file-name "~/org"))) ;ホームにorgがなかったら作る
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks") "* TODO %?\n  %i\n  %a")
	("j" "Journal" entry (file+datetree "~/org/journal.org") "* %?\nEntered on %U\n  %i\n  %a")))


(setq org-todo-keywords '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)"))) ;; TODO状態
(setq org-log-done 'time);; DONEの時刻を記録

;;http://misohena.jp/blog/2017-10-26-how-to-use-code-block-of-emacs-org-mode.html
;; メモ書きに大変便利、結果は#+begin_src ruby で結果はC-cC-c出力
(org-babel-do-load-languages
 'org-babel-load-languages
 (mapcar (lambda (lang) (cons lang t))
	 `(ditaa
	   dot
					;octave
	   perl
	   python
	   ruby
	   js
	   shell
	   ,(if (locate-library "ob-shell") 'shell 'sh)
	   sqlite
	   )))
(setq org-confirm-babel-evaluate nil) ;; コードを評価するとき尋ねない ditaa作成時の問い合わせをoff



  ;;;
  ;;; markdown mode
  ;;;
  ;;; https://qiita.com/howking/items/bcc4e05bfb16777747fa を見て研究する
;; markdownコマンドは github の markdown api
(setq markdown-command "jq --slurp --raw-input '{\"text\": \"\\(.)\", \"mode\": \"gfm\"}' | curl -sS --data @- https://api.github.com/markdown")
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))
(eval-after-load "markdown-mode"
  '(defalias 'markdown-add-xhtml-header-and-footer 'my/markdown-add-html5-header-and-footer))
(defun my/markdown-add-html5-header-and-footer (title)
  "Wrap XHTML header and footer with given TITLE around current buffer."
  (goto-char (point-min))
  (insert "<!doctype html>\n"
	  "<html lang=\"ja\">\n"
	  "<head>\n  <title>")
  (insert title)
  (insert "</title>\n")
  (insert "  <meta charset=\"utf-8\">\n")
  (insert "  <link href=\"https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/2.8.0/github-markdown.min.css\" rel=\"stylesheet\">\n")
  (insert "  <style>body { zoom: 150%; } body > h1:not(:first-child) { border: 0; page-break-before: always; } h2{ page-break-before: always; }</style>\n")
  (insert "  <style>\n")
  (insert "  @media screen { div.footer { display: none; } }\n")
  (insert "  @media print { @page { size: legal landscape; margin-top: 0; margin-bottom: 6mm; } h1 { padding-top: 50mm; } h2 { padding-top: 0 } div.footer { position: fixed; right: 0; bottom: 0; } }\n")
  (insert "  </style>\n")
  (insert "</head>\n"
	  "<body class=\"markdown-body\">\n")
  (goto-char (point-max))
  (insert "\n"
	  "<div class=\"footer\"><img src=\"https://user-images.githubusercontent.com/13231263/31114194-d9656554-a857-11e7-8a87-245bf60475be.png\" style=\"width: 80px\"></div>"
	  "</body>\n" "</html>\n"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (evil evil-org helm))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(require 'evil)
(evil-mode 1)
