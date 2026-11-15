-- =============================================================================
-- Options
-- =============================================================================

vim.g.mapleader = " "
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.showmode = false
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
local transparent = false

vim.filetype.add({
	extension = { mdx = "mdx" },
})

-- =============================================================================
-- Keymaps
-- =============================================================================

vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "Open file explorer" })
vim.keymap.set("n", "<leader>b", "<C-^>", { desc = "Jump to previous buffer" })
vim.keymap.set("n", "<leader>q", "<cmd>edit ~/Documents/quick.md<CR>", { desc = "Open quick note" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic message" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })

vim.keymap.set("n", "<leader>cd", function()
	local line = vim.api.nvim_win_get_cursor(0)[1] - 1
	local diagnostics = vim.diagnostic.get(0, { lnum = line })

	if #diagnostics == 0 then
		vim.notify("No diagnostic on this line", vim.log.levels.INFO)
		return
	end

	local messages = {}
	for _, diagnostic in ipairs(diagnostics) do
		table.insert(messages, diagnostic.message)
	end

	local text = table.concat(messages, "\n")
	vim.fn.setreg("+", text)
	vim.notify("Diagnostic copied to clipboard", vim.log.levels.INFO)
end, { desc = "Copy diagnostic message to clipboard" })

-- =============================================================================
-- Commands
-- =============================================================================

vim.api.nvim_create_user_command("DisableLSP", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	for _, client in ipairs(clients) do
		vim.lsp.buf_detach_client(bufnr, client.id)
	end

	if #clients > 0 then
		print("LSP detached from current buffer")
	else
		print("No LSP attached to current buffer")
	end
end, { desc = "Detach LSP from current buffer" })

-- =============================================================================
-- Transparency
-- =============================================================================

local function apply_transparency()
	if transparent then
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	end
end

vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("Transparency", { clear = true }),
	callback = apply_transparency,
})

-- =============================================================================
-- Lazy bootstrap
-- =============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- =============================================================================
-- Themes
-- =============================================================================

local themes = {
	{ "idr4n/andromeda.nvim", name = "andromeda" },
	{ "Shatur/neovim-ayu", name = "ayu" },
	{ "catppuccin/nvim", name = "catppuccin" },
	{ "chaserensberger/christmas.nvim", name = "christmas" },
	{ "Mofiqul/dracula.nvim", name = "dracula" },
	{ "sainnhe/everforest", name = "everforest" },
	{ "ellisonleao/gruvbox.nvim", name = "gruvbox" },
	{ "rebelot/kanagawa.nvim", name = "kanagawa" },
	{ "oxfist/night-owl.nvim", name = "night-owl", label = "nightowl" },
	{ "shaunsingh/nord.nvim", name = "nord" },
	{ "navarasu/onedark.nvim", name = "onedark", label = "one-dark" },
	{ "drewtempelmeyer/palenight.vim", name = "palenight" },
	{ name = "rensberger" },
	{ "rose-pine/neovim", name = "rosepine", colorscheme = "rose-pine" },
	{ "folke/tokyonight.nvim", name = "tokyonight" },
	{ "datsfilipe/vesper.nvim", name = "vesper" },
	{ "phha/zenburn.nvim", name = "zenburn" },
}

local colorscheme_specs = {}
local theme_menu = {}
for _, theme in ipairs(themes) do
	if theme[1] then
		table.insert(colorscheme_specs, { theme[1], name = theme.name, lazy = false })
	end
	table.insert(theme_menu, {
		name = theme.label or theme.name,
		colorscheme = theme.colorscheme or theme.name,
	})
end

-- =============================================================================
-- Plugins
-- =============================================================================

