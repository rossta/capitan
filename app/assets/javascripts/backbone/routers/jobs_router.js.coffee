class Capitan.Routers.JobsRouter extends Backbone.Router
  initialize: (options) ->
    @jobs = new Capitan.Collections.JobsCollection()
    @jobs.reset options.jobs

  routes:
    "/new"      : "newJob"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/jobs/:id"      : "show"
    ".*"        : "index"

  # newJob: ->
  #   @view = new Capitan.Views.Jobs.NewView(collection: @jobs)
  #   $("#jobs").html(@view.render().el)

  index: ->
    @view = new Capitan.Views.Jobs.IndexView(jobs: @jobs)
    $("#jobs").html(@view.render().el)

  show: (id) ->
    job = @jobs.get(id)

    @view = new Capitan.Views.Jobs.IndexView(jobs: new Capitan.Collections.JobsCollection([job]))
    $("#jobs").html(@view.render().el)

  # edit: (id) ->
  #   job = @jobs.get(id)

  #   @view = new Capitan.Views.Jobs.EditView(model: job)
  #   $("#jobs").html(@view.render().el)
