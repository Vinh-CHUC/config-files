require('tabby').setup({
  preset = 'tab_only',
  option = {
    theme = {
      fill = 'TabLineFill',       -- tabline background
      head = 'TabLine',           -- head element highlight
      current_tab = 'TabLineSel', -- current tab label highlight
      tab = 'TabLineFill',        -- other tab label highlight
      win = 'TabLine',            -- window highlight
      tail = 'TabLine',           -- tail element highlight
    },
    nerdfont = true,              -- whether use nerdfont
    lualine_theme = "auto",          -- lualine theme name
    buf_name = {
      mode = 'unique', -- or 'relative', 'tail', 'shorten'
    },
  },
})

vim.keymap.set("n", "<leader>y", ":Tabby jump_to_tab<CR>")
vim.keymap.set("n", "<leader>tr", ":Tabby rename_tab ", { noremap = true })
