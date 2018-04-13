FactoryGirl.define do
  factory :memo do
    title 'memo title'
    content 'test content'
    association :user
  end
end
