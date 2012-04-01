Capitan.Views.Stacks ||= {}

class Capitan.Views.Stacks.NewView extends Backbone.View
  template: JST["backbone/templates/stacks/new"]

  events:
    "submit #new-stack": "save"

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
      success: (stack) =>
        @model = stack
        window.location.hash = "/#{@model.id}"

      error: (stack, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
