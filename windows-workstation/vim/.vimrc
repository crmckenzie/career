" no one cares about vi... poor vi
set nocompatible 

" vundle setup
filetype on " required on Mac
filetype off


let is_windows=has('win32')
set runtimepath+=~/.vim/bundle/vundle.vim
let path='~/.vim/bundle'
  
call vundle#begin(path)

Bundle 'gmarik/Vundle.vim'

Bundle 'tpope/vim-sensible'

" enhanced file explorer
Bundle 'scrooloose/nerdtree'

" expanded syntax support
Bundle "scrooloose/syntastic"

" This is a simple plugin that helps to end certain structures automatically.
Bundle 'tpope/vim-endwise' 

" Provides powershell syntax highlighting
Bundle "PProvost/vim-ps1"

" This project contains Vim configuration files for editing and compiling Ruby
Bundle 'vim-ruby/vim-ruby' 

Bundle "ecomba/vim-ruby-refactoring"

" tab completion
Bundle 'ervandew/supertab'

" Git integration - required by airline
Bundle 'tpope/vim-fugitive'

" enhanced status bar
Bundle 'bling/vim-airline'

" fuzzy finder
Bundle 'kien/ctrlp.vim'

Bundle "tmhedberg/matchit"
" buffer control enhancements
Bundle 'jlanzarotta/bufexplorer'

" color schemes
Bundle 'nanotech/jellybeans.vim'

" add integrated console support
" Bundle 'ervandew/screen'
" clojure repl support
Bundle 'tpope/vim-fireplace' 
Bundle 'tpope/vim-leiningen'

call vundle#end()

filetype plugin indent on

" enhance file listing
set wildmode=list:longest

" text display
set number
set nowrap 

" turn on syntax highlighting
syntax on

" ConEmu
if !empty($CONEMUBUILD)
    set termencoding=utf8
    set term=xterm
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
    " termcap codes for cursor shape changes on entry and exit to
    " /from insert mode
    " doesn't work
    "let &t_ti="\e[1 q"
    "let &t_SI="\e[5 q"
    "let &t_EI="\e[1 q"
    "let &t_te="\e[0 q"
endif

" themes
set background=dark
color jellybeans

" Allow backspacing over autoindent, line breaks and start of insert action
" set backspace=indent,eol,start

" key mappings 
let mapleader=","

" Open markdown files with Chrome.
if has('win32')
  let browser = 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'
  autocmd BufEnter *.md exe 'noremap <F5> :!start ' . browser . ' %:p<CR>'
endif

" tab options
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set autoindent " Match indents on new lines.
set smartindent " Intellegently dedent / indent new lines based on rules.

" We have VCS -- we don't need this stuff.
set nobackup " We have vcs, we don't need backups.
set nowritebackup " We have vcs, we don't need backups.
set noswapfile " They're just annoying. Who likes them?
 
" don't nag me when hiding buffers
set hidden " allow me to have buffers with unsaved changes.
set autoread " when a file has changed on disk, just load it. Don't ask.
 
" Make search more sane
set ignorecase " case insensitive search
set smartcase " If there are uppercase letters, become case-sensitive.
" set incsearch " live incremental searching
set showmatch " live match highlighting
set hlsearch " highlight matches
set gdefault " use the `g` flag by default.

" folding
set foldmethod=syntax
set foldlevelstart=2


"vim-airline settings
let g:airline#extensions#tabline#enabled = 1
set laststatus=2

" NERDTREE
map <Leader>n :NERDTreeToggle<CR>
" let NERDTreeShowHidden=1
let NERDTreeIgnore=["\.git"]

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" syntastic options
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" CTRL+P options
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("h")': ['<c-cr>', '<c-s>'],
  \ 'AcceptSelection("v")': ['<c-x>','<c-v>', '<RightMouse>'],
  \ }

