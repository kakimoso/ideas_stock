FactoryGirl.define do
  factory :memo do
    title 'memo title'
    content 'test content'
    association :owner
  end
end
