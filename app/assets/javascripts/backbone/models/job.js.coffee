class Capitan.Models.Job extends Backbone.Model
  paramRoot: 'job'

  defaults:
    name: null
    enabled: null

  builds: ->
    relatedBuilds = Capitan.Collections.Builds.select((build) => 
      @id == build.get("job_id")
    )
    buildCollection = new Capitan.Collections.BuildsCollection
    buildCollection.add(relatedBuilds)
    buildCollection


class Capitan.Collections.JobsCollection extends Backbone.Collection
  model: Capitan.Models.Job
  url: '/jobs'

window.Capitan.Collections.Jobs = new Capitan.Collections.JobsCollection