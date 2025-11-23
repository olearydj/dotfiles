-- ~/.config/nvim/lua/custom/init.lua
-- My custom configurations

-- Markdown-specific settings for better readability
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.opt_local.wrap = true -- Enable line wrapping
    vim.opt_local.linebreak = true -- Wrap at word boundaries
    vim.opt_local.breakindent = true -- Maintain indentation on wrapped lines
    vim.opt_local.textwidth = 0 -- Disable hard wrapping
    vim.opt_local.wrapmargin = 0 -- No right margin

    -- Navigate wrapped lines naturally with j/k
    vim.keymap.set('n', 'j', 'gj', { buffer = true, desc = 'Move down by display line' })
    vim.keymap.set('n', 'k', 'gk', { buffer = true, desc = 'Move up by display line' })
  end,
  group = vim.api.nvim_create_augroup('markdown-wrap', { clear = true }),
})
