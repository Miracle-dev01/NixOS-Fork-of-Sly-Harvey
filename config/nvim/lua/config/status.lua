require('lualine').setup({
  options = {
    theme = 'auto',
    section_separators = '',
    component_separators = '',
  },

  sections = {
    lualine_a = { 'mode' },          -- NORMAL, INSERT, VISUAL, COMMAND
    lualine_b = { 'branch' },
    lualine_c = {
      {
        'filename',
        path = 1,                  -- show relative path
        symbols = {
          modified = '[+]',
          readonly = '[READONLY]',
          unnamed = '[No Name]',
        }
      }
    },

    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  }
})