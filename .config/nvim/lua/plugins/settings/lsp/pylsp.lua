return {
  pylsp = {
    configurationSources = {"pycodestyle"},
    plugins = {
      flake8 = {
	config = nil,
	enabled = false,
	exclude = nil,
	executable = "flake8",
	filename = nil,
	hangClosing = nil,
	ignore = nil,
	indentSize = nil,
	maxLineLength = nil,
	perFileIgnores = nil,
	select = nil,
      },
      jedi = {
	env_vars = nil,
	environment = nil,
	extra_paths = {},
      },
      jedi_completion = {
	cache_for = {"pandas","numpy","tensorflow","matplotlib"},
	eager = false,
	enabled = true,
	fuzzy = false,
	include_class_objects = true,
	include_params = true,
	resolve_at_most = 25,
      },
      jedi_definition = {
	enabled = true,
	follow_builtin_imports = true,
	follow_imports = true,
      },
      jedi_hover = {
	enabled = true,
      },
      jedi_references = {
	enabled = true,
      },
      jedi_signature_help = {
	enabled = true,
      },
      jedi_symbols = {
	all_scopes = true,
	enabled = true,
	include_import_symbols = true,
      },
      mccabe = {
	enabled = true,
	threshold = 15,
      },
      preload = {
	enabled = true,
	modules = nil,
      },
      pycodestyle = {
	enabled = true,
	exclude = nil,
	filename = nil,
	hangClosing = nil,
	ignore = nil,
	indentSize = nil,
	maxLineLength = 99,
	select = nil,
      },
      pydocstyle = {
	addIgnore = nil,
	addSelect = nil,
	convention = nil,
	enabled = false,
	ignore = nil,
	match = "(?!test_).*\\.py",
	matchDir = "[^\\.].*",
	select = nil,
      },
      pyflakes = {
	enabled = true,
      },
      pylint = {
	args = nil,
	enabled = false,
	executable = nil,
      },
      rope_completion = {
	eager = false,
	enabled = false,
      },
      yapf = {
	enabled = true,
      }
    },
    rope = {
      extensionModules = nil,
      ropeFolder = nil,
    }
  }
}
