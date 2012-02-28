FactoryGirl.define do
  factory :job do
    sequence(:name) { |n| "app #{i}" }
  end
end
