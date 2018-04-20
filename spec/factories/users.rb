FactoryGirl.define do
  factory :user do
    name 'test user'
    password 'foobar'
    password_confirmation 'foobar'

    trait :other_user do
      name 'other_user'
    end

    # after(:create) do |user|
    #   create_list(:sub_book, 1, user_id: user)
    # end

    # # create実行後に (memoを,5件作る,カラム名: 値)
    # after(:create) do |user|
    #   create_list(:memo, 5, user: user)
    #   create_list(:ro_memo, 1, user: user)
    #   create_list(:private_memo, 1, user: user)
    # end
  end

  factory :private_user, class: :user do
    name 'I have pmemo'
    password 'foobar'
    password_confirmation 'foobar'

    # after(:create) do |user|
    #   create_list(:memo, 1, user: user)
    #   create_list(:ro_memo, 1, user: user)
    #   create_list(:private_memo, 1, user: user)
    # end
  end
end
