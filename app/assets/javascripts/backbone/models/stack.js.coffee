class Capitan.Models.Stack extends Backbone.Model
  paramRoot: 'stack'

  defaults:
    name: "Stack"

  jobs: ->
    @jobsCollection ||= (new Capitan.Collections.JobsCollection).add(@get("jobs"))
    @jobsCollection

class Capitan.Collections.StacksCollection extends Backbone.Collection
  model: Capitan.Models.Stack
  url: '/stacks'
