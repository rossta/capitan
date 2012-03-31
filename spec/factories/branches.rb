FactoryGirl.define do
  factory :branch do
    sequence(:name) { |n| "origin/branch_#{n}" }
    sequence(:job_id)
  end
end
