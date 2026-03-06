return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#181825',
				base01 = '#181825',
				base02 = '#879291',
				base03 = '#879291',
				base04 = '#dfedea',
				base05 = '#f8fffd',
				base06 = '#f8fffd',
				base07 = '#f8fffd',
				base08 = '#ffbf9f',
				base09 = '#ffbf9f',
				base0A = '#aff8ec',
				base0B = '#a5ffab',
				base0C = '#d7fff8',
				base0D = '#aff8ec',
				base0E = '#c1fff4',
				base0F = '#c1fff4',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#879291',
				fg = '#f8fffd',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#aff8ec',
				fg = '#181825',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#879291' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#d7fff8', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#c1fff4',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#aff8ec',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#aff8ec',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#d7fff8',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#a5ffab',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#dfedea' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#dfedea' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#879291',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
