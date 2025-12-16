return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
      sync_install = false,
      auto_install = true,
      ignore_install = { "javascript" },
      highlight = {
        enable = true,
        disable = { "c", "rust" },
        additional_vim_regex_highlighting = false,
      },
      -- rainbow = {
      --   enable = true,
      --   -- Which query to use for finding delimiters
      --   query = 'rainbow-parens',
      --   -- Highlight the entire buffer all at once
      --   strategy = require 'ts-rainbow.strategy.global',
      --   -- Do not enable for files with morethan n lines
      --   max_file_lines = 3000
      -- }
    },
  },
}

