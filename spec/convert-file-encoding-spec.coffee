ConvertToUtf8 = require '../lib/convert-file-encoding'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "ConvertToUtf8", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('convertToUtf8')

  describe "when the convert-file-encoding:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.convert-file-encoding')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'convert-file-encoding:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.convert-file-encoding')).toExist()
        atom.workspaceView.trigger 'convert-file-encoding:toggle'
        expect(atom.workspaceView.find('.convert-file-encoding')).not.toExist()
