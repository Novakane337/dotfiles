local vim = vim

local global_options = {

  -- GENERAL ( :help nvim-defaults )
  -- Always 5 lines at the bottom
  scrolloff = 5,
  -- No backup file
  backup = false,
  -- Enables to switch between unsaved buffers and keep undo history
  hidden = true,
  -- Puts new split windows to the bottom of the current
  splitbelow = true,
  -- Puts new vsplit windows to the right of the current
  splitright = true,
  -- Use the clipboard for all operations
  clipboard = "unnamedplus",
  -- Show preview of substitute command
  inccommand = "nosplit",
  -- Enable mouse
  mouse = "a",
  -- Don't give |ins-completion-menu| messages.
  shortmess = "filnxtToOFc",
  -- Use python 3
  pyxversion = 3,
  -- Dont select newline in visual mode ( v$ )
  selection = "exclusive",
  -- Do not redraw screen in the middle of a macro
  lazyredraw = true,

  -- COMPLETION ( :help 'complete' )
  -- Ignore case when completing file and directory
  wildignorecase = true,
  -- Set completeopt to have a better completion experience
  completeopt = "menuone,noinsert,noselect",

  -- SEARCH
  -- Case insensitive searching
  ignorecase = true,
  -- Override ignorecase if upper case typed
  smartcase = true,

  -- THEME
  termguicolors = true,
  showmode = false,
  showcmd = false,
  -- Better display for messages
  cmdheight = 2,
  -- Smaller updatetime for CursorHold & CursorHoldI
  updatetime = 300
}

for name, value in pairs(global_options) do
  vim.o[name] = value
end

local window_options = {
  -- Show line number
  number = true,
  -- Don't insert line breaks in the middle of a word
  linebreak = true,
  -- Always show signcolumns
  signcolumn = "yes"
}

for name, value in pairs(window_options) do
  vim.wo[name] = value
end

local buffer_options = {
  -- No swap file
  swapfile = false,
  -- Break line after 100 characters
  textwidth = 100,
  -- Use 4 spaces instead of tab
  -- Copy indent from current line when starting a new line
  softtabstop = 4,
  shiftwidth  = 4,
  expandtab   = true
}

for name, value in pairs(buffer_options) do
  vim.bo[name] = value
end

local plugin_options = {
  -- Gutentags ( https://github.com/ludovicchabant/vim-gutentags )
  -- Group all tags files in a folder
  gutentags_cache_dir = "~/.cache/tags",

  -- Signify ( https://github.com/mhinz/vim-signify )
  signify_vcs_list = "[ 'git', 'yadm' ]",
  signify_sign_add = "✓",
  signify_sign_delete = "✗",
  signify_sign_delete_first_line = "-",
  signify_sign_change = "✶",
  signify_sign_changedelete = "~",
  signify_sign_show_count = 1,

  -- Hexokinase ( https://github.com/RRethy/vim-hexokinase )
  Hexokinase_v2 = 0,

  -- Editor config ( https://github.com/editorconfig/editorconfig-vim )
  -- To ensure that this plugin works well with Tim Pope's fugitive
  EditorConfig_exclude_patterns = "['fugitive://.*']",

  -- Fzf ( https://github.com/junegunn/fzf.vim )
  -- [Buffers] Jump to the existing window if possible
  fzf_buffers_jump = 1,

}

for name, value in pairs(plugin_options) do
  vim.g[name] = value
end

-- TODO Nnn and Fzf