require("lazy").setup({
	spec = vim.list_extend(vim.list_slice(colorscheme_specs), {
		-- Appearance
		{
			"zaldih/themery.nvim",
			lazy = false,
			dependencies = colorscheme_specs,
			opts = { themes = theme_menu, livePreview = true },
		},
		{
			"NvChad/nvim-colorizer.lua",
			opts = { "css", "javascript", "markdown", html = { mode = "foreground" } },
		},
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			opts = { sections = { lualine_x = {} } },
		},
		{
			"luckasRanarison/tailwind-tools.nvim",
			dependencies = { "nvim-treesitter/nvim-treesitter" },
		},
		-- Navigation
		{
			"nvim-telescope/telescope.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			opts = {
				defaults = {
					file_ignore_patterns = { "^%.git/", "^%.venv/", "^bb/", "node_modules/", "sandbox/" },
				},
				pickers = {
					find_files = { hidden = true, no_ignore = true },
				},
			},
			config = function(_, opts)
				require("telescope").setup(opts)
				local builtin = require("telescope.builtin")
				vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
				vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
				vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
				vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
			end,
		},
		{
			"ThePrimeagen/harpoon",
			branch = "harpoon2",
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				local harpoon = require("harpoon")
				harpoon:setup()

				vim.keymap.set("n", "<leader>ha", function()
					harpoon:list():add()
				end, { desc = "Add file to Harpoon" })
				vim.keymap.set("n", "<leader>hm", function()
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end, { desc = "Open Harpoon menu" })

				for i = 1, 6 do
					vim.keymap.set("n", string.format("<leader>h%d", i), function()
						harpoon:list():replace_at(i)
					end, { desc = "Set Harpoon slot " .. i })
					vim.keymap.set("n", string.format("<leader>hd%d", i), function()
						harpoon:list():remove_at(i)
					end, { desc = "Remove Harpoon slot " .. i })
					vim.keymap.set("n", string.format("<leader>%d", i), function()
						harpoon:list():select(i)
					end, { desc = "Jump to Harpoon slot " .. i })
				end

				vim.keymap.set("n", "<leader>hc", function()
					for i = 1, 6 do
						harpoon:list():remove_at(i)
					end
				end, { desc = "Clear first six Harpoon slots" })
			end,
		},
		-- Syntax highlighting
		{
			"nvim-treesitter/nvim-treesitter",
			branch = "main",
			lazy = false,
			build = ":TSUpdate",
			config = function()
				require("nvim-treesitter").install({
					"lua",
					"markdown",
					"markdown_inline",
					"javascript",
					"typescript",
					"tsx",
					"go",
					"html",
					"json",
					"css",
					"rust",
					"yaml",
					"scala",
					"python",
					"terraform",
					"cpp",
				})
				vim.api.nvim_create_autocmd("FileType", {
					group = vim.api.nvim_create_augroup("TreesitterHighlight", { clear = true }),
					pattern = {
						"lua",
						"markdown",
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"go",
						"html",
						"json",
						"css",
						"rust",
						"yaml",
						"scala",
						"python",
						"terraform",
						"cpp",
					},
					callback = function(event)
						vim.treesitter.start(event.buf)
					end,
				})
			end,
		},
		-- LSP
		{ "mason-org/mason.nvim", opts = {} },
		{
			"mason-org/mason-lspconfig.nvim",
			dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp" },
			config = function()
				local capabilities = require("cmp_nvim_lsp").default_capabilities()
				vim.lsp.config.tailwindcss = { capabilities = capabilities }
				vim.lsp.config.lua_ls = {
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							workspace = {
								library = vim.api.nvim_get_runtime_file("", true),
								checkThirdParty = false,
							},
						},
					},
				}
				vim.lsp.config.ruff = {
					capabilities = capabilities,
					init_options = { settings = { logLevel = "info" } },
				}
				local servers_with_defaults = { "rust_analyzer", "ts_ls", "gopls", "html", "cssls", "clangd", "ty" }
				for _, server in ipairs(servers_with_defaults) do
					vim.lsp.config[server] = { capabilities = capabilities }
				end

				vim.api.nvim_create_autocmd("LspAttach", {
					group = vim.api.nvim_create_augroup("PythonLsp", { clear = true }),
					callback = function(event)
						local client = vim.lsp.get_client_by_id(event.data.client_id)
						if client and client.name == "ruff" then
							-- Let ty provide Python hover documentation.
							client.server_capabilities.hoverProvider = false
						end
					end,
				})

				-- Configure servers before Mason enables them.
				require("mason-lspconfig").setup({
					ensure_installed = {
						"lua_ls",
						"ts_ls",
						"gopls",
						"html",
						"cssls",
						"rust_analyzer",
						"clangd",
						"ty",
						"ruff",
						"tailwindcss",
					},
					automatic_enable = {
						exclude = { "basedpyright", "pyright", "ruff_lsp" },
					},
				})
			end,
		},
		-- Formatting
		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "oxfmt" },
					javascriptreact = { "oxfmt" },
					typescript = { "oxfmt" },
					typescriptreact = { "oxfmt" },
					html = { "oxfmt" },
					astro = { "oxfmt" },
					markdown = { "oxfmt" },
					mdx = { "oxfmt" },
					json = { "oxfmt" },
					jsonc = { "oxfmt" },
					yaml = { "oxfmt" },
					css = { "oxfmt" },
					go = { "gofumpt" },
					rust = { "rustfmt" },
					python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
					cpp = { "clang-format" },
				},
				format_on_save = { timeout_ms = 5000, lsp_format = "fallback" },
			},
		},
		-- Completion
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				"L3MON4D3/LuaSnip",
				{
					"roobert/tailwindcss-colorizer-cmp.nvim",
					opts = { color_square_width = 2 },
				},
			},
			config = function()
				local cmp = require("cmp")
				cmp.setup({
					snippet = {
						expand = function(args)
							require("luasnip").lsp_expand(args.body)
						end,
					},
					mapping = cmp.mapping.preset.insert({
						["<C-b>"] = cmp.mapping.scroll_docs(-4),
						["<C-f>"] = cmp.mapping.scroll_docs(4),
						["<C-Space>"] = cmp.mapping.complete(),
						["<C-e>"] = cmp.mapping.abort(),
						["<CR>"] = cmp.mapping.confirm({ select = true }),
					}),
					sources = cmp.config.sources({
						{ name = "nvim_lsp" },
						{ name = "path" },
					}, {
						{ name = "buffer" },
					}),
					formatting = {
						format = require("tailwindcss-colorizer-cmp").formatter,
					},
				})
				cmp.setup.cmdline(":", {
					mapping = cmp.mapping.preset.cmdline(),
					sources = cmp.config.sources({
						{ name = "path" },
					}, {
						{ name = "cmdline" },
					}),
				})
			end,
		},
		-- Editing
		{
			"numToStr/Comment.nvim",
			dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
			config = function()
				require("Comment").setup({
					pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
				})
				vim.keymap.set("n", "<leader>/", function()
					require("Comment.api").toggle.linewise.current()
				end, { desc = "Toggle comment on current line" })
				vim.keymap.set(
					"v",
					"<leader>/",
					"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
					{ desc = "Toggle comment on selected lines" }
				)
			end,
		},
		{ "m4xshen/autoclose.nvim", opts = {} },
		{
			"lewis6991/gitsigns.nvim",
			opts = {
				current_line_blame = false,
				current_line_blame_opts = { virt_text_pos = "eol", delay = 0 },
			},
			config = function(_, opts)
				require("gitsigns").setup(opts)
				vim.keymap.set("n", "<leader>gb", function()
					require("gitsigns").toggle_current_line_blame()
				end, { desc = "Toggle git blame" })
			end,
		},
		{
			"nosduco/remote-sshfs.nvim",
			dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
			config = function()
				require("remote-sshfs").setup()
				vim.keymap.set(
					"n",
					"<leader>rc",
					require("remote-sshfs.api").connect,
					{ desc = "Connect remote SSH filesystem" }
				)
			end,
		},
		{
			"Gentleman-Programming/veil.nvim",
			event = "VeryLazy",
			config = function()
				require("veil").setup()
			end,
		},
	}),
	checker = { enabled = false },
})

apply_transparency()
