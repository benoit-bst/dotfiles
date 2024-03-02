return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>se",
        function()
          require("telescope.builtin").grep_string({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Search string under cursor",
      },
    },
  },
}
