return {
  adapters = {
    firefox = {
      type = 'executable',
      command = 'node',
      args = { os.getenv('HOME') .. '/debuggers/vscode-firefox-debug/dist/adapter.bundle.js' },
    }
  },

  configurations = {
    javascript = {{
      name = 'Debug with Firefox',
      type = 'firefox',
      request = 'launch',
      reAttach = true,
      url = 'http://localhost:3000',
      webRoot = '${workspaceFolder}',
      firefoxExecutable = '/usr/bin/firefox'
    }},
    vue = {{
      name = 'Debug with Firefox',
      type = 'firefox',
      request = 'launch',
      reAttach = true,
      url = 'http://localhost:3000',
      webRoot = '${workspaceFolder}',
      firefoxExecutable = '/usr/bin/firefox'
    }}
  }
}
