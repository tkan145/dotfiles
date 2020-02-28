"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Mark Tran
"
" Sections:
"    -> Basic settings
"    -> mapping
"    -> autocmd
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ============================================================================
" BASIC SETTINGS
" ============================================================================

let mapleader      = ','

augroup vimrc
  autocmd!
augroup END

set nu                                  "line number
set relativenumber
set linespace=10
set autoindent 
set smartindent
set lazyredraw                          " Don't redraw while executing macros (good performance config)
set laststatus=2
set showcmd
set novisualbell                          " No annoying sound on errors
set noerrorbells
set t_vb=
set tm=500
set backspace=indent,eol,start          " Configure backspace so it acts as it should act
set timeoutlen=500
set whichwrap+=<,>,h,l
set shortmess=aIT
set hidden                              " A buffer becomes hidden when it is abandoned
set ignorecase                          " Ignore case when searching
set smartcase                           " When searching try to be smart about cases 
set hlsearch                            " Highlight search results
set incsearch                           " Makes search act like search in modern browsers
set showmatch                           " Show matching brackets when text indicator is over them
set mat=2                               " How many tenths of a second to blink when matching brackets
set wildmenu                            " Turn on the Wild menu
set wildmode=full                       " Complete the next full match
set wildignore=*.o,*~,*.pyc             " Ignore compiled file
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif
set tabstop=4                          " 1 tab == 2 spaces
set shiftwidth=4
set expandtab smarttab                 " Use spaces instead of tabs
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
set splitbelow

" Turn backup off, since most stuff is in SVN, git et.c anyway...
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

function! s:statusline_expr()
  let mod = "%{&modified ? '[+] ' : !&modifiable ? '[x] ' : ''}"
  let ro  = "%{&readonly ? '[RO] ' : ''}"
  let ft  = "%{len(&filetype) ? '['.&filetype.'] ' : ''}"
  let fug = "%{exists('g:loaded_fugitive') ? fugitive#statusline() : ''}"
  let sep = ' %= '
  let pos = ' %-12(%l : %c%V%) '
  let pct = ' %P'

  return '[%n] %F %<'.mod.ro.ft.fug.sep.pos.'%*'.pct
endfunction
let &statusline = s:statusline_expr()

set modelines=2
set synmaxcol=1000

" ctags
set tags=./tags;/

" set complete=.,w,b,u,t
set complete-=i

" mouse
silent! set ttymouse=xterm2
set mouse=a

" 100 chars/line
set textwidth=0
if exists('&colorcolumn')
  set colorcolumn=100
endif

" Linebreak on 100 characters
set lbr
set tw=100

" Keep the cursor on the same column
set nostartofline

if exists('&fixeol')
  set nofixeol
endif

" oisable scrollbars (real hackers don't use scrollbars for navigation!)
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" Enable filetype plugins
filetype plugin on
filetype indent on

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" Add a bit extra margin to the left
set foldcolumn=1

" Remap VIM 0 to first non-blank character
map 0 ^

" Persitence undo
set undodir=~/.vim/undodir
set undofile

" ----------------------------------------------------------------------------
" Colors and Fonts
" ----------------------------------------------------------------------------
syntax enable                           " Enable syntax highlighting
" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

"if has('termguicolors')
"  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"  set termguicolors
"endif

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

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

set background=dark
" ----------------------------------------------------------------------------
" Parenthesis/bracket
" ----------------------------------------------------------------------------
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i

" ============================================================================
" MAPPINGS
" ============================================================================
" ----------------------------------------------------------------------------
" Basic mappings
" ----------------------------------------------------------------------------
set pastetoggle=<F7>

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Fast editing and reloading of vimrc configs
" map <leader>r :e! ~/.vimrc/my_configs.vim<cr>
" autocmd! bufwritepost ~/.vim_runtime/my_configs.vim source ~/.vim_runtime/my_configs.vim

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

