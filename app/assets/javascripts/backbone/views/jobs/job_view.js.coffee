Capitan.Views.Jobs ||= {}

class Capitan.Views.Jobs.JobView extends Backbone.View
  template: JST["backbone/templates/jobs/job"]

  events:
    "click .destroy" : "destroy"

  tagName: "li"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON()))
    buildIndex = new Capitan.Views.Builds.IndexView({ builds: @model.builds() })
    @$(".builds").html(buildIndex.el)

    return this
