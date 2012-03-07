Capitan.Views.Builds ||= {}

class Capitan.Views.Builds.EditView extends Backbone.View
  template : JST["backbone/templates/builds/edit"]

  events :
    "submit #edit-build" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (build) =>
        @model = build
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
