# nvim

插件和 TS 自动安装，lsp 通过 `:MasonInstallAll` 安装。

# mini

无插件版 vim 配置：

```vim
""""""""""""""""""""""""""""""
" 基本设置
""""""""""""""""""""""""""""""

" 历史记录
set history=1000

" 检测文件类型
filetype on

" 针对不同的文件类型采用不同的缩进格式
filetype indent on

" 允许插件
filetype plugin on

" 启动自动补全
filetype plugin indent on

" 文件自动检测外部更改
set autoread

" 隐藏援助乌干达儿童的提示
" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()set shortmess=atI

" 禁用声音与图标
set noerrorbells
set novisualbell
set t_vb=

" 禁止生成临时文件
set nowritebackup
set nobackup
set noswapfile
set viminfo='100,n$HOME/.config/nvim/viminfo

" 高亮显示当前行/列
set cursorline
" set cursorcolumn

" 退出后内容缓存在屏幕上
" set t_ti= t_te=

" 启用鼠标
set mouse-=a
" set paste

set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set showmatch
set nolinebreak

" 退出确认
set confirm

""""""""""""""""""""""""""""""
" 界面排版设置
""""""""""""""""""""""""""""""

" 显示行号
set number

" 显示当前的行号列号
set ruler

" 取消换行
" set nowrap

" 移动光标时，上下方显示的行数
set scrolloff=4

" tab相关变更
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" 缩进配置
set autoindent
set smartindent

" buffer设置
set hidden
set wildmode=list:longest
set ttyfast

" 搜索忽略大小写
set ignorecase

" 搜索字符高亮
set hlsearch

" 增量搜索模式
set incsearch

" 有一个或以上大写字母时仍大小写敏感
set smartcase

" 行内替换
set gdefault

" 默认展开所有代码
set foldmethod=indent
set nofoldenable

" 去掉 Scrollbar
set guioptions-=r
set guioptions-=L

" 显示 tab
set list listchars=tab:>-
set laststatus=0

""""""""""""""""""""""""""""""
" 文件编码及类型设置
""""""""""""""""""""""""""""""

set encoding=utf-8
set termencoding=utf-8

" autocmd FileType make set noexpandtab
autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp,rust,go,lua setlocal et sta sw=4 ts=4 sts=4
autocmd FileType javascript,typescript,html,css,xml,json,yaml setlocal et sta sw=2 ts=2 sts=2
au BufRead,BufNewFile *.vue,*.tsx setlocal filetype=javascript

" 记住上次打开的位置
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

""""""""""""""""""""""""""""""
" 主题
""""""""""""""""""""""""""""""

set t_Co=256
colorscheme desert
set background=dark
hi LineNr ctermfg=245 ctermbg=235
hi CursorLine ctermbg=235 cterm=NONE guibg=Grey40
syntax on

""""""""""""""""""""""""""""""
" 其他
""""""""""""""""""""""""""""""

" 访问系统剪贴板
set clipboard=unnamed

" 自动加载配置
" autocmd! bufwritepost .vimrc source %

" 自动切换工作目录
" set autochdir

" 自动补全配置
set completeopt=longest,menu

" 增强模式中的命令行自动完成操作
set wildmenu wildmode=full

" 关闭预览窗口
set completeopt-=preview

" 更快的关键字补全
set complete-=i
set complete-=t
```
