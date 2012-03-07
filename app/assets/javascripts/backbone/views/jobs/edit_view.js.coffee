Capitan.Views.Jobs ||= {}

class Capitan.Views.Jobs.EditView extends Backbone.View
  template : JST["backbone/templates/jobs/edit"]

  events :
    "submit #edit-job" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (job) =>
        @model = job
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
