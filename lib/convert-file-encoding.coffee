{CompositeDisposable} = require 'atom'
fs    = require 'fs'
iconv = require 'iconv-lite'

commandSubscription = null
module.exports =
  disposables: null
  activate: (state) ->
    @disposables = new CompositeDisposable
    @disposables.add atom.commands.add 'atom-workspace', "convert-file-encoding:shift_jis", =>  @convertTo 'shift_jis'
    @disposables.add atom.commands.add 'atom-workspace', "convert-file-encoding:euc-jp", =>     @convertTo 'euc-jp'
    @disposables.add atom.commands.add 'atom-workspace', "convert-file-encoding:cp932", =>      @convertTo 'cp932'
    @disposables.add atom.commands.add 'atom-workspace', "convert-file-encoding:gbk", =>        @convertTo 'gbk'
    @disposables.add atom.commands.add 'atom-workspace', "convert-file-encoding:big5", =>       @convertTo 'big5'
    @disposables.add atom.commands.add 'atom-workspace', "convert-file-encoding:big5-hkscs", => @convertTo 'big5-hkscs'
    @disposables.add atom.commands.add 'atom-workspace', "convert-file-encoding:euc-kr", =>     @convertTo 'euc-kr'
    @disposables.add atom.commands.add 'atom-workspace', "convert-file-encoding:utf-8", =>      @convertTo 'utf-8'
    @disposables.add atom.commands.add 'atom-workspace', "convert-file-encoding:utf16le", =>    @convertTo 'utf16le'
    @disposables.add atom.commands.add 'atom-workspace', "convert-file-encoding:utf16be", =>    @convertTo 'utf16be'

  deactivate: ->
    @disposables?.dispose()
    @disposables = null

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
