Capitan.Views.Builds ||= {}

class Capitan.Views.Builds.ShowView extends Backbone.View
  template: JST["backbone/templates/builds/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
