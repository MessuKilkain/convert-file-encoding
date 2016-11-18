fs    = require 'fs'
iconv = require 'iconv-lite'

module.exports =

  activate: (state) ->
    atom.commands.add 'atom-workspace', "convert-file-encoding:utf-8", =>      @convertTo 'utf-8'
    atom.commands.add 'atom-workspace', "convert-file-encoding:utf16le", =>    @convertTo 'utf16le'

  deactivate: ->
    #@convertToUtf8View.destroy()

  serialize: ->
    #convertToUtf8ViewState: @convertToUtf8View.serialize()

  convertTo: (encoding) ->
    editor = atom.workspace?.getActiveTextEditor()
    if not editor?
      #error
      return
    encoding = editor.getEncoding()
    path = editor.getPath()
    if not path?
      #error
      return
    convertedText = iconv.encode editor.getText, encoding
    if not convertedText?
      #error
      return
    fs.writeFileSync( uri, convertedText )

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
