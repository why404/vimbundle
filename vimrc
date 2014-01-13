"=============================================================
"=============================================================
"
"    Vim 基本配置
"
"=============================================================
"=============================================================

"关闭vi的一致性模式 避免以前版本的一些Bug和局限
set nocompatible

"配置backspace键工作方式
set backspace=indent,eol,start

"显示行号
set number

"设置在编辑过程中右下角显示光标的行列信息
set ruler

"当一行文字很长时取消换行
"set nowrap

"在状态栏显示正在输入的命令
set showcmd

" Show current mode
set showmode

" Set 7 lines to the cursor - when moving vertically using j/k 上下滚动,始终在中间
set scrolloff=7

"设置历史记录条数
set history=1000

"设置取消备份 禁止临时文件生成
set nobackup
set noswapfile

"突出现实当前行列、高亮当前行列
set cursorline
set cursorcolumn

"设置匹配模式 类似当输入一个左括号时会匹配相应的那个右括号
set showmatch

"设置文内智能搜索提示
" 高亮search命中的文本。
set hlsearch

"设置C/C++方式自动对齐
set autoindent
set cindent

"指定配色方案为256色
set t_Co=256

"设置搜索时忽略大小写
set ignorecase

" 随着键入即时搜索
set incsearch
" 有一个或以上大写字母时仍大小写敏感
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise

"设置在Vim中可以使用鼠标 防止在Linux终端下无法拷贝
set mouse=a

"设置Tab宽度
set tabstop=4
"设置自动对齐空格数
set shiftwidth=4
"设置按退格键时可以一次删除4个空格
set softtabstop=4
"设置按退格键时可以一次删除4个空格
set smarttab
"将Tab键自动转换成空格 真正需要Tab键时使用[Ctrl + V + Tab]
set expandtab

"设置编码方式
set encoding=utf-8
"自动判断编码时 依次尝试一下编码
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set helplang=cn

" Use Unix as the standard file type
set ffs=unix,dos,mac

" 如遇Unicode值大于255的文本，不必等到空格再折行。
set formatoptions+=m
" 合并两行中文时，不在中间加空格：
set formatoptions+=B


"===================================================================
"===================================================================
"
"   自定义vim操作
"
"====================================================================
"====================================================================
map <F5> :call Do_OneFileMake()<CR>
map <F2> :call Do_FileSave()<CR>
map <F3> :call Do_FileSaveAndQuit()<CR>

" === 当前文件保存 ===
function Do_FileSave()
    let source_file_name=expand("%:t")
    if source_file_name==""
        echoh1 WarningMsg | echo "The file name is empty." | echoh1 None
        return
    endif

    execute "w"
endfunction

" === 当前文件保存退出 ===
function Do_FileSaveAndQuit()
    let source_file_name=expand("%:t")
    if source_file_name==""
        echoh1 WarningMsg | echo "The file name is empty." | echoh1 None
        return
    endif

    execute "wq"
endfunction

" === 单文件编译 仅支持c、cc、cpp、go文件 ===
function Do_OneFileMake()
    if expand("%:p:h")!=getcwd()
        echoh1 WarningMsg | echo "Failed to make. This's file is not in the current dir." | echoh1 None
        return
    endif

    let source_file_name=expand("%:t")

    if source_file_name==""
        echoh1 WarningMsg | echo "The file name is empty." | echoh1 None
        return
    endif

    if ( (&filetype!="c")&&(&filetype!="cc")&&(&filetype!="cpp")&&(&filetype!="go") )
    echoh1 WarningMsg | echo "Please just make c、cc、cpp and go file." | echoh1 None
        return
    endif

    if &filetype=="c"
        set makeprg=gcc\ %\ -o\ %<
    endif

    execute "w"
    execute "silent make"
    execute "q"
endfunction


"==============================================================
"==============================================================
"
"   Vundle插件管理和配置项
"
"==============================================================
"==============================================================

"开始使用Vundle的必须配置
set nocompatible

filetype off
" filetype plugin indent off
" set runtimepath+=$GOROOT/misc/vim
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"=== 使用Vundle来管理Vundle ===
Bundle 'gmarik/vundle'

