Capitan.Views.Builds ||= {}

class Capitan.Views.Builds.IndexView extends Backbone.View
  template: JST["backbone/templates/builds/index"]

  initialize: () ->
    @options.builds.bind('reset', @addAll)
    @render()

  addAll: () =>
    @options.builds.each(@addOne)

  addOne: (build) =>
    view = new Capitan.Views.Builds.BuildView({model : build})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(builds: @options.builds.toJSON() ))
    @addAll()

    return this
