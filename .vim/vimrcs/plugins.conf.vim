" ============================================================================
" PLUGINS
" ============================================================================
" ----------------------------------------------------------------------------
" vim-plug extension
" ----------------------------------------------------------------------------
function! s:plug_gx()
  let line = getline('.')
  let sha  = matchstr(line, '^  \X*\zs\x\{7,9}\ze ')
  let name = empty(sha) ? matchstr(line, '^[-x+] \zs[^:]\+\ze:')
                      \ : getline(search('^- .*:$', 'bn'))[2:-2]
  let uri  = get(get(g:plugs, name, {}), 'uri', '')
  if uri !~ 'github.com'
    return
  endif
  let repo = matchstr(uri, '[^:/]*/'.name)
  let url  = empty(sha) ? 'https://github.com/'.repo
                      \ : printf('https://github.com/%s/commit/%s', repo, sha)
  call netrw#BrowseX(url, 0)
endfunction

function! s:scroll_preview(down)
  silent! wincmd P
  if &previewwindow
    execute 'normal!' a:down ? "\<c-e>" : "\<c-y>"
    wincmd p
  endif
endfunction

function! s:plug_doc()
  let name = matchstr(getline('.'), '^- \zs\S\+\ze:')
  if has_key(g:plugs, name)
    for doc in split(globpath(g:plugs[name].dir, 'doc/*.txt'), '\n')
      execute 'tabe' doc
    endfor
  endif
endfunction

function! s:setup_extra_keys()
  " PlugDiff
  nnoremap <silent> <buffer> J :call <sid>scroll_preview(1)<cr>
  nnoremap <silent> <buffer> K :call <sid>scroll_preview(0)<cr>
  nnoremap <silent> <buffer> <c-n> :call search('^  \X*\zs\x')<cr>
  nnoremap <silent> <buffer> <c-p> :call search('^  \X*\zs\x', 'b')<cr>
  nmap <silent> <buffer> <c-j> <c-n>o
  nmap <silent> <buffer> <c-k> <c-p>o

  " gx
  nnoremap <buffer> <silent> gx :call <sid>plug_gx()<cr>

  " helpdoc
  nnoremap <buffer> <silent> H  :call <sid>plug_doc()<cr>
endfunction

autocmd vimrc FileType vim-plug call s:setup_extra_keys()

let g:plug_window = '-tabnew'
let g:plug_pwindow = 'vertical rightbelow new'

" ----------------------------------------------------------------------------
" goyo.vim
" ----------------------------------------------------------------------------
function! s:goyo_enter()
  if has('gui_running')
    set fullscreen
    set background=light
    set linespace=7
  elseif exists('$TMUX')
    silent !tmux set status off
  endif
  let &l:statusline = '%M'
  hi StatusLine ctermfg=red guifg=red cterm=NONE gui=NONE
endfunction

function! s:goyo_leave()
  if has('gui_running')
    set nofullscreen
    set background=dark
    set linespace=0
  elseif exists('$TMUX')
    silent !tmux set status on
  endif
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
nnoremap <silent> <leader>z :Goyo<cr>

" ----------------------------------------------------------------------------
" vim-signify
" ----------------------------------------------------------------------------
let g:signify_vcs_list = ['git']
let g:signify_skip_filetype = { 'journal': 1 }
"highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
"highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
"highlight DiffChange        cterm=bold ctermbg=none ctermfg=227

" ----------------------------------------------------------------------------
" undotree
" ----------------------------------------------------------------------------
let g:undotree_WindowLayout = 2
nnoremap U :UndotreeToggle<CR>

" ----------------------------------------------------------------------------
" indentLine
" ----------------------------------------------------------------------------
let g:indentLine_enable = 1
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#616161'

" ----------------------------------------------------------------------------
" Tagbar
" ----------------------------------------------------------------------------
let g:tagbar_sort = 0
nnoremap <silent> <F9> :TagbarToggle<cr>

" ----------------------------------------------------------------------------
" vim-fugitive
" ----------------------------------------------------------------------------
nmap     <Leader>g :Gstatus<CR>gg<c-n>
nnoremap <Leader>d :Gdiff<CR>

