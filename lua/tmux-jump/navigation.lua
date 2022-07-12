local utils = require("tmux-jump.utils")

local M = {}

-- Create new tmux window and returns the window index
local function create_terminal()
    local created_idx
    local out, ret, _ =
        utils.get_os_command_output(
        {
            "tmux",
            "new-window",
            "-P",
            "-F",
            "#{window_index}"
        },
        vim.loop.cwd()
    )

    if ret == 0 then
        created_idx = out[1]
    end

    if created_idx == nil then
        return nil
    end

    return created_idx
end

-- Checks if the tmux window with given window index exists
local function terminal_exists(target_idx)

    local window_list, _, _ =
        utils.get_os_command_output(
        {
            "tmux",
            "list-windows"
        },
        vim.loop.cwd()
    )

    for _, line in pairs(window_list) do
        local window_idx = utils.split_string(line, ":")[1]

        if window_idx == "" .. target_idx then
            return true
        end
    end

    return false
end

-- Move the window at the source index to the target index
local function move_terminal(source_idx, target_idx)
    if source_idx ~= "" .. target_idx then
        local _, ret, stderr =
            utils.get_os_command_output(
            {
                "tmux",
                "move-window",
                "-s",
                source_idx,
                "-t",
                target_idx
            }
        )

        if ret ~= 0 then
            error("Failed to re-number the source terminal." .. stderr[1])
        end
    end
end

-- Create the window with index "target_idx" if it doesn't already exists
local function find_or_create_terminal(target_idx)

    if not terminal_exists(target_idx) then
        local created_idx = create_terminal()

        if created_idx == nil then
            error("Failed to find and create tmux window.")
            return
        end

        move_terminal(created_idx, target_idx)
    end
end

-- Go to tmux window at index "target_idx"
function M.gotoWindow(target_idx)
    find_or_create_terminal(target_idx)

    local _, ret, stderr =
        utils.get_os_command_output(
        {
            "tmux",
            "select-window",
            "-t",
            target_idx
        },
        vim.loop.cwd()
    )

    if ret ~= 0 then
        error("Failed to go to terminal." .. stderr[1])
    end
end

return M
