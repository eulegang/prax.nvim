--local namespace = vim.api.nvim_create_namespace("atkpx")
local namespace = 0

vim.api.nvim_set_hl(namespace, "AtkpxStatusOk", {
  fg = "#113311",
  bg = "#44dd44",
})

vim.api.nvim_set_hl(namespace, "AtkpxStatusClientError", {
  fg = "#333311",
  bg = "#dddd44",
})

vim.api.nvim_set_hl(namespace, "AtkpxStatusServerError", {
  fg = "#331111",
  bg = "#dd4444",
})

vim.api.nvim_set_hl(namespace, "AtkpxStatusRedirect", {
  fg = "#111133",
  bg = "#4444dd",
})

vim.api.nvim_set_hl(namespace, "AtkpxStatusInfo", {
  fg = "#113333",
  bg = "#44dddd",
})

vim.api.nvim_set_hl(namespace, "AtkpxMethodGET", { fg = "#113311", bg = "#44dd44", })
vim.api.nvim_set_hl(namespace, "AtkpxMethodHEAD", { fg = "#113333", bg = "#44dddd", })
vim.api.nvim_set_hl(namespace, "AtkpxMethodPOST", { fg = "#333311", bg = "#dddd44", })
vim.api.nvim_set_hl(namespace, "AtkpxMethodPUT", { fg = "#111133", bg = "#4444dd", })
vim.api.nvim_set_hl(namespace, "AtkpxMethodDELETE", { fg = "#331111", bg = "#dd4444", })
vim.api.nvim_set_hl(namespace, "AtkpxMethodOPTIONS", { fg = "#113333", bg = "#44dddd", })
vim.api.nvim_set_hl(namespace, "AtkpxMethodTRACE", { fg = "#1133aa", bg = "#44ddff", })
vim.api.nvim_set_hl(namespace, "AtkpxMethodPATCH", { fg = "#332211", bg = "#ddaa44", })
