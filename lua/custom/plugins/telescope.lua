return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-tree/nvim-web-devicons',
    'folke/todo-comments.nvim',
    'nvim-telescope/telescope-frecency.nvim', -- Add this line
  },
  config = function()
    local telescope = require 'telescope'
    local actions = require 'telescope.actions'
    telescope.setup {
      defaults = {
        path_display = { 'smart' },
        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous, -- move to prev result
            ['<C-j>'] = actions.move_selection_next, -- move to next result
            ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
      extensions = {
        frecency = {
          show_scores = true, -- Show frecency scores
          show_unindexed = true, -- Show files not yet indexed
          ignore_patterns = { '*.git/*', '*/tmp/*' }, -- Ignore certain patterns
          disable_devicons = false, -- Keep file icons
        },
      },
    }
    telescope.load_extension 'fzf'
    telescope.load_extension 'frecency' -- Add this line

    -- set keymaps
    local keymap = vim.keymap -- for conciseness
    keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Fuzzy find files in cwd' })
    keymap.set('n', '<leader>fr', '<cmd>Telescope frecency<cr>', { desc = 'Fuzzy find frequent files' }) -- Modified this line
    keymap.set('n', '<leader>fo', '<cmd>Telescope oldfiles<cr>', { desc = 'Fuzzy find recent files' }) -- Added this for old functionality
    keymap.set('n', '<leader>fs', '<cmd>Telescope live_grep<cr>', { desc = 'Find string in cwd' })
    keymap.set('n', '<leader>fc', '<cmd>Telescope grep_string<cr>', { desc = 'Find string under cursor in cwd' })
    keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<cr>', { desc = 'Find todos' })
  end,
}
