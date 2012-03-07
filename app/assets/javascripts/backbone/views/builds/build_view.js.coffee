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
    return this
