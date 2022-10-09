OnchiView = require './onchi-view'
{CompositeDisposable} = require 'atom'

module.exports = Onchi =
  onchiView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @onchiView = new OnchiView(state.onchiViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @onchiView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'onchi:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @onchiView.destroy()

  serialize: ->
    onchiViewState: @onchiView.serialize()

  toggle: ->
    console.log 'Onchi was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
