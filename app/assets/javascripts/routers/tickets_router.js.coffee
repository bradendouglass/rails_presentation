class Ticketer.Routers.Tickets extends Backbone.Router

  routes:
    "/users/*id": 'index'

  initialize: ->
    @collection = new Ticketer.Collections.Tickets()
    @collection.fetch()

  index: (id)->
    view = new Ticketer.Views.TicketsIndex(collection: @collection)
    $('#tickets').html(view.render().el)
