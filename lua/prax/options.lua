--- @class Opts
--- @field short string
--- @field long string
--- @field completion string?
--- @field value boolean

--- @type { [string]: Opts }
local options = {
    file = {
        short = 'f',
        long = 'file',
        completion = 'file',
        value = true,
    },

    log = {
        short = 'L',
        long = 'log',
        completion = 'file',
        value = true,
    },
    key = {
        short = 'k',
        long = 'key',
        completion = 'file',
        value = true,

    },
    cert = {

        short = 'c',
        long = 'cert',
        completion = 'file',
        value = true,

    },
    watch = {
        short = 'w',
        long = 'watch',
        value = false,
    }
}


local M = {}


local function complete_opts(args)
    local last = args[#args - 1]
    local current = args[#args]

    local potential = {}
    for name, value in pairs(options) do
        if last == ('-' .. value.short) or last == ('--' .. value.long) then
            if value.completion == nil then
                return nil
            end

            return vim.fn.getcompletion(current, value.completion)
        end
        potential[name] = true
    end

    for _, arg in ipairs(args) do
        for name, opt in pairs(options) do
            if arg == ('-' .. opt.short) or arg == ('--' .. opt.long) then
                potential[name] = false
            end
        end
    end

    local res = {}
    for name, include in pairs(potential) do
        if include then
            local opt = options[name]
            table.insert(res, '-' .. opt.short)
            table.insert(res, '--' .. opt.long)
        end
    end

    return res
end


function M.parse(args)
    local res = {}

    local name = nil

    for _, arg in ipairs(args) do
        if name ~= nil then
            res[name] = arg
            name = nil
        else
            for n, opt in pairs(options) do
                if arg == ('-' .. opt.short) or arg == ('--' .. opt.long) then
                    if opt.value then
                        name = n
                    else
                        res[n] = true
                    end
                end
            end
        end
    end

    return res
end

function M.comp(_, line)
    local l = vim.split(line, "%s+")

    if #l == 2 then
        return { 'spawn', 'kill' }
    end

    if l[2] == 'spawn' then
        return complete_opts(l)
    else
        return nil
    end
end

return M

