" neobundle.vim設定
set nocompatible               " recommend
filetype plugin indent off     " required!
if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim/
	call neobundle#rc(expand('~/.vim/bundle/'))
endif
"" githubにあるもの
" 例: 'git://github.com/Shougo/neobundle.vim'
NeoBundle 'Shougo/neobundle.vim' " プラグイン管理
NeoBundle 'Shougo/vimproc' " vimshellで必要
" after install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/vimshell' " vim内で走るshell
NeoBundle 'Shougo/unite.vim' " とりあえず編集履歴や同ディレクトリのファイル一覧
NeoBundle 'Shougo/neocomplcache' " 補完
NeoBundle 'Lokaltog/vim-powerline' " ステータスバー拡張
NeoBundle 'thinca/vim-quickrun' " 即実行
NeoBundle 'thinca/vim-ref' " リファレンス
NeoBundle 'thinca/vim-unite-history' " コマンド履歴
NeoBundle 'tyru/open-browser.vim' " ブラウザで開く
NeoBundle 'kana/vim-smartword' " 文字の移動
NeoBundle 'ujihisa/neco-look' " 英語の補完 neocomplcache依存
NeoBundle 'tpope/vim-surround' " 囲み文字()等の操作
NeoBundle 'jceb/vim-hier' " エラー検出
NeoBundle 'h1mesuke/unite-outline' " アウトライン表示
"" githubのvim scriptに登録されているもの
" 例: 'git://github.com/vim-scripts/sudo.vim'
NeoBundle 'sudo.vim' " vim sudo:ファイル or :e sudo:ファイル でsudo権限で編集
NeoBundle 'Align' " セパレータを使った整形
NeoBundle 'matchit.zip' " % での移動の拡張
NeoBundle 'taglist.vim' " タグリスト
"NeoBundle 'Smooth-Scroll' " C-f,C-b,C-d,C-uの動きを滑らかに
NeoBundle 'MultipleSearch' " 検索の複数ハイライト
NeoBundle 'SingleCompile' " ファイルのコンパイル、実行
NeoBundle 'TwitVim' " twitterクライアント
"" github以外
NeoBundle 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex' " tex用
filetype plugin indent on       " required!

syntax on
filetype plugin on
" neocomplcacheトリガ
let g:neocomplcache_enable_at_startup = 1
" vim-powerline設定
let g:Powerline_symbols = 'fancy'
" vim-latex
" \llでコンパイル
" \lvでpdfをpreviewで開く
set shellslash
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='pdf'
let g:Tex_CompileRule_pdf='xelatex $*'
let g:Tex_ViewRule_pdf='/usr/bin/open -a /Applications/Preview.app'
let g:Tex_IgnoredWarnings =
	\"Underfull\n".
	\"Overfull\n".
	\"specifier changed to\n".
	\"You have requested\n".
	\"Missing number, treated as zero.\n".
	\"There were undefined references\n".
	\"Citation %.%# undefined\n".
	\"Command %.%# invalid in math mode\n".
	\"Text page %.%# contains only floats\n"
	\"A float is stuck\n"
	\"Float too large\n"
	\"LaTeX Font Warning:"
let g:Tex_IgnoreLevel = 12

setlocal omnifunc=syntaxcomplete#Complete
set wildmenu
set nobackup
set noswapfile
set autoindent
set smartindent
set autoread
set hidden
highlight DiffAdd term=bold ctermbg=6
if &diff
	set wrap
endif
inoremap <C-b> <LEFT>
inoremap <C-f> <RIGHT>
inoremap <C-d> <DELETE>

" 編集箇所を記憶
if has("autocmd")
	autocmd BufReadPost *
	\ if line("'\"") > 0 && line ("'\"") <= line("$") |
	\   exe "normal! g'\"" |
	\ endif
endif

" viの時にscreen上のタイトルを vi [編集ファイル] とする
if &term =~ "screen"
	autocmd VimLeave * silent! exe '!echo -n "k' . "edited [%]" . '\\"'
	autocmd BufEnter * silent! exe '!echo -n "k' . "vi [%]" . '\\"'
endif

autocmd BufNewFile,BufRead * call SetTab()
function SetTab()
" fortranの場合のtabの動作を変更
	if &syntax == 'fortran'
		execute 'set expandtab | set shiftwidth=2 | set tabstop=2'
	else
		execute 'set shiftwidth=4 | set tabstop=4'
	endif
" texの場合のspell checkを作動
	if &syntax == 'tex'
		execute 'setlocal spell'
	else
		execute 'setlocal nospell'
	endif
endf

