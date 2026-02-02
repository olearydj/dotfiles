-- ~/.config/nvim/lua/custom/init.lua
-- My custom configurations

-- Markdown/Quarto settings for better readability
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'quarto' },
  callback = function()
    vim.opt_local.wrap = true -- Enable line wrapping
    vim.opt_local.linebreak = true -- Wrap at word boundaries
    vim.opt_local.breakindent = true -- Maintain indentation on wrapped lines
    vim.opt_local.textwidth = 0 -- Disable hard wrapping
    vim.opt_local.wrapmargin = 0 -- No right margin

    -- Navigate wrapped lines naturally with j/k
    vim.keymap.set('n', 'j', 'gj', { buffer = true, desc = 'Move down by display line' })
    vim.keymap.set('n', 'k', 'gk', { buffer = true, desc = 'Move up by display line' })

    -- Manual markdown linting (auto-lint disabled for markdown/quarto)
    vim.keymap.set('n', '<leader>ml', function()
      require('lint').try_lint('markdownlint')
    end, { buffer = true, desc = '[M]arkdown [L]int' })

    -- Auto-fix markdown issues
    vim.keymap.set('n', '<leader>mf', function()
      local file = vim.fn.expand('%:p')
      vim.cmd('write') -- save first
      vim.fn.system({ 'markdownlint', '--fix', '--config', vim.fn.stdpath('config') .. '/.markdownlint.json', file })
      vim.cmd('edit') -- reload file
    end, { buffer = true, desc = '[M]arkdown [F]ix' })

    -- Activate otter.nvim for LSP features in code blocks
    require('otter').activate()
  end,
  group = vim.api.nvim_create_augroup('markdown-quarto', { clear = true }),
})
