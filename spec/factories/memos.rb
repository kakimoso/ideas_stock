FactoryGirl.define do
  factory :memo do
    sequence :title do |n|
      "#{n}.memo title"
    end
    sequence :content do |n|
      "#{n} memo content"
    end
    edit_flag 3
    association :book

    trait :other_memo do
      title 'other memo'
      content 'this is other memo content'
    end

    factory :ro_memo do
      title 'read only'
      edit_flag 2
    end

    factory :private_memo do
      title 'private'
      edit_flag 1
    end

  end

  factory :book_memo, class: :memo do
    sequence :title do |n|
      "#{n}.memo title"
    end
    sequence :content do |n|
      "#{n} memo content"
    end
    edit_flag 3
    association :book
    user_id { book.user }
  end

end