" Tags
nnoremap <C-]> g<C-]>
nnoremap g[ :pop<cr>

" Jump list (to newer position)
nnoremap <C-p> <C-i>

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
" Quickfix
" ----------------------------------------------------------------------------
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

" Make sure that enter is never overriden in the quickfix window
" autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" ----------------------------------------------------------------------------
" Buffers
" ----------------------------------------------------------------------------
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" Close the current buffer
map <leader>bd  :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

map <leader>t :e ~/todo.md<cr>
" ----------------------------------------------------------------------------
" Tabs
" ----------------------------------------------------------------------------
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>
map <leader>tn :tabnew<cr>
map <leader>tc :tabclose<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" ----------------------------------------------------------------------------
" <tab> / <s-tab> | Circular windows navigation
" ----------------------------------------------------------------------------
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

" ----------------------------------------------------------------------------
" <tab> / <s-tab> / <c-v><tab> | super-duper-tab
" ----------------------------------------------------------------------------
function! s:can_complete(func, prefix)
  if empty(a:func)
    return 0
  endif
  let start = call(a:func, [1, ''])
  if start < 0
    return 0
  endif

  let oline  = getline('.')
  let line   = oline[0:start-1] . oline[col('.')-1:]

  let opos   = getpos('.')
  let pos    = copy(opos)
  let pos[2] = start + 1

  call setline('.', line)
  call setpos('.', pos)
  let result = call(a:func, [0, matchstr(a:prefix, '\k\+$')])
  call setline('.', oline)
  call setpos('.', opos)

  if !empty(type(result) == type([]) ? result : result.words)
    call complete(start + 1, result)
    return 1
  endif
  return 0
endfunction

function! s:feedkeys(k)
  call feedkeys(a:k, 'n')
  return ''
endfunction

function! s:super_duper_tab(pumvisible, next)
  let [k, o] = a:next ? ["\<c-n>", "\<tab>"] : ["\<c-p>", "\<s-tab>"]
  if a:pumvisible
    return s:feedkeys(k)
  endif

  let line = getline('.')
  let col = col('.') - 2
  if line[col] !~ '\k\|[/~.]'
    return s:feedkeys(o)
  endif

  let prefix = expand(matchstr(line[0:col], '\S*$'))
  if prefix =~ '^[~/.]'
    return s:feedkeys("\<c-x>\<c-f>")
  endif
  if s:can_complete(&omnifunc, prefix) || s:can_complete(&completefunc, prefix)
    return ''
  endif
  return s:feedkeys(k)
endfunction

"if has_key(g:plugs, 'ultisnips')
  " UltiSnips will be loaded only when tab is first pressed in insert mode
 " if !exists(':UltiSnipsEdit')
 "   inoremap <silent> <Plug>(tab) <c-r>=plug#load('ultisnips')?UltiSnips#ExpandSnippet():''<cr>
 "   imap <tab> <Plug>(tab)
 " endif

 " let g:SuperTabMappingForward  = "<tab>"
 " let g:SuperTabMappingBackward = "<s-tab>"
 " function! SuperTab(m)
 "   return s:super_duper_tab(a:m == 'n' ? "\<c-n>" : "\<c-p>",
 "                          \ a:m == 'n' ? "\<tab>" : "\<s-tab>")
 " endfunction
"else
  inoremap <silent> <tab>   <c-r>=<SID>super_duper_tab(pumvisible(), 1)<cr>
  inoremap <silent> <s-tab> <c-r>=<SID>super_duper_tab(pumvisible(), 0)<cr>
"endif

" Used by coc
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

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
" #gi / #gpi | go to next/previous indentation level
" ----------------------------------------------------------------------------
function! s:go_indent(times, dir)
  for _ in range(a:times)
    let l = line('.')
    let x = line('$')
    let i = s:indent_len(getline(l))
    let e = empty(getline(l))

    while l >= 1 && l <= x
      let line = getline(l + a:dir)
      let l += a:dir
      if s:indent_len(line) != i || empty(line) != e
        break
      endif
    endwhile
    let l = min([max([1, l]), x])
    execute 'normal! '. l .'G^'
  endfor
endfunction
nnoremap <silent> gi :<c-u>call <SID>go_indent(v:count1, 1)<cr>
nnoremap <silent> gpi :<c-u>call <SID>go_indent(v:count1, -1)<cr>

" ----------------------------------------------------------------------------
" <leader>bs | buf-search
" ----------------------------------------------------------------------------
nnoremap <leader>bs :cex []<BAR>bufdo vimgrepadd @@g %<BAR>cw<s-left><s-left><right>

" ----------------------------------------------------------------------------
" <leader>space | term
" ----------------------------------------------------------------------------
nnoremap <leader><space> :term ++close ./release.sh<cr>

" ----------------------------------------------------------------------------
" #!! | Shebang
" ----------------------------------------------------------------------------
inoreabbrev <expr> #!! "#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)

" ----------------------------------------------------------------------------
" #!! | Shebang
" ----------------------------------------------------------------------------
map <leader>e :e! ~/.vim_runtime/my_configs.vim<cr>
autocmd! bufwritepost ~/.vim_runtime/my_configs.vim source ~/.vim_runtime/my_configs.vim

" ============================================================================
" FUNCTIONS & COMMANDS {{{
" ============================================================================
" ----------------------------------------------------------------------------
" :CopyRTF
" ----------------------------------------------------------------------------
function! s:colors(...)
  return filter(map(filter(split(globpath(&rtp, 'colors/*.vim'), "\n"),
        \                  'v:val !~ "^/usr/"'),
        \           'fnamemodify(v:val, ":t:r")'),
        \       '!a:0 || stridx(v:val, a:1) >= 0')
endfunction

function! s:copy_rtf(line1, line2, ...)
  let [ft, cs, nu] = [&filetype, g:colors_name, &l:nu]
  let lines = getline(1, '$')

  tab new
  setlocal buftype=nofile bufhidden=wipe nonumber
  let &filetype = ft
  call setline(1, lines)
  doautocmd BufNewFile filetypedetect

  execute 'colo' get(a:000, 0, 'seoul256-light')
  hi Normal ctermbg=NONE guibg=NONE

  let lines = getline(a:line1, a:line2)
  let indent = repeat(' ', min(map(filter(copy(lines), '!empty(v:val)'), 'len(matchstr(v:val, "^ *"))')))
  call setline(a:line1, map(lines, 'substitute(v:val, indent, "", "")'))

  call tohtml#Convert2HTML(a:line1, a:line2)
  g/^\(pre\|body\) {/s/background-color: #[0-9]*; //
  silent %write !textutil -convert rtf -textsizemultiplier 1.3 -stdin -stdout | ruby -e 'puts STDIN.read.sub(/\\\n}$/m, "\n}")' | pbcopy

  bd!
  tabclose

  let &l:nu = nu
  execute 'colorscheme' cs
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
" <F4> | Swap betwen header and cpp file
" ----------------------------------------------------------------------------
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

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
  elseif &filetype == 'python'
    execute prefix.'python '.file.rdr
  elseif &filetype == 'go'
    execute prefix.'go run '.file.rdr
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

" ----------------------------------------------------------------------------
" Clean extra space on save
" ----------------------------------------------------------------------------
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

" ----------------------------------------------------------------------------
" Visual mode pressing * or # searches for the current selection
" ----------------------------------------------------------------------------
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
" Visual mode pressing * or # searches for the current selection
" ----------------------------------------------------------------------------
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Use the the_silver_searcher if possible (much faster than Ack)
"if executable('ag')
"   let g:ackprg = 'ag --vimgrep --smart-case'
"endif

"   When you press gv you Ack after the selected text
" vnoremap <silent> <F2> :call VisualSelection('gv', '')<CR>

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" ----------------------------------------------------------------------------
" Spell checking
" ----------------------------------------------------------------------------
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" ============================================================================
" TEXT OBJECTS
" ============================================================================

" ----------------------------------------------------------------------------
" ?i<shift>-` | Inside ``` block
" ----------------------------------------------------------------------------
xnoremap <silent> i~ g_?^\s*```<cr>jo/^\s*```<cr>kV:<c-u>nohl<cr>gv
xnoremap <silent> a~ g_?^\s*```<cr>o/^\s*```<cr>V:<c-u>nohl<cr>gv
onoremap <silent> i~ :<C-U>execute "normal vi~"<cr>
onoremap <silent> a~ :<C-U>execute "normal va~"<cr>

" ============================================================================
" AUTOCMD {{{
" ============================================================================
augroup vimrc
  au BufWritePost vimrc,.vimrc nested if expand('%') !~ 'fugitive' | source % | endif

  " File types
  au BufNewFile,BufRead *.icc               set filetype=cpp
  au BufNewFile,BufRead *.py                set filetype=python
  au BufNewFile,BufRead *.go                set filetype=go
  au BufNewFile,BufRead Dockerfile*         set filetype=dockerfile

  " Included syntax
  " au FileType,ColorScheme * call <SID>file_type_handler()

  " Fugitive
  au FileType gitcommit setlocal completefunc=emoji#complete
  au FileType gitcommit nnoremap <buffer> <silent> cd :<C-U>Gcommit --amend --date="$(date)"<CR>

  " http://vim.wikia.com/wiki/Highlight_unwanted_spaces
  au BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
  au InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/

  " Unset paste on InsertLeave
  au InsertLeave * silent! set nopaste

  " Close preview window
  if exists('##CompleteDone')
    au CompleteDone * pclose
  else
    au InsertLeave * if !pumvisible() && (!exists('*getcmdwintype') || empty(getcmdwintype())) | pclose | endif
  endif

  autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.go,*.cpp,*.h :call CleanExtraSpaces()
augroup END

:command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> -
:command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> - |fmt -csw78



