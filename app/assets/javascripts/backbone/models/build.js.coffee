class Capitan.Models.Build extends Backbone.Model
  paramRoot: 'build'

  defaults:
    number: null
    sha: null
    built_at: null
    result: null

class Capitan.Collections.BuildsCollection extends Backbone.Collection
  model: Capitan.Models.Build
  url: '/builds'

window.Capitan.Collections.Builds = new Capitan.Collections.BuildsCollection