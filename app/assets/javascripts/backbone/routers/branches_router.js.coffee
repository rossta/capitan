class Capitan.Routers.BranchesRouter extends Backbone.Router
  initialize: (options) ->
    @branches = new Capitan.Collections.BranchesCollection()
    @branches.reset options.branches

  routes:
    "/new"      : "newBranch"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newBranch: ->
    @view = new Capitan.Views.Branches.NewView(collection: @branches)
    $("#branches").html(@view.render().el)

  index: ->
    @view = new Capitan.Views.Branches.IndexView(branches: @branches)
    $("#branches").html(@view.render().el)

  show: (id) ->
    branch = @branches.get(id)

    @view = new Capitan.Views.Branches.ShowView(model: branch)
    $("#branches").html(@view.render().el)

  edit: (id) ->
    branch = @branches.get(id)

    @view = new Capitan.Views.Branches.EditView(model: branch)
    $("#branches").html(@view.render().el)
