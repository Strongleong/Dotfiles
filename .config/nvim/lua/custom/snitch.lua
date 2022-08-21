local job_ok, Job = pcall(require, "plenary.job")
if not job_ok then
  vim.notify('Error. Plenary is not installed')
  return
end

local function trim(s)
  return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

local function snitch()
  vim.notify('Snitching...')

  local locations = {}
  local isError = false

  vim.fn.setqflist({}, 'r')

  Job:new({
    command = 'snitch',
    args = { 'list' },
    cwd = vim.fn.getcwd(),
    -- cwd = '/home/strongleong/projects/dom.sakh.com/',
    on_stdout = vim.schedule_wrap(function(error, data, _)
      vim.notify(data)

      if error then
        isError = true
        vim.notify(data)
        return
      end

      local file = data:match("(.-)%d*:")
      local line = data:match(":(%d*):")
      local text = trim(data:match(":%d*:(.*)"))

      vim.notify(file .. line .. text)

      table.insert(locations, { filename = file, lnum = line, text = text })
    end),
    on_stderr = function(_, data)
      isError = true
      print(data)
    end,
    on_exit = vim.schedule_wrap(function()
      if not isError then
        vim.fn.setqflist(locations, 'r')
        vim.fn.setqflist({}, 'a', { title = 'Snitch' })
        vim.cmd('copen')
        vim.notify('Done!')
      end
    end)
  }):start()
end

return snitch