"=== PowerLine插件 状态栏增强展示 ===
Bundle 'Lokaltog/vim-powerline'
"vim有一个状态栏 加上powline则有两个状态栏
set laststatus=2
set t_Co=256
let g:Powline_symbols='fancy'

Bundle 'bling/vim-airline'

"=== 括号显示增强 ===
Bundle 'kien/rainbow_parentheses.vim'
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 40
let g:rbpt_loadcmd_toggle = 0

"=== The-NERD-tree 目录导航插件 ===
Bundle 'vim-scripts/The-NERD-tree'
"开启目录导航快捷键映射成n键
nnoremap <silent> <F8> :NERDTreeToggle<CR>
"高亮鼠标所在的当前行
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
let g:netrw_home='~/bak'
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end

"=== buffer管理 ===
Bundle 'fholgado/minibufexpl.vim'
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
"解决FileExplorer窗口变小问题
let g:miniBufExplForceSyntaxEnable = 1
let g:miniBufExplorerMoreThanOne=2
let g:miniBufExplCycleArround=1
" 默认方向键左右可以切换buffer
nnoremap <TAB> :MBEbn<CR>
noremap <leader>bn :MBEbn<CR>
noremap <leader>bp :MBEbp<CR>
noremap <leader>bd :MBEbd<CR>

"=== Tagbar 标签导航 ===
Bundle 'majutsushi/tagbar'
"标签导航快捷键
nmap <F9> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

"=== 标签导航 要装ctags ===
Bundle 'vim-scripts/taglist.vim'
set tags=tags;/
let Tlist_Ctags_Cmd="/usr/bin/ctags"
nnoremap <silent> <F8> :TlistToggle<CR>
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Auto_Open = 0
let Tlist_Auto_Update = 1
let Tlist_Close_On_Select = 0
let Tlist_Compact_Format = 0
let Tlist_Display_Prototype = 0
let Tlist_Display_Tag_Scope = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Exit_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 0
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Hightlight_Tag_On_BufEnter = 1
let Tlist_Inc_Winwidth = 0
let Tlist_Max_Submenu_Items = 1
let Tlist_Max_Tag_Length = 30
let Tlist_Process_File_Always = 0
let Tlist_Show_Menu = 0
let Tlist_Show_One_File = 1
let Tlist_Sort_Type = "order"
let Tlist_Use_Horiz_Window = 0
let Tlist_Use_Right_Window = 0
let Tlist_WinWidth = 25

"=== A 头文件和实现文件自动切换插件 ===
Bundle 'vim-scripts/a.vim'
"将切换的快捷键映射成<F4> Qt中使用该快捷键习惯了
nnoremap <silent> <F4> :A<CR>

"=== ctrlp 文件搜索插件 不需要外部依赖包 ===
Bundle 'kien/ctrlp.vim'
"设置开始文件搜索的快捷键
let g:ctrlp_map = '<leader>p'
"设置默认忽略搜索的文件格式
"set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux"
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz)$',
    \ }
let g:ctrlp_cmd = 'CtrlP'
map <leader>f :CtrlPMRU<CR>
"\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
"设置搜索时显示的搜索结果最大条数
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

"=== YouCompleteMe 自动补全插件 迄今为止用到的最好的自动VIM自动补全插件 ===
Bundle 'Valloric/YouCompleteMe'
"自动补全配置插件路径
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
"nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
"youcompleteme 默认tab s-tab 和自动补全冲突
"let g:ycm_key_list_select_completion=['<c-n>']
let g:ycm_key_list_select_completion = ['<Down>']
"let g:ycm_key_list_previous_completion=['<c-p>']
let g:ycm_key_list_previous_completion = ['<Up>']"
"nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
"let g:UltiSnipsExpandTrigger="<c-j>"
"当选择了一项后自动关闭自动补全提示窗口
"let g:ycm_autoclose_preview_window_after_completion=1
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0

"=== 主题solarized ===
Bundle 'altercation/vim-colors-solarized'
let g:solarized_termtrans=1
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"

"=== 主题 molokai ===
Bundle 'tomasr/molokai'
"设置主题
"colorscheme molokai
colorscheme solarized
set background=dark
set t_Co=256

