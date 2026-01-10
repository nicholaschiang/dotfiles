-- Load the existing vimscript ~/.vimrc
-- https://neovim.io/doc/user/lua-guide.html#_using-vim-commands-and-functions-from-lua
vim.cmd("source ~/.vimrc")

-- Use LSP for Rhombus/Shplait syntax highlighting
-- https://neovim.io/doc/user/lsp.html
-- https://github.com/benknoble/vim-racket/issues/13
-- https://docs.racket-lang.org/shplait/index.html
-- https://docs.racket-lang.org/rhombus-guide/index.html
--
-- yay -S extra/racket
-- raco pkg install racket-langserver
-- raco pkg install shplait
vim.lsp.config('racket', {
	cmd = {"racket",  "-l", "racket-langserver"},
	filetypes = { "rhombus", "shplait", "racket" },
	settings = {},
})
vim.lsp.enable('racket')
