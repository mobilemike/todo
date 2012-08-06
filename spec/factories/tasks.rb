FactoryGirl.define do
  factory :task do
  	sequence(:title) { |n| "Test task #{n}" }
  end
end