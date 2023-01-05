set number
set ignorecase
set smartcase
set incsearch
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
set clipboard+=unnamedplus


" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif
call plug#begin('~/.vim/plugged')

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

Plug 'vim-airline/vim-airline'
Plug 'fatih/vim-go'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'phpactor/phpactor'
Plug 'dense-analysis/ale'
Plug 'vim-test/vim-test'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'mzlogin/vim-markdown-toc'
Plug 'NLKNguyen/papercolor-theme'

call plug#end()

" vim-go settings
let g:go_metalinter_enabled = []
let g:go_metalinter_command = 'golangci-lint'
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet','revive','errcheck','staticcheck','unused','varcheck']

" ALE settings
let g:ale_fixers = {
\   'php': ['phpcbf'],
\   'proto': ['ale#fixers#protolint#Fix'],
\}
let g:ale_linters = {
\   'proto': ['protolint'],
\}

" We recommend you set this.
let g:ale_lint_on_text_changed = 'never'
let g:ale_fix_on_save = 1
let g:ale_php_phpstan_executable = system('if ! type git &> /dev/null; then echo phpstan; else PSE=`git rev-parse --show-toplevel 2> /dev/null`/vendor/bin/phpstan; if [ -x "$PSE" ]; then echo -n $PSE; else echo phpstan; fi; fi')

" vim-instant-markdown settings
filetype plugin on
let g:instant_markdown_autostart = 1
let g:instant_markdown_mermaid = 1

set background=dark
colorscheme PaperColor

""" ctrlp settings
   let g:ctrlp_use_caching = 1
   let g:ctrlp_clear_cache_on_exit = 0
   let g:ctrlp_cache_dir = '$HOME/.vim/cache/ctrlp'
   let g:ctrlp_max_files = 1000
   let g:ctrlp_max_history = &history
   let g:ctrlp_max_depth = 10
   let g:ctrlp_user_command = [
         \ '.git', 'cd %s && git ls-files . -co --exclude-standard',
         \ 'rg %s --files --color=never --glob ""',
         \ 'find %s -type f'
         \ ]
   let g:ctrlp_custom_ignore = {
     \ 'dir': '\v[\/](\.git\|dist)$',
     \ 'file': '\v\.(exe|so|dll)$',
   \ }
   let g:ctrlp_working_path_mode = 'ra'
   let g:ctrlp_reuse_window = 'startify'
