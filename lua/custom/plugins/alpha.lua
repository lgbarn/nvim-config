return {
  'goolord/alpha-nvim',
  event = 'VimEnter',
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    -- Safely get the macOS first name or fallback to username
    local function get_first_name()
      local handle = io.popen [[dscl . -read /Users/$(whoami) RealName 2>/dev/null | tail -1 | awk '{print $1}']]
      if not handle then
        return os.getenv 'USER' or 'there'
      end

      local result = handle:read '*a'
      handle:close()

      if result == nil or result == '' then
        return os.getenv 'USER' or 'there'
      end

      return result:gsub('\n', '')
    end

    local first_name = get_first_name()

    dashboard.section.header.val = {
      ' Hi ' .. first_name .. '!!!',
      '                                                     ',
      '                       Welcome to                    ',
      '                                                     ',
      '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
      '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
      '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
      '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
      '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
      '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
      '                                                     ',
    }

    dashboard.section.buttons.val = {
      dashboard.button('e', '  > New File', '<cmd>ene<CR>'),
      dashboard.button('SPC ee', '  > Toggle file explorer', '<cmd>NvimTreeToggle<CR>'),
      dashboard.button('SPC ff', '󰱼  > Find File', '<cmd>Telescope find_files<CR>'),
      dashboard.button('SPC fs', '  > Find Word', '<cmd>Telescope live_grep<CR>'),
      dashboard.button('SPC wr', '󰁯  > Restore Session For Current Directory', '<cmd>SessionRestore<CR>'),
      dashboard.button('q', '  > Quit NVIM', '<cmd>qa<CR>'),
    }

    alpha.setup(dashboard.opts)
    vim.cmd [[autocmd FileType alpha setlocal nofoldenable]]
  end,
}
