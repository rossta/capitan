FactoryGirl.define do
  factory :'capitan/app' do
    sequence(:provider_id) { |n| n }
    name 'CP App'
    account_name 'challengepostcom'
  end

  factory :'capitan/deploy' do
  end
end