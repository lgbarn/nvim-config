return {
  {
    'coder/claudecode.nvim',
    dependencies = {
      'folke/snacks.nvim',
    },
    cmd = {
      'ClaudeCode',
      'ClaudeCodeFocus',
      'ClaudeCodeSelectModel',
      'ClaudeCodeSend',
      'ClaudeCodeAdd',
      'ClaudeCodeDiffAccept',
      'ClaudeCodeDiffDeny',
    },
    keys = {
      { '<leader>cc', '<cmd>ClaudeCode<cr>', desc = 'Toggle Claude Code' },
      { '<leader>cf', '<cmd>ClaudeCodeFocus<cr>', desc = 'Focus Claude Code' },
      { '<leader>cm', '<cmd>ClaudeCodeSelectModel<cr>', desc = 'Select Claude Model' },
      { '<leader>cs', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send Selection to Claude' },
      { '<leader>ca', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept Claude Changes' },
      { '<leader>cd', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Reject Claude Changes' },
    },
    opts = {
      git_repo_cwd = true,
      terminal_provider = 'auto',
      selection_tracking = {
        enabled = true,
        debounce_ms = 100,
      },
      diff_opts = {
        auto_show = true,
      },
    },
  },
}
