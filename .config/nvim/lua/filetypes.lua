vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern = {'Gemfile', 'Rakefile', 'Vagrantfile', 'Thorfile', 'config.ru'},
  command = 'set ft=ruby',
  desc    = 'Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby'
})

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern = {'*.twig', '*.twig'},
  command = 'set ft=htmljinja',
  desc    = 'Map .twig files as jinja templates'
})

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.coffee',
  command = 'set ft=coffee',
  desc    = 'Map *.coffee to coffee type'
})

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern ='*.es6',
  command = 'set ft=javascript',
  desc    = 'Highlight es6 like Javascript'
})

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern ={'*.mustache', '*.hbs'},
  command = 'set ft=mustache',
  desc    = 'Hbs and mustache files.'
})

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern = 'Jenkinsfile',
  command = 'set ft=groovy',
  desc    = 'Jenkinsfile are groovy'
})

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern = {'*.lr'},
  command = 'set ft=markdown',
  desc    = 'Lector uses custom file types, but markdown contents.'
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  command = 'setl softtabstop=4 shiftwidth=4 tabstop=4 textwidth=100 colorcolumn=99',
  desc    = 'Make python follow PEP8'
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'rst',
  command = 'setl textwidth=80 colorcolumn=81',
  desc    = 'Make python follow PEP8'
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'cucumber', 'yaml', 'sass', 'scss', 'ruby', 'eruby', 'less'},
  command = 'setl softtabstop=2 shiftwidth=2 tabstop=2 colorcolumn=100',
  desc    = 'Make ruby,scss,sass,less use 2 spaces for indentation.',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'php',
  command = 'setl textwidth=120 softtabstop=4 shiftwidth=4 tabstop=4 colorcolumn=120',
  desc    = 'PHP settings'
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  command = 'setl textwidth=120 softtabstop=4 shiftwidth=4 tabstop=4 noexpandtab colorcolumn=100',
  desc    = 'Golang settings'
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  command = 'setl textwidth=80 softtabstop=4 shiftwidth=4 tabstop=4 colorcolumn=79',
  desc    = 'Markdown settings'
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'css', 'typescript', 'javascript', 'mustache', 'htmljinja', 'html'},
  command = 'setl textwidth=120 softtabstop=2 shiftwidth=2 tabstop=2 colorcolumn=120',
  desc    = 'Javascript, CSS, and html settings'
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'pov'},
  command = 'set filetype=phtml',
  desc    = 'Inc files are hptml'
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'coffee', 'groovy', 'elm', 'dockerfile'},
  command = 'setl textwidth=100 softtabstop=2 shiftwidth=2 tabstop=2 colorcolumn=100',
  desc    = 'CoffeeScript, Groovy, Elm, Docker'
})
