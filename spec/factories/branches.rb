FactoryGirl.define do
  factory :branch do
    sequence(:name) { |n| "origin/branch_#{n}" }
  end
end
