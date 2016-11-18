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
      console.error("no editor")
      return
    path = editor.getPath()
    if not path?
      console.error("no path")
      return
    originalText = editor.getText()
    convertedText = iconv.encode editor.getText(), encoding
    if not convertedText?
      console.error("no convertedText")
      return
    fs.writeFileSync( path, convertedText )
    editor.setEncoding(encoding)
    editor.setText(originalText)
