local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local colors = require("colors").get() 
local theme = {
  normal = {
    a = { fg = colors.black, bg = colors.red },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white, bg = colors.lightbg2 },
    y = { fg = colors.red, bg = colors.red },
    z = { fg = colors.green, bg = colors.green },
  },
  insert = { 
    a = { fg = colors.black, bg = colors.dark_purple },
    y = { fg = colors.dark_purple, bg = colors.dark_purple } 
  },
  visual = {
    a = { fg = colors.black, bg = colors.cyan }, 
    y = { fg = colors.cyan, bg = colors.cyan } 
  },
  replace = {
    a = { fg = colors.black, bg = colors.orange }, 
    y = { fg = colors.orange, bg = colors.orange } 
  },
  command = {
    a = { fg = colors.black, bg = colors.pink }, 
    y = { fg = colors.pink, bg = colors.pink } 
  },
}

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

--   git add
--   git mod
--   git remove
--   git ignore
--   git rename
--   error
--   info
--   question
--   warning
--   lightbulb

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	-- symbols = { error = "  ", warn = "  " },
	colored = false,
	update_in_insert = false,
	always_visible = true,
}

local diff = {
	"diff",
	colored = false,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width
}

local filetype = {
	"filetype",
	icons_enabled = false,
	icon = nil,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local location = {
	"location",
	padding = 0,
}

-- cool function for progress
local progress = function()
  local current_line = vim.fn.line "."
  local total_line = vim.fn.line "$"

  if current_line == 1 then
     return "Top"
  elseif current_line == vim.fn.line "$" then
     return "Bot"
  end
  local result, _ = math.modf((current_line / total_line) * 100)
  if result < 10 then
    return " " .. result .. "%%"
  end
  return result .. "%%"
end

local progress_icon = function()
  return " "
end


local mode_icon = function()
  return " " 
end 

local lsp_icon = function()
  if next(vim.lsp.buf_get_clients()) ~= nil then
     return "  LSP"
  else
     return ""
  end
end

local dir_name = function()
  local dir_name = vim.fn.expand("%:p")
  return " " .. dir_name 
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = theme,
		component_separators = { left = "", right = "" },
		section_separators = { left = " ", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", "toggleterm" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "branch", diagnostics },
		lualine_b = { diff },
		lualine_c = { 
    },
		lualine_x = { 
      location, 
      {
        lsp_icon,
        color = { bg = colors.grey },
        separator = { left = " ", right = "" },
        padding = { left = 0, right = 0 }
      }
    },
		lualine_y = {
      {
        mode_icon,
        color = { fg = colors.black },
        separator = { left = " ", right = "" },
        padding = { left = 0, right = 0 }
      },
      {
        "mode",
        color = { bg = colors.grey },
      },
    },
		lualine_z = {
      {
        progress_icon,
        color = { fg = colors.black }, 
        separator = { left = "", right = "" },
        padding = { left = 0, right = 0 }
      },
      {
        progress,
        color = { bg = colors.grey } 
      }
    },
	},
	inactive_sections = {
		lualine_a = {
      {
        dir_name,
        color = { bg = colors.grey, fg = colors.white },
        separator = { right = " " },
      }
    },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
