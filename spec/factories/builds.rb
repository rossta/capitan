FactoryGirl.define do
  factory :build do
    sequence(:number) { |n| n }
    result_message "SUCCESS"
    built_at Time.now
  end
end