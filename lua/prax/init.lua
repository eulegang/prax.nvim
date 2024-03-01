--- @class PluginOptions
--- @field debug string?
--- @field file string?
--- @field log string?
--- @field key string?
--- @field cert string?
--- @field watch boolean

--- @alias Job integer

local M = {}

--- @type Job?
local job = nil

--- @param opts PluginOptions
--- @return Job
local function create_job(opts)
    local cmd = {}

    if opts.debug ~= nil then
        table.insert(cmd, 'cargo')
        table.insert(cmd, 'run')
        table.insert(cmd, '--quiet')
        table.insert(cmd, '--manifest-path')
        table.insert(cmd, opts.debug .. 'Cargo.toml')
        table.insert(cmd, '--')
    else
        table.insert(cmd, 'prax')
    end

    if opts.file ~= nil then
        table.insert(cmd, '--file')
        table.insert(cmd, opts.file)
    end

    if opts.log ~= nil then
        table.insert(cmd, "--log")
        table.insert(cmd, opts.log)
    end

    if opts.key ~= nil then
        table.insert(cmd, '--key')
        table.insert(cmd, opts.key)
    end

    if opts.cert ~= nil then
        table.insert(cmd, '--cert')
        table.insert(cmd, opts.cert)
    end

    if opts.watch == true then
        table.insert(cmd, '--watch')
    end

    table.insert(cmd, '--nvim')
    table.insert(cmd, '-')

    return vim.fn.jobstart(cmd, {
        rpc = true,
        on_stderr = function(_, data)
            for _, line in ipairs(data) do
                vim.print(line)
            end
        end,
        on_exit = function(_, status)
            vim.print("prax exited " .. status)
        end
    })
end

--- @param opts PluginOptions options for configuring the prax nvim plugin
function M.setup(opts)
    vim.api.nvim_create_user_command('Prax', function(o)
        if #o.fargs == 0 then
            if job == nil then
                job = create_job(opts)
                vim.fn.rpcnotify(job, "job_id", job)
            else
                vim.fn.rpcnotify(job, "shutdown")
                vim.fn.jobwait({ job })
            end
        elseif o.fargs[1] == "spawn" then
            job = create_job(opts)
            vim.fn.rpcnotify(job, "job_id", job)
        elseif o.fargs[1] == "kill" then
            vim.fn.rpcnotify(job, "shutdown")
            vim.fn.jobwait({ job })
        else
            vim.print("invalid arguments '" .. table.concat(o.fargs, ' ') .. "'")
        end
    end, {
        nargs = '*',
        desc = "Prax command",
        complete = function(_, line)
            local l = vim.split(line, "%s+")

            if #l == 2 then
                return { 'spawn', 'kill' }
            end

            local last = l[#l - 1]
            local current_complete = l[#l]

            if last == '-f' or last == "--file" then
                return vim.fn.getcompletion(current_complete, "file")
            elseif last == '-L' or last == '--log' then
                return vim.fn.getcompletion(current_complete, "file")
            elseif last == '-w' or last == '--watch' then
                return nil
            elseif last == '-k' or last == '--key' then
                return vim.fn.getcompletion(current_complete, "file")
            elseif last == '-c' or last == '--cert' then
                return vim.fn.getcompletion(current_complete, "file")
            else
                local file = true
                local log = true
                local watch = true
                local key = true
                local cert = true

                for _, value in ipairs(l) do
                    if value == '-f' or value == '--file' then
                        file = false
                    end
                    if value == '-L' or value == '--log' then
                        log = false
                    end
                    if value == '-w' or value == '--watch' then
                        watch = false
                    end
                    if value == '-k' or value == '--key' then
                        key = false
                    end
                    if value == '-c' or value == '--cert' then
                        cert = false
                    end
                end

                local opts = {}

                if file then
                    table.insert(opts, '-f')
                    table.insert(opts, '--file')
                end

                if log then
                    table.insert(opts, '-L')
                    table.insert(opts, '--log')
                end

                if watch then
                    table.insert(opts, '-w')
                    table.insert(opts, '--watch')
                end

                if key then
                    table.insert(opts, '-k')
                    table.insert(opts, '--key')
                end

                if cert then
                    table.insert(opts, '-c')
                    table.insert(opts, '-cert')
                end

                return opts
            end
        end
    })
end

--- Show the detail buffer
function M.detail()
    vim.fn.rpcnotify(job, "detail")
end

--- Submit the modifications to the intercept buffer
function M.submit_intercept()
    vim.fn.rpcnotify(job, "submit_intercept")
end

return M
