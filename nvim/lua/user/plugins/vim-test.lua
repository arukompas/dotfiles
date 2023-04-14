vim.g['test#enabled_runners'] = { "php#phpunit", "php#pest" }

vim.keymap.set('n', '<Leader>tn', ':w<CR>:TestNearest<CR>')
vim.keymap.set('n', '<Leader>tf', ':w<CR>:TestFile<CR>')
vim.keymap.set('n', '<Leader>ts', ':w<CR>:TestSuite<CR>')
vim.keymap.set('n', '<Leader>tl', ':w<CR>:TestLast<CR>')
vim.keymap.set('n', '<Leader>tv', ':w<CR>:TestVisit<CR>')

vim.cmd([[
  let test#php#phpunit#executable = 'php -dopcache.enable_cli=1  -dopcache.validate_timestamps=0 -dopcache.file_cache_consistency_checks=0 vendor/bin/phpunit'
  let test#php#phpunit#options = '--colors=always'

  function! FloatermStrategy(cmd)
    execute 'silent FloatermKill scratch'
    execute 'FloatermNew! --autoclose=2 --name=scratch '.a:cmd.' |less -X'
  endfunction
  let g:test#custom_strategies = {'floaterm': function('FloatermStrategy')}
  let g:test#strategy = 'floaterm'
]])
