let g:python_host_prog='/usr/local/bin/python'
let g:python3_host_prog='/usr/local/bin/python3'

let s:dein_cache_dir = expand('~/.cache/dein')
let s:dein_config_dir = expand('~/.config/nvim/dein')
let s:dein_dir = s:dein_cache_dir . '/repos/github.com/Shougo/dein.vim'

if &compatible
  set nocompatible
endif
execute 'set runtimepath^=' . s:dein_dir

if dein#load_state(s:dein_cache_dir)
  call dein#begin(s:dein_cache_dir)

  let s:toml      = s:dein_config_dir . '/.dein.toml'
  let s:lazy_toml = s:dein_config_dir . '/.dein_lazy.toml'
  let s:neo_toml  = s:dein_config_dir . '/.dein_neo.toml' 

  call dein#load_toml(s:toml, {'lazy': 0})
  if has('nvim')
    call dein#load_toml(s:neo_toml, {})
  endif
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

"let g:deoplete#enable_at_startup = 1
"let g:deoplete#file#enable_buffer_path = 1
"let g:deoplete#enable_smart_case = 1
call dein#call_hook('source')

syntax enable
filetype plugin indent on

if dein#check_install(['vimproc'])
  call dein#install(['vimproc'])
endif

if dein#check_install()
  call dein#install()
endif

set fenc=utf-8
set nobackup
set noswapfile
set autoread
set hidden
set showcmd

" 'set paste' no comment out
" Reason: If there is a set paste don't work deoplete.nvim
"set paste
set clipboard+=unnamedplus

set number
set title
set showmatch
set cursorline
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
"set list
set wildmode=list:longest
nnoremap j gj
nnoremap k gk

set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>
