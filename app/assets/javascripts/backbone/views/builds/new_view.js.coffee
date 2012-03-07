Capitan.Views.Builds ||= {}

class Capitan.Views.Builds.NewView extends Backbone.View
  template: JST["backbone/templates/builds/new"]

  events:
    "submit #new-build": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (build) =>
        @model = build
        window.location.hash = "/#{@model.id}"

      error: (build, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
