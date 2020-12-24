local execute = vim.api.nvim_command
local fn = vim.fn

-- Ensure that packer.nvim is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end

-- Only required if you have packer in your `opt` pack
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself as an optional plugin
  use { 'wbthomason/packer.nvim', opt = true }

  -- Lsp
  use 'neovim/nvim-lspconfig'
  use {
    'nvim-lua/completion-nvim',

    config = function()
      -- Use completion-nvim in every buffer
      vim.cmd [[ augroup Complete ]]
      vim.cmd [[ autocmd! ]]
      vim.cmd [[ autocmd BufEnter * lua require'completion'.on_attach() ]]
      vim.cmd [[ augroup END ]]

      local opts = {
        -- Non ins-complete method should be specified in 'mode'
        completion_chain_complete_list = {
          completion_items = { {"lsp"}, {"snippet"}, {"buffers"}, {"path"} },
          mode = { {"<c-p>"}, {"<c-n>"}, {"file"}, {"line"}, {"tags"} }
        },
        completion_auto_change_source = 1,
        completion_enable_auto_paren = 1,
        completion_enable_snippet = "vim-vsnip",
      }

      for name, value in pairs(opts) do
        vim.g[name] = value
      end
    end,

    requires = {
      { 'hrsh7th/vim-vsnip', event = 'InsertEnter *' },
      { 'hrsh7th/vim-vsnip-integ', event = 'InsertEnter *' },
      { 'steelsojka/completion-buffers', event = 'InsertEnter *' }
    }
  }

  -- Files
  use '~/.config/fzf'
  use {
    'junegunn/fzf.vim',

    config = function()
      local opts = {
        fzf_layout = {
          window = { width = 0.8, height = 0.9 }
        },
        fzf_buffers_jump = 1,
        fzf_action = {
          ["ctrl-t"] = "tab split",
          ["ctrl-h"] = "split",
          ["ctrl-v"] = "vsplit"
        }
      }

      for name, value in pairs(opts) do
        vim.g[name] = value
      end
    end
  }
  use {
    'mcchrish/nnn.vim',

    cmd = { 'Np', 'NnnPicker' },
    config = function()
      local opts = {
        ["nnn#layout"] = {
          window = { width = 0.5, height = 0.6, highlight = "Debug" }
        },
        ["nnn#set_default_mappings"] = 0,
        ["nnn#action"] = {
          ["<c-t>"] = "tab split",
          ["<c-h>"] = "split",
          ["<c-v>"] = "vsplit"
        },
        ["nnn#command"] = "nnn -e",
      }

      for name, value in pairs(opts) do
        vim.g[name] = value
      end
    end
  }
  use {
    'ludovicchabant/vim-gutentags',
    config = function()
      vim.g.gutentags_cache_dir = "~/.cache/tags"
    end
  }

  -- UI
  use {
    'junegunn/goyo.vim',
    cmd = 'Goyo',
    config = function()
      -- Launch Limelight with Goyo
      vim.cmd [[ augroup GoyoMode ]]
      vim.cmd [[ autocmd! ]]
      vim.cmd [[ autocmd User GoyoEnter Limelight ]]
      vim.cmd [[ autocmd User GoyoLeave Limelight! ]]
      vim.cmd [[ augroup END ]]
    end,

    requires = {
      'junegunn/limelight.vim',
      opt = true,
      event = 'GoyoEnter'
    }
  }

  -- Misc
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-commentary'
  use 'cohama/lexima.vim'
  use 'itchyny/vim-cursorword'
  use {
    'mhinz/vim-signify',
    config = function()
      local opts = {
        signify_vcs_list = "[ 'git', 'yadm' ]",
        signify_sign_add = "+",
        signify_sign_delete = "✗",
        signify_sign_delete_first_line = "-",
        signify_sign_change = "»",
        signify_sign_changedelete = "~",
        signify_sign_show_count = 1,
      }

      for name, value in pairs(opts) do
        vim.g[name] = value
      end
    end
  }

  use {
    'junegunn/vim-easy-align',
    -- FIXME <Plug> doesn't work
    keys = '<Plug>(EasyAlign)',
    cmd = 'EasyAlign'
  }
  use {
    'moll/vim-bbye',
    cmd = 'Bdelete'
  }
  use {
    'norcalli/nvim-colorizer.lua',
    cmd = 'ColorizerToggle'
  }
  use {
    'justinmk/vim-sneak',
    -- FIXME <Plug> doesn't work
    -- keys = { '<Plug>Sneak_s', '<Plug>Sneak_S' },
    config = function()
      vim.g["sneak#label"] = 1
    end
  }
  use {
    'junegunn/rainbow_parentheses.vim',
    ft = { 'clojure', 'fennel' }
  }
  use {
    'voldikss/vim-floaterm',
    config = function()
      vim.g.floaterm_width = 0.8
    end
  }

    -- Lang
  use 'sheerun/vim-polyglot'
  use {
    'editorconfig/editorconfig-vim',
    config = function()
      vim.g.EditorConfig_exclude_patterns = "['fugitive://.*']"
    end
  }
    use {
    'iamcco/markdown-preview.nvim',
    opt = true,
    run = function()
      fn['mkdp#util#install']()
    end,
    ft = 'markdown'
  }

end)
