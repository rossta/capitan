require 'yaml'

YAML.load_file('config/engineyard.yml').tap do |yaml|
  yaml.each do |stack_name, enviroments|
    puts "Building #{stack_name} stack..."
    stack = Capitan::Stack.find_or_create_by_title(stack_name)

    enviroments.each do |environment_key, ey_config|
      ey_app, ey_env = Capitan::Engineyard.ey_app_and_environment(ey_config)

      puts "Building #{environment_key} environment for #{ey_app.name}|#{ey_env.name}|#{ey_app.account.name}..."

      app = stack.apps.find_or_initialize_by_provider_id(ey_app.id) do |a|
        a.name = ey_app.name
        a.account_name = ey_app.account.name
      end
      app.save!

      app.add_environment(environment_key, ey_env.name)
    end
  end
end


YAML.load_file("config/jenkins.yml").tap do |yaml|
  yaml["jobs"].each do |job_name|
    puts "Adding #{job_name} job..."
    Capitan::Job.find_or_create_by_name(job_name)
  end  
end