"=== 更高效的移动 ,, + w/fx ===
Bundle 'Lokaltog/vim-easymotion'

Bundle 'vim-scripts/matchit.zip'

"=== indentLine代码排版缩进标识 ===
Bundle 'Yggdroot/indentLine'
let g:indentLine_noConcealCursor = 1
let g:indentLine_color_term = 0
"缩进的显示标识|
let g:indentLine_char = '¦'

"=== vim-trailing-whitespace将代码行最后无效的空格标红 ===
Bundle 'bronson/vim-trailing-whitespace'
map <leader><space> :FixWhitespace<cr>

"=== for code alignment ==
Bundle 'godlygeek/tabular'
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>

Bundle 'junegunn/vim-easy-align'


"=== Drawit ==
Bundle 'vim-scripts/DrawIt'

"=== Markdown ===
Bundle 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled=1

"=== Clang ===
Bundle 'LucHermitte/vim-clang'
Bundle 'vim-scripts/c.vim'

"=== Python ===
Bundle 'klen/python-mode'
Bundle 'python.vim'
Bundle 'python_match.vim'
Bundle 'pythoncomplete'
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai

"=== PHP ===
Bundle 'spf13/PIV'

"=== Ruby ===
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'ecomba/vim-ruby-refactoring'
autocmd FileType ruby,eruby,yaml set tw=80 ai sw=2 sts=2 et
autocmd FileType ruby,eruby,yaml setlocal foldmethod=manual
autocmd User Rails set tabstop=2 shiftwidth=2 softtabstop=2 expandtab

"=== Javascript ===
Bundle "pangloss/vim-javascript"
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
"Bundle 'kchmck/vim-coffee-script'
"au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 tabstop=2 softtabstop=2 expandtab
"Bundle 'alfredodeza/jacinto.vim'
"au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
"au BufNewFile,BufReadPost *.coffee setl tabstop=2 softtabstop=2 shiftwidth=2 expandtab
"Bundle 'nono/jquery.vim'
"au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
"Syntax for JavaScript libraries
Bundle 'othree/javascript-libraries-syntax.vim'
let g:used_javascript_libs = 'jquery,angularjs,requirejs' " underscore, backbone, prelude, sugar
"You can use local vimrc to setup libraries used in project. Sample code for local vimrc:
"autocmd BufReadPre *.js let b:javascript_lib_use_jquery = 1
"autocmd BufReadPre *.js let b:javascript_lib_use_underscore = 1
"autocmd BufReadPre *.js let b:javascript_lib_use_backbone = 1
"autocmd BufReadPre *.js let b:javascript_lib_use_prelude = 0
"autocmd BufReadPre *.js let b:javascript_lib_use_angularjs = 1
Bundle 'hallettj/jslint.vim'
Bundle 'mattn/jscomplete-vim'
Bundle 'ahayman/vim-nodejs-complete'

"=== HTML ===
Bundle 'mattn/emmet-vim'
Bundle 'tpope/vim-haml'
Bundle 'juvenn/mustache.vim'
Bundle 'digitaltoad/vim-jade'
Bundle 'slim-template/vim-slim'
au BufNewFile,BufReadPost *.jade setl shiftwidth=2 tabstop=2 softtabstop=2 expandtab
au BufNewFile,BufReadPost *.html setl shiftwidth=2 tabstop=2 softtabstop=2 expandtab
au BufNewFile,BufReadPost *.slim setl shiftwidth=2 tabstop=2 softtabstop=2 expandtab
"=== 自动补全html/xml标签 ===
Bundle 'docunext/closetag.vim'
let g:closetag_html_style=1

"=== CSS ===
Bundle 'wavded/vim-stylus'
Bundle 'lunaru/vim-less'
nnoremap ,m :w <BAR> !lessc % > %:t:r.css<CR><space>


"=== Clojure ===
"Bundle 'guns/vim-clojure-static'
"Bundle 'tpope/vim-fireplace'
"Bundle 'tpope/vim-classpath'

