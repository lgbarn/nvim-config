-- lua/plugins/precommit.lua
return {
  'ttibsi/pre-commit.nvim',
  -- lazy-load on command or key
  cmd = 'Precommit',
  keys = {
    { '<leader>pc', '<cmd>Precommit<CR>', desc = 'pre-commit (current file)' },
  },

  config = function()
    ----------------------------------------------------------------------
    -- helper: true if we're on a protected branch (main, master, prod …)
    ----------------------------------------------------------------------
    local function on_protected_branch()
      local ok, branch = pcall(function()
        return vim.fn.systemlist({ 'git', 'rev-parse', '--abbrev-ref', 'HEAD' })[1]
      end)
      if not ok or not branch or branch == '' then
        return false -- not a Git repo / detached HEAD → allow
      end

      -- customise this table to taste
      local protected = { main = true, master = true, prod = true }
      return protected[branch] ~= nil
    end

    ----------------------------------------------------------------------
    -- override the stock :Precommit command with a guard
    ----------------------------------------------------------------------
    -- grab the original implementation the plugin registered
    local original = require('precommit').execute

    -- delete the old user command (defined by plugin in plugin/precommit.vim)
    pcall(vim.api.nvim_del_user_command, 'Precommit')

    -- re-register with branch check
    vim.api.nvim_create_user_command('Precommit', function()
      if on_protected_branch() then
        vim.notify(
          '⚠️  pre-commit is disabled on the protected branch. ' .. 'Commit your changes on a feature branch instead.',
          vim.log.levels.WARN,
          { title = 'pre-commit' }
        )
        return
      end
      original() -- run the plugin's normal current-file workflow
    end, {})
  end,
}
