return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      ensure_installed = {
        "c",
        "cpp",
        "cmake",
        "c_sharp",
        "rust",
        "scala",
        "python",
        "lua",
        "luadoc",
        "luap",
        "groovy",
        "java",
        "javascript",
        "bash",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "markdown",
        "markdown_inline",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
    },
  },
}