"=== Haskell
"Bundle 'Twinside/vim-syntax-haskell-cabal'
"Bundle 'lukerandall/haskellmode-vim'
"au BufEnter *.hs compiler ghc
"let g:ghc = "/usr/local/bin/ghc"
"let g:haddock_browser = "open"

"=== Erlang ===
Bundle 'jimenezrick/vimerl'

"=== Golang ===
" This part is opmtimized for Go programming language.
" To use this configuration, make sure you have
" installed Go ( http://golang.org ). Once you have installed
" Go environment, use the following commands to install
" other tools:
"
"   go get github.com/bradfitz/goimports
"   go get code.google.com/p/rog-go/exp/cmd/godef
"   go get github.com/nsf/gocode
"   go get github.com/jstemmer/gotags
"   go get github.com/golang/lint/golint
"
" To install goimport:
"   go get github.com/bradfitz/goimports
Bundle 'jnwhiteh/vim-golang'
" Let's gofmt it before saving it
" autocmd BufWritePre *.go :Fmt
autocmd FileType go autocmd BufWritePre <buffer> Fmt

" To install godef:
"   go get code.google.com/p/rog-go/exp/cmd/godef
Bundle 'dgryski/vim-godef'

" To install gocode:
"   go get github.com/nsf/gocode
Bundle 'Blackrush/vim-gocode'

" Go tags
" To install gotags:
"     go get -u github.com/jstemmer/gotags
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" golint
" To install golint:
"   go get github.com/golang/lint/golint
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim

" gocomplete
set rtp+=$GOPATH/src/github.com/nsf/gocode/vim


"=== 快速插入代码片段 ===
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle "honza/vim-snippets"

"Bundle 'SirVer/ultisnips'
"let g:UltiSnipsExpandTrigger = "<tab>"
"let g:UltiSnipsJumpForwardTrigger = "<tab>"
"定义存放代码片段的文件夹 .vim/snippets下，使用自定义和默认的，将会的到全局，有冲突的会提示
"let g:UltiSnipsSnippetDirectories=["snippets", "bundle/ultisnips/UltiSnips"]

"=== 快速 加减注释 ===
Bundle 'scrooloose/nerdcommenter'

"=== 快速加入修改环绕字符 ===
Bundle 'tpope/vim-surround'
"for repeat -> enhance surround.vim, . to repeat command
Bundle 'tpope/vim-repeat'

"=== 自动补全单引号、双引号、括号等 ===
Bundle 'Raimondi/delimitMate'
" for python docstring ",优化输入
au FileType python let b:delimitMate_nesting_quotes = ['"']


"=== 编辑时自动语法检查标红, vim-flake8目前还不支持,所以多装一个 ===
" 使用pyflakes,速度比pylint快
Bundle 'scrooloose/syntastic'
let g:syntastic_error_symbol='>>'
let g:syntastic_warning_symbol='>'
let g:syntastic_check_on_open=1
let g:syntastic_enable_highlighting = 0
"let g:syntastic_python_checker="flake8,pyflakes,pep8,pylint"
let g:syntastic_python_checkers=['pyflakes']
highlight SyntasticErrorSign guifg=white guibg=black


"=== for nginx conf file highlight.   need to confirm it works ===
Bundle 'vim-scripts/nginx.vim'

"=== for git ===
Bundle 'tpope/vim-fugitive'

"=== edit history, 可以查看回到某个历史状态 ===
Bundle 'sjl/gundo.vim'
nnoremap <leader>h :GundoToggle<CR>


"=============================================================
"=============================================================
"
"    Vim 补充配置
"
"=============================================================
"=============================================================

"开启语法高亮功能
syntax enable
syntax on


"检测文件类型
filetype on
"针对不同的文件采用不同的缩进方式
filetype indent on
"允许插件
filetype plugin on
"启动智能补全
filetype plugin indent on


" Enable omni completion.
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType java set omnifunc=javacomplete#Complete
autocmd FileType go set omnifunc=gocomplete#Complete
if has("autocmd") && exists("+omnifunc")
     autocmd Filetype *
   \ if &omnifunc == "" |
   \   setlocal omnifunc=syntaxcomplete#Complete |
   \ endif
endif
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
"let g:rubycomplete_rails = 1
