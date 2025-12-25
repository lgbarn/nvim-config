return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {
    dir = vim.fn.expand(vim.fn.stdpath 'state' .. '/sessions/'),
    options = { 'buffers', 'curdir', 'tabpages', 'winsize' },
  },
  keys = {
    {
      '<leader>wr',
      function()
        require('persistence').load()
      end,
      desc = 'Restore session for cwd',
    },
    {
      '<leader>ws',
      function()
        require('persistence').save()
      end,
      desc = 'Save session for cwd',
    },
    {
      '<leader>wl',
      function()
        require('persistence').load { last = true }
      end,
      desc = 'Restore last session',
    },
  },
  config = function(_, opts)
    require('persistence').setup(opts)
    -- Auto-restore on startup (optional)
    vim.api.nvim_create_autocmd('VimEnter', {
      group = vim.api.nvim_create_augroup('restore_session', { clear = true }),
      callback = function()
        if vim.fn.argc() == 0 then
          require('persistence').load()
        end
      end,
      nested = true,
    })
  end,
}
