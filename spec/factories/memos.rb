FactoryGirl.define do
  factory :memo do
    sequence :title do |n|
      "memo title #{n}"
    end
    sequence :content do |n|
      "memo content #{n}"
    end
    edit_flag 2
    association :user

    trait :other_memo do
      title 'other memo'
      content 'this is other memo content'
    end

  end

end
