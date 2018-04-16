FactoryGirl.define do
  factory :memo do
    title 'memo title 1'
    content 'test content'
    association :user

    trait :other_memo do
      title 'memo title 2'
      content 'this is other memo'
    end

  end

end
