local job_ok, Job = pcall(require, "plenary.job")
if not job_ok then
  vim.notify('Error. Plenary is not installed')
  return
end

local project_root = "market.sakh.com"
local webview_root = "market.sakh.com/front/app/vue"

local uploadJob = Job:new({
  command = 'rsync',
  args = {
    '-av',
    '--progress',
    '--delete',
    '--exclude=node_modules',
    '--exclude=.git',
    'market.sakh.com',
    'dev:~/domains/'
  },
  cwd = '/home/strongleong/projects',
  on_stdout = vim.schedule_wrap(function(error, data, _)
    if error then
      vim.notify(data)
    end
  end),
  on_stderr = vim.schedule_wrap(function(_, data)
    vim.notify(data)
  end),
  on_exit = vim.schedule_wrap(function(_, _)
    vim.notify('[ME] Uploaded')
  end)

})

local compileJob =
Job:new({
  command = 'npm',
  args = {
    'run',
    'build'
  },
  cwd = '/home/strongleong/projects/market.sakh.com/front/app/vue',
  on_stdout = vim.schedule_wrap(function(error, data, _)
    if error then
      vim.notify(data)
    end
  end),
  on_stderr = vim.schedule_wrap(function(_, data)
    vim.notify(data)
  end),
  on_exit = vim.schedule_wrap(function(_, _)
    vim.notify('[ME] Compiled')
  end)
})

local function upload()
  local cwd = vim.fn.getcwd()
  if not string.find(cwd, project_root) then
    return
  end

  uploadJob:start()
end

local function compile()
  local cwd = vim.api.nvim_buf_get_name(0)
  if not string.find(cwd, webview_root) then
    return
  end

  compileJob:start()
end

local function compileAndUpload()
  local cwd = vim.api.nvim_buf_get_name(0)
  if not string.find(cwd, webview_root) then
    return
  end

  compileJob:and_then(uploadJob)
  compileJob:start()
end

vim.api.nvim_create_user_command('Upload', upload, { nargs = '?' })
vim.api.nvim_create_user_command('Compile', compile, { nargs = '?' })
vim.api.nvim_create_user_command('CompileAndUpload', compileAndUpload, { nargs = '?' })

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*',
  command = ":Upload<CR>"
})

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = { '*.vue', '*.js', '*.css', '*.scss' },
  command = ":CompileAndUpload<CR>"
})
