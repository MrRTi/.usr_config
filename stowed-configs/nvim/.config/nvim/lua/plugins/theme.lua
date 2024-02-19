return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				integrations = {
					gitsigns = true,
					harpoon = true,
					mason = true,
					cmp = true,
					lsp_trouble = true,
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
						},
						inlay_hints = {
							background = true,
						},
					},
					treesitter = true,
					treesitter_context = false,
					telescope = {
						enabled = true,
					},
					which_key = true,
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"cormacrelf/dark-notify",
		config = function()
			require("dark_notify").run({
				schemes = {
					dark = {
						background = "dark",
					},
					light = {
						background = "light",
					},
				},
			})
		end,
	},
}
