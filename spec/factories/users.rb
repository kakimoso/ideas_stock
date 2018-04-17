FactoryGirl.define do
  factory :user do
    name 'test user'
    password 'foobar'
    password_confirmation 'foobar'

    trait :other_user do
      name 'other_user'
    end

    # create実行後に (memoを,5件作る,カラム名: 値)
    after(:create) do |user|
      create_list(:memo, 5, user: user)
    end
  end
end
