FactoryGirl.define do
  factory :user do
    sequence :name do |n|
       "test user #{n}"
     end
    password 'foobar'
    password_confirmation 'foobar'

    trait :other_user do
      name 'other_user'
    end

    trait :with_emp_book do
      after(:create) do |user|
        user.books << FactoryGirl.create(:sub_book, user_id: user.id)
      end
    end

    trait :with_book do
      after(:create) do |user|
        user.books << FactoryGirl.create(:sub_book, user_id: user.id)
        # 簡略化は後回しで
        user.books.first.memos << FactoryGirl.create(
          :book_memo, user_id: user.id, book_id: user.books.first.id
        )
        user.books.first.memos << FactoryGirl.create(
          :book_memo,
          user_id: user.id,
          book_id: user.books.first.id,
          edit_flag: 2
        )
        user.books.first.memos << FactoryGirl.create(
          :book_memo,
          user_id: user.id,
          book_id: user.books.first.id,
          edit_flag: 1
        )
      end
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
