if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'junegunn/goyo.vim'

" Colors
Plug 'tomasr/molokai'|
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'morhetz/gruvbox'
Plug 'yuttie/hydrangea-vim'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'AlessandroYorba/Despacio'
Plug 'cocopon/iceberg.vim'
Plug 'w0ng/vim-hybrid'
Plug 'nightsense/snow'
Plug 'nightsense/stellarized'
Plug 'arcticicestudio/nord-vim'

" Edit
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'editorconfig/editorconfig-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'less', 'css', 'scss', 'json', 'markdown', 'python', 'yaml', 'html'] }

" Browsing
Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesEnable' }
autocmd! User indentLine doautocmd indentLine Syntax

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
augroup nerd_loader
  autocmd!
  autocmd VimEnter * silent! autocmd! FileExplorer
  autocmd BufEnter,BufNew *
        \  if isdirectory(expand('<amatch>'))
        \|   call plug#load('nerdtree')
        \|   execute 'autocmd! nerd_loader'
        \| endif
augroup END

if v:version >= 703
  Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
endif

"Plug 'ctrlpvim/ctrlp.vim'

"Ack"
"Plug 'mileszs/ack.vim'

" Fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Git
Plug 'tpope/vim-fugitive'

if v:version >= 703
  Plug 'mhinz/vim-signify'
endif

" Lang
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'moby/moby' , {'rtp': '/contrib/syntax/vim/'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Lint
Plug 'w0rp/ale'

" Status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
