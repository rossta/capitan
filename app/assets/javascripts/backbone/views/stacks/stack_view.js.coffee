Capitan.Views.Stacks ||= {}

class Capitan.Views.Stacks.StackView extends Backbone.View
  template: JST["backbone/templates/stacks/stack"]

  tagName: "li"

  className: "span5"

  addAllJobs: () =>
    @model.jobs().each(@addOneJob)

  addOneJob: (job) =>
    view = new Capitan.Views.Jobs.StatusView({ model: job })
    @$(".job_statuses tbody").append(view.render().el)

  render: ->
    $(@el).html(@template(@model.toJSON()))
    @addAllJobs()

    return this
