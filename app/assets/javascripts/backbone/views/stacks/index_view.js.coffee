Capitan.Views.Stacks ||= {}

class Capitan.Views.Stacks.IndexView extends Backbone.View
  template: JST["backbone/templates/stacks/index"]

  events:
    "click .refresh" : "fetch"

  initialize: () ->
    @stacks = @options.stacks
    @stacks.bind('reset', @render)

  addAll: () =>
    @stacks.each(@addOne)

  addOne: (stack) =>
    view = new Capitan.Views.Stacks.StackView({ model : stack })
    @$("ul").append(view.render().el)

  fetch: () =>
    @stacks.fetch()

    return false

  render: =>
    $(@el).html(@template(@timeStampsToJSON()))
    @addAll()
    setTimeout(@fetch, 60000)

    return this

  timeStampsToJSON: ->
    date = (new Date)
    { today: date.format("fullDate"), time: date.format("mediumTime") }
