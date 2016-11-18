fs    = require 'fs'
iconv = require 'iconv-lite'

module.exports =

  activate: (state) ->
    atom.commands.add 'atom-workspace', "convert-file-encoding:utf-8", =>      @open 'utf-8'
    atom.commands.add 'atom-workspace', "convert-file-encoding:utf16le", =>    @open 'utf16le'

  deactivate: ->
    #@convertToUtf8View.destroy()

  serialize: ->
    #convertToUtf8ViewState: @convertToUtf8View.serialize()

  open: (encoding) ->
    editor = atom.workspace?.getActiveTextEditor()
    if not editor?
      #error
      return
    encoding = editor.getEncoding()
    path = editor.getPath()
    if not path?
      #error
      return
    buffer = fs.readFileSync(path)
    if not buffer?
      #error
      return
    convertedText = iconv.decode buffer, encoding
    editor.setText convertedText
    # atom.workspace.saveActivePaneItem()

  save: (encoding) ->
    workspace = atom.workspace
    editor = workspace.getActiveTextEditor()
    path = editor.getPath()
    buffer = fs.readFileSync(path)
    data = buffer.toString 'UTF8'
    buf = iconv.encode data, encoding
    fs.writeFileSync( uri, buf )
