Capitan.Views.Stacks ||= {}

class Capitan.Views.Jobs.IndexView extends Backbone.View
  template: JST["backbone/templates/jobs/index"]

  events:
    "click .refresh" : "fetch"

  initialize: () ->
    @jobs = @options.jobs
    @jobs.bind('reset', @render)

  addAll: () =>
    @jobs.each(@addOne)

  addOne: (job) =>
    view = new Capitan.Views.Jobs.JobView({ model: job })
    @$("ul").append(view.render().el)

  fetch: () =>
    @jobs.fetch()

    return false

  render: =>
    $(@el).html(@template(@timeStampsToJSON()))
    @addAll()
    setTimeout(@fetch, 60000)

    return this

  timeStampsToJSON: ->
    date = (new Date)
    { today: date.format("fullDate"), time: date.format("mediumTime") }
