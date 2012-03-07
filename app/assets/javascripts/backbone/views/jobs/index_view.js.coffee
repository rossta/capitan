Capitan.Views.Jobs ||= {}

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
    $(@el).html(@template(time: @formatCurrentTime()))
    @addAll()
    setTimeout(@fetch, 60000)

    return this

  formatCurrentTime: ->
    d = new Date()
    day = d.getDay()
    dayDate = d.getDate()
    month = d.getMonth() + 1
    year = "#{d.getFullYear()}".replace(/^\d\d/, "")
    hours = d.getHours()
    minutes = d.getMinutes()
    seconds = if "#{d.getSeconds()}".length == 1 then "0#{d.getSeconds()}" else d.getSeconds()
    "#{hours}:#{minutes}:#{seconds} #{month}/#{dayDate}/#{year}"
