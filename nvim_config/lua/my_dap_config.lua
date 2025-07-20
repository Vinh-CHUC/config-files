--
-- Haven't really well tested these various things
--

-- Core debugging flow
vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end, { desc = 'Debug: Continue (gdb: c)' })
vim.keymap.set('n', '<leader>dn', function() require('dap').step_over() end, { desc = 'Debug: Next/Step over (gdb: n)' })
vim.keymap.set('n', '<leader>ds', function() require('dap').step_into() end, { desc = 'Debug: Step into (gdb: s)' })
vim.keymap.set('n', '<leader>df', function() require('dap').step_out() end, { desc = 'Debug: Finish/Step out (gdb: f)' })

-- Breakpoints (gdb: b, d, info b)
vim.keymap.set('n', '<leader>db', function() require('dap').toggle_breakpoint() end, { desc = 'Debug: Toggle breakpoint (gdb: b)' })
vim.keymap.set('n', '<leader>dB', function()
  require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = 'Debug: Conditional breakpoint' })
vim.keymap.set('n', '<leader>dx', function() require('dap').clear_breakpoints() end, { desc = 'Debug: Clear all breakpoints (gdb: d)' })

-- Inspection and evaluation (gdb: p, info locals)
vim.keymap.set('n', '<leader>dp', function()
  require('dap').eval(vim.fn.input('Expression: '))
end, { desc = 'Debug: Print/Evaluate expression (gdb: p)' })
vim.keymap.set('v', '<leader>dp', function()
  require('dap').eval()
end, { desc = 'Debug: Evaluate selection' })

-- REPL and interaction (ipython-like)
vim.keymap.set('n', '<leader>di', function() require('dap').repl.toggle() end, { desc = 'Debug: Interactive REPL (ipython-like)' })
vim.keymap.set('n', '<leader>dl', function() require('dap').run_last() end, { desc = 'Debug: Run last configuration' })

-- Session management (gdb: q, run)
vim.keymap.set('n', '<leader>dq', function() require('dap').terminate() end, { desc = 'Debug: Quit/Terminate session (gdb: q)' })
vim.keymap.set('n', '<leader>dR', function() require('dap').restart() end, { desc = 'Debug: Restart session' })

-- Additional useful commands
vim.keymap.set('n', '<leader>du', function() require('dap').up() end, { desc = 'Debug: Go up stack frame (gdb: up)' })
vim.keymap.set('n', '<leader>dd', function() require('dap').down() end, { desc = 'Debug: Go down stack frame (gdb: down)' })

-- Python-specific (if using nvim-dap-python)
vim.keymap.set('n', '<leader>dt', function() require('dap-python').test_method() end, { desc = 'Debug: Test method' })
vim.keymap.set('n', '<leader>dT', function() require('dap-python').test_class() end, { desc = 'Debug: Test class' })

 -- Add keybindings for manual control
vim.keymap.set('n', '<leader>dtu', function() require('dapui').toggle() end, { desc = 'Toggle Debug UI' })
vim.keymap.set('n', '<leader>de', function() require('dapui').eval() end, { desc = 'Evaluate expression' })
vim.keymap.set('v', '<leader>de', function() require('dapui').eval() end, { desc = 'Evaluate selection' })

vim.cmd('iabbrev iembed from IPython import embed; embed()')
vim.cmd('iabbrev pdb import pdb; pdb.set_trace()')
