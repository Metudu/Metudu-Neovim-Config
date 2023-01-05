-- auto install packer if not installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
    return
end

-- add list of plugins to install
return packer.startup(function(use)
    -- packer can manage itself
    use "wbthomason/packer.nvim"
    use "bluz71/vim-nightfly-guicolors"     -- background color
    use "christoomey/vim-tmux-navigator"    -- window properties
    use "szw/vim-maximizer"                 -- window properties
    use "tpope/vim-surround"                -- code editing
    -- ysw<character>   surround the word with character
    -- ds<character>    remove the surrounding character
    -- cs<character that will be changed> <character that will replace> change the surrounding character

    use "vim-scripts/ReplaceWithRegister"   -- code editing
    use "numToStr/Comment.nvim"             -- comment with gc
    use "nvim-tree/nvim-tree.lua"           -- file tree
    use "kyazdani42/nvim-web-devicons"      -- icons for file tree
    use "nvim-lualine/lualine.nvim"         -- status line

    use "hrsh7th/nvim-cmp"                  -- basic autocompletion
    use "hrsh7th/cmp-buffer"                -- basic autocompletion
    use "hrsh7th/cmp-path"                  -- basic autocompletion

    use "L3MON4D3/LuaSnip"                  -- basic autocompletion
    use "saadparwaiz1/cmp_luasnip"          -- basic autocompletion
    use "rafamadriz/friendly-snippets"      -- basic autocompletion

    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"
    use "neovim/nvim-lspconfig"
    use "hrsh7th/cmp-nvim-lsp"
    use {"glepnir/lspsaga.nvim", branch = "main"}
    use "onsails/lspkind.nvim"

    use "andweeb/presence.nvim"             -- discord presence

--    use ({"nvim-telescope/telescope.nvim", branch = "0.1.x"})
--    use ({"nvim-telescope/telescope-fzf-native.nvim", run = "make"})

    if packer_bootstrap then
        require("packer").sync()
    end
end)
