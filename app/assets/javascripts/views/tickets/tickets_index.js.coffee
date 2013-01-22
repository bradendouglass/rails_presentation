class Ticketer.Views.TicketsIndex extends Backbone.View
  template: JST['tickets/index']

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template(tickets: @collection))
    this
