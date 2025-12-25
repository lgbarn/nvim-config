return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {
    modes = {
      char = {
        enabled = false, -- disables overriding f/F/t/T
      },
    },
  },
  keys = {
    {
      '<leader>f',
      function()
        require('flash').jump()
      end,
      mode = { 'n', 'x', 'o' },
      desc = 'Flash Jump',
    },
    {
      '<leader>F',
      function()
        require('flash').treesitter()
      end,
      mode = { 'n', 'x', 'o' },
      desc = 'Flash Treesitter',
    },
  },
}
