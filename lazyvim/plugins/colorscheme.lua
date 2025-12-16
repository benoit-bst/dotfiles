return {
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      bold = false,
      italic = {
        strings = false,
        emphasis = false,
        comments = false,
        operators = false,
        folds = false,
      },
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      color_overrides = {
        mocha = {
          base = "#1c1c1c",
          mantle = "#1c1c1c",    -- secondary background
          crust = "#1c1c1c",     -- outer background
          btext1 = "#E3E3E3",
          subtext0 = "#CFCFCF",
          overlay2 = "#AFAFAF",
          overlay1 = "#9E9E9E",
          overlay0 = "#8E8E8E",
          surface2 = "#757575",
          surface1 = "#5F5F5F",
          surface0 = "#494949",
          rosewater = "#F92672", -- pink/red accent
          flamingo = "#F7649A",
          pink = "#C0146D",
          mauve = "#E9A0E9",     -- purple
          red = "#F92672",
          maroon = "#F92672",
          peach = "#FD971F",     -- orange
          yellow = "#B2C014",
          green = "#2B9710",
          teal = "#399CC6",      -- cyan
          sky = "#66D9EF",
          sapphire = "#66D9EF",
          blue = "#399CC6",
          lavender = "#DB518B",


        },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  -- -- Rainbow Highlighting
  -- {
  --   "HiPhish/nvim-ts-rainbow2",
  -- },
}

