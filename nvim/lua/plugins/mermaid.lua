return {
	"kevalin/mermaid.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {
		format = {
			shift_width = 4, -- Indentation size (spaces)
		},
		lint = {
			enabled = true, -- Enable diagnostics via mmdc
			command = "mmdc", -- Path to mermaid-cli executable
		},
		preview = {
			renderer = "mermaid.js", -- "mermaid.js" or "beautiful-mermaid"
			theme = "default", -- Theme name (renderer-specific)
		},
	},
	config = function(_, opts)
		require("mermaid").setup(opts)

		-- Setup keymaps only for mermaid buffers
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "mermaid",
			callback = function()
				local buf = vim.api.nvim_get_current_buf()
				vim.keymap.set("n", "<leader>mp", "<cmd>MermaidPreview<CR>", { buffer = buf, desc = "Mermaid Preview" })
				vim.keymap.set("n", "<leader>mf", "<cmd>MermaidFormat<CR>", { buffer = buf, desc = "Mermaid Format" })
				vim.keymap.set("n", "<leader>mr", "<cmd>MermaidRender<CR>", { buffer = buf, desc = "Mermaid Render" })
				vim.keymap.set("n", "<leader>mc", "<cmd>MermaidCopyURL<CR>", { buffer = buf, desc = "Mermaid Copy URL" })
				vim.keymap.set(
					"n",
					"<leader>mx",
					"<cmd>MermaidPreviewStop<CR>",
					{ buffer = buf, desc = "Mermaid Stop Preview" }
				)
			end,
		})
	end,
}
