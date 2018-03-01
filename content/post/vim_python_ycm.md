+++
author = "qwding"
categories = ["vim"]
date = "2018-03-01T10:28:28+08:00"
description = "resolve python ycm not work"
featured = ""
featuredpath = ""
linktitle = ""
title = "解决python 的ycm跳转不好使"

+++

年前折腾很久，终于把golang vim折腾好了，结果发现python ycm不好使了，很头痛

今天解决了，记录下过程

1. 查阅日志，进入到vim进行跳转操作，输入命令`YcmDebugInfo`，打印出来信息，及日志存储位置
2. 查阅日志，发现报了`Max retries exceeded with url: /ready` ,并且发现1的日志的server端口和这个访问的端口不同
3. 查阅issue，发现有人在linux下编译是不支持anaconda版本python的，是不是我mac 的 python版本选择有问题？
4. 再次查阅日志，发现server和vim用的不是一个python版本，于是在vimrc里同时配置了
```
   let g:ycm_python_binary_path = '/usr/local/bin/python2.7'
   let g:ycm_server_python_interpreter = '/usr/local/bin/python2.7'
```
5. 编译后发现好使了，很开心，但是出现另一个问题，系统经常报python崩溃了... 我也快崩溃了
6. 改用python3编译，虽然编译时候还是报了一个`require 3.3 `我用的是3.6，但是编译完后发现好使了，也没有报python崩溃


贴下现在配置

```

if &compatible
  set nocompatible "去掉有关vi一致性模式，避免以前版本的bug和局限 
end 
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

Bundle 'VundleVim/Vundle.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'dyng/ctrlsf.vim'	
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'altercation/vim-colors-solarized'
Bundle 'majutsushi/Tagbar' 
Bundle 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
" 括号成对跳转 % 跳转
Bundle 'tmhedberg/matchit'
" 多光标操作
Bundle 'terryma/vim-multiple-cursors'
" , = 对齐
Bundle 'godlygeek/tabular'
" 自动补全括号
Bundle 'jiangmiao/auto-pairs'
" 多层括号变色
Bundle 'luochen1990/rainbow'
" 保存vim编辑信息，比如最后的位置
Bundle 'vim-scripts/restore_view.vim'
" 添加注释  gc 注释
Bundle 'tpope/vim-commentary'
" tab 自动补全代码
Bundle 'honza/vim-snippets'

" golang 
Bundle 'fatih/vim-go'
Bundle 'undx/vim-gocode'

" python
Bundle 'nvie/vim-flake8'
" Bundle 'Yggdroot/indentLine' python 缩进线, 感觉会影响性能
" Bundle 'klen/python-mode'   " 非常影响速度
" Bundle 'vim-scripts/pythoncomplete'
" Bundle 'davidhalter/jedi-vim' " 响应速度变慢

" git
" git 显示状态插件
Bundle 'mhinz/vim-signify'
" git 执行命令插件
Bundle 'tpope/vim-fugitive'                


" markdown
Bundle 'tamlok/vim-markdown'

" 没装的
" Bundle 'Lokaltog/vim-easymotion' 光标记录跳转

" 显示设置
let g:solarized_termcolors=256
syntax enable
set background=dark
colorscheme solarized
set guifont=Monaco:h13 

" 功能设置
" set mouse=a	" 鼠标滚动
set nu 		" 行号
set autoindent  " vim使用自动对齐，也就是把当前行的对齐格式应用到下一行(自动缩进）
set tabstop=4	" tab 4空格
set showmatch	" 设置匹配模式，类似当输入一个左括号时会匹配相应的右括号
set incsearch	" 搜索时候定位
set ic          " 搜索不区分大小写
set hlsearch	" 搜索高亮
set cursorline  " 突出显示当前行
set clipboard=unnamed " 系统剪切板
set confirm		" 没有保存或文件只读时弹出确认
set autoread	" 文件自动检测外部更改
" set foldlevelstart=99 " 不折叠代码
set encoding=utf-8

" plugins 
filetype on     " 检测文件的类型
filetype plugin on " 很关键！ 不开启，各种插件用不了
set tags=./tags;/,~/.vimtags	" ; 不可省略，表示若当前目录中不存在tags， 则在父目录中寻找。

" 设置 leader 键位
let mapleader="."

" NERDTree 配置
map <C-e> :NERDTree <CR>
let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']

" YCM 配置
let g:ycm_python_binary_path = '/usr/local/bin/python3.6'
let g:ycm_server_python_interpreter = '/usr/local/bin/python3.6'
let g:ycm_min_num_of_chars_for_completion=2   " 补齐字符数
" let g:ycm_complete_in_strings = 1             " 字符串中也开启补全
" inoremap <expr> <CR>       pumvisible() ? '<C-y>' : '\<CR>' " 回车即选中当前项
map gd  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" let g:ycm_keep_logfiles = 1
let g:ycm_log_level = 'debug'


" EasyMotion
"let g:EasyMotion_smartcase = 0
"let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
"map <Leader><leader>h <Plug>(easymotion-linebackward)
"map <Leader><Leader>j <Plug>(easymotion-j)
"map <Leader><Leader>k <Plug>(easymotion-k)
"map <Leader><leader>l <Plug>(easymotion-lineforward)
" 重复上一次操作, 类似repeat插件, 很强大
"map <Leader><leader>. <Plug>(easymotion-repeat)
" nmap s <Plug>(easymotion-s) 				" 将Leader 换成了s键


" Tagbar ctags对golang worker
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

" cscope 配置
set cscopequickfix=s-,c-,d-,i-,t-,e-
cs add cscope.out
" cscope -Rbkq 生成scope一种方式
" find /Users/dingqiwei/gopath/src/git.megvii.com/wjf/backbone -name "*.go" > cscope.files
" cw (windows) cn (next) cp (previous) 
"augroup qf
"    autocmd!
"    autocmd QuickFixCmdPost * cwindow
"augroup END
nmap gu :cs find s <C-R>=expand("<cword>")<CR><CR>

" vim-airline  状态栏插件
" 开启powerline字体
" let g:airline_powerline_fonts = 1
" 使用powerline包装过的字体
set guifont=Source\ Code\ Pro\ for\ Powerline:h14

" Multip Cursor 多行编辑， 选中后 I 进行编辑
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" rainbow 多层括号变色开启
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

" vim-commentary 注释
autocmd FileType python,shell set commentstring=#\ %s                 " 设置Python注释字符

" 自定义快捷键
nmap <F6> :cn<cr>
nmap <F7> :cp<cr>

noremap H ^
noremap L $
nnoremap <C-g> :CtrlSF<Space> 

" 尝试解决卡帧
set re=1
set ttyfast
set lazyredraw


```
