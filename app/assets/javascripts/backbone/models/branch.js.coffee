class Capitan.Models.Branch extends Backbone.Model
  paramRoot: 'branch'

  defaults:
    name: null
    last_build_number: null

class Capitan.Collections.BranchesCollection extends Backbone.Collection
  model: Capitan.Models.Branch
  url: '/branches'

window.Capitan.Collections.Branches = new Capitan.Collections.BranchesCollection