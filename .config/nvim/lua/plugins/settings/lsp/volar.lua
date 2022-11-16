return {
  volar = {
    autoCompleteRefs    = false,
    autoWrapParentheses = true,
    codeLens = {
      pugTools         = false,
      references       = true,
      scriptSetupTools = false
    },
    completion = {
      autoImportComponent  = true,
     preferredAttrNameCase = "auto-kebab",
     preferredTagNameCase  = "auto",
    },
    diagnostics = {
      delay = 200,
    },
    icon = {
      preview      = true,
      splitEditors = true,
    },
    preview = {
      backgroundColor = "#f0f0f0",
      port = 3333,
      script = {
        nuxi = "node {NUXI_BIN} dev --port {PORT}",
        vite = "node {VITE_BIN} --port={PORT}",
      },
      transparentGrid = false,
    },
    splitEditors = {
      layout = {
        left  = { "script","scriptSetup","styles" },
        right = { "template","customBlocks" },
      },
    },
    takeOverMode = {
      enabled = "auto",
    },
    updateImportsOnFileMove = {
      enabled = true,
    },
    vueserver = {
      maxOldSpaceSize = nil,
      useSecondServer = false,
    },
  },
}