set backspace=2 " インデントや改行の削除
set showmatch " （）の対応
set ambiwidth=double
set nonumber
set ruler
set nolist
set wrap
set whichwrap+=b,s,h,l,<,>,[,]

" *レジスタとクリップボードを共有
set clipboard+=unnamed,autoselect

" 編集行にカーソル
set cursorline
augroup cch
	autocmd! cch
	autocmd WinLeave * set nocursorline
	autocmd WinEnter,BufRead * set cursorline
augroup END

" 日本語のencodingの設定
if &encoding !=# 'utf-8'
	set encoding=japan
	set fileencoding=japan
endif
if has('iconv')
	let s:enc_euc = 'euc-jp'
	let s:enc_jis = 'iso-2022-jp'
" iconvがeucJP-msに対応しているかをチェック
	if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'eucjp-ms'
		let s:enc_jis = 'iso-2022-jp-3'
" iconvがJISX0213に対応しているかをチェック
	elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'euc-jisx0213'
		let s:enc_jis = 'iso-2022-jp-3'
	endif
" fileencodingsを構築
	if &encoding ==# 'utf-8'
		let s:fileencodings_default = &fileencodings
		let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
		let &fileencodings = &fileencodings .','. s:fileencodings_default
		unlet s:fileencodings_default
	else
		let &fileencodings = &fileencodings .','. s:enc_jis
		set fileencodings+=utf-8,ucs-2le,ucs-2
		if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
			set fileencodings+=cp932
			set fileencodings-=euc-jp
			set fileencodings-=euc-jisx0213
			set fileencodings-=eucjp-ms
			let &encoding = s:enc_euc
			let &fileencoding = s:enc_euc
		else
			let &fileencodings = &fileencodings .','. s:enc_euc
		endif
	endif
" 定数を処分
	unlet s:enc_euc
	unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
	function! AU_ReCheck_FENC()
	if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
		let &fileencoding=&encoding
	endif
	endfunction
	autocmd BufReadPost * call AU_ReCheck_FENC()
endif

set fileformat=unix
set fileformats=unix,dos,mac

" ステータスバー
set laststatus=2
set statusline=%n:\ %<%F\ [%{&fileformat}][%{&fileencoding!=''?&fileencoding:&encoding}]%m%r%h%w%=%4l,%2c\ %4P

" filetypeの指定
augroup filetypedetect
au! BufRead,BufNewFile *.plt setfiletype gnuplot " pltのfiletypeをgnuplotに
au! BufRead,BufNewFile *.txt setfiletype tex " txtのfiletypeをtexに
augroup END

" unite.vim
let g:unite_enable_start_insert=0
"noremap <C-u><C-b> :Unite buffer<CR> " バッファ一覧
"noremap <C-u><C-f> :UniteWithBufferDir -buffer-name=files file<CR> " 同ディレクトリのファイル一覧
"noremap <C-u><C-r> :Unite file_mru<CR> " 履歴一覧
"noremap <C-u><C-y> :Unite -buffer-name=register register<CR> " レジスタ一覧
noremap fb :Unite buffer<CR> " バッファ一覧
noremap ff :UniteWithBufferDir -buffer-name=files file<CR> " 同ディレクトリのファイル一覧
noremap fm :Unite file_mru<CR> " 履歴一覧
noremap fr :Unite -buffer-name=register register<CR> " レジスタ一覧
noremap fo :Unite outline<CR> " アウトライン一覧

" vimshell
let g:vimshell_prompt = $USER."% "
"nnoremap <C-u><C-i> :VimShell<CR>
"nnoremap <C-u><C-p> :VimShellPop<CR>
nnoremap fs :VimShellPop<CR>
let g:vimshell_popup_height = 35

" vim-ref
nnoremap fa :Ref alc 

" multiplesearch
nnoremap fh :Search 
nnoremap fg :SearchReset<CR>

" smartword
map W  <Plug>(smartword-w)
map B  <Plug>(smartword-b)
map E  <Plug>(smartword-e)
map ,w  <Plug>(smartword-w)
map ,b  <Plug>(smartword-b)
map ,e  <Plug>(smartword-e)
map ,ge  <Plug>(smartword-ge)

" matchit.zip
let b:match_words = "<if>:<endif>"
let b:match_words = "<do>:<enddo>"
let b:match_words = "<begin>:<end>"

" TwitVim設定
let twitvim_count = 50

" Esc二回押しで終了
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
au FileType help nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType help inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
au FileType vimshell nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType vimshell inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
au FileType quickrun nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType quickrun inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
au FileType ref-* nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType ref-* inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
au FileType twitvim nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType twitvim inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
au FileType taglist nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType taglist inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

