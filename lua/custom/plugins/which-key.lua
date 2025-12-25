return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    spec = {
      { '<leader>c', group = 'Claude Code' },
      { '<leader>cc', desc = 'Toggle Claude' },
      { '<leader>cf', desc = 'Focus Claude' },
      { '<leader>cm', desc = 'Select Model' },
      { '<leader>cs', desc = 'Send Selection', mode = 'v' },
      { '<leader>ca', desc = 'Accept Changes' },
      { '<leader>cd', desc = 'Reject Changes' },
    },
  },
}
