module Capitan
  class Build < ActiveRecord::Base
    # Jenkins job notification
    # {"name":"JobName",
    #  "url":"JobUrl",
    #  "build":{"number":1,
    #     "phase":"STARTED",
    #     "status":"FAILED",
    #           "url":"job/project/5",
    #           "fullUrl":"http://ci.jenkins.org/job/project/5"
    #           "parameters":{"branch":"master"}
    #    }
    # }
    def self.sync_latest(job_name)
      require 'rubygems'; require 'ruby-debug'; debugger
      builds_json = Capitan::Jenkins::API.get_latest_build(job_name)
      # Capitan::Jenkins::API.get_latest_build(job_name).keys: 
       # ["actions",
       # "artifacts",
       # "building",
       # "description",
       # "duration",
       # "fullDisplayName",
       # "id",
       # "keepLog",
       # "number",
       # "result",
       # "timestamp",
       # "url",
       # "builtOn",
       # "changeSet",
       # "culprits"]
       
       # branches: Capitan::Jenkins::API.get_latest_build(job_name)["actions"][1]["buildsByBranchName"].keys
       # branch: {"buildNumber"=>41,
        # "buildResult"=>nil,
        # "revision"=>
        #  {"SHA1"=>"36e7d414a45625e61b44a32b693eb5cbf63f6c02",
        #   "branch"=>
        #    [{"SHA1"=>"36e7d414a45625e61b44a32b693eb5cbf63f6c02",
        #      "name"=>"origin/wip_state_activity"}]}}
      
      
      causes, builds_by_branch = builds_json["actions"]
      build_json = builds_by_branch["lastBuiltRevision"]
    end
    
  end
end