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
      's',
      function()
        require('flash').jump()
      end,
      mode = { 'n', 'x', 'o' },
      desc = 'Flash Jump',
    },
    {
      'S',
      function()
        require('flash').treesitter()
      end,
      mode = { 'n', 'x', 'o' },
      desc = 'Flash Treesitter',
    },
  },
}