" ----------------------------------------------------------------------------
" ack.vim
" ----------------------------------------------------------------------------
"if executable('ag')
"  let &grepprg = 'ag --nogroup --nocolor --column'
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
"  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
"  let g:ctrlp_use_caching = 0
"else
"  let &grepprg = 'grep -rn $* *'
"endif
"command! -nargs=1 -bar Grep execute 'silent! grep! <q-args>' | redraw! | copen
"nnoremap <silent> <F2> :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
" ----------------------------------------------------------------------------
" ALE
" ----------------------------------------------------------------------------
let g:ale_linters = {
\ 'javascript': [],
\ 'yaml': [],
\ 'python': ['flake8','pylint','pep8'],
\ 'go': ['gopls'],
\}
let g:ale_linters_explicit = 1
let g:ale_fixers = {
\  'python': ['autopep8'],
\}
let g:ale_lint_delay = 1000
let g:ale_sign_warning = 'W'
let g:ale_sign_error = 'E'

" Only run linting when saving the file
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_open_list = 0
let g:ale_open_quickfix = 0

" Python virtualenv
nmap ]a <Plug>(ale_next_wrap)
nmap [a <Plug>(ale_previous_wrap)

" ----------------------------------------------------------------------------
" Prettier
" ----------------------------------------------------------------------------
let g:prettier#autoformat = 1
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.scss,*.json,*.md,*.yaml,*.html PrettierAsync
let g:prettier#config#tab_width = 4
let g:prettier#config#print_width = 100

" ----------------------------------------------------------------------------
" COC
" ----------------------------------------------------------------------------
let g:coc_selectmode_mapping = 0
hi CocErrorSign   ctermfg=15 ctermbg=236
hi CocWarningSign ctermfg=15 ctermbg=236
" Bindings
nmap <silent> <leader>df <Plug>(coc-definition)
nmap <silent> <leader>dc <Plug>(coc-declaration)
nmap <silent> <leader>td <Plug>(coc-type-definition)
nmap <silent> <leader>im <Plug>(coc-implementation)
nmap <silent> <leader>rf <Plug>(coc-references)
nmap <silent> <leader>rn <Plug>(coc-rename)

" ----------------------------------------------------------------------------
" gruvbox
" ----------------------------------------------------------------------------
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'hard'

" ----------------------------------------------------------------------------
" vim-go
" ----------------------------------------------------------------------------
let g:go_def_mapping_enabled = 0
let g:go_fmt_command = 'goimports'
let g:go_def_reuse_buffer = 1
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_fmt_autosave = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_statusline_duration = 10000

" ----------------------------------------------------------------------------
" airline
" ----------------------------------------------------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tagbar#enabled = 0

" Enable ale integration with airline.
let g:airline#extensions#ale#enabled = 1
let airline#extensions#ale#error_symbol = 'E:'
let airline#extensions#ale#warning_symbol = 'W:'
let airline#extensions#ale#show_line_numbers = 1

" Enable coc integration
let g:airline#extensions#coc#enabled = 1
let airline#extensions#coc#error_symbol = 'E>'
let airline#extensions#coc#warning_symbol = 'W>'
let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

" ----------------------------------------------------------------------------
" CTRL-P
" ----------------------------------------------------------------------------
"let g:ctrlp_working_path_mode = 0
"let g:ctrlp_map = '<c-f>'
"map ; :CtrlP<cr>
"map <leader>b :CtrlPBuffer<cr>
"map <leader>f :CtrlPMRU<cr>
"let g:ctrlp_max_height = 20
"let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee|^\.svn\^\**/*pyc'

" ----------------------------------------------------------------------------
" FZF
" ----------------------------------------------------------------------------
map ; :Files<cr>
map <leader>b :Buffers<cr>
map <leader>l :Lines<cr>
map <leader>f :History<cr>
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)
nnoremap <silent> <F2> :Rg <C-R><C-W><CR>:cw<CR>

" ----------------------------------------------------------------------------
" Nerd Tree
" ----------------------------------------------------------------------------
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <leader>n :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>

" ----------------------------------------------------------------------------
" surround.vim config
" ----------------------------------------------------------------------------
vmap Si S(i_<esc>f)
au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>
