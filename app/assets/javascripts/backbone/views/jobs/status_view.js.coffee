Capitan.Views.Jobs ||= {}

class Capitan.Views.Jobs.StatusView extends Backbone.View
  template: JST["backbone/templates/jobs/status"]

  tagName: "tr"

  render: ->
    $(@el).html(@template(@model.toJSON()))

    return this
