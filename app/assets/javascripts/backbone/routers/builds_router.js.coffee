class Capitan.Routers.BuildsRouter extends Backbone.Router
  initialize: (options) ->
    @builds = new Capitan.Collections.BuildsCollection()
    @builds.reset options.builds

  routes:
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  index: ->
    @view = new Capitan.Views.Builds.IndexView(builds: @builds)
    $("#builds").html(@view.render().el)

  # show: (id) ->
  #   build = @builds.get(id)

  #   @view = new Capitan.Views.Builds.ShowView(model: build)
  #   $("#builds").html(@view.render().el)

  # edit: (id) ->
  #   build = @builds.get(id)

  #   @view = new Capitan.Views.Builds.EditView(model: build)
  #   $("#builds").html(@view.render().el)
