Capitan.Views.Branches ||= {}

class Capitan.Views.Branches.BranchView extends Backbone.View
  template: JST["backbone/templates/branches/branch"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
