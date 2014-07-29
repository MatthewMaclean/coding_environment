"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Cursor stuff
set ttyfast
set laststatus=2
set ruler

" Show line number
set number
set relativenumber

function! NumberToggle()
    if(&relativenumber == 1)
      set norelativenumber
    else
      set relativenumber
    endif
endfunc

set relativenumber
nnoremap <silent> <C-a> :call NumberToggle()<CR>

au FocusLost * :set norelativenumber
au FocusGained * :set relativenumber
au InsertEnter * :set norelativenumber
au InsertLeave * :set relativenumber

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Highlight search results
set hlsearch

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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable
set hlsearch
set background=dark

"let g:solarized_termcolors=16
let g:solarized_termtrans=1
colorscheme solarized

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Set colour column at 80 for line length "
set colorcolumn=80


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make sure line isn't at edge of window
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

" Dont change buffer when replace-pasting
vnoremap p "_c<C-r>"<Esc>

" Make switching buffer easier to type
for i in range(1, 100)
    exe "map ;" . i . " :b" . i . "<CR>"
endfor

" Move vim windows
nmap <silent> <Up> :wincmd k<CR>
nmap <silent> <Down> :wincmd j<CR>
nmap <silent> <Left> :wincmd h<CR>
nmap <silent> <Right> :wincmd l<CR>

" Up down alternatives
vnoremap <silent> <C-Up> <Up>
vnoremap <silent> <C-Down> <Down>
vnoremap <silent> <C-Left> <Left>
vnoremap <silent> <C-Right> <Right>

" window
noremap ;h  <C-w>s<CR>
noremap ;v  <C-w>v<CR>

" tab
nmap <C-t> :tabedit %<CR>
nmap <C-w> :tabc<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => On save
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
execute pathogen#infect()

" buftabs configuration
let g:buftabs_in_statusline=1
let g:buftabs_marker_modified='[+]'
let g:buftabs_marker_start='<'
let g:buftabs_marker_end='>'

" nerdtree configuration
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeIgnore=['\.swp$', '\.o$', '\.d$', '\.pyc$']
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowHidden=1
