local wezterm = require("wezterm") --[[@as Wezterm]] --- this type cast invokes the LSP module for Wezterm

local M = {}

M.is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"
M.is_mac = (wezterm.target_triple == "x86_64-apple-darwin" or wezterm.target_triple == "aarch64-apple-darwin")
M.separator = M.is_windows and "\\" or "/"

M.home = (os.getenv("USERPROFILE") or os.getenv("HOME") or wezterm.home_dir or ""):gsub("\\", "/")

return M
