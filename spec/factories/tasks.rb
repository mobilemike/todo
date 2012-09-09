FactoryGirl.define do
  factory :task do
  	sequence(:title) { |n| "Test task #{n}" }

    trait :completed do
      completed true
    end

    trait :past do
      assigned_date { Date.current - 5 }
    end

    trait :yesterday do
      assigned_date { Date.current - 1 }
    end

    trait :tomorrow do
      assigned_date { Date.current + 1 }
    end
  end
end