let mapleader      = ','
let maplocalleader = ','

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ============================================================================
" VIM-PLUG BLOCK {{{
" ============================================================================
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Colors
Plug 'tomasr/molokai'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'morhetz/gruvbox'
  let g:gruvbox_contrast_dark = 'hard'
" Plug 'morhetz/gruvbox'
"   let g:gruvbox_contrast_dark = 'soft'
Plug 'yuttie/hydrangea-vim'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'AlessandroYorba/Despacio'
Plug 'cocopon/iceberg.vim'
Plug 'w0ng/vim-hybrid'
Plug 'nightsense/snow'
Plug 'nightsense/stellarized'
Plug 'arcticicestudio/nord-vim'
Plug 'nightsense/cosmic_latte'

" Edit
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
  map  gc  <Plug>Commentary
  nmap gcc <Plug>CommentaryLine
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
  let g:undotree_WindowLayout = 2
  nnoremap U :UndotreeToggle<CR>
Plug 'AndrewRadev/splitjoin.vim'
  let g:splitjoin_split_mapping = ''
  let g:splitjoin_join_mapping = ''
  nnoremap gss :SplitjoinSplit<cr>
  nnoremap gsj :SplitjoinJoin<cr>
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'markdown', 'python', 'yaml', 'html'] }

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

