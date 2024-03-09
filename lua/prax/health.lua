local start = vim.health.start

local ok = vim.health.ok
local error = vim.health.error

local support = "^0.1.1"

local supported_versions = vim.version.range(support)

local M = {}

function M.check()
    start "checking binary installed"

    if vim.fn.executable("prax") ~= 1 then
        error "prax is not installed on this machine"
        return
    else
        local content = vim.fn.system({ 'prax', '-V' })
        if content == nil then
            error "failed to run prax"
        end

        local version = vim.version.parse(content, { strict = false })
        if version == nil then
            error "failed to find version of prax"
            return
        end

        if not supported_versions:has(version) then
            local found = string.format("%i.%i.%i", version.major, version.minor, version.patch)
            local msg = string.format(
                "this plugin does not support the installed version of prax. installed %s required %s",
                found,
                support
            )

            error(msg)

            return
        end
    end


    ok "prax is configured correctly"
end

return M
