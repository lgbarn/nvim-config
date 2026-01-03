return {
  {
    'folke/snacks.nvim',
    lazy = true, -- Load on-demand when Claude Code needs terminal
    opts = {
      terminal = {
        win = {
          position = 'right',
          width = 0.4,
        },
      },
    },
  },
}