" Lang
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Lint
Plug 'w0rp/ale'
  let g:ale_linters = {'yaml': [],}
  let g:ale_fixers = {}
  let g:ale_lint_delay = 1000
  nmap ]a <Plug>(ale_next_wrap)
  nmap [a <Plug>(ale_previous_wrap)

" Status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
call plug#end()

" }}}
" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================
set nu               " Display line number
set autoindent
set smartindent
set lazyredraw " Don't redraw while executing macros (good performance config)
set laststatus=2
set showcmd
set visualbell
set noerrorbells
set novisualbell
set foldcolumn=1 " Add a bit extra margin to the left
set backspace=indent,eol,start
set timeoutlen=500
set whichwrap=b,s
set shortmess=aIT
set hlsearch " CTRL-L / CTRL-R W  highlight search
set incsearch " Makes search act like search in modern browsers
set ruler "Always show current position
set hidden
set ignorecase smartcase " Ignore case when searching
set wildmenu
set wildmode=full
set tabstop=4 " tab is 4 spaces
set shiftwidth=4 " indent to a tab
set expandtab smarttab
set scrolloff=5 " 5 lines visible above the cursor
set encoding=utf-8
set list
set listchars=tab:\|\ ,
set virtualedit=block
set nojoinspaces
set diffopt=filler,vertical
set autoread
set clipboard=unnamed
set foldlevelstart=99
set grepformat=%f:%l:%c:%m,%f:%l:%m
set completeopt=menuone,preview
set nocursorline
set nrformats=hex
set nobackup
set nowb
set noswapfile
set formatoptions+=1
if has('patch-7.3.541')
  set formatoptions+=j
endif
if has('patch-7.4.338')
  let &showbreak = '↳ '
  set breakindent
  set breakindentopt=sbr
endif

let c_space_errors = 1

" if has('termguicolors')
"   let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"   let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"   set termguicolors
" endif

set modelines=2
set synmaxcol=1000

" set complete=.,w,b,u,t
set complete-=i

" 80 chars/line
set textwidth=0
if exists('&colorcolumn')
  set colorcolumn=100
endif

" Keep the cursor on the same column
set nostartofline

" Disable newline at the end of file
if exists('&fixeol')
  set nofixeol
endif

" coc-nvim settings
" Disable newline at the end of file
if exists('&fixeol')
  set nofixeol
endif

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

set splitbelow
set splitright

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

" Persitence undo
set undodir=~/.vim/undodir
set undofile
" }}}
" ============================================================================
" GUI {{{
" ============================================================================
" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

try
    colorscheme gruvbox
catch
endtry

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

" Open new line below and above current line
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" Save
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>
nnoremap <leader>s :update<cr>
nnoremap <leader>w :update<cr>

" Quit
inoremap <C-Q>     <esc>:q<cr>
nnoremap <C-Q>     :q<cr>
vnoremap <C-Q>     <esc>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>Q :qa!<cr>

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

" Make Y behave like other capitals
nnoremap Y y$

" ----------------------------------------------------------------------------
" Quickfix
" ----------------------------------------------------------------------------
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

" ----------------------------------------------------------------------------
" Buffers
" ----------------------------------------------------------------------------
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" ----------------------------------------------------------------------------
" Tabs
" ----------------------------------------------------------------------------
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" ----------------------------------------------------------------------------
" <tab> / <s-tab> | Circular windows navigation
" ----------------------------------------------------------------------------
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

" ----------------------------------------------------------------------------
" Markdown headings
" ----------------------------------------------------------------------------
nnoremap <leader>1 m`yypVr=``
nnoremap <leader>2 m`yypVr-``
nnoremap <leader>3 m`^i### <esc>``4l
nnoremap <leader>4 m`^i#### <esc>``5l
nnoremap <leader>5 m`^i##### <esc>``6l

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
" <leader>bs | buf-search
" ----------------------------------------------------------------------------
nnoremap <leader>bs :cex []<BAR>bufdo vimgrepadd @@g %<BAR>cw<s-left><s-left><right>

" ----------------------------------------------------------------------------
" #!! | Shebang
" ----------------------------------------------------------------------------
inoreabbrev <expr> #!! "#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)

" }}}
" ============================================================================
" FUNCTIONS & COMMANDS {{{
" ============================================================================
" Donn't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

" ----------------------------------------------------------------------------
" :Root | Change directory to the root of the Git repository
" ----------------------------------------------------------------------------
function! s:root()
  let root = systemlist('git rev-parse --show-toplevel')[0]
  if v:shell_error
    echo 'Not in git repo'
  else
    execute 'lcd' root
    echo 'Changed directory to: '.root
  endif
endfunction
command! Root call s:root()

" ----------------------------------------------------------------------------
" <F5> / <F6> | Run script
" ----------------------------------------------------------------------------
function! s:run_this_script(output)
  let head   = getline(1)
  let pos    = stridx(head, '#!')
  let file   = expand('%:p')
  let ofile  = tempname()
  let rdr    = " 2>&1 | tee ".ofile
  let win    = winnr()
  let prefix = a:output ? 'silent !' : '!'
  " Shebang found
  if pos != -1
    execute prefix.strpart(head, pos + 2).' '.file.rdr
  " Shebang not found but executable
  elseif executable(file)
    execute prefix.file.rdr
  elseif &filetype == 'go'
    execute prefix.'go run '.file.rdr
  elseif &filetype == 'py'
    execute prefix.'python '.file
  elseif &filetype == 'tex'
    execute prefix.'latex '.file. '; [ $? -eq 0 ] && xdvi '. expand('%:r').rdr
  elseif &filetype == 'dot'
    let svg = expand('%:r') . '.svg'
    let png = expand('%:r') . '.png'
    " librsvg >> imagemagick + ghostscript
    execute 'silent !dot -Tsvg '.file.' -o '.svg.' && '
          \ 'rsvg-convert -z 2 '.svg.' > '.png.' && open '.png.rdr
  else
    return
  end
  redraw!
  if !a:output | return | endif

  " Scratch buffer
  if exists('s:vim_exec_buf') && bufexists(s:vim_exec_buf)
    execute bufwinnr(s:vim_exec_buf).'wincmd w'
    %d
  else
    silent!  bdelete [vim-exec-output]
    silent!  vertical botright split new
    silent!  file [vim-exec-output]
    setlocal buftype=nofile bufhidden=wipe noswapfile
    let      s:vim_exec_buf = winnr()
  endif
  execute 'silent! read' ofile
  normal! gg"_dd
  execute win.'wincmd w'
endfunction
nnoremap <silent> <F5> :call <SID>run_this_script(0)<cr>
nnoremap <silent> <F6> :call <SID>run_this_script(1)<cr>

" ----------------------------------------------------------------------------
" <F7> | Paste mode
" ----------------------------------------------------------------------------
" Toggle paste mode on and off
map <silent> <F7> :setlocal paste!<cr>
" ----------------------------------------------------------------------------
" <F8> | Color scheme selector
" ----------------------------------------------------------------------------
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

function! s:colors(...)
    return filter(map(filter(split(globpath(&rtp, 'colors/*.vim'), "\n"),
          \                  'v:val !~ "^/usr/"'),
          \           'fnamemodify(v:val, ":t:r")'),
          \       '!a:0 || stridx(v:val, a:1) >= 0')
endfunction
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

" ----------------------------------------------------------------------------
" ConnectChrome
" ----------------------------------------------------------------------------
"  TODO
"

" ----------------------------------------------------------------------------
" <Leader>?/! | Google it / Feeling lucky
" ----------------------------------------------------------------------------
" TODO

" }}}
" ============================================================================
" TEXT OBJECTS {{{
" ============================================================================

" ----------------------------------------------------------------------------
" Common
" ----------------------------------------------------------------------------
function! s:textobj_cancel()
  if v:operator == 'c'
    augroup textobj_undo_empty_change
      autocmd InsertLeave <buffer> execute 'normal! u'
            \| execute 'autocmd! textobj_undo_empty_change'
            \| execute 'augroup! textobj_undo_empty_change'
    augroup END
  endif
endfunction

noremap         <Plug>(TOC) <nop>
inoremap <expr> <Plug>(TOC) exists('#textobj_undo_empty_change')?"\<esc>":''

" ----------------------------------------------------------------------------
" ?ii / ?ai | indent-object
" ?io       | strictly-indent-object
" ----------------------------------------------------------------------------
function! s:indent_len(str)
  return type(a:str) == 1 ? len(matchstr(a:str, '^\s*')) : 0
endfunction

function! s:indent_object(op, skip_blank, b, e, bd, ed)
  let i = min([s:indent_len(getline(a:b)), s:indent_len(getline(a:e))])
  let x = line('$')
  let d = [a:b, a:e]

  if i == 0 && empty(getline(a:b)) && empty(getline(a:e))
    let [b, e] = [a:b, a:e]
    while b > 0 && e <= line('$')
      let b -= 1
      let e += 1
      let i = min(filter(map([b, e], 's:indent_len(getline(v:val))'), 'v:val != 0'))
      if i > 0
        break
      endif
    endwhile
  endif

  for triple in [[0, 'd[o] > 1', -1], [1, 'd[o] < x', +1]]
    let [o, ev, df] = triple

    while eval(ev)
      let line = getline(d[o] + df)
      let idt = s:indent_len(line)

      if eval('idt '.a:op.' i') && (a:skip_blank || !empty(line)) || (a:skip_blank && empty(line))
        let d[o] += df
      else | break | end
    endwhile
  endfor
  execute printf('normal! %dGV%dG', max([1, d[0] + a:bd]), min([x, d[1] + a:ed]))
endfunction
xnoremap <silent> ii :<c-u>call <SID>indent_object('>=', 1, line("'<"), line("'>"), 0, 0)<cr>
onoremap <silent> ii :<c-u>call <SID>indent_object('>=', 1, line('.'), line('.'), 0, 0)<cr>
xnoremap <silent> ai :<c-u>call <SID>indent_object('>=', 1, line("'<"), line("'>"), -1, 1)<cr>
onoremap <silent> ai :<c-u>call <SID>indent_object('>=', 1, line('.'), line('.'), -1, 1)<cr>
xnoremap <silent> io :<c-u>call <SID>indent_object('==', 0, line("'<"), line("'>"), 0, 0)<cr>
onoremap <silent> io :<c-u>call <SID>indent_object('==', 0, line('.'), line('.'), 0, 0)<cr>

" ----------------------------------------------------------------------------
" <Leader>I/A | Prepend/Append to all adjacent lines with same indentation
" ----------------------------------------------------------------------------
nmap <silent> <leader>I ^vio<C-V>I
nmap <silent> <leader>A ^vio<C-V>$A

" ----------------------------------------------------------------------------
" ?i_ ?a_ ?i. ?a. ?i, ?a, ?i/
" ----------------------------------------------------------------------------
function! s:between_the_chars(incll, inclr, char, vis)
  let cursor = col('.')
  let line   = getline('.')
  let before = line[0 : cursor - 1]
  let after  = line[cursor : -1]
  let [b, e] = [cursor, cursor]

  try
    let i = stridx(join(reverse(split(before, '\zs')), ''), a:char)
    if i < 0 | throw 'exit' | end
    let b = len(before) - i + (a:incll ? 0 : 1)

    let i = stridx(after, a:char)
    if i < 0 | throw 'exit' | end
    let e = cursor + i + 1 - (a:inclr ? 0 : 1)

    execute printf("normal! 0%dlhv0%dlh", b, e)
  catch 'exit'
    call s:textobj_cancel()
    if a:vis
      normal! gv
    endif
  finally
    " Cleanup command history
    if histget(':', -1) =~ '<SNR>[0-9_]*between_the_chars('
      call histdel(':', -1)
    endif
    echo
  endtry
endfunction

for [s:c, s:l] in items({'_': 0, '.': 0, ',': 0, '/': 1, '-': 0})
  execute printf("xmap <silent> i%s :<C-U>call <SID>between_the_chars(0,  0, '%s', 1)<CR><Plug>(TOC)", s:c, s:c)
  execute printf("omap <silent> i%s :<C-U>call <SID>between_the_chars(0,  0, '%s', 0)<CR><Plug>(TOC)", s:c, s:c)
  execute printf("xmap <silent> a%s :<C-U>call <SID>between_the_chars(%s, 1, '%s', 1)<CR><Plug>(TOC)", s:c, s:l, s:c)
  execute printf("omap <silent> a%s :<C-U>call <SID>between_the_chars(%s, 1, '%s', 0)<CR><Plug>(TOC)", s:c, s:l, s:c)
endfor

" ----------------------------------------------------------------------------
" ?ie | entire object
" ----------------------------------------------------------------------------
xnoremap <silent> ie gg0oG$
onoremap <silent> ie :<C-U>execute "normal! m`"<Bar>keepjumps normal! ggVG<CR>

" ----------------------------------------------------------------------------
" ?i# | inner comment
" ----------------------------------------------------------------------------
function! s:inner_comment(vis)
  if synIDattr(synID(line('.'), col('.'), 0), 'name') !~? 'comment'
    call s:textobj_cancel()
    if a:vis
      normal! gv
    endif
    return
  endif

  let origin = line('.')
  let lines = []
  for dir in [-1, 1]
    let line = origin
    let line += dir
    while line >= 1 && line <= line('$')
      execute 'normal!' line.'G^'
      if synIDattr(synID(line('.'), col('.'), 0), 'name') !~? 'comment'
        break
      endif
      let line += dir
    endwhile
    let line -= dir
    call add(lines, line)
  endfor

  execute 'normal!' lines[0].'GV'.lines[1].'G'
endfunction
xmap <silent> i# :<C-U>call <SID>inner_comment(1)<CR><Plug>(TOC)
omap <silent> i# :<C-U>call <SID>inner_comment(0)<CR><Plug>(TOC)

" ----------------------------------------------------------------------------
" ?ic / ?iC | Blockwise column object
" ----------------------------------------------------------------------------
function! s:inner_blockwise_column(vmode, cmd)
  if a:vmode == "\<C-V>"
    let [pvb, pve] = [getpos("'<"), getpos("'>")]
    normal! `z
  endif

  execute "normal! \<C-V>".a:cmd."o\<C-C>"
  let [line, col] = [line('.'), col('.')]
  let [cb, ce]    = [col("'<"), col("'>")]
  let [mn, mx]    = [line, line]

  for dir in [1, -1]
    let l = line + dir
    while line('.') > 1 && line('.') < line('$')
      execute "normal! ".l."G".col."|"
      execute "normal! v".a:cmd."\<C-C>"
      if cb != col("'<") || ce != col("'>")
        break
      endif
      let [mn, mx] = [min([line('.'), mn]), max([line('.'), mx])]
      let l += dir
    endwhile
  endfor

  execute printf("normal! %dG%d|\<C-V>%s%dG", mn, col, a:cmd, mx)

  if a:vmode == "\<C-V>"
    normal! o
    if pvb[1] < line('.') | execute "normal! ".pvb[1]."G" | endif
    if pvb[2] < col('.')  | execute "normal! ".pvb[2]."|" | endif
    normal! o
    if pve[1] > line('.') | execute "normal! ".pve[1]."G" | endif
    if pve[2] > col('.')  | execute "normal! ".pve[2]."|" | endif
  endif
endfunction

xnoremap <silent> ic mz:<C-U>call <SID>inner_blockwise_column(visualmode(), 'iw')<CR>
xnoremap <silent> iC mz:<C-U>call <SID>inner_blockwise_column(visualmode(), 'iW')<CR>
xnoremap <silent> ac mz:<C-U>call <SID>inner_blockwise_column(visualmode(), 'aw')<CR>
xnoremap <silent> aC mz:<C-U>call <SID>inner_blockwise_column(visualmode(), 'aW')<CR>
onoremap <silent> ic :<C-U>call   <SID>inner_blockwise_column('',           'iw')<CR>
onoremap <silent> iC :<C-U>call   <SID>inner_blockwise_column('',           'iW')<CR>
onoremap <silent> ac :<C-U>call   <SID>inner_blockwise_column('',           'aw')<CR>
onoremap <silent> aC :<C-U>call   <SID>inner_blockwise_column('',           'aW')<CR>

" }}}
" ============================================================================
" PLUGINS {{{
" ============================================================================
" ----------------------------------------------------------------------------
" fzf
" ----------------------------------------------------------------------------"
command! -nargs=? -complete=dir AF
  \ call fzf#run(fzf#wrap(fzf#vim#with_preview({
  \   'source': 'fd --type f --hidden --follow --exclude .git --no-ignore . '.expand(<q-args>)
  \ })))

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" nnoremap <silent> <Leader><Leader> :Files<CR>
nnoremap <silent> <expr> ; (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader>f        :History<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>L        :Lines<CR>
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
nnoremap <silent> <Leader>ag       :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG       :Ag <C-R><C-A><CR>
xnoremap <silent> <Leader>ag       y:Ag <C-R>"<CR>
nnoremap <silent> <Leader>`        :Marks<CR>
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let options = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  if a:fullscreen
    let options = fzf#vim#with_preview(options)
  endif
  call fzf#vim#grep(initial_command, 1, options, a:fullscreen)
endfunction


vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" When you press gv you Ack after the selected text
vnoremap <silent> -bang gv :call VisualSelection('gv', '')<CR>

func! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call RipgrepFzf(l:pattern, 1)
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
nnoremap <silent> <Leader>r :RG <C-R><C-W><CR>

" ----------------------------------------------------------------------------
" airline
" ----------------------------------------------------------------------------"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" ----------------------------------------------------------------------------
" airline
" ----------------------------------------------------------------------------"
let g:prettier#autoformat = 1 
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.scss,*.json,*.md,*.yaml PrettierAsync
let g:prettier#config#tab_width = 4 
let g:prettier#config#print_width = 100

" ----------------------------------------------------------------------------
" coc-nvim
" ----------------------------------------------------------------------------"
if has_key(g:plugs, 'coc.nvim')
    " TextEdit might fail if hidden is not set.
    set hidden

    " Some servers have issues with backup files, see #649.
    set nobackup
    set nowritebackup

    " Give more space for displaying messages.
    set cmdheight=2

    " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    " delays and poor user experience.
    set updatetime=300

    " Don't pass messages to |ins-completion-menu|.
    set shortmess+=c

    " Always show the signcolumn, otherwise it would shift the text each time
    " diagnostics appear/become resolved.
    set signcolumn=yes
    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
    " position. Coc only does snippet and additional edit on confirm.
    if has('patch8.1.1068')
      " Use `complete_info` if your (Neo)Vim version supports it.
      inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    else
      imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    " Use <TAB> for selections ranges.
    " NOTE: Requires 'textDocument/selectionRange' support from the language server.
    " coc-tsserver, coc-python are the examples of servers that support it.
    "nmap <silent> <TAB> <Plug>(coc-range-select)
    "xmap <silent> <TAB> <Plug>(coc-range-select)

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Mappings using CoCList:
    " Show all diagnostics.
    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions.
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " Show commands.
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document.
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols.
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list.
    nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

    let g:lightline = {
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'component_function': {
	\   'cocstatus': 'coc#status'
	\ },
	\ }

    " Use auocmd to force lightline update.
    autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
endif

" }}}
" ============================================================================
" AUTOCMD {{{
" ============================================================================

augroup vimrc
  "au BufWritePost vimrc,.vimrc nested if expand('%') !~ 'fugitive' | source % | endif

  " File types
  au BufNewFile,BufRead *.icc               set filetype=cpp
  au BufNewFile,BufRead Dockerfile*         set filetype=dockerfile
  au BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
  
  " Return to last edit position when opening files (You want this!)
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  
  " Fugitive
  au FileType gitcommit setlocal completefunc=emoji#complete
  au FileType gitcommit nnoremap <buffer> <silent> cd :<C-U>Gcommit --amend --date="$(date)"<CR>

  " Unset paste on InsertLeave
  au InsertLeave * silent! set nopaste

  " Close preview window
  if exists('##CompleteDone')
    au CompleteDone * pclose
  else
    au InsertLeave * if !pumvisible() && (!exists('*getcmdwintype') || empty(getcmdwintype())) | pclose | endif
  endif
augroup END
