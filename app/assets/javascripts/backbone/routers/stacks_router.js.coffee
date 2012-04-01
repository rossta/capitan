class Capitan.Routers.StacksRouter extends Backbone.Router
  initialize: (options) ->
    @stacks = new Capitan.Collections.StacksCollection()
    @stacks.reset options.stacks

  routes:
    "/new"      : "newStack"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  index: ->
    @view = new Capitan.Views.Stacks.IndexView(stacks: @stacks)
    $("#stacks").html(@view.render().el)

  show: (id) ->
    stack = @stacks.get(id)

    @view = new Capitan.Views.Stacks.IndexView(jobs: new Capitan.Collections.StacksCollection([stack]))
    $("#stacks").html(@view.render().el)

  # newStack: ->
  #   @view = new Capitan.Views.Stacks.NewView(collection: @stacks)
  #   $("#stacks").html(@view.render().el)

  # index: ->
  #   @view = new Capitan.Views.Stacks.IndexView(stacks: @stacks)
  #   $("#stacks").html(@view.render().el)

  # show: (id) ->
  #   stack = @stacks.get(id)

  #   @view = new Capitan.Views.Stacks.ShowView(model: stack)
  #   $("#stacks").html(@view.render().el)

  # edit: (id) ->
  #   stack = @stacks.get(id)

  #   @view = new Capitan.Views.Stacks.EditView(model: stack)
  #   $("#stacks").html(@view.render().el)
