local namespace = 0

vim.api.nvim_set_hl(namespace, "PraxStatusOk", {
    fg = "#113311",
    bg = "#44dd44",
})

vim.api.nvim_set_hl(namespace, "PraxStatusClientError", {
    fg = "#333311",
    bg = "#dddd44",
})

vim.api.nvim_set_hl(namespace, "PraxStatusServerError", {
    fg = "#331111",
    bg = "#dd4444",
})

vim.api.nvim_set_hl(namespace, "PraxStatusRedirect", {
    fg = "#111133",
    bg = "#4444dd",
})

vim.api.nvim_set_hl(namespace, "PraxStatusInfo", {
    fg = "#113333",
    bg = "#44dddd",
})

vim.api.nvim_set_hl(namespace, "PraxMethodGET", { fg = "#113311", bg = "#44dd44", })
vim.api.nvim_set_hl(namespace, "PraxMethodHEAD", { fg = "#113333", bg = "#44dddd", })
vim.api.nvim_set_hl(namespace, "PraxMethodPOST", { fg = "#333311", bg = "#dddd44", })
vim.api.nvim_set_hl(namespace, "PraxMethodPUT", { fg = "#111133", bg = "#4444dd", })
vim.api.nvim_set_hl(namespace, "PraxMethodDELETE", { fg = "#331111", bg = "#dd4444", })
vim.api.nvim_set_hl(namespace, "PraxMethodOPTIONS", { fg = "#113333", bg = "#44dddd", })
vim.api.nvim_set_hl(namespace, "PraxMethodTRACE", { fg = "#1133aa", bg = "#44ddff", })
vim.api.nvim_set_hl(namespace, "PraxMethodPATCH", { fg = "#332211", bg = "#ddaa44", })
