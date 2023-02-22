set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua require("lsp_config")

" Import on save
autocmd BufWritePost *.go lua vim.lsp.buf.format { async = true }
autocmd BufWritePre *.go lua org_imports(1000)

