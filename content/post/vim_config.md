+++
author = "qwding"
categories = ["vim"]
date = "2018-01-24T10:28:28+08:00"
description = "my vim config"
featured = ""
featuredpath = ""
linktitle = ""
title = "转战vim"

+++


### 转战vim

环境改变人，周围有些用vim，并且感觉编码爽的飞起，于是决定转战vim

之前已经铺垫了几个月了，特意温习些快捷键，并且工作中联系使用,最近开始折腾IDE, 并且开始投入正式使用

### 折腾过程

先选择了大神spf13的配置， 然而，使用并不是很顺利，装上以后加载插件过多，打开大文件，和YCM自动补全延迟高，拉低了效率。并且很多插件真的并不会用到，比如说里面还有rails插件等。

于是果断放弃了spf13的配置，自己搞自己需要的。

贴出配置
```
if &compatible
  set nocompatible "去掉有关vi一致性模式，避免以前版本的bug和局限
end

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

Plugin 'fatih/vim-go'
Bundle 'undx/vim-gocode'
Bundle 'Valloric/YouCompleteMe'
Bundle 'dyng/ctrlsf.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-fugitive'
" Bundle 'Yggdroot/indentLine'
Bundle 'tmhedberg/matchit'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'






" 'tpope/vim-fugitive'      git 插件
" 'dyng/ctrlsf.vim'		    搜索插件
" 'Yggdroot/indentLine' 	python 缩进线, 会有一点点卡
" 'tmhedberg/matchit'       括号成对跳转 % 跳转
" 'Lokaltog/vim-easymotion' 光标记录跳转



let g:solarized_termcolors=256
syntax enable
set background=dark
colorscheme solarized
set guifont=Monaco:h13


set mouse=a	" 鼠标滚动
set nu 		" 行号
filetype on     " 检测文件的类型
set autoindent  " vim使用自动对齐，也就是把当前行的对齐格式应用到下一行(自动缩进）
set tabstop=4	" tab 4空格
set showmatch	" 设置匹配模式，类似当输入一个左括号时会匹配相应的右括号
set incsearch	" 搜索时候定位
set ic          " 搜索不区分大小写
set hlsearch	" 搜索高亮
set cursorline  " 突出显示当前行
" set clipboard=unnamed " 系统剪切板
set confirm		" 没有保存或文件只读时弹出确认
set autoread	" 文件自动检测外部更改

" NERDTree 配置
map <C-e> :NERDTree <CR>

" YCM 配置
let g:ycm_min_num_of_chars_for_completion=1   " 补齐字符数
let g:ycm_complete_in_strings = 1             " 字符串中也开启补全
" inoremap <expr> <CR>       pumvisible() ? '<C-y>' : '\<CR>' " 回车即选中当前项


" EasyMotion
let g:EasyMotion_smartcase = 1
"let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)
" 重复上一次操作, 类似repeat插件, 很强大
map <Leader><leader>. <Plug>(easymotion-repeat)
nmap s <Plug>(easymotion-s) 				" 将Leader 换成了s键

"NERDTree \
let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']

```

### 使用继续

当然，自己折腾对各个插件了解程度会更进一步了解，上面只不过我目前需要的一些基础,现在写python和golang，之后有习惯再继续添加配置


### 几点不满意

1. 代码跳转没有IDE强大，不能从方法定义处转到使用处，目前只能全局搜索了，所以看陌生代码时候更喜欢切回IDE，确实方便
2. 需要搭配键盘会更爽，但是配了键盘当然又要配触摸板，看狗东上都是300起，最近需要节制，等下个月吧....


# 后续更新

### 1.25
```
if &compatible
  set nocompatible "去掉有关vi一致性模式，避免以前版本的bug和局限
end

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

Plugin 'fatih/vim-go'
Bundle 'undx/vim-gocode'
Bundle 'Valloric/YouCompleteMe'
Bundle 'dyng/ctrlsf.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-fugitive'
" Bundle 'Yggdroot/indentLine'
Bundle 'tmhedberg/matchit'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'majutsushi/Tagbar'





" 'tpope/vim-fugitive'      git 插件
" 'dyng/ctrlsf.vim'		    搜索插件
" 'Yggdroot/indentLine' 	python 缩进线
" 'tmhedberg/matchit'       括号成对跳转 % 跳转
" 'Lokaltog/vim-easymotion' 光标记录跳转


" 显示设置
let g:solarized_termcolors=256
syntax enable
set background=dark
colorscheme solarized
set guifont=Monaco:h13

" 功能设置
set mouse=a	" 鼠标滚动
set nu 		" 行号
set autoindent  " vim使用自动对齐，也就是把当前行的对齐格式应用到下一行(自动缩进）
set tabstop=4	" tab 4空格
set showmatch	" 设置匹配模式，类似当输入一个左括号时会匹配相应的右括号
set incsearch	" 搜索时候定位
set ic          " 搜索不区分大小写
set hlsearch	" 搜索高亮
set cursorline  " 突出显示当前行
" set clipboard=unnamed " 系统剪切板
set confirm		" 没有保存或文件只读时弹出确认
set autoread	" 文件自动检测外部更改

" plugins
filetype on     " 检测文件的类型
filetype plugin on " 很关键！ 不开启，各种插件用不了
set tags=./tags;/,~/.vimtags	" ; 不可省略，表示若当前目录中不存在tags， 则在父目录中寻找。

" NERDTree 配置
map <C-e> :NERDTree <CR>

" YCM 配置
let g:ycm_min_num_of_chars_for_completion=1   " 补齐字符数
let g:ycm_complete_in_strings = 1             " 字符串中也开启补全
" inoremap <expr> <CR>       pumvisible() ? '<C-y>' : '\<CR>' " 回车即选中当前项


" EasyMotion
let g:EasyMotion_smartcase = 1
"let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)
" 重复上一次操作, 类似repeat插件, 很强大
map <Leader><leader>. <Plug>(easymotion-repeat)
nmap s <Plug>(easymotion-s) 				" 将Leader 换成了s键

"NERDTree \
let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']


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


" 自定义快捷键
nmap <F6> :cn<cr>
nmap <F7> :cp<cr>

noremap H ^
noremap L $
```

1. 这次更新解决几个问题

* golang做ctags时候居然只有文件内部跳转，多文件不跳转了

安装了Tagbar 及vim-go都不管用， 经过一番排查，发现 filetype plugin on需要打开，解决

* cscope 可以从方法定义处找到使用处

其实是解决ctags时候发现的，居然有这种神器，还需要其他IDE么？


