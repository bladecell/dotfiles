return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#181825',
				base01 = '#181825',
				base02 = '#988d8f',
				base03 = '#988d8f',
				base04 = '#f6e7ea',
				base05 = '#fff8f9',
				base06 = '#fff8f9',
				base07 = '#fff8f9',
				base08 = '#ff9fa1',
				base09 = '#ff9fa1',
				base0A = '#ffb9c4',
				base0B = '#baffa5',
				base0C = '#ffdae0',
				base0D = '#ffb9c4',
				base0E = '#ffc6cf',
				base0F = '#ffc6cf',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#988d8f',
				fg = '#fff8f9',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#ffb9c4',
				fg = '#181825',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#988d8f' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#ffdae0', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#ffc6cf',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#ffb9c4',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#ffb9c4',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#ffdae0',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#baffa5',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#f6e7ea' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#f6e7ea' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#988d8f',
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
