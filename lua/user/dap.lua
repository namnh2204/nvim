local M = {}


M.setup = function()
  local signs = {
    active = false,
    on_config_done = nil,
    breakpoint = {
      text = "",
      texthl = "LspDiagnosticsSignError",
      linehl = "",
      numhl = "",
    },
    breakpoint_rejected = {
      text = "",
      texthl = "LspDiagnosticsSignHint",
      linehl = "",
      numhl = "",
    },
    stopped = {
      text = "",
      texthl = "LspDiagnosticsSignInformation",
      linehl = "DiagnosticUnderlineInfo",
      numhl = "LspDiagnosticsSignInformation",
    },
  }
  local dap = require "dap"

  vim.fn.sign_define("DapBreakpoint", signs.breakpoint)
  vim.fn.sign_define("DapBreakpointRejected", signs.breakpoint_rejected)
  vim.fn.sign_define("DapStopped", signs.stopped)

  dap.defaults.fallback.terminal_win_cmd = "50vsplit new"

end

return M
