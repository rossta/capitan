Capitan.Views.Jobs ||= {}

class Capitan.Views.Jobs.IndexView extends Backbone.View
  template: JST["backbone/templates/jobs/index"]

  initialize: () ->
    @options.jobs.bind('reset', @addAll)

  addAll: () =>
    @options.jobs.each(@addOne)

  addOne: (job) =>
    view = new Capitan.Views.Jobs.JobView({ model: job })
    @$("ul").append(view.render().el)
    
  render: =>
    $(@el).html(@template(jobs: @options.jobs.toJSON() ))
    @addAll()

    return this
