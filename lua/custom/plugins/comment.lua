return {
  'numToStr/Comment.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'folke/ts-comments.nvim',
  },
  config = function()
    -- setup ts-comments for context-aware commenting
    require('ts-comments').setup()

    -- enable comment
    require('Comment').setup()
  end,
}
