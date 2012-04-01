Capitan.Views.Stacks ||= {}

class Capitan.Views.Stacks.ShowView extends Backbone.View
  template: JST["backbone/templates/stacks/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
