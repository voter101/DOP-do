# => SRC FOLDER
toast './'

	# EXCLUDED FOLDERS (optional)
	# exclude: ['folder/to/exclude', 'another/folder/to/exclude', ... ]

	# => VENDORS (optional)
  # vendors: ['vendors/underscore.js']

	# => OPTIONS (optional, default values listed)
	bare: true
	packaging: true
	# expose: ''
	# minify: true

	# => HTTPFOLDER (optional), RELEASE / DEBUG (required)
	httpfolder: '../'
	release: '../app.js'
	debug: '../app-debug.js'
