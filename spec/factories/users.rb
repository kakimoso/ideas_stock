FactoryGirl.define do
  factory :user do
    name 'test user'
    password 'foobar'
    password_confirmation 'foobar'

    trait :no_name do
      name ''
    end

    trait :no_password do
      password ''
    end

    trait :short_password do
      password 'short'
      password_confirmation 'short'
    end

    trait :long_name do
      name 'a' * 21
    end
  end
end
