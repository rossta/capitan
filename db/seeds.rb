platform = Capitan::Stack.find_or_create_by_title("platform")

{
  environment_name: 'challengepost_staging',
  app_name:         'challengepost',
  account:          'challengepostcom'
}.tap do |config|
  ey_app, ey_env = Capitan::Engineyard.ey_app_and_environment(config)

  app = platform.apps.find_or_initialize_by_provider_id(ey_app.id) do |a|
    a.name = ey_app.name
    a.account_name = ey_app.account.name
  end
  app.save!

  app.add_environment('staging', ey_env.name)
end