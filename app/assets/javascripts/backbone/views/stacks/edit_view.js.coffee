Capitan.Views.Stacks ||= {}

class Capitan.Views.Stacks.EditView extends Backbone.View
  template : JST["backbone/templates/stacks/edit"]

  events :
    "submit #edit-stack" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (stack) =>
        @model = stack
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
