window.Ticketer =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new Ticketer.Routers.Tickets
    Backbone.history.start(pushState: true)

$(document).ready ->
  Ticketer.initialize()
