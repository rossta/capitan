FactoryGirl.define do
  factory :job do
    sequence(:name) { |n| "app #{n}" }
  end
end
