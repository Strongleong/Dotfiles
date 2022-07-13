return {
  adapters = {
    php = {
      type = 'executable',
      command = 'node',
      args = { os.getenv('HOME') .. '/debuggers/vscode-php-debug/out/phpDebug.js' },
    }
  },
  configurations = {
    php = {{
      type = 'php',
      request = 'launch',
      name = 'Listen for Xdebug',
      port = 9005
    }}
  }
}
