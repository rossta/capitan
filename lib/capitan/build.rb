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
      builds_json = Capitan::Jenkins::API.get_latest_build(job_name)
      causes, builds_by_branch = builds_json["actions"]
      build_json = builds_by_branch["lastBuiltRevision"]
      
    end
    
  end
end