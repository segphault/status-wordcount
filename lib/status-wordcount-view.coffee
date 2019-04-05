{View} = require 'atom'

module.exports =
class StatusWordcountView extends View
  @content: ->
    @div class: "status-wordcount inline-block"

  initialize: (serializeState) ->
    atom.workspaceView.command "status-wordcount:toggle", => @toggle()

  updateWordCount: =>
    try
        editor = atom.workspaceView.getActivePaneItem()
        count = editor.getText().match(/\S+/g).length
        @text("#{count} words").show()
    catch
        @text("read-only").show()

  serialize: ->

  destroy: ->
    @detach()

  attach: ->
    statusbar = atom.workspaceView.statusBar
    statusbar.appendRight this

    atom.workspaceView.eachEditorView (editor) =>
      @subscribe editor.getEditor().getBuffer(), "contents-modified", @updateWordCount

    @subscribe atom.workspaceView, "pane-container:active-pane-item-changed", @updateWordCount

    @updateWordCount()

  toggle: ->
    if @hasParent() then @detach() else @attach()
