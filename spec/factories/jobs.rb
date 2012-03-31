FactoryGirl.define do
  factory :job do
    sequence(:name) { |n| "job #{n}" }
    enabled true
  end
end
