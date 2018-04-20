FactoryGirl.define do
  factory :book_no, class: :book do
    name "test book"
    association :user, factory: :user
    memo_id { [FactoryGirl.create(:book_memo)] }
  end

  factory :book do
    name "parent book"
    association :user, factory: :user
  end

  factory :sub_book, class: :book do
    name "sub book"
  end

end
