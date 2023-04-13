local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').reset()
require('packer').init({
  compile_path = vim.fn.stdpath('data')..'/site/plugin/packer_compiled.lua',
  display = {
    open_fn = function ()
      return require('packer.util').float({ border = 'solid' })
    end,
  },
})

local use = require('packer').use

-- Packer can manage itself
use ('wbthomason/packer.nvim')

-- Commenting support.
use('tpope/vim-commentary')

use({
  'jessarcher/onedark.nvim',
  config = function()
    vim.cmd('colorscheme onedark')

    -- Hide the characters in FloatBorder
    vim.api.nvim_set_hl(0, 'FloatBorder', {
      fg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
      bg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
    })

    -- Make the StatusLineonText background the same as StatusLine
    vim.api.nvim_set_hl(0, 'StatusLineNonText', {
      fg = vim.api.nvim_get_hl_by_name('NonText', true).foreground,
      bg = vim.api.nvim_get_hl_by_name('StatusLine', true).background,
    })

    -- Hide the characters in CursorLineBg
    vim.api.nvim_set_hl(0, 'CursorLineBg', {
      fg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
      bg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
    })

    vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', { fg = '#30323E' })
    vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#2F313C' })
  end,
})

-- Add, change, and delete surrounding text
use("tpope/vim-surround")

-- Useful commands like :Rename and SudoWrite
use('tpope/vim-eunuch')

-- Pairs of handy bracket mappings, like [b and ]b
use('tpope/vim-unimpaired')

-- Indent autodetection with editorconfig support.
use('tpope/vim-sleuth')

-- Allow plugins to enable repeating commands.
use('tpope/vim-repeat')

use('jessarcher/vim-heritage') -- Automatically create parent dirs when saving
use('nelstrom/vim-visual-star-search')
use('christoomey/vim-tmux-navigator')
use({
  'airblade/vim-rooter',
  setup = function()
    vim.g.rooter_manual_only = 1
  end,
  config = function()
    vim.cmd('Rooter')
  end,
})
use('farmergreg/vim-lastplace')

use({
  'kyazdani42/nvim-tree.lua',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('user.plugins.nvim-tree')
  end,
})

use({
  'whatyouhide/vim-textobj-xmlattr',
  requires = 'kana/vim-textobj-user',
})

use({
  'windwp/nvim-autopairs',
  config = function()
    require('nvim-autopairs').setup()
  end,
})

use({
  'karb94/neoscroll.nvim',
  config = function()
    require('user.plugins.neoscroll')
  end,
})

use({
  'famiu/bufdelete.nvim',
  config = function()
    vim.keymap.set('n', '<Leader>q', ':Bdelete<CR>')
  end,
})

use({
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    require('user.plugins.indent-blankline')
  end,
})

use({
  'AndrewRadev/splitjoin.vim',
  config = function()
    require('user.plugins.splitjoin')
  end,
})

use({
  'sickill/vim-pasta',
  config = function()
    vim.g.pasta_disabled_filetypes = { 'fugitive' }
  end,
})

use({
  'nvim-lualine/lualine.nvim',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('user.plugins.lualine')
  end,
})

use({
  'akinsho/bufferline.nvim',
  requires = 'kyazdani42/nvim-web-devicons',
  after = 'onedark.nvim',
  config = function()
    require('user.plugins.bufferline')
  end,
})

use({
  'glepnir/dashboard-nvim',
  config = function()
    require('user.plugins.dashboard')
  end,
})

-- just testing

use({
  'lewis6991/gitsigns.nvim',
  requires = 'nvim-lua/plenary.nvim',
  config = function()
    require('gitsigns').setup({
      sign_priority = 20,
      current_line_blame = true,
      -- on_attach = function(bufnr)
      --   vim.keymap.set('n', ']h', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true, buffer = bufnr })
      --   vim.keymap.set('n', '[h', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true, buffer = bufnr })
      -- end,
    })
    vim.keymap.set('n', ']h', ':Gitsigns next_hunk<CR>')
    vim.keymap.set('n', '[h', ':Gitsigns prev_hunk<CR>')
    vim.keymap.set('n', 'gs', ':Gitsigns stage_hunk<CR>')
    vim.keymap.set('n', 'gu', ':Gitsigns undo_stage_hunk<CR>')
    vim.keymap.set('n', 'gp', ':Gitsigns preview_hunk<CR>')
    vim.keymap.set('n', 'gb', ':Gitsigns blame_line<CR>')
  end,
})

use({
  'voldikss/vim-floaterm',
  config = function()
    require('user.plugins.floaterm')
  end,
})

use({
  'nvim-telescope/telescope.nvim',
  requires = {
    { 'nvim-lua/plenary.nvim' },
    { 'kyazdani42/nvim-web-devicons' },
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    { 'nvim-telescope/telescope-live-grep-args.nvim' },
  },
  config = function()
    require('user.plugins.telescope')
  end,
})

use({
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  requires = {
    'nvim-treesitter/playground',
    'nvim-treesitter/nvim-treesitter-textobjects',
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  config = function()
    require('user.plugins.treesitter')
  end,
})

use({
  'tpope/vim-fugitive',
  requires = 'tpope/vim-rhubarb',
  cmd = 'G',
})

use({
  'neovim/nvim-lspconfig',
  requires = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'b0o/schemastore.nvim',
    'jose-elias-alvarez/null-ls.nvim',
    'jayp0521/mason-null-ls.nvim',
  },
  run = ':MasonUpdate',
  config = function()
    require('user/plugins/lspconfig')
  end,
})

-- PHP Refactoring tools
use({
  'phpactor/phpactor',
  ft = 'php',
  run = 'composer install --no-dev --optimize-autoloader',
  config = function()
    vim.keymap.set('n', '<Leader>pm', ':PhpactorContextMenu<CR>')
  end,
})

-- Completion
use({
  'hrsh7th/nvim-cmp',
  requires = {
    'L3MON4D3/LuaSnip',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-nvim-lua',
    'jessarcher/cmp-path',
    'onsails/lspkind-nvim',
    'saadparwaiz1/cmp_luasnip',
  },
  config = function()
    require('user.plugins.cmp')
  end,
})

-- Testing helper
use({
  'vim-test/vim-test',
  config = function()
    require('user/plugins/vim-test')
  end,
})

use({
  'github/copilot.vim',
  config = function()
    vim.keymap.set('i', '<C-J>', [[copilot#Accept("\<CR>")]], { expr = true })
  end,
})

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if packer_bootstrap then
    require('packer').sync()
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile>
  augroup end
]])

