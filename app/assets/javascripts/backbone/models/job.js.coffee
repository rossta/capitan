class Capitan.Models.Job extends Backbone.Model
  paramRoot: 'job'

  defaults:
    name: "Job"
    enabled: true

  builds: ->
    @buildCollection ||= (new Capitan.Collections.BuildsCollection).add(@get("builds"))
    @buildCollection

class Capitan.Collections.JobsCollection extends Backbone.Collection
  model: Capitan.Models.Job
  url: '/jobs'

window.Capitan.Collections.Jobs = new Capitan.Collections.JobsCollection