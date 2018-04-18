FactoryGirl.define do
  factory :memo do
    sequence :title do |n|
      "#{n}.memo title"
    end
    sequence :content do |n|
      "#{n} memo content"
    end
    edit_flag 3
    association :user

    trait :other_memo do
      title 'other memo'
      content 'this is other memo content'
    end

    factory :ro_memo do
      edit_flag 2
    end

    factory :private_memo do
      edit_flag 1
    end

  end

end
