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

    vim.print(vim.inspect(cmd))

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
    vim.api.nvim_create_user_command("PraxStart", function()
        job = create_job(opts)
        vim.fn.rpcnotify(job, "job_id", job)
        vim.print("prax started " .. job)
    end, {
        desc = "Start a prax session"
    })


    vim.api.nvim_create_user_command("PraxStop", function()
        if job then
            vim.print("stoping chan " .. job)
            vim.fn.rpcnotify(job, "shutdown")
            vim.fn.jobwait({ job })
        end
    end, {
        desc = "Stop the prax session"
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
