Capitan.Views.Builds ||= {}

class Capitan.Views.Builds.BuildView extends Backbone.View
  template: JST["backbone/templates/builds/build"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON()))
    spinTarget = @$(".spin-target")[0]
    new Spinner(@spinnerOpts).spin(spinTarget)
    return this

  spinnerOpts:
    lines: 9
    width: 2,
    length: 4,
    radius: 3,
    top: 1,
    left: 2