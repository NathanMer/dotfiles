"------------------------------------------------------------
"Vundle Stuff

filetype off " required for vundle - changed later

" Set up stuff:
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Call plugins
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-scripts/a.vim'
Plugin 'wting/rust.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-surround'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-repeat'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Raimondi/delimitMate'
Plugin 'vim-airline/vim-airline-themes'

" After plugins
call vundle#end()

"-------------------------------------------------------------------------------
" Basics

" Set 'nocompatible' to ward off unexpected things that your distro might
"
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype plugin indent on

" Enable syntax highlighting
syntax on

" Helps if I have more than one file open
set hidden

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch
set incsearch

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
set nomodeline

"------------------------------------------------------------
" Usability options {{{1
"
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Display line numbers on the left
set number

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>


"------------------------------------------------------------
" Indentation and white space options {{{1

" Indentation settings for using 4 spaces instead of tabs.
set shiftwidth=4
set softtabstop=4
set expandtab

"see EOL's and trailing spaces and stuff I think
set list
set lcs=tab:»·
set lcs+=trail:·

"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

let mapleader = ","

" Space to insert one character
nnoremap <Space> i_<Esc>r

" get root in editor
cmap wsudo w !sudo tee >/dev/null %

" An easier way to save
nmap <Leader>s :w<CR>

nmap <Leader>r :! pdflatex %<CR>

"-------------------------------------------------------------------------------
" Themes, Colors, and Fonts
set background=dark
colorscheme solarized
set guifont=Source\ Code\ Pro\ for\ Powerline\ Bold\ 10
let g:airline_powerline_fonts = 1

"-------------------------------------------------------------------------------
" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
nmap <Leader>g :YcmCompleter GoTo<Return>

"-------------------------------------------------------------------------------
" Rust.vim and other rust stuff
"Get rust syntax highlighting
au BufNewFile,BufRead *.rs set filetype=rust
let g:ycm_rust_src_path = '/usr/local/rust/rustc-1.5.0/src'

"-------------------------------------------------------------------------------
" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Fix syntastic error jumping
function! <SID>LocationPrevious()
  try
    lprev
  catch /^Vim\%((\a\+)\)\=:E553/
    llast
  endtry
endfunction

function! <SID>LocationNext()
  try
    lnext
  catch /^Vim\%((\a\+)\)\=:E553/
    lfirst
  endtry
endfunction

nnoremap <silent> <Plug>LocationPrevious    :<C-u>exe 'call <SID>LocationPrevious()'<CR>
nnoremap <silent> <Plug>LocationNext        :<C-u>exe 'call <SID>LocationNext()'<CR>
nmap <silent> <Leader>ep  <Plug>LocationPrevious
nmap <silent> <Leader>en  <Plug>LocationNext

let g:syntastic_python_python_exec = '/usr/bin/python2'

"-------------------------------------------------------------------------------
" EasyMotion

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
nmap <Leader>m <Plug>(easymotion-s)

"Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

"-------------------------------------------------------------------------------
" UltiSnips

function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction


if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif

if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger     . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " .     g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"

"-------------------------------------------------------------------------------
" Other stuff of mine

" Spell check
au BufNewFile,BufRead *.tex set spell spelllang=en_us
au BufNewFile,BufRead COMMIT_EDITMSG set spell spelllang=en_us
au BufNewFile,BufRead *.m set nospell
set spell spelllang=en_us

" LaTeX (rubber) macro
nnoremap <leader>t :w<CR>:!rubber --pdf --warn all %<CR>
let g:tex_flavor="latex"

" keep cursor from hitting the edge of the screen
set scrolloff=5

" add vertical line
set colorcolumn=80
