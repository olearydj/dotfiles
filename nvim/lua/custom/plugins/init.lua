-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Seamless navigation between tmux panes and vim splits
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
    },
    keys = {
      { '<C-h>', '<cmd>TmuxNavigateLeft<cr>', desc = 'Navigate left (vim/tmux)' },
      { '<C-j>', '<cmd>TmuxNavigateDown<cr>', desc = 'Navigate down (vim/tmux)' },
      { '<C-k>', '<cmd>TmuxNavigateUp<cr>', desc = 'Navigate up (vim/tmux)' },
      { '<C-l>', '<cmd>TmuxNavigateRight<cr>', desc = 'Navigate right (vim/tmux)' },
    },
  },

  -- Otter.nvim: LSP features for embedded code in markdown/quarto
  {
    'jmbuhr/otter.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    ft = { 'markdown', 'quarto' },
    opts = {},
  },

  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = ':call mkdp#util#install()',
    keys = {
      { '<leader>mp', '<cmd>MarkdownPreviewToggle<cr>', desc = '[M]arkdown [P]review toggle' },
    },
  },

  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'BufReadPost',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      enable = true,
      max_lines = 3,
      multiline_threshold = 1,
    },
    keys = {
      {
        '[c',
        function()
          require('treesitter-context').go_to_context(vim.v.count1)
        end,
        desc = 'Jump to [C]ontext',
      },
    },
  },

  {
    'stevearc/aerial.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      backends = { 'treesitter', 'lsp', 'markdown', 'man' },
      layout = {
        min_width = 30,
        default_direction = 'right',
      },
      attach_mode = 'global',
      filter_kind = false,
    },
    keys = {
      { '<leader>o', '<cmd>AerialToggle!<cr>', desc = '[O]utline toggle' },
      { '<leader>so', '<cmd>Telescope aerial<cr>', desc = '[S]earch [O]utline symbols' },
    },
    config = function(_, opts)
      require('aerial').setup(opts)
      require('telescope').load_extension('aerial')
    end,
  },
}
