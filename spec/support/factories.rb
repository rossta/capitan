FactoryGirl.define do

  factory :'capitan/app' do
    name 'Platform'

    sequence(:provider_id) { |n| n }
    account_name 'challengepostcom'
  end

  factory :'capitan/deploy' do

  end

  factory :'capitan/stack' do
    title 'Platform Stack'
  end

end