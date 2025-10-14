return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local mode = {
        'mode',
        fmt = function(str)
          return ' ' .. str
          -- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
        end,
      }

      local filename = {
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 2, -- 0 = just filename, 1 = relative path, 2 = absolute path
      }

      local hide_in_width = function()
        return vim.fn.winwidth(0) > 100
      end

      local diagnostics = {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        sections = { 'error', 'warn' },
        symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
        colored = false, -- Disable colored output
        update_in_insert = false,
        always_visible = false,
        cond = hide_in_width,
      }

      local diff = {
        'diff',
        colored = true,
        symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
        cond = hide_in_width,
      }
      local my_custom_theme = {
        normal = {
          a = { fg = '#2c2c2c', bg = '#ff6000', gui = 'bold' },
          b = { fg = '#2b2b2b', bg = '#80401a' },
          c = { fg = '#ff6000', bg = 'none' },
        },
        insert = {
          a = { fg = '#2c2c2c', bg = '#ff6000', gui = 'bold' },
          b = { fg = '#2b2b2b', bg = '#80401a' },
          c = { fg = '#ff6000', bg = 'none' },
        },
        visual = {
          a = { fg = '#2c2c2c', bg = '#ff6000', gui = 'bold' },
          b = { fg = '#2b2b2b', bg = '#80401a' },
          c = { fg = '#ff6000', bg = 'none' },
        },
        replace = {
          a = { fg = '#2c2c2c', bg = '#ff6000', gui = 'bold' },
          b = { fg = '#2b2b2b', bg = '#80401a' },
          c = { fg = '#ff6000', bg = 'none' },
        },
        inactive = {
          a = { fg = '#ff6000', bg = '#80401a', gui = 'bold' },
          b = { fg = '#ff6000', bg = '#80401a' },
          c = { fg = '#ff6000', bg = '#80401a' },
        },
      }

      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = my_custom_theme, -- Set theme based on environment variable
          -- Some useful glyphs:
          -- https://www.nerdfonts.com/cheat-sheet
          --        
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '--' },
          -- disabled_filetypes = { 'alpha', 'neo-tree', 'explorer'},
          always_divide_middle = true,
        },
        sections = {
          lualine_a = { mode },
          lualine_b = { 'branch' },
          lualine_c = { filename },
          lualine_x = { diagnostics, diff, { 'encoding', cond = hide_in_width }, { 'filetype', cond = hide_in_width } },
          lualine_y = { 'location' },
          lualine_z = { 'progress' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { { 'filename', path = 1 } },
          lualine_x = { { 'location', padding = 0 } },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = { 'fugitive' },
      }
    end,
  }

