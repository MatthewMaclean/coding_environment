" Required for vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Sets leader key
let mapleader="'"

nnoremap <silent> <Leader>r :redraw!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

"let g:solarized_termcolors=16
let g:solarized_termtrans=1
colorscheme solarized

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Set colour column at 80 for line length "
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

" Cause search to blink upon n
nnoremap <silent> n   n:call HLNext(0.05)<cr>
highlight WhiteOnRed ctermbg=black
function! HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#'.@/
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set term=screen-256color

" Cursor stuff
set ttyfast
set laststatus=2
set ruler

" Show line number
" (ecl)
set number
set relativenumber
highlight LineNr ctermbg=0 guibg=lightgrey

function! NoRelative()
    set norelativenumber
    set number
endfunc

function! NumberToggle()
    if(&relativenumber == 1)
        :call NoRelative()
    else
        set relativenumber
    endif
endfunc

nnoremap <silent> <C-a> :call NumberToggle()<CR>

au FocusLost * :call NoRelative()
au FocusGained * :set relativenumber
au InsertEnter * :call NoRelative()
au InsertLeave * :set relativenumber

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Highlight search results (ecl)
set hlsearch

" Start searching as you type (ecl)
set incsearch

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" set window title
set title

" make : more accessible (ecl)
map ;  :

" faster save and quit (ecl)
nnoremap :w :w<CR>
nnoremap :q :q<CR>
nnoremap :wq :wq<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indentation strategy is based upon file type
filetype plugin indent on

" Use spaces instead of tabs (ecl)
set expandtab

" You can delete an entire tab rather than the individual spaces
set smarttab

" 1 tab == 4 spaces (ecl)
set shiftwidth=4
set tabstop=4

function! TabSizeToggle()
    if(&shiftwidth == 2)
        set shiftwidth=4
        set tabstop=4
    else
        set shiftwidth=2
        set tabstop=2
    endif
endfunc

nnoremap <silent> <Leader>t :call TabSizeToggle()<CR>

" Wrap when a line is too long
set wrap

" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" map sort function to a key (ecl)
vnoremap <Leader>s :sort<CR>

" highlight tabs and non-breaking spaces
set listchars="tab:\uBB\uBB,nbsp:~"
set list


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Copy paste (ecl)
set clipboard=unnamed
nnoremap <Leader>p :set paste!<CR>

" Make sure line isn't at edge of window (ecl)
set scrolloff=5

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" setting u undofile
set undodir=~/.vim/undodir
set undofile
set undolevels=1000 " max
set undoreload=10000 " max number of lines to save

" Dont change buffer when replace-pasting (ecl)
vnoremap p "_c<C-r>"<Esc>

for i in range(1, 100)
    " Make switching buffer easier to type
    exe "noremap <leader>" . i . " :b" . i . "<CR>"
    " Make switching tabs easier to type
    exe "noremap <leader>t" . i . " " . i . "gt<CR>"
endfor

" Move vim windows (ecl)
nnoremap <silent> <Up> :wincmd k<CR>
nnoremap <silent> <Down> :wincmd j<CR>
nnoremap <silent> <Left> :wincmd h<CR>
nnoremap <silent> <Right> :wincmd l<CR>

" window (ecl)
noremap <silent> <Leader>h  <C-w>s<CR>
noremap <silent> <Leader>v  <C-w>v<CR>

" tab
nnoremap <silent> <C-t> :tabedit %<CR>
nnoremap <silent> <C-w> :tabc<CR>
" (ecl)
nnoremap <silent> <Tab> :tabn<CR>
" (ecl)
nnoremap <silent> <Leader><Tab> :tabp<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'MatthewMaclean/buftabs'
Plugin 'ervandew/supertab'
Plugin 'gmarik/vundle'
Plugin 'kien/ctrlp.vim'
Plugin 'klen/python-mode'
Plugin 'scrooloose/nerdtree'

" youcompleteme
"let g:ycm_filetype_blacklist = { 'python' : 1 }

" buftabs configuration
let g:buftabs_only_basename=1
let g:buftabs_in_statusline=1
let g:buftabs_marker_modified='[+]'
let g:buftabs_marker_start='<'
let g:buftabs_marker_end='>'
nnoremap <Leader>b :ls<CR>

" nerdtree configuration
noremap <C-n> :NERDTreeToggle<CR>
let g:NERDTreeIgnore=['\.swp$', '\.o$', '\.d$', '\.pyc$']
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowHidden=1

" python-mode configuration
let g:pymode_lint_checker="pyflakes,pep8"
let g:pymode_lint_unmodified=1
let g:pymode_lint_cwindow=0
let g:pymode_folding=0
let g:pymode_motion=0
let g:pymode_doc=0
let g:pymode_breakpoint=0
let g:pymode_rope=0
let g:pymode_options_max_line_length=100

" ctrlp configuration
let g:ctrlp_map = '<Leader>f'
set wildignore+=*.swp,*.swo
" Doesn't look at files included in .gitignore
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" scala syntax highlighting
au BufRead,BufNewFile *.scala set iletype=scala
au! Syntax scala source ~/.vim/syntax/scala.vim

" Turn filetype back on
filetype on
