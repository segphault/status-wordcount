StatusWordcountView = require './status-wordcount-view'

module.exports =
  statusWordcountView: null

  activate: (state) ->
    @statusWordcountView = new StatusWordcountView(state.statusWordcountViewState)

  deactivate: ->
    @statusWordcountView.destroy()

  serialize: ->
    statusWordcountViewState: @statusWordcountView.serialize()
