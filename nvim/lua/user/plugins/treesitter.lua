require('nvim-treesitter.configs').setup({
  ensure_installed = {
    "gitignore",
    "jsdoc",
    "php",
    "phpdoc",
    "vue",
    "html",
    "css",
    "javascript",
    "typescript",
    "json",
    "lua",
    "sql",
    "vim",
    "vimdoc",
    "yaml",
    "c",
    "rust",
  },
  auto_install = true,
  highlight = {
    enable = true,
    disable = { 'NvimTree' },
    additional_vim_regex_highlighting = false,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["if"] = "@function.inner",
        ["af"] = "@function.outer",
        ["ic"] = "@class.inner",
        ["ac"] = "@class.outer",
        ['ia'] = '@parameter.inner',
        ['aa'] = '@parameter.outer',
      },
    },
  },
  context_commentstring = {
    enable = true,
  },
})
