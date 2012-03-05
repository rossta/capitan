# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "rossta"
    uid "123456"
    provider "github"
    email "rossta@example.com"
  end
end
