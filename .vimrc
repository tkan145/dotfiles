

let s:darwin = has('mac')
let mapleader      = ','
let maplocalleader = ','


" }}}
" ============================================================================
" VIM-PLUG BLOCK {{{
" ============================================================================

silent! if plug#begin('~/.vim/plugged')

" Colors
Plug 'tomasr/molokai'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'morhetz/gruvbox'
	let g:gruvbox_contrast_dark = 'hard'
Plug 'joshdick/onedark.vim'

" Edit
Plug 'tpope/vim-commentary'
  map  gc  <Plug>Commentary
  nmap gcc <Plug>CommentaryLine

" Browsing
Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesEnable' }
  autocmd! User indentLine doautocmd indentLine Syntax
  let g:indentLine_color_term = 239
  let g:indentLine_color_gui = '#616161'


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

" Git
Plug 'tpope/vim-fugitive'
	nmap     <Leader>g :Gstatus<CR>gg<c-n>
	nnoremap <Leader>d :Gdiff<CR>

Plug 'mhinz/vim-signify'
	let g:signify_vcs_list = ['git']
	let g:signify_skip_filetype = { 'journal': 1 }
	let g:signify_sign_add          = '│'
	let g:signify_sign_change       = '│'
	let g:signify_sign_changedelete = '│'

" Fzf
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Lsp
if has('nvim')
	Plug 'neovim/nvim-lspconfig'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'hrsh7th/cmp-nvim-lsp'
	" Plug 'saadparwaiz1/cmp_luasnip'
	" Plug 'L3MON4D3/LuaSnip'
else
endif

" UI
Plug 'itchyny/lightline.vim'
	let g:lightline = {
		\ 'colorscheme': 'gruvbox',
		\ }

call plug#end()
endif

" }}}
" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================
set nu               " Display line number
set tabstop=4
set shiftwidth=4
set ignorecase smartcase " Ignore case when searching
" Enable break indent
if has('patch-7.4.338')
  let &showbreak = '↳ '
  set breakindent
  set breakindentopt=sbr
endif

" Peristence undo
set undofile

" 80 chars/line
set textwidth=0
if exists('&colorcolumn')
  set colorcolumn=80
endif

" Set font according to system
if has("mac") || has("macunix")
    set gfn=IBM\ Plex\ Mono:h14,Hack:h14,Source\ Code\ Pro:h15,Menlo:h15
elseif has("win16") || has("win32")
    set gfn=IBM\ Plex\ Mono:h14,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has("gui_gtk2")
    set gfn=IBM\ Plex\ Mono:h14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("linux")
    set gfn=IBM\ Plex\ Mono:h14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("unix")
    set gfn=Monospace\ 11
endif

" }}}
" ============================================================================
" GUI {{{
" ============================================================================
" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

colorscheme gruvbox
set background=dark

" }}}
" ============================================================================
" MAPPINGS {{{
" ============================================================================

" ----------------------------------------------------------------------------
" Basic mappings
" ----------------------------------------------------------------------------
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <C-space> ?

" Save
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>
nnoremap <leader>s :update<cr>
nnoremap <leader>w :update<cr>

" <leader>n | NERD Tree
nnoremap <leader>n :NERDTreeToggle<cr>

" jk | Escaping!
inoremap jk <Esc>
xnoremap jk <Esc>
cnoremap jk <C-c>

" Movement in insert mode
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-^> <C-o><C-^>

" ----------------------------------------------------------------------------
" Moving lines
" ----------------------------------------------------------------------------
nnoremap <silent> <C-k> :move-2<cr>
nnoremap <silent> <C-j> :move+<cr>
nnoremap <silent> <C-h> <<
nnoremap <silent> <C-l> >>
xnoremap <silent> <C-k> :move-2<cr>gv
xnoremap <silent> <C-j> :move'>+<cr>gv
xnoremap <silent> <C-h> <gv
xnoremap <silent> <C-l> >gv
xnoremap < <gv
xnoremap > >gv

" ----------------------------------------------------------------------------
" <Leader>c Close quickfix/location window
" ----------------------------------------------------------------------------
nnoremap <leader>c :cclose<bar>lclose<cr>

" ----------------------------------------------------------------------------
" :A
" ----------------------------------------------------------------------------
function! s:a(cmd)
  let name = expand('%:r')
  let ext = tolower(expand('%:e'))
  let sources = ['c', 'cc', 'cpp', 'cxx']
  let headers = ['h', 'hh', 'hpp', 'hxx']
  for pair in [[sources, headers], [headers, sources]]
    let [set1, set2] = pair
    if index(set1, ext) >= 0
      for h in set2
        let aname = name.'.'.h
        for a in [aname, toupper(aname)]
          if filereadable(a)
            execute a:cmd a
            return
          end
        endfor
      endfor
    endif
  endfor
endfunction
command! A call s:a('e')
command! AV call s:a('botright vertical split')

" }}}
" ============================================================================
" PLUGINS {{{
" ============================================================================

" ----------------------------------------------------------------------------
" fzf.nvim
" ----------------------------------------------------------------------------
let $FZF_DEFAULT_OPTS .= ' --inline-info'

" All files
command! -nargs=? -complete=dir AF
  \ call fzf#run(fzf#wrap(fzf#vim#with_preview({
  \   'source': 'fd --type f --hidden --follow --exclude .git --no-ignore . '.expand(<q-args>)
  \ })))


if exists('$TMUX')
  let g:fzf_layout = { 'tmux': '-p90%,60%' }
else
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
endif

nnoremap <silent> <expr> ; (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>L        :Lines<CR>
nnoremap <silent> <Leader>ag       :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG       :Ag <C-R><C-A><CR>
xnoremap <silent> <Leader>ag       y:Ag <C-R>"<CR>
nnoremap <silent> <Leader>`        :Marks<CR>
nnoremap <silent> <Leader>f        :History<CR>
nnoremap <silent> <Leader>h        :History:<CR>

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let options = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  let options = fzf#vim#with_preview(options, 'right', 'ctrl-/')
  call fzf#vim#grep(initial_command, 1, options, a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" }}}
" ============================================================================
" FUNCTIONS & COMMANDS {{{
" ============================================================================
" ----------------------------------------------------------------------------
" <F8> | Color scheme selector
" ----------------------------------------------------------------------------
function! s:colors(...)
  return filter(map(filter(split(globpath(&rtp, 'colors/*.vim'), "\n"),
        \                  'v:val !~ "^/usr/"'),
        \           'fnamemodify(v:val, ":t:r")'),
        \       '!a:0 || stridx(v:val, a:1) >= 0')
endfunction

function! s:rotate_colors()
  if !exists('s:colors')
    let s:colors = s:colors()
  endif
  let name = remove(s:colors, 0)
  call add(s:colors, name)
  execute 'colorscheme' name
  redraw
  echo name
endfunction
nnoremap <silent> <F8> :call <SID>rotate_colors()<cr>

augroup vimrc
	if has('nvim')
		" auto-format
		" autocmd BufWritePost * lua vim.lsp.buf.formatting()
		" autocmd BufWritePre *.go lua org_imports(1000)
	endif
augroup END
