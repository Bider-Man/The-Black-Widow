return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
    config = function()
      -- Set to 1 to automatically start the preview server
      vim.g.mkdp_auto_start = 0
      
      -- Set to 1 to automatically close the preview window when switching buffers
      vim.g.mkdp_auto_close = 1
      
      -- Refresh the preview on markdown buffer save (0 = disabled, 1 = auto, 2 = sync)
      vim.g.mkdp_refresh_slow = 0
      
      -- Browser to open preview in (empty = default)
      vim.g.mkdp_browser = ''
      
      -- Port for the preview server
      vim.g.mkdp_port = ''
      
      -- Theme: 'dark' or 'light'
      vim.g.mkdp_theme = 'dark'
      
      -- Preview options
      vim.g.mkdp_preview_options = {
        mermaid = { theme = 'dark' },
        hide_yaml_meta = 1,
        sequence_diagrams = {},
      }
    end,
  }
}
