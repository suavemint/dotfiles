set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
Plugin 'thoughtbot/vim-rspec'
Plugin 'pangloss/vim-javascript'
Plugin 'kchmck/vim-coffee-script'
Plugin 'burnettk/vim-angular'
Plugin 'jgdavey/tslime.vim'
" set shell=/bin/zsh
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ

let mapleader = ','
inoremap jk <Esc>
execute pathogen#infect()
set sessionoptions-=options
syntax on
set number
set hidden "Experimental ATM
set backspace=indent,eol,start
" note that the following rval is made by hitting ctrl-v and then backspace...
" this remaps backspace to actually BACKSPACE - not delete.
set t_kb=ctrl-vBACKSPACE
fixdel
au BufWinLeave * mkview
" au BufWinEnter * silent loadview
set nocompatible ruler laststatus=2 showcmd showmode number
" ruby customizations
set ts=2
set sw=2
set smarttab
set expandtab
set softtabstop=2
set shiftwidth=2
set autoindent
set ai

set ignorecase smartcase
set cursorline
set showtabline=2

set hlsearch
set incsearch
highlight Search cterm=underline term=underline
" Turn off search highlight.
nnoremap <leader><space> :nohlsearch<CR>

" Set ,w -> :w
nnoremap <leader>w :w<CR>

" Set ,q -> :wq
nnoremap <leader>q :wq<CR>

" Highlight keyword pairs like do/end.
runtime macros/matchit.vim

" Enable slim syntax highlighting.
autocmd FileType slim setlocal foldmethod=indent
autocmd BufNewFile,BufRead *.slim set filetype=slim

" Set background and color scheme.
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
filetype on
autocmd FileType python set omnifunc=pythoncomplete#Complete
filetype plugin on
filetype indent on
set ofu=syntaxcomplete#Complete
set t_Co=256
autocmd FileType ruby compiler ruby
" autocmd FileType python,ruby autocmd BufWritePre <buffer> :%s/\s\+$//e
" Python execution in separate shell via F5.
" autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
" autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
" autocmd BufRead *.py nmap <F5> :!python %<CR>

" Flexible window resizing when they lose focus to another:
"
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

" Relink the move-to-window key commands.
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k

" Make Esc kill open Command-T popover.
if &term =~ "xterm" || &term =~ "screen"
  let g:CommandTCancelMap = ['<ESC>', '<C-c>']
endif

" Rails convenience key commands.
map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
map <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
map <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
map <leader>gh :CommandTFlush<cr>\|:CommandT app/helpers<cr>
map <leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
map <leader>gp :CommandTFlush<cr>\|:CommandT public<cr>
map <leader>gs :CommandTFlush<cr>\|:CommandT public/stylesheets<cr>
map <leader>gr :topleft :split config/routes.rb<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>

" " Open files with <leader>f
" map <leader>f :CommandTFlush<cr>\|:CommandT<cr>

" " Open files, limited to the directory of the current file, with <leader>gf
" " This requires the %% mapping found below.
map <leader>gf :CommandTFlush<cr>\|:CommandT %%<cr>

" " Switch between the last two files.
nnoremap <leader><leader> <c-^>

" " View or edit files in same directory as current file.
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

" vim-javascript syntax highlighting.
let javascript_enable_domhtmlcss = 1
let b:javascript_fold = 0
let javascript_ignore_javaScriptdoc = 1


" Run the corresponding rspec file.
let g:rspec_runner = "os_x_iterm"
let g:rspec_command = "!bin/spring rspec {spec}"
map <leader>r :call RunCurrentSpecFile()<cr>
map <leader>s :call RunNearestSpec()<cr>

"" Additional filetype detection support
""
" Setup coffeescript
au BufRead,BufNewFile *coffee set ft=coffee

" Setup Haproxy configs
au BufRead,BufNewFile haproxy* set ft=haproxy

" Treat JSON files like JavaScript
au BufRead,BufNewFile *.json set ft=javascript

" Setup less files
au BufRead,BufNewFile {*.less} set ft=scss

" Add a few more file types to ruby syntax
au BufRead,BufNewFile {*.god,*.thor,*.pill,*.axlsx} set ft=ruby

" Generic configuration files
au BufRead,BufNewFile {*.conf} set ft=conf
