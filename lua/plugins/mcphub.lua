return {
  'ravitemer/mcphub.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  build = 'bundled_build.lua',
  keys = {
    { '<leader>oh', '<cmd>MCPHub<cr>', desc = '[O]pen MCP [H]ub' },
  },
  opts = {
    port = 3000,
    use_bundled_binary = true,
    extensions = {
      copilotchat = {
        enabled = true,
        convert_tools_to_functions = true,
        convert_resources_to_functions = true,
        add_mcp_prefix = false,
      },
    },
    -- https://ravitemer.github.io/mcphub.nvim/configuration.html#function-example
    -- Does not work for some reason
    -- global_env = function()
    -- local repo_paths = require('utils').get_repo_paths()
    -- return {
    --   REPOSITORY_PATH = repo_paths,
    -- }
    -- end,
  },
}
