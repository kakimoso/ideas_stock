FactoryGirl.define do
  factory :user do
    name 'test user'
    password 'foobar'
    password_confirmation 'foobar'

    trait :other_user do
      name 'other_user'
    end
  end
end
