module Capitan
  class Deploy < ActiveRecord::Base
    # :provider_id, :created_at, :commit, :finished_at, :migrate_command, :output,
    # :ref, :resolved_ref, :successful, :user_name, :app_id, :environment
    
    def sync_with_ey_deploy(ey_deploy)
      update_attributes({
        provider_id:      ey_deploy.id,
        created_at:       ey_deploy.created_at,
        finished_at:      ey_deploy.finished_at,
        migrate_command:  ey_deploy.migrate_command,
        output:           ey_deploy.output,
        ref:              ey_deploy.ref,
        resolved_ref:     ey_deploy.resolved_ref,
        successful:       ey_deploy.successful,
        user_name:        ey_deploy.user_name
      })
    end
  end
end